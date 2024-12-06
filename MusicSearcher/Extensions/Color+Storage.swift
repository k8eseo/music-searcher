//
//  Color+Storage.swift
//  MusicSearcher
//
//  Created by Katie Seo on 12/5/24.
//

import Foundation
import SwiftUI

extension Color: RawRepresentable {
    
    public init?(rawValue: String) {
        if let data = Data(base64Encoded: rawValue)  {
            let uiColor = try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [UIColor.self], from: data) as? UIColor
            self = Color(uiColor ?? .black)
        } else {
            self = .black
        }
    }
    
    public var rawValue: String {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: UIColor(self), requiringSecureCoding: false) as Data
            return data.base64EncodedString()
        } catch { return error.localizedDescription }
    }
}
