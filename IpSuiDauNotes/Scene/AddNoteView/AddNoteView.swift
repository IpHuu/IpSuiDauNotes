//
//  AddNoteView.swift
//  IpSuiDauNotes
//
//  Created by Ipman on 17/08/2023.
//

import SwiftUI
import Combine
struct AddNoteView: View {
    var user: MUser?
    @ObservedObject var viewModel = NotesViewModel()
    @State private var content = ""
    @State private var title = ""
    var body: some View {
        VStack{
            Text("Add Notes")
                .font(.largeTitle)
                .bold()
            Spacer()
            TextField("Title", text: $title)
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
            TextEditor(text: $content)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
            Spacer()
            Button {
                if let userid = user?.userid, let username = user?.username{
                    viewModel.addNote(userid: userid, username: username, title: title, content: content)
                }
                
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.blue)
                    Text("Save")
                        .foregroundColor(.white)
                        .bold()
                }
            }.frame(width: 200, height: 60)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .alert(isPresented: $viewModel.isShowAlert) {
                Alert(title: Text("Notification"),
                      message: Text(viewModel.message))
            }.padding(20)
            .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView()
    }
}
