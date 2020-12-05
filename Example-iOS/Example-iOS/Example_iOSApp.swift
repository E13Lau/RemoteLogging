//
//  Example_iOSApp.swift
//  Example-iOS
//
//  Created by lau on 2020/12/4.
//

import SwiftUI
import RemoteLogging
import Logging

var log = Logger(label: "Example")


@main
struct Example_iOSApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView().onAppear {
                log.debug("ContentView onAppear!!")
            }.onDisappear {
                log.debug("ContentView onDisappear!!")
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        initRemoteLogging()
        
        //also you can using RemoteLogHandler like this
        let server = LocalServer()
        server.runServer(port: 0)
        var logger = Logger(label: "Example logger") { (label) -> LogHandler in
            return RemoteLogHandler(label: label, server: server),
        }
        logger.info("🎉🎉🎉")
        
        return true
    }
    
    private func initRemoteLogging() {
        LocalServer.default.runServer()
        LoggingSystem.bootstrap { (label) -> LogHandler in
            var handler = MultiplexLogHandler([
                RemoteLogHandler(label: label, server: LocalServer.default),
                StreamLogHandler.standardOutput(label: label),
            ])
            handler.logLevel = .trace
            return handler
        }
    }
}
