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
    @State private var isLoaded = false
    var body: some View {
        NavigationView {
            ZStack {
                List(content: {
                    ForEach(viewModel.listNotes, id: \.self) { note in
                        HStack {
                            NoteRow(note: note)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Button {
                                
                            } label: {
                                Image(systemName: "trash")
                            }.frame(width: 30, height: 30, alignment: .trailing)
                                .onTapGesture {
                                    viewModel.removeNote(note: note)
                                }

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
        .onAppear(perform: {
            if !isLoaded{
                isLoaded = true
                if let username = user?.username{
                    viewModel.getNotes(username: username)
                }
            }
            
        }).alert(isPresented: $viewModel.isShowAlert) {
            Alert(title: Text("Notification"),
                  message: Text(viewModel.message), dismissButton: .default(Text("OK")){
                viewModel.isShowAlert = false
            })
        }
    }
}

struct MyNotesView_Previews: PreviewProvider {
    static var previews: some View {
        MyNotesView(user: MUser(username: "1", userid: "2"))
    }
}
