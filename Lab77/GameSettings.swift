//
//  GameSettings.swift
//  LAB7
//
//  Created by IMD 224 on 2024-02-22.
//

import SwiftUI


/// this class allows to recolect the data from my steepers sepately and get the total items. it should be observable to be able to use the properties in other views
/// similar to a  static class that can be accessed from other views using this protocol
class GameSettings: ObservableObject {
    
    /// this variable will contain the total amount of all the steeper and making a sum to return that total that will determine the size of my grid
    var gridSize: Int {
           return numberOfCats + numberOfDogs + numberOfCircles
       }
    
    
    
    ///Every time a @Published property changes, it notifies all observing views so they can update..
    ///  this variable will stoarage my total amount fior my cat type  variable que me alcacenara mi numero de cat of all  my steepers
    @Published var numberOfCats: Int = 0
    /// variable que me alcacenara mi numero de cat en los steepers
    @Published var numberOfDogs: Int = 0
    /// variable que me alcacenara mi numero de cat en los steepers
    @Published var numberOfCircles: Int = 0
    
    
    
    
    
    
    /// this new properties allow to control de game  to show the text game over start false but when the user have achieved all the correect one It will be updated
    @Published var isGameOver: Bool = false
    /// this new properties allow to control general attempts
    @Published var attempts: Int = 0
    /// this new properties allow to control de game  to show the text game over start false but when the user have achieved all the correect one It will be updated
    @Published var remains: Int = 0
    
   
    /// this fuction it is going to reset all the variable.
      func resetGame() {
          isGameOver = false
          attempts = 0
          remains = 0
      }
    
    




}


///Every time a @Published property changes, it notifies all observing views so they can update..
