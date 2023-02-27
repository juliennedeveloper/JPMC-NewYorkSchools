//
//  SchoolsGateway.swift
//  20230223-KomranGhahremani-NYCSchools
//
//  Created by Komran Ghahremani on 2/23/23.
//

import Combine
import Foundation

struct SchoolsGateway: Gateway {
    let api = API()
    static let baseURL = URL(string: "https://data.cityofnewyork.us/resource/")!
    
    enum Endpoint {
        case schools
        case scores(dbn: String)
    }
    
    // Function to fetch the list of schools
    func fetchSchools() -> AnyPublisher<[School], Error> {
        run(Endpoint.schools.request)
    }
    
    // Function to fetch SAT Scores for a specific school
    func fetchScore(for school: School) -> AnyPublisher<[Score], Error> {
        run(Endpoint.scores(dbn: school.dbn).request)
    }
}

extension SchoolsGateway.Endpoint {
    
    var path: String {
        switch self {
        case .schools: return "s3k6-pzi2.json"
        case .scores: return "f9bf-2cp4.json"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .schools: return []
        case .scores(let id): return [URLQueryItem(name: "dbn", value: id)]
        }
    }
    
    var request: URLRequest {
        let urlPath = SchoolsGateway.baseURL.appending(path: path)
        
        var components = URLComponents(url: urlPath, resolvingAgainstBaseURL: false)
        components?.queryItems = queryItems
        
        guard let url = components?.url else { fatalError("malformed url request") }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(API.key)", forHTTPHeaderField: "X-App-Token")
        
        return request
    }
    
}
