#IpSuiDauNote App

Một ứng dụng để ghi chú cho thành viên.

Features:

    1. Add new user
    2. Add new note
    3. Xem danh sách thành viên
    4. Xem danh sách ghi chú của bản thân và thành viên
Requirements

    - ios 15.0+
    - Xcode 14.2
    
Architecture

    - MVVM
Library

    - SwiftUI, Combine, Firebase, FireStoreSwift, 
Structure

    Root 
    |---- CustomView: Chứa các View custom được sử dụng chung
    |---- Main: Chưa các file dùng trong toàn bộ ứng dụng
    |---- Database: Chứa file quản lý Firebase Firestore database
    |---- Models: Chứa các đổi tưởng
    |---- Extensions: Chứa các nội dung mở rộng
    |---- Scene: Màn hình ứng dụng
            |---- SettingView
            |---- AddNoteView
            |---- ListNoteView
            |---- LoginView
            |---- Members
            |---- MyNotes
            |---- TabView   
Dependency

    Swift Package Manager: https://github.com/firebase/firebase-ios-sdk.git
    
Running the tests
