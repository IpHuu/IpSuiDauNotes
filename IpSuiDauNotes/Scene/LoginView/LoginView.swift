//
//  JoinView.swift
//  IpSuiDauNotes
//
//  Created by Ipman on 16/08/2023.
//

import SwiftUI

struct LoginView: View {
    @State private var isShowAlert: Bool = false
    @StateObject var viewModel = LoginViewModel()
    @EnvironmentObject var appRouter: AppRouter
    var body: some View {
        
        VStack{
            Image(systemName: "note.text")
                .resizable()
                .foregroundColor(.blue)
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            Text("Notes App")
                .font(.largeTitle)
                .bold()
            TextField("Username", text: $viewModel.username)
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .autocapitalization(.none)
            Button {
                viewModel.addNewUser(username: viewModel.username, appRouter: appRouter)
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.blue)
                    Text("Login")
                        .foregroundColor(.white)
                        .bold()
                }
            }.frame(width: 200, height: 60)

        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .alert(isPresented: $viewModel.isShowAlert) {
                Alert(title: Text("Thông báo"),
                      message: Text(viewModel.message))
            }.padding(20)
            .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
