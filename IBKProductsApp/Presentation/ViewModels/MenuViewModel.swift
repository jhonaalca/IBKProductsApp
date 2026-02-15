//
//  MenuViewModel.swift
//  IBKProductsApp
//
//  Created by Jhona Alca on 14/02/26.
//

import UIKit

protocol MenuViewModelDelegate: AnyObject {
    func didUpdateTabBarColor()
}

class MenuViewModel {
    weak var delegate: MenuViewModelDelegate?
    private let colorRepository: ColorRepositoryProtocol
    
    init(colorRepository: ColorRepositoryProtocol = ColorRepository()) {
        self.colorRepository = colorRepository
    }
    
    func getCurrentTabBarColor() -> UIColor? {
        return colorRepository.getTabBarColor()
    }
    
    func saveTabBarColor(_ color: UIColor) {
        colorRepository.saveTabBarColor(color)
        delegate?.didUpdateTabBarColor()
    }
}
