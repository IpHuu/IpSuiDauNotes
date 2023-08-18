//
//  DoubleExtensions.swift
//  IpSuiDauNotes
//
//  Created by Ipman on 17/08/2023.
//

import Foundation
extension Double{
    func formatDateChatMessage() -> String {
        let date = Date(timeIntervalSince1970: self / 1000)
        let dateFormatter = DateFormatter()
        if Calendar.current.isDateInToday(date){
            dateFormatter.dateFormat = "HH:mm"
        }else if Calendar.current.isDateInYesterday(date){
            dateFormatter.dateFormat = "E HH:mm"
        }else if Calendar.current.component(.month, from: date) ==  Calendar.current.component(.month, from: Date()){
            dateFormatter.dateFormat = "MMMM dd HH:mm"
        }else if Calendar.current.component(.year, from: date) == Calendar.current.component(.year, from: Date()) {
            dateFormatter.dateFormat = "MMMM dd HH:mm"
        }else{
            dateFormatter.dateFormat = "yyyy MMMM dd HH:mm"
        }
        
        return dateFormatter.string(from: date)
    }
}
