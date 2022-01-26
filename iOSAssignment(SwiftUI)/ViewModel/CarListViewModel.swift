//
//  CarListViewModel.swift
//  iOSAssignment(SwiftUI)
//
//  Created by Alex Yang on 2022-01-26.
//

import Foundation

class CarListViewModel: ObservableObject {
    
    @Published var items = [CarListItem]()
    
    func fetchCars() {
        Task {
            if let result = try? await CarFetcher.fetchCars() {
                DispatchQueue.main.async {
                    self.items = result
                }
            }
        }
    }
}
