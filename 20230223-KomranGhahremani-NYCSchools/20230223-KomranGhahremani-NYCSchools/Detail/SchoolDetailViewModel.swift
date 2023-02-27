//
//  SchoolDetailViewModel.swift
//  20230223-KomranGhahremani-NYCSchools
//
//  Created by Komran Ghahremani on 2/26/23.
//

import Combine
import Foundation
import SwiftUI

class SchoolDetailViewModel: Identifiable, ObservableObject {
    @Published var isLoading: Bool = false
    @Published var math: String = "N/A"
    @Published var reading: String = "N/A"
    @Published var writing: String = "N/A"
    
    let id = UUID()
    let school: School
    private var bag = Set<AnyCancellable>()
    
    init(school: School) {
        self.school = school
    }
    
    // With more time would definitely like to add a more robust networking layer with timeout capabilities for example
    func fetchScores() {
        self.isLoading = true
        
        SchoolsGateway()
            .fetchScore(for: school)
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .compactMap({ $0.first })
            .sink(receiveValue: { score in
                self.math = score.math
                self.reading = score.reading
                self.writing = score.writing
                self.isLoading = false
            })
            .store(in: &bag)
    }
    
    func subwayColor(for line: Character) -> Color {
        switch line {
        case "1", "2", "3": return .red
        case "M", "F", "B", "D": return .orange
        case "A", "C", "E": return .blue
        case "4", "5", "6", "G": return .green
        case "Q", "R", "N", "W": return .yellow
        case "7": return .purple
        default: return .gray
        }
    }
}
