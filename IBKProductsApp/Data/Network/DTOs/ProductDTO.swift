//
//  ProductDTO.swift
//  IBKProductsApp
//
//  Created by Jhona Alca on 14/02/26.
//

import Foundation

struct ProductDTO: Codable {
    let id: Int
    let title: String
    let price: Int
    let description: String
    let category: CategoryDTO
    let images: [String]
    
    struct CategoryDTO: Codable {
        let id: Int
        let name: String
        let image: String
    }
    
    func toDomain() -> Product {
        return Product(
            id: id,
            title: title,
            price: price,
            description: description,
            category: Product.Category(
                id: category.id,
                name: category.name,
                image: category.image
            ),
            images: images
        )
    }
}
