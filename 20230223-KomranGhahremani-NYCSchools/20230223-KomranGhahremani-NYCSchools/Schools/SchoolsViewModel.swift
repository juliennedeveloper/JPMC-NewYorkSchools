//
//  SchoolsViewModel.swift
//  20230223-KomranGhahremani-NYCSchools
//
//  Created by Komran Ghahremani on 2/26/23.
//

import SwiftUI
import Combine

class SchoolsViewModel: ObservableObject {
    @Published var schools: [School] = []
    @Published var isLoading: Bool = false
    private var bag = Set<AnyCancellable>()
    
    init() {
        isLoading = true
        
        // monitor the completion of the fetch to hide the loader
        $schools
            .dropFirst()
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in
                self.isLoading = false
            })
            .store(in: &bag)
    }
    
    func fetchSchools() {
        SchoolsGateway()
            .fetchSchools()
            .receive(on: DispatchQueue.main)
            .compactMap{ $0 }
            .replaceError(with: [])
            .assign(to: &$schools)
    }
}
