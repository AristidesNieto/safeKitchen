//
//  UserProfile.swift
//  Recetario_SwiftUI
//
//  Created by Luis Angel Zempoalteca on 21/11/25.
//

import Foundation
import SwiftData

@Model
class UserProfile {
    var name: String
    var age: Int
    var isAllergicToShrimp: Bool
    var isAllergicToNuts: Bool
    var isAllergicToEggs: Bool
    var isAllergicToFish: Bool
    var isAllergicToGluten: Bool
    var isAllergicToSoy: Bool
    var isAllergicToDriedFruits: Bool
    var isAllergicToMilk: Bool

    // Inicializador corregido: Asignamos valores directamente
    init(name: String = "",
         age: Int = 0,
         isAllergicToShrimp: Bool = false,
         isAllergicToNuts: Bool = false,
         isAllergicToEggs: Bool = false,
         isAllergicToFish: Bool = false,
         isAllergicToGluten: Bool = false,
         isAllergicToSoy: Bool = false,
         isAllergicToDriedFruits: Bool = false,
         isAllergicToMilk: Bool = false) {
        
        self.name = name
        self.age = age
        self.isAllergicToShrimp = isAllergicToShrimp
        self.isAllergicToNuts = isAllergicToNuts
        self.isAllergicToEggs = isAllergicToEggs
        self.isAllergicToFish = isAllergicToFish
        self.isAllergicToGluten = isAllergicToGluten
        self.isAllergicToSoy = isAllergicToSoy
        self.isAllergicToDriedFruits = isAllergicToDriedFruits
        self.isAllergicToMilk = isAllergicToMilk
    }
}
