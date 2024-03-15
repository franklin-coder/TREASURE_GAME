//
//  StepperItem.swift
//  LAB7
//
//  Created by IMD 224 on 2024-02-22.
//

import Foundation
import SwiftUI


///This would be my structure for each Steeper with their properties

struct StepperItem: Identifiable, Hashable {
    /// individual id for each steeper
    var id = UUID()
    /// this is going to be the label for each steeper this will show the type taking the rawValue of each picker and putting as label
    var label: String //
    /// The initial value for each stepper
    var value: Int = 0
    /// variable with a enum as value than contain each type of image
    var type: ItemType
    

    /// here my enum for my variable type storage all my cases or types
    /// it should be type string to get the name, CaseIterable to be able to go for eachone using foreach, and identifable to be able to differenciate each one
    enum ItemType: String, CaseIterable, Identifiable {
        case dog = "Dog"
        case cat = "Cat"
        case circle = "Circle"
        
        /// variable que me asigna el id a cada uno en cada interacion pero a cada case
        var id: Self { self }
    
    }
}


