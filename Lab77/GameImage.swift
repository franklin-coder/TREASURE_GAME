//
//  GameImage.swift
//  LAB7
//
//  Created by IMD 224 on 2024-02-22.


import Foundation
import SwiftUI

///This would be my structure for each image with their properties
///identiflable and hashable to be able to create diferents instances.
struct GameImage: Identifiable, Hashable {
    /// to assign a different ID for each instance
    var id = UUID()
    /// name of each instance "image"
    var name: String
    /// variable to determine is the image is shown or not. Initially it would be false
    var isRevealed: Bool = false 
   
}

