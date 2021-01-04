//
//  DetailView.swift
//  Example-iOS
//
//  Created by lau on 2020/12/5.
//

import SwiftUI
import Foundation

struct DetailView: View {
    var body: some View {
        VStack {
            Text("DetailView!")
            Button("Tap to run/stop timer") {
                timer.toggle()
            }
        }.onAppear{
            logger.info("🎉🎉🎉")
            log.trace("Detail onAppear!!")
        }.onDisappear {
            timer.stop()
            logger.info("🎉🎉🎉")
            log.trace("Detail onDisappear!!")
        }
    }
    
    var timer = Timer()
    class Timer {
        var timer: DispatchSourceTimer?
        var isRun: Bool = false
        func toggle() {
            if isRun {
                isRun.toggle()
                stop()
            } else {
                isRun.toggle()
                run()
            }
        }
        
        func run() {
            timer?.cancel()
            let t = DispatchSource.makeTimerSource()
            t.schedule(wallDeadline: .now(), repeating: .milliseconds(100))
            var count = 10000
            t.setEventHandler {
                switch count % 7 {
                case 0:
                    log.trace("ding~\(count)")
                case 1:
                    log.debug("ding~\(count)")
                case 2:
                    log.info("ding~\(count)")
                case 3:
                    log.notice("ding~\(count)")
                case 4:
                    log.warning("ding~\(count)")
                case 5:
                    log.error("ding~\(count)")
                case 6:
                    log.critical("ding~\(count)")
                default:
                    log.trace("ding~\(count)")
                }
                count -= 1
                if count == 0 {
                    t.cancel()
                }
            }
            t.resume()
            timer = t
        }
        func stop() {
            timer?.cancel()
            timer = nil
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
