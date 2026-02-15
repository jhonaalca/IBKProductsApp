//
//  ColorRepository.swift
//  IBKProductsApp
//
//  Created by Jhona Alca on 14/02/26.
//

import UIKit

class ColorRepository: ColorRepositoryProtocol {
    private let userDefaults = UserDefaults.standard
    private let colorKey = "tabBarColor"
    
    func saveTabBarColor(_ color: UIColor) {
        do {
            let colorData = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: true)
            userDefaults.set(colorData, forKey: colorKey)
            userDefaults.synchronize() // Forzar escritura inmediata
            print("✅ Color guardado: \(color)")
        } catch {
            print("❌ Error guardando color: \(error)")
        }
    }
    
    func getTabBarColor() -> UIColor? {
        guard let colorData = userDefaults.data(forKey: colorKey) else {
            print("ℹ️ No hay color guardado")
            return nil
        }
        
        do {
            if let color = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: colorData) {
                print("✅ Color recuperado: \(color)")
                return color
            }
        } catch {
            print("❌ Error recuperando color: \(error)")
        }
        
        return nil
    }
}
