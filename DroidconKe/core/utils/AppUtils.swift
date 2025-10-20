//
//  AppUtils.swift
//  DroidconKe
//
//  Created by @sirodevs on 19/10/2025.
//

import Foundation
import SwiftUI

class AppUtils {
    static func sendEmail() {
        let subject = "DroidconKe Feedback"
        let body = "Hi, \n\nI would like share some things about the app..."
        let email = "futuristicken@gmail.com"
        
        let encodedSubject = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let encodedBody = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        if let url = URL(string: "mailto:\(email)?subject=\(encodedSubject)&body=\(encodedBody)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    func filterString(input: String) -> String? {
        let regex = try? NSRegularExpression(pattern: ": (.+?) :", options: [])
        if let match = regex?.firstMatch(in: input, options: [], range: NSRange(input.startIndex..., in: input)) {
            let range = match.range(at: 1)
            if let swiftRange = Range(range, in: input) {
                return String(input[swiftRange])
            }
        }
        return input
    }
    
    func generateDropDownItems(initial: String = "", lowerLimit: Int?, upperLimit: Int?, incremental: Bool = true, minLength: Int = 2) -> [String] {
        var temp: [String] = [initial]
        var items: [String] = []
        
        if incremental {
            for i in lowerLimit!..<upperLimit! + 1 {
                temp.append(String(i))
            }
        } else {
            for i in (upperLimit!..<lowerLimit!).reversed() {
                temp.append(String(i))
            }
        }
        
        for item in temp {
            if item.count < minLength {
                items.append("0\(item)")
            } else {
                items.append(item)
            }
        }
        return items
    }
    
    func capitalize(str: String?) -> String {
        guard let str = str, !str.isEmpty else { return "" }
        return str.prefix(1).uppercased() + str.dropFirst()
    }
    
    func truncateString(cutoff: Int, myString: String) -> String {
        let words = myString.split(separator: " ")
        if myString.count > cutoff {
            if myString.count - words.last!.count < cutoff {
                return myString.replacingOccurrences(of: String(words.last!), with: "")
            } else {
                return String(myString.prefix(cutoff))
            }
        } else {
            return ""//myString.trim()
        }
    }
    
    func truncateWithEllipsis(cutoff: Int, myString: String) -> String {
        return myString.count <= cutoff ? myString : "\(myString.prefix(cutoff))..."
    }
    
    func songCopyString(title: String, content: String) -> String {
        return "\(title)\n\n\(content)"
    }
    
    func bookCountString(title: String, count: Int) -> String {
        return "\(title) (\(count))"
    }
    
    func lyricsString(lyrics: String) -> String {
        return lyrics.replacingOccurrences(of: "#", with: "\n").replacingOccurrences(of: "''", with: "'")
    }
    
    func songShareString(title: String, content: String) -> String {
        return "\(title)\n\n\(content)\n\nvia #SongLib https://songlib.vercel.app"
    }
    
    func verseOfString(number: String, count: Int) -> String {
        return "VERSE \(number) of \(count)"
    }
    
    func getFontSize(characters: Int, height: Double, width: Double) -> Double {
        return sqrt((height * width) / Double(characters))
    }
}
