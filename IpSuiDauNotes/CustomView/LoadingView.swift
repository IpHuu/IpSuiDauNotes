//
//  LoadingView.swift
//  IpSuiDauNotes
//
//  Created by Ipman on 18/08/2023.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Text("Loading...")
                .font(.headline)
            ProgressView()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
