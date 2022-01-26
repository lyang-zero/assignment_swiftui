//
//  DatabaseManager.swift
//  iOSAssignment(SwiftUI)
//
//  Created by Alex Yang on 2022-01-26.
//

import Foundation

struct NetWorkConfig {
    static let baseUrl = "https://carfax-for-consumers.firebaseio.com/"
}

enum FetcherError: Error {
    case invalidURL
    case missingData
}


struct CarFetcher {
    
    static func fetchCars() async throws -> [CarListItem]{
        guard let url = URL(string: "\(NetWorkConfig.baseUrl)assignment.json") else {
            throw FetcherError.invalidURL
        }
        
        // Use the async variant of URLSession to fetch data
        let (data, _) = try await URLSession.shared.data(from: url)
        
        // Parse the JSON data
        struct Result: Codable {
            let listings: [CarListItem]
        }
        let result = try JSONDecoder().decode(Result.self, from: data)
        return result.listings
    }
}

