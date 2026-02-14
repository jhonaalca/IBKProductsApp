//
//  Product.swift
//  IBKProductsApp
//
//  Created by Jhona Alca on 14/02/26.
//

import Foundation

struct Product {
    let id: Int
    let title: String
    let price: Int
    let description: String
    let category: Category
    let images: [String]
    
    struct Category {
        let id: Int
        let name: String
        let image: String
    }
}
