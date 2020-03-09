//
//  LogoTitleBar.swift
//  Hustings
//
//  Created by Matthew Sykes on 25/02/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI

struct LogoTitleBar: View {
    var body: some View {
        VStack(spacing: 0){
            Rectangle()
                .fill(Color("HustingsGreen"))
                .frame(height: 30)
            ZStack {
//                Rectangle()
//                    .fill(Color("HustingsGreen"))
//                    .frame(height: 10)
                Rectangle()
                    .fill(Color("HustingsGreen"))
                    .frame(height: 90)
            }.overlay(
                Image("HustingsLogoWhite")
                    .resizable()
                    .scaledToFit()
                    .padding(10)
            )
        }//.frame(height: 82)
        .edgesIgnoringSafeArea(.top)
    }
}

struct LogoTitleBar_Previews: PreviewProvider {
    static var previews: some View {
        LogoTitleBar()
    }
}
