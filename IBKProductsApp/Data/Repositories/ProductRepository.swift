//
//  ProductRepository.swift
//  IBKProductsApp
//
//  Created by Jhona Alca on 14/02/26.
//

import Foundation

class ProductRepository: ProductRepositoryProtocol {
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient.shared) {
        self.apiClient = apiClient
    }
    
    func getProducts(offset: Int, limit: Int, completion: @escaping (Result<[Product], Error>) -> Void) {
        let endpoint = Endpoint.products(offset: offset, limit: limit)
        
        apiClient.request(endpoint) { (result: Result<[ProductDTO], APIError>) in
            switch result {
            case .success(let productDTOs):
                let products = productDTOs.map { $0.toDomain() }
                completion(.success(products))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
