//
//  Users.swift
//  IpSuiDauNotes
//
//  Created by Ipman on 17/08/2023.
//

import Foundation
import FirebaseFirestoreSwift
struct MUser: Identifiable, Codable, Hashable{
    var id: String?
    var username: String
    var userid: String
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case userid
    }

}
