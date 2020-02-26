//
//  DashboardOptionsView.swift
//  Hustings
//
//  Created by Matthew Sykes on 26/02/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI

struct DashboardOptionsView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image("LearnIcon")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 240)
                .padding(.horizontal,20)
                .shadow(color: Color.black.opacity(0.5), radius: 5, x: 5, y: 5)
            Image("DebateIcon")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 240)
                .padding(.horizontal,20)
                .shadow(color: Color.black.opacity(0.5), radius: 5, x: 5, y: 5)
            Image("ClassIcon")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 240)
                .padding(.horizontal,20)
                .shadow(color: Color.black.opacity(0.5), radius: 5, x: 5, y: 5)
        }
    }
}

struct DashboardOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardOptionsView()
    }
}
