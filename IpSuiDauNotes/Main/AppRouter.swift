//
//  AppRoute.swift
//  IpSuiDauNotes
//
//  Created by Ipman on 17/08/2023.
//

import Foundation
enum AppFlow{
    case login
    case tabbar
}
class AppRouter: ObservableObject{
    @Published var flow: AppFlow = .login
}
