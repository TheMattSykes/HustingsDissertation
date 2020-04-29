//
//  DashboardView.swift
//  Hustings
//
//  Created by Matthew Sykes on 15/04/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI

struct DashboardView: View {
    
    @State var progress: Int = 64
    @State var progressAngle: CGFloat = 0.64
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(Color.gray, lineWidth: 15)
                Circle()
                    .trim(from: 0, to: progressAngle)
                    .stroke(Color("HustingsGreen"), lineWidth: 15)
                    .rotationEffect(.degrees(-90))
                Text("\(progress)%")
                    .font(.largeTitle)
                    .foregroundColor(Color("HustingsGreen"))
            }.frame(width: 180, height: 180, alignment: .center)
        }.onAppear(
            perform: {
                
            }
        )
    }
}
