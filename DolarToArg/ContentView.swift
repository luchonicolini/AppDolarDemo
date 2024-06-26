//
//  ContentView.swift
//  DolarToArg
//
//  Created by Luciano Nicolini on 26/06/2024.
//

import SwiftUI

struct ContentView: View {
    @State var showLauncher: Bool = true
    @State var animationDuration: Double = 0.5
    
    var body: some View {
        ZStack {
            if showLauncher {
                LauncherView()
                    .transition(.opacity)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation {
                                self.showLauncher = false
                            }
                        }
                    }
            } else {
                TabView {
                    HomeView()
                        .tabItem {
                            Image(systemName: "dollarsign.circle")
                            Text("Home")
                               
                        }
                    
                    ConversionView()
                        .tabItem {
                            Image(systemName: "arrow.triangle.2.circlepath")
                            Text("Conversiones")
                        }
                        .accentColor(.black)
            
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
