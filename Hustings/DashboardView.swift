//
//  DashboardView.swift
//  Hustings
//
//  Created by Matthew Sykes on 26/02/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        VStack(){
            LogoTitleBar()
            Spacer()
            Text("Welcome, <firstname>")
                .font(.title)
                .foregroundColor(Color("HustingsGreen"))
            DashboardOptionsView()
            Spacer()
        }.background(Color.white)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
