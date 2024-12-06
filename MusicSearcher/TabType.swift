//
//  TabType.swift
//  MusicSearcher
//
//  Created by Katie Seo on 12/3/24.
//

import Foundation
import SwiftUI

enum TabType: Int, CaseIterable {
    case home, search
    
    var title: String {
        String(describing: self).capitalized
    }
    
    var image: String {
        switch self {
        case .home: "home"
        case .search: "search"
        }
    }
}
