//
//  DashboardView.swift
//  Hustings
//
//  Created by Matthew Sykes on 26/02/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI

struct DashboardView: View {
    
    var firstName:String
    
    var body: some View {
        NavigationView() {
            VStack(alignment: .center){
                LogoTitleBar()
                Spacer()
                Text("Welcome, \(firstName)")
                    .font(.title)
                    .foregroundColor(Color("HustingsGreen"))
                DashboardOptionsView()
                Spacer()
            }
        }.navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("", displayMode: .inline)
        
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(firstName: "Name")
    }
}
