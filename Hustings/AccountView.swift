//
//  AccountView.swift
//  Hustings
//
//  Created by Matthew Sykes on 27/02/2020.
//  Copyright © 2020 Matthew Sykes. All rights reserved.
//

import SwiftUI

struct AccountView: View {
    
    @EnvironmentObject var session: StoreSession
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person.circle")
                Text("My Account")
            }
            
            Text("")
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
