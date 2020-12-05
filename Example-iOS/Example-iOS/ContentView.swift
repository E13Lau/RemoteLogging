//
//  ContentView.swift
//  Example-iOS
//
//  Created by lau on 2020/12/4.
//

import SwiftUI
import Logging


struct ContentView: View {
    var body: some View {
        NavigationView(content: {
            VStack {
                NavigationLink(
                    destination: DetailView(),
                    label: {
                        Text("show detail view")
                    })
                Button("Start") {
                    log.debug("tap Start button!!")
                }.padding()
            }.onAppear {
                log.trace("ContentView onAppear!")
            }.onDisappear {
                log.trace("ContentView onDisappear!")
            }.navigationTitle("Content")
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
