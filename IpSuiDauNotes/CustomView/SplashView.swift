//
//  SplashView.swift
//  IpSuiDauNotes
//
//  Created by Ipman on 18/08/2023.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.blue
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image(systemName: "note.text")
                    .resizable()
                    .foregroundColor(.white)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                Text("Notes App")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
