//
//  NavigationCategory.swift
//  INRRecorderApp
//
//  Created by Christian Guedemann on 29.12.2025.
//

import Foundation
import SwiftUI
enum NavigationCategory: Int, Hashable, CaseIterable, Identifiable, Codable {
    case home
    case dataPoints
    case graphics
    
    var id: Int { rawValue }

    var localizedName: LocalizedStringKey {
        switch self {
        case .home:
            return "Heute"
        case .dataPoints:
            return "Messungen"
        case .graphics:
            return "Statistik"
        }
    }
}
