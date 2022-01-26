//
//  CarItem.swift
//  iOSAssignment(SwiftUI)
//
//  Created by Alex Yang on 2022-01-26.
//

import Foundation

struct CarListItem: Codable, Identifiable {
    let id: String
    let year: Int
    let make: String
    let mileage: Int
    let model: String
    let trim: String
    let listPrice: Double
    let images: Images
    let dealer: Dealer
    
    var listingImageUrl: URL? {
        URL(string: images.medium.first ?? "")
    }
    
    var mileageStr: String {
        mileage > 1000 ? "\(mileage/1000)K" : "\(mileage)"
    }
    
    
    struct Images: Codable {
        let large: [String]
        let medium: [String]
        let small: [String]
    }
    
    struct Dealer: Codable {
        let phone: String
        let city: String
        let state: String
    }
}



