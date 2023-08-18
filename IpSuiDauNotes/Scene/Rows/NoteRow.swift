//
//  NoteRow.swift
//  IpSuiDauNotes
//
//  Created by Ipman on 17/08/2023.
//

import SwiftUI

struct NoteRow: View {
    let note: MNotes
    var body: some View {
        
        VStack {
            HStack{
                Text(note.title)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, alignment: .leading)
                    .font(.headline)
                Text(note.timestamp.formatDateChatMessage())
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, alignment: .trailing)
                    .font(.subheadline)
            }
            Text(note.content)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, alignment: .leading)
                .font(.body)
            
        }
    }
}
