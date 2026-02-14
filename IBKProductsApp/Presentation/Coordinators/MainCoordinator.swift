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
        let placeholderVC = UIViewController()
        placeholderVC.view.backgroundColor = .white
        placeholderVC.title = "Productos"
        
        let placeholderNav = UINavigationController(rootViewController: placeholderVC)
        placeholderNav.tabBarItem = UITabBarItem(
            title: "Productos",
            image: UIImage(systemName: "list.bullet"),
            selectedImage: UIImage(systemName: "list.bullet.fill")
        )
        
        tabBarController.viewControllers = [placeholderNav]
        navigationController.setViewControllers([tabBarController], animated: false)
    }
}
