//
//  ProductsViewModelDelegate.swift
//  IBKProductsApp
//
//  Created by Jhona Alca on 14/02/26.
//

import Foundation

protocol ProductsViewModelDelegate: AnyObject {
    func didLoadProducts()
    func didFailWithError(_ error: String)
    func showLoading()
    func hideLoading()
}

class ProductsViewModel {
    weak var delegate: ProductsViewModelDelegate?
    private let repository: ProductRepositoryProtocol
    
    private var products: [Product] = []
    private var currentOffset = 0
    private let limit = 10
    private var isLoading = false
    private var hasMoreProducts = true
    
    var numberOfProducts: Int {
        return products.count
    }
    
    func product(at index: Int) -> Product? {
        guard index < products.count else { return nil }
        return products[index]
    }
    
    init(repository: ProductRepositoryProtocol = ProductRepository()) {
        self.repository = repository
    }
    
    func loadInitialProducts() {
        products = []
        currentOffset = 0
        hasMoreProducts = true
        loadProducts()
    }
    
    func loadMoreProducts() {
        guard !isLoading && hasMoreProducts else { return }
        loadProducts()
    }
    
    private func loadProducts() {
        isLoading = true
        delegate?.showLoading()
        
        repository.getProducts(offset: currentOffset, limit: limit) { [weak self] result in
            guard let self = self else { return }
            
            self.isLoading = false
            self.delegate?.hideLoading()
            
            switch result {
            case .success(let newProducts):
                if newProducts.isEmpty {
                    self.hasMoreProducts = false
                } else {
                    self.products.append(contentsOf: newProducts)
                    self.currentOffset += self.limit
                    self.delegate?.didLoadProducts()
                }
                
            case .failure(let error):
                self.delegate?.didFailWithError(error.localizedDescription)
            }
        }
    }
}
