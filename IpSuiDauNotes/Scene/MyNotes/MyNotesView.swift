//
//  MyNotesView.swift
//  IpSuiDauNotes
//
//  Created by Ipman on 17/08/2023.
//

import SwiftUI
import Combine
struct MyNotesView: View {
    var user: MUser?
    @ObservedObject private var viewModel = NotesViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                List(content: {
                    ForEach(viewModel.listNotes, id: \.self) { note in
                        HStack {
                            NoteRow(note: note)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Button {
                                viewModel.removeNote(note: note)
                            } label: {
                                Image(systemName: "trash")
                            }.frame(width: 30, height: 30, alignment: .trailing)

                        }
                        
                    }
                })
                .navigationTitle("My Notes")
                .navigationBarItems(trailing:
                    HStack {
                        NavigationLink {
                            AddNoteView(user: AppStorage.cachedUser, viewModel: viewModel)
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                )
                
                if viewModel.isLoading {
                    LoadingView()
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear(perform: {
            if let username = user?.username{
                viewModel.getNotes(username: username)
            }
        }).alert(isPresented: $viewModel.isShowAlert) {
            Alert(title: Text("Notification"),
                  message: Text(viewModel.message))
        }
    }
}

struct MyNotesView_Previews: PreviewProvider {
    static var previews: some View {
        MyNotesView(user: MUser(username: "1", userid: "2"))
    }
}
