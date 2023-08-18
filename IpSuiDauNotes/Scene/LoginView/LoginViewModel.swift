//
//  JoinModelView.swift
//  IpSuiDauNotes
//
//  Created by Ipman on 16/08/2023.
//

import Foundation
import Combine
import SwiftUI
class LoginViewModel: ObservableObject{
    @Published var username: String = ""
    @Published var message: String = ""
    @Published var isShowAlert: Bool = false
    @Published var isExsistUser: Bool = false
    @Published var isLogined: Bool = false
    
    private var cancellables: Set<AnyCancellable> = []
    
    func exsistUser(completion: @escaping(Bool) -> Void){
        let result = FirebaseManager.share.exsistUser(username: username)
        result
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion{
                case .failure(let error):
                    self?.message = error.localizedDescription
                    self?.isShowAlert = true
                    break
                case .finished:
                    break
                }
            }) { isExsist in
                completion(isExsist)
            }
            .store(in: &cancellables)
    }
    
    func addNewUser(username: String, appRouter: AppRouter){
        if username.isEmpty{
            self.message = "Please enter your username"
            self.isShowAlert = true
            return
        }
        exsistUser { [weak self] isExsist in
            if !isExsist{
                self?.addUserToDatabase(username: username, appRouter: appRouter)
            }else{
                self?.getUser(username: username){ user in
                    if let user = user{
                        AppStorage.cachedUser = user
                        AppState.share.isLogined = true
                        DispatchQueue.main.async {
                            self?.isLogined = true
                            appRouter.flow = .tabbar
                        }
                    }
                    
                    
                }
                
            }
        }
    }
    
    func getUser(username: String, completion: @escaping(MUser?) -> Void){
        let data = FirebaseManager.share.getUser(username: username)
        data.receive(on: DispatchQueue.global())
            .sink(receiveCompletion: { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                case .finished:
                    break
                }
            }) { user in
                completion(user)
            }.store(in: &cancellables)
    }
    
    func addUserToDatabase(username: String, appRouter: AppRouter){
        let data = FirebaseManager.share.addUser(username: username)
        data
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion{
                case .failure(let error):
                    self?.message = error.localizedDescription
                    self?.isShowAlert = true
                    break
                case .finished:
                    break
                }
            }) { [weak self] user in
                appRouter.flow = .tabbar
                AppStorage.cachedUser = user
                self?.isLogined = true
                AppState.share.isLogined = true
                self?.username = ""
            }.store(in: &cancellables)
    }
    
    
}
