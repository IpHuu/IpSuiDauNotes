//
//  FirebaseManager.swift
//  IpSuiDauNotes
//
//  Created by Ipman on 17/08/2023.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine
class FirebaseManager: ObservableObject{
    static let share = FirebaseManager()
    private let db = Firestore.firestore()
    
    func exsistUser(username: String) -> Future<Bool, Error>{
        return Future<Bool, Error>{ [weak self] promise in
            guard let doc = self?.db.collection("users").whereField("username", isEqualTo: username) else { return }
            doc.getDocuments { snapshot, error in
                if let error = error{
                    promise(.failure(error))
                }else{
                    if let snapshot = snapshot{
                        do{
                            if snapshot.documents.count == 0{
                                promise(.success(false))
                            }else{
                                for doc in snapshot.documents{
                                    let jsonData = try JSONSerialization.data(withJSONObject: doc.data(), options: [])
                                    if let user = try JSONDecoder().decode(MUser.self, from: jsonData) as? MUser{
                                        promise(.success(true))
                                    }
                                }
                            }
                            
                            
                        }catch{
                            promise(.failure(error))
                        }
                        
                    }
                }
            }
        }
    }
    
    func getUser(username: String) -> Future<MUser, Error>{
        return Future<MUser, Error>{
            [weak self] promise in
            guard let doc = self?.db.collection("users") else { return }
            doc.whereField("username", isEqualTo: username)
                .getDocuments { snapshot, error in
                if let error = error{
                    promise(.failure(error))
                }else{
                    
                    if let snapshot = snapshot{
                        do{
                            for doc in snapshot.documents{
                                let jsonData = try JSONSerialization.data(withJSONObject: doc.data(), options: [])
                                if let user = try JSONDecoder().decode(MUser.self, from: jsonData) as? MUser{
                                    promise(.success(user))
                                }
                            }
                            
                        }catch{
                            promise(.failure(error))
                        }
                        
                    }
                }
            }
        }
    }
    
    func addUser(username: String) -> Future<MUser, Error>{
        return Future<MUser, Error>{ [weak self] promise in
            guard let doc = self?.db.collection("users") else { return }
            let timeStamp = Int(NSDate().timeIntervalSince1970 * 1000)
            let userid = "u\(timeStamp)"
            let data: [String: Any] = [
                "username" : username,
                "userid":userid
            ]
            doc.document(userid).setData(data){ error in
                if let error = error{
                    promise(.failure(error))
                }
            }
            let user = MUser(id: userid, username: username, userid: userid)
            promise(.success(user))
        }
        
    }
    
    func addNotes(title: String, content: String, username: String, userid: String) -> Future<MNotes, Error>{
        return Future<MNotes, Error>{
            [weak self] promise in
            guard let doc = self?.db.collection("notes") else { return }
            
            let timeStamp = Double(NSDate().timeIntervalSince1970 * 1000)
            let noteid = "n\(timeStamp)"
            let data: [String: Any] = [
                "title": title,
                "noteid": noteid,
                "userid": userid,
                "username": username,
                "content" : content,
                "timestamp": timeStamp
            ]
            doc.document(noteid).setData(data){
                error in
                if let error = error{
                    promise(.failure(error))
                }
            }
            let note = MNotes(id: noteid,
                              noteid: noteid,
                              username: username,
                              userid: userid,
                              title: title,
                              content: content,
                              timestamp: Double(timeStamp))
            promise(.success(note))
        }
    }
    
    func deleteNote(noteid: String) -> Future<Bool, Error>{
        return Future<Bool, Error>{
            [weak self] promise in
            guard let doc = self?.db.collection("notes") else { return }
            let ref = doc.document(noteid)
            ref.delete{ error in
                if let error = error{
                    promise(.failure(error))
                }else{
                    promise(.success(true))
                }
                
            }
        }
    }
    
    func getListNote(username: String) -> Future<[MNotes], Error>{
        return Future<[MNotes], Error>{ [weak self] promise in
            guard let doc = self?.db.collection("notes") else { return }
            doc.order(by: "timestamp", descending: true)
                .whereField("username", isEqualTo: username)
                .getDocuments { querySnapShot, error in
                    if let error = error{
                        promise(.failure(error))
                    }else{
                        var list: [MNotes] = []
                        for doc in querySnapShot!.documents{
                            do{
                                let jsonData = try JSONSerialization.data(withJSONObject: doc.data(), options: [])
                                if let note = try JSONDecoder().decode(MNotes.self, from: jsonData) as? MNotes{
                                    list.append(note)
                                }
                            }catch{
                                promise(.success([]))
                            }

                        }
                        promise(.success(list))
                    }
                }

        }
    }
    
    func getListMember() -> Future<[MUser], Error>{
        return Future<[MUser], Error>{[weak self] promise in
            guard let doc = self?.db.collection("users"), let curruserid = AppStorage.cachedUser?.userid  else { return }
            doc.whereField("userid", isNotEqualTo: curruserid)
                .getDocuments { querySnapShot, error in
                    if let error = error{
                        promise(.failure(error))
                    }else{
                        var list: [MUser] = []
                        for doc in querySnapShot!.documents{
                            do{
                                let jsonData = try JSONSerialization.data(withJSONObject: doc.data(), options: [])
                                if let user = try JSONDecoder().decode(MUser.self, from: jsonData) as? MUser{
                                    list.append(user)
                                }
                            }catch{
                                promise(.failure(error))
                            }
                            
                        }
                        promise(.success(list))
                    }
                }
            
        }
    }
    
    
}
