//
//  Endpoint.swift
//  IBKProductsApp
//
//  Created by Jhona Alca on 14/02/26.
//

import Foundation

enum Endpoint {
    case products(offset: Int, limit: Int)
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.escuelajs.co"
        components.path = path
        
        if case .products(let offset, let limit) = self {
            components.queryItems = [
                URLQueryItem(name: "offset", value: "\(offset)"),
                URLQueryItem(name: "limit", value: "\(limit)")
            ]
        }
        
        return components.url
    }
    
    private var path: String {
        switch self {
        case .products:
            return "/api/v1/products"
        }
    }
}
