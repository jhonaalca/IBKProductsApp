//
//  APIClient.swift
//  IBKProductsApp
//
//  Created by Jhona Alca on 14/02/26.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case noData
    case decodingError
    case networkError(Error)
}

protocol APIClientProtocol {
    func request<T: Codable>(_ endpoint: Endpoint, completion: @escaping (Result<T, APIError>) -> Void)
}

class APIClient: APIClientProtocol {
    static let shared = APIClient()
    private let session = URLSession.shared
    
    private init() {}
    
    func request<T: Codable>(_ endpoint: Endpoint, completion: @escaping (Result<T, APIError>) -> Void) {
        guard let url = endpoint.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.decodingError))
                }
            }
        }
        
        task.resume()
    }
}
