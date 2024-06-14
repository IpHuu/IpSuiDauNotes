//
//  ListNoteView.swift
//  IpSuiDauNotes
//
//  Created by Ipman on 17/08/2023.
//

import SwiftUI
struct ListNoteView: View {
    var user: MUser?
    @StateObject private var viewModel = NotesViewModel()
    var body: some View {
        ZStack{
            List(viewModel.listNotes, id: \.self) { item in
                NoteRow(note: item)
            }
            if viewModel.isLoading{
                LoadingView()
            }
        }
        
        .navigationTitle("Notes")
        .navigationBarTitleDisplayMode(.inline)
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

struct ListNoteView_Previews: PreviewProvider {
    static var previews: some View {
        ListNoteView()
    }
}
