//
//  PrimaryTabView.swift
//  Hustings
//
//  Created by Matthew Sykes on 28/02/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI

struct PrimaryTabView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor(displayP3Red: 0.419, green: 0.725, blue: 0.215, alpha: 1.0)
    }
    var body: some View {
        VStack {
            LogoTitleBar()
            TabView {
                DashboardView()
                    .tabItem {
                        Image(systemName: "clock")
                        Text("Dashboard")
                }
                
                LearnMenuView()
                    .tabItem {
                        Image(systemName: "link.circle")
                        Text("Learn")
                    }
                
                Text("Debate Mode")
                    .tabItem {
                        Image(systemName: "exclamationmark.bubble")
                        Text("Debate")
                    }
                
                ClassView()
                    .tabItem {
                        Image(systemName: "person.3.fill")
                        Text("Class")
                    }
                
                AccountView()
                    .tabItem {
                        Image(systemName: "person.circle")
                        Text("My Account")
                    }
            }.accentColor(.blue)
            //.background(Color("HustingsGreen"))
        }
    }
}

struct PrimaryTabView_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryTabView()
    }
}
