//
//  TabView.swift
//  IpSuiDauNotes
//
//  Created by Ipman on 17/08/2023.
//

import SwiftUI

struct TabbarBottomView: View {
    @EnvironmentObject var appRouter: AppRouter
    var body: some View {
        TabView {
            MyNotesView(user: AppStorage.cachedUser)
                .tabItem {
                    Image(systemName: "person")
                    Text("My Notes")
                }
                
            MembersView()
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Members")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
                
        }.onAppear() {
//            UITabBar.appearance().barTintColor = .yellow
//            UITabBar.appearance().backgroundColor = UIColor.white
        }
    }
}

struct TabbarBottomView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarBottomView()
    }
}
