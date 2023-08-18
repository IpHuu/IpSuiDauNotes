//
//  MyNotesViewModel.swift
//  IpSuiDauNotes
//
//  Created by Ipman on 17/08/2023.
//

import Foundation
import Combine
import SwiftUI
class NotesViewModel: ObservableObject{
    @Published var listNotes: [MNotes] = []
    @Published var message: String = ""
    @Published var isShowAlert: Bool = false
    @Published var isLoading: Bool = false
    private var cancellables: Set<AnyCancellable> = []
    func getNotes(username: String){
        self.isLoading = true
        let response = FirebaseManager.share.getListNote(username: username)
        response.receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion{
                case .failure(let error):
                    self?.isShowAlert.toggle()
                    self?.message = error.localizedDescription
                    break
                case .finished:
                    break
                }
            }) { [weak self] listnote in
                self?.isLoading = false
                self?.listNotes = listnote
                if listnote.count == 0{
                    self?.isShowAlert.toggle()
                    self?.message = "List note empty"
                }
            }
            .store(in: &cancellables)
    }
    func addNote(userid: String, username: String, title: String, content: String){
        self.isLoading = true
        let response = FirebaseManager.share.addNotes(title: title, content: content, username: username, userid: userid)
        response.receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion{
                case.failure(let error):
                    self?.message = error.localizedDescription
                    self?.isShowAlert = true
                    break
                case .finished:
                    break
                }
            }) { [weak self] note in
                self?.isLoading = false
                if !note.noteid.isEmpty{
                    self?.message = "Add note successfully"
                    self?.isShowAlert = true
                    self?.listNotes.insert(note, at: 0)
                }
            }.store(in: &cancellables)
    }
    
    func removeNote(note: MNotes){
        self.isLoading = true
        if let index = self.listNotes.firstIndex(where: {$0.noteid == note.noteid}){
            let response = FirebaseManager.share.deleteNote(noteid: note.noteid)
            response.receive(on: DispatchQueue.main)
                .sink(receiveCompletion: {
                    [weak self] completion in
                       self?.isLoading = false
                       switch completion{
                       case.failure(let error):
                           self?.message = error.localizedDescription
                           self?.isShowAlert = true
                           break
                       case .finished:
                           break
                       }
                }) { [weak self] result in
                    self?.isLoading = false
                    if result{
                        self?.message = "Note removed"
                        self?.isShowAlert = true
                        self?.listNotes.remove(at: index)
                    }
                }
                .store(in: &cancellables)
        }
        
    }
}
