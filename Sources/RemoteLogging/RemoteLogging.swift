import Logging
import Foundation

public protocol RemoteLogServer {
    func send(text: String)
}

public struct RemoteLogHandler: LogHandler {
    public init(label: String, server: RemoteLogServer) {
        self.label = label
        self.server = server
    }
    private var label: String
    private var server: RemoteLogServer
    private var queue = DispatchQueue(label: "RemoteLogHandler.DispatchQueue")
    
    public subscript(metadataKey metadataKey: String) -> Logger.Metadata.Value? {
        get {
            self.metadata[metadataKey]
        }
        set(newValue) {
            self.metadata[metadataKey] = newValue
        }
    }
    
    public var metadata: Logger.Metadata = [:]
    
    public var logLevel: Logger.Level = .trace
    
    public func log(level: Logger.Level, message: Logger.Message, metadata: Logger.Metadata?, source: String, file: String, function: String, line: UInt) {
        queue.async {
            let filename = file.components(separatedBy: "/").last ?? ""
            let text = "\(self.timestamp()) \(source) \(level.emoji) \(filename):\(line) \(function)"
            server.send(text: text)
            server.send(text: message.description)
        }
    }
    
    private func timestamp() -> String {
        var buffer = [Int8](repeating: 0, count: 255)
        var time: timeval = timeval(tv_sec: 0, tv_usec: 0)
        gettimeofday(&time, nil)
        let localTime = localtime(&time.tv_sec)
        strftime(&buffer, buffer.count, "%Y-%m-%dT%H:%M:%S", localTime)
        var zone = [Int8](repeating: 0, count: 8)
        strftime(&zone, zone.count, "%z", localTime)
        var millseconds = [Int8](repeating: 0, count: 8)
        _ = snprintf(ptr: &millseconds, 8, ".%03d", time.tv_usec / 1000)
        strcat(&buffer, millseconds)
        strcat(&buffer, zone)
        return buffer.withUnsafeBufferPointer {
            $0.withMemoryRebound(to: CChar.self) {
                String(cString: $0.baseAddress!)
            }
        }
    }
}

fileprivate extension Logger.Level {
    var emoji: String {
        switch self {
        case .trace:
            return "🔍"
        case .debug:
            return "🛠"
        case .info:
            return "💬"
        case .notice:
            return "🗯"
        case .warning:
            return "⚠️"
        case .error:
            return "❌"
        case .critical:
            return "💥"
        }
    }
}
