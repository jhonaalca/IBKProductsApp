//
//  ColorRepositoryProtocol.swift
//  IBKProductsApp
//
//  Created by Jhona Alca on 14/02/26.
//

import UIKit

protocol ColorRepositoryProtocol {
    func saveTabBarColor(_ color: UIColor)
    func getTabBarColor() -> UIColor?
}
