//
//  MainCoordinator.swift
//  IBKProductsApp
//
//  Created by Jhona Alca on 14/02/26.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [CoordinatorProtocol] { get set }
    func start()
}

class MainCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    var childCoordinators: [CoordinatorProtocol] = []
    let tabBarController = UITabBarController()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        // Products coordinator
        let productsNavController = UINavigationController()
        let productsCoordinator = ProductsCoordinator(navigationController: productsNavController)
        productsCoordinator.parent = self
        childCoordinators.append(productsCoordinator)
        productsCoordinator.start()
        
        productsNavController.tabBarItem = UITabBarItem(
            title: "Productos",
            image: UIImage(systemName: "list.bullet"),
            selectedImage: UIImage(systemName: "list.bullet.fill")
        )
        
        // Menu Coordinator
        let menuNavController = UINavigationController()
        menuNavController.tabBarItem = UITabBarItem(
            title: "Menú",
            image: UIImage(systemName: "gear"),
            selectedImage: UIImage(systemName: "gear.fill")
        )
        
        tabBarController.viewControllers = [
            productsNavController,
            menuNavController
        ]
        
        navigationController.setViewControllers([tabBarController], animated: false)
    }
}
