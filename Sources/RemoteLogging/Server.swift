import Telegraph

public class LocalServer: RemoteLogServer {
    public static var `default` = LocalServer()
    
    public init() { }
    
    private let httpServer = Server()
    
    public func runServer(port: Int = 9777) {
        httpServer.serveBundle(.module, "/")
        
        // MARK: - websocket config
        httpServer.webSocketDelegate = self
        
        do {
            try httpServer.start(port: port)
            print("🎉🎉🎉 RemoteLoggin run in \(httpServer.port)")
        } catch {
            print(error.localizedDescription)
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
}

extension LocalServer: ServerWebSocketDelegate {
    public func server(_ server: Server, webSocketDidConnect webSocket: WebSocket, handshake: HTTPRequest) {
    }
    
    public func server(_ server: Server, webSocket: WebSocket, didSendMessage message: WebSocketMessage) {
    }
    
    public func server(_ server: Server, webSocket: WebSocket, didReceiveMessage message: WebSocketMessage) {
    }
    
    public func server(_ server: Server, webSocketDidDisconnect webSocket: WebSocket, error: Error?) {
    }
}

