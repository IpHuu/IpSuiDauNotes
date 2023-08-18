//
//  UserRow.swift
//  IpSuiDauNotes
//
//  Created by Ipman on 17/08/2023.
//

import SwiftUI

struct UserRow: View {
    let member: MUser
    
    var body: some View {
        HStack {
            Image(systemName: "person")
                .resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(25)
                .aspectRatio(contentMode: .fit)
            Text(member.username)
                .font(.headline)
        }
    }
}
