//
//  MNotes.swift
//  IpSuiDauNotes
//
//  Created by Ipman on 17/08/2023.
//

import Foundation
struct MNotes:Identifiable, Codable, Hashable{
    var id: String?
    var noteid: String
    var username: String
    var userid: String
    var title: String
    var content: String
    var timestamp: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case noteid
        case username
        case userid
        case title
        case content
        case timestamp
    }
}
