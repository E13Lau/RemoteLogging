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
            t.schedule(wallDeadline: .now(), repeating: .seconds(1))
            var count = 1000
            t.setEventHandler {
                switch count % 7 {
                case 0:
                    log.trace("ding~")
                case 1:
                    log.debug("ding~")
                case 2:
                    log.info("ding~")
                case 3:
                    log.notice("ding~")
                case 4:
                    log.warning("ding~")
                case 5:
                    log.error("ding~")
                case 6:
                    log.critical("ding~")
                default:
                    log.trace("ding~")
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
