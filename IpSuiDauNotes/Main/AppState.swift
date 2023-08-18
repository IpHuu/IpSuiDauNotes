//
//  AppState.swift
//  IpSuiDauNotes
//
//  Created by Ipman on 17/08/2023.
//

import Foundation
import Combine
private enum AuthenticatedKey: String {
    case currentUser = "currentUser"
    case isLogined = "isLogined"
}
@propertyWrapper
struct StorageObject<T: Codable> {
    private let key: String
    private let defaultValue: T?
    
    init(key: String, defaultValue: T?) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T?{
        get {
            guard let data = UserDefaults.standard.data(forKey: key) else {
                return defaultValue
            }
            do {
                let decodedValue = try JSONDecoder().decode(T.self, from: data)
                return decodedValue
            } catch {
                print("Error decoding JSON: \(error)")
                return defaultValue
            }
        }
        set {
            do {
                let encodedValue = try JSONEncoder().encode(newValue)
                UserDefaults.standard.set(encodedValue, forKey: key)
            } catch {
                print("Error encoding JSON: \(error)")
            }
        }
    }
}

@propertyWrapper
struct StorageGeneric<T> {
    private let key: String
    private let defaultValue: T

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            // Read value from UserDefaults
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            // Set value to UserDefaults
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
final class AppState: ObservableObject {
    static let share = AppState()
    let objectWillChange = ObservableObjectPublisher()
    
    @StorageGeneric(key: AuthenticatedKey.isLogined.rawValue, defaultValue: false)
    var isLogined: Bool

    private var notificationSubscription: AnyCancellable?

    init() {
        notificationSubscription = NotificationCenter.default.publisher(for: UserDefaults.didChangeNotification).sink { _ in
            self.objectWillChange.send()
        }
    }
}

final class AppStorage{
    static let share = AppStorage()
    @StorageObject(key: AuthenticatedKey.currentUser.rawValue, defaultValue: nil)
    static var cachedUser: MUser?
}
