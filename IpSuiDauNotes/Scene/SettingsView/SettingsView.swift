//
//  SettingsView.swift
//  IpSuiDauNotes
//
//  Created by Ipman on 17/08/2023.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appRouter: AppRouter
    var body: some View {
        GeometryReader { geomytry in
            VStack{
                Text("Hello! \(AppStorage.cachedUser?.username ?? "")")
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, alignment: .center)
                    .font(.largeTitle)
                Button {
                    AppState.share.isLogined = false
                    appRouter.flow = .login
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.blue)
                        Text("Logout")
                            .foregroundColor(.white)
                            .bold()
                    }
                }
                .frame(width: 200, height: 60)
                Spacer()
            }
            .padding(10)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
