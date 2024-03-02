//
//  StepperItem.swift
//  LAB7
//
//  Created by IMD 224 on 2024-02-22.
//

import Foundation
import SwiftUI


//paso 3 en este paso lo que hacemos en identificable cada steeper y hashable
struct StepperItem: Identifiable, Hashable {
    var id = UUID() // mi id para cada steeper
    var label: String // el string que voy a mostrar
    var value: Int = 0 // mi valor inicial de mi steeper
    var type: ItemType // variable que me llama mi enumerador que contiene mis tres opcines
    
    
   // aca mi enum que almacena mis tres opciones en la variable type
    enum ItemType: String, CaseIterable, Identifiable {
        case dog = "Dog"
        case cat = "Cat"
        case circle = "Circle"
        
        var id: Self { self } // variable que me asigna el id a cada uno en cada interacion pero a cada case
    
    }
}


// son diferentes UUID() por que este se usa en struct o clases y me da un id para la cklase en general independiente de sus propiedades perovar id: Self { self }  me le da un id a cada caso de el enum y por eso se usan es en los enum
