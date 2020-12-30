import Telegraph
import Foundation

public struct LogMessage: Codable {
    var type = MessageType.log
    /// iso8601
    let date: String
    let source: String
    let file: String
    let line: String
    let method: String
    let level: Int
    let message: String
}

struct InfoMessage: Codable {
    var type = MessageType.info
    let name: String
}

public struct MessageType {
    static let info = "info"
    static let log = "log"
}

public class LocalServer: RemoteLogServer {
    public static var `default` = LocalServer()
    
    public init() { }
    
    private let httpServer = Server()
    
    public func runServer(port: Int = 9777) {
        
        let bundleName = "RemoteLogging_RemoteLogging"
        guard var resourceURL = Bundle(for: LocalServer.self).resourceURL else {
            print("RemoteLogging - unable to find bundle named ", bundleName)
            return
        }
        resourceURL.appendPathComponent(bundleName + ".bundle")
        guard let bundle = Bundle(url: resourceURL) else {
            print("RemoteLogging - unable to find bundle named ", bundleName)
            return
        }

        httpServer.serveBundle(bundle, "/")
        
        // MARK: - websocket config
        httpServer.webSocketDelegate = self
        
        do {
            try httpServer.start(port: port)
            print("🎉🎉🎉 RemoteLogging running, link http://\(ProcessInfo.processInfo.hostName):\(httpServer.port)")
        } catch {
            print("RemoteLogging -", error.localizedDescription)
            let nsError = error as NSError
            if nsError.code == 48 {
                print("RemoteLoggin -", "using automatic port assignment")
                runServer(port: 0)
            }
        }
    }
    
    public func send(text: String) {
        guard self.httpServer.isRunning else {
            return
        }
        self.httpServer.webSockets.forEach({ ws in
            ws.send(text: text)
        })
    }

    public func send(message: LogMessage) {
        send(text: message.jsonString ?? "")
    }
}

extension LocalServer: ServerWebSocketDelegate {
    public func server(_ server: Server, webSocketDidConnect webSocket: WebSocket, handshake: HTTPRequest) {
        let name = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? ""
        webSocket.send(text: InfoMessage(name: name).jsonString ?? "")
    }
    
    public func server(_ server: Server, webSocket: WebSocket, didSendMessage message: WebSocketMessage) {
    }
    
    public func server(_ server: Server, webSocket: WebSocket, didReceiveMessage message: WebSocketMessage) {
    }
    
    public func server(_ server: Server, webSocketDidDisconnect webSocket: WebSocket, error: Error?) {
    }
}

fileprivate extension Encodable {
    var jsonString: String? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
}
