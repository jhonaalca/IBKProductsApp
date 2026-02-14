//
//  ProductRepositoryProtocol.swift
//  IBKProductsApp
//
//  Created by Jhona Alca on 14/02/26.
//

import Foundation

protocol ProductRepositoryProtocol {
    func getProducts(offset: Int, limit: Int, completion: @escaping (Result<[Product], Error>) -> Void)
}
