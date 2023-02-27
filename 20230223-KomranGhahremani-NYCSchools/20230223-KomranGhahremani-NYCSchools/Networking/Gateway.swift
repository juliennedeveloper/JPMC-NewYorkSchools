//
//  Gateway.swift
//  20230223-KomranGhahremani-NYCSchools
//
//  Created by Komran Ghahremani on 2/23/23.
//

import Combine
import Foundation

protocol Gateway {
    static var baseURL: URL { get }
    var api: API { get }
    
    func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error>
}

extension Gateway {
    func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
        return api.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}

/**
    `Response<T>` encapsulates request response value and the response for error code debug

    `run()` takes in request, decoder and creates data task as publisher for the request to
    produce Response by decoding data as type `T.self`
 */
struct API {
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    static let key = "dZJYKCcSqcnH7wIdPpkIOdV0f"

    func run<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                guard let url = request.url else { fatalError("Invalid request url") }
                
                // Debug printing
                let requestName = String(describing: url)
                let response = String(decoding: result.data, as: UTF8.self)
                print("API Response \(requestName): \(response)")
                
                let value = try decoder.decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
