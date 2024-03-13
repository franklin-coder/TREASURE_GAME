//
//  GameSettings.swift
//  LAB7
//
//  Created by IMD 224 on 2024-02-22.
//

import SwiftUI

class GameSettings: ObservableObject { 
    
    var gridSize: Int {
           return numberOfCats + numberOfDogs + numberOfCircles
       }
    
    
    // observable Object es basicamente lo que manejasmo en unity o c# como una clase static que puede ser accedida solo con llaamrla desde cualquier otro lugar dentro del namespace aqui es lo mismo desde cualquier vista puedo acceder teniendo este protocolo
    //lo estoy usando por que necesito pasar estas variables tanto a mi sertings como a mi gameView entonces no estoy usando binding como usualmente sino el protocolo observableObject
    @Published var numberOfCats: Int = 0  // variable que me alcacenara mi numero de cat en los steepers
    @Published var numberOfDogs: Int = 0 // variable que me almacenara numero de dogs de los steeper
    @Published var numberOfCircles: Int = 0 // variable que me almacenara numero de circles en los steepers
    
    // Nuevas propiedades para controlar el estado del juego
    @Published var isGameOver: Bool = false
    @Published var attempts: Int = 0
    @Published var remains: Int = 0
    
    // Método para reiniciar el juego
      func resetGame() {
          isGameOver = false
          attempts = 0
          remains = 0// algún valor inicial, dependiendo de tu lógica de juego GameView
      }
    
    




}

//@Published lo que me permite es que cuando estoy usando el protocolo de ObservableObject entonces usando este decorador me permite actualizar este valor donde sea que se este usando independiente de la vista por ejemplo si lo modifico en los steepers entonces me lo actualizara en la vista de gameView y por suspuesto en la clase ademas de su propio vista

//Cada vez que una propiedad @Published cambia, notifica a todas las vistas que la observan para que se actualicen.
