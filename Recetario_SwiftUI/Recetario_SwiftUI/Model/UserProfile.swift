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
    var biologicalSex: String
    var height: Double
    var weight: Double
    
    var isAllergicToShrimp: Bool
    var isAllergicToNuts: Bool
    var isAllergicToEggs: Bool
    var isAllergicToFish: Bool
    var isAllergicToGluten: Bool
    var isAllergicToSoy: Bool
    var isAllergicToDriedFruits: Bool
    var isAllergicToMilk: Bool

    init(name: String = "",
         age: Int = 0,
         biologicalSex: String = "Hombre",
         height: Double = 0.0,
         weight: Double = 0.0,
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
        self.biologicalSex = biologicalSex
        self.height = height
        self.weight = weight
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
