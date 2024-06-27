//
//  HomeView.swift
//  AppDolar
//
//  Created by Luciano Nicolini on 26/06/2024.
//

import SwiftUI
import GoogleMobileAds

struct HomeView: View {
    @ObservedObject var networkManager = DolarNetworkManager()
    @AppStorage("dollars") var storedDollars: String = ""
    
    let backgroundColor = Color("Background")
    let horizontalPadding: CGFloat = 20
    let verticalPadding: CGFloat = 10
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                backgroundColor.ignoresSafeArea(.all)
                
                if networkManager.loading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color(.color))
                        .progressViewStyle(CircularProgressViewStyle(tint: .primary))
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 0) {
                            DateView(launcher: "DolarHoy")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 20)
                                .padding(.horizontal, horizontalPadding)
                            
                            Hashtags()
                                .padding()
                            Divider()
                            
                            ForEach(networkManager.dolarData) { dolarData in
                                DollarView(index: dolarData)
                                    .frame(maxWidth: .infinity)
                                    .padding(verticalPadding)
                            }
                        }
                        .animation(.easeInOut, value: networkManager.dolarData)
                    }
                }
            }
            .onAppear {
                networkManager.fetchData()
            }
        }
        .navigationBarBackButtonHidden()
        .onDisappear {
            storedDollars = ""
        }
    }
}


#Preview {
    HomeView()
}
