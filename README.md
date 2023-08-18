#IpSuiDauNote App

Một ứng dụng để ghi chú cho thành viên.

#Requirements

    - ios 15.0+
    - Xcode 14.2
    
#Architecture

    - MVVM
#Library

    - SwiftUI, Combine, Firebase, FireStoreSwift, 
    
#Navigation and Routing

    - Use NavigationView and NavigationLink for app navigation.
    - Implement a central router (AppRouter) with an @EnvironmentObject for managing navigation state.

#Dependency

    Swift Package Manager: https://github.com/firebase/firebase-ios-sdk.git
    
#Data management

    - Integrate Firebase Firestore for cloud data storage 
    - Create Firebase Manager classes to handle Firebase interactions
    - Implement Combine framework for reactive data binding and asynchronous operations.
    - Use UserDefault to store the application's state data.
    
#User Management

    - Not implementing account Authentication
    - Managing user information by username
    - Storing login state (joining the app)
    - Storing user login information (username)
    
#Lists and Detail Views

    - Use SwiftUI's List, ForEach, and NavigationLink to display lists of data.
#Error Handling and Notifications

    - Implement error handling and display relevant alerts or messages.
    - Use Combine's @Published to manage notification messages.
Running the tests
