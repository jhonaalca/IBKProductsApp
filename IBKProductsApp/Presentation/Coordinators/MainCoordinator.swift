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
    private let colorRepository = ColorRepository()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        applySavedTabBarColor()
        setupNotifications()
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
        let menuCoordinator = MenuCoordinator(navigationController: menuNavController)
        menuCoordinator.parent = self
        childCoordinators.append(menuCoordinator)
        menuCoordinator.start()
        
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
    
    func updateTabBarColor(_ color: UIColor) {
        print("🎨 Actualizando tabBar color a: \(color)")
        tabBarController.tabBar.barTintColor = color
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.backgroundColor = color
        
        // Guardar en repository
        colorRepository.saveTabBarColor(color)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func applySavedTabBarColor() {
        if let savedColor = colorRepository.getTabBarColor() {
            print("🎨 Aplicando color guardado al tabBar: \(savedColor)")
            tabBarController.tabBar.barTintColor = savedColor
            tabBarController.tabBar.isTranslucent = false
            tabBarController.tabBar.backgroundColor = savedColor
        } else {
            print("🎨 Usando color por defecto")
            tabBarController.tabBar.barTintColor = .systemBlue
            tabBarController.tabBar.isTranslucent = false
        }
    }
    
    private func setupNotifications() {
        // Para cuando la app vuelve de background
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleAppWillEnterForeground),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
    }
    
    @objc private func handleAppWillEnterForeground() {
        applySavedTabBarColor()
    }
}
