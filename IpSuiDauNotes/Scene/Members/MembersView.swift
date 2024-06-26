//
//  MembersView.swift
//  IpSuiDauNotes
//
//  Created by Ipman on 17/08/2023.
//

import SwiftUI

struct MembersView: View {
    @StateObject private var viewModel = MemebersViewModel()
    @State private var isLoaded = false
    var body: some View {
        NavigationView {
            ZStack{
                List{
                    ForEach(viewModel.listUser, id: \.self) { user in
                        NavigationLink {
                            ListNoteView(user: user)
                        } label: {
                            UserRow(member: user)
                        }
                    }
                    
                }.listStyle(.plain)
                .navigationTitle("Members")
                
                if viewModel.isLoading {
                    LoadingView()
                }
            }
            
        }
        .onAppear(perform: {
            if !isLoaded{
                isLoaded = true
                viewModel.getMember()
            }
            
        })
        
        
    }
}

struct MembersView_Previews: PreviewProvider {
    static var previews: some View {
        MembersView()
    }
}
