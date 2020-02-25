//
//  TitleLogo.swift
//  Hustings
//
//  Created by Matthew Sykes on 24/02/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI

struct TitleLogo: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color("HustingsGreen"))
                .frame(height: 100)
        }.overlay(
            Image("HustingsLogoWhite")
                .resizable()
                .scaledToFit()
                .padding(10)
        )
            
    }
}

struct TitleLogo_Previews: PreviewProvider {
    static var previews: some View {
        TitleLogo()
    }
}
