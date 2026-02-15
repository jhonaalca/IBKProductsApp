//
//  MenuCoordinator.swift
//  IBKProductsApp
//
//  Created by Jhona Alca on 14/02/26.
//

import UIKit

class MenuCoordinator: NSObject, CoordinatorProtocol {
    var navigationController: UINavigationController
    var childCoordinators: [CoordinatorProtocol] = []
    weak var parent: MainCoordinator?
    private let colorRepository = ColorRepository()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    func start() {
        let viewModel = MenuViewModel(colorRepository: colorRepository)
        let viewController = MenuViewController(viewModel: viewModel)
        viewController.coordinator = self
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func showColorPicker(currentColor: UIColor) {
        let colorPicker = UIColorPickerViewController()
        colorPicker.selectedColor = currentColor
        colorPicker.delegate = self
        colorPicker.supportsAlpha = false // Solo colores sólidos
        navigationController.present(colorPicker, animated: true)
    }
}

// MARK: - UIColorPickerViewControllerDelegate
extension MenuCoordinator: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let selectedColor = viewController.selectedColor
        
        print("🎨 Color seleccionado: \(selectedColor)")
        
        // Guardar en repository
        colorRepository.saveTabBarColor(selectedColor)
        
        // Actualizar tabBar a través del parent coordinator
        parent?.updateTabBarColor(selectedColor)
        
        // Notificar al ViewModel a través del método público
        if let menuVC = navigationController.viewControllers.first as? MenuViewController {
            menuVC.updateColor(selectedColor)
        }
        
        viewController.dismiss(animated: true)
    }
}
