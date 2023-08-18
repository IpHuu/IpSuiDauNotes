//
//  MembersViewModel.swift
//  IpSuiDauNotes
//
//  Created by Ipman on 17/08/2023.
//

import Foundation
import Combine
import SwiftUI
class MemebersViewModel: ObservableObject{
    @Published var listUser: [MUser] = []
    @Published var isLoading: Bool = false
    private var cancellables: Set<AnyCancellable> = []
    func getMember(){
        self.isLoading = true
        let response = FirebaseManager.share.getListMember()
        response.receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                case .finished:
                    break
                }
            }) { [weak self] users in
                self?.isLoading = false
                self?.listUser = users
            }.store(in: &cancellables)
    }
}
