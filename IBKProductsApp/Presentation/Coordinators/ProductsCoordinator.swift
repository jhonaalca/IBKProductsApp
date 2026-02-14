//
//  ProductsCoordinator.swift
//  IBKProductsApp
//
//  Created by Jhona Alca on 14/02/26.
//


// Presentation/Coordinators/ProductsCoordinator.swift
import UIKit

class ProductsCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    var childCoordinators: [CoordinatorProtocol] = []
    weak var parent: MainCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = ProductsViewModel()
        let viewController = ProductsViewController(viewModel: viewModel)
        viewController.coordinator = self
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func showProductDetail(_ product: Product) {
        // Implementaremos esto en el siguiente commit
    }
}
