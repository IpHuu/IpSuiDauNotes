//
//  IpSuiDauNotesApp.swift
//  IpSuiDauNotes
//
//  Created by Ipman on 16/08/2023.
//

import SwiftUI

@main
struct IpSuiDauNotesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var appRouter = AppRouter()
    @State private var isLoading = true
    var body: some Scene {
        WindowGroup {
            if isLoading {
                SplashView()
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 1.0))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isLoading = false
                        }
                    }
            } else {
                rootView
                    .environmentObject(appRouter)
            }
            
        }
    }
    
    @ViewBuilder
    var rootView: some View {
        switch appRouter.flow {
        case .login:
            if AppState.share.isLogined{
                TabbarBottomView()
            }else{
                LoginView()
            }
        case .tabbar:
            TabbarBottomView()
        }
    }
}
