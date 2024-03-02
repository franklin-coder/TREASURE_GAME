//
//  GameImage.swift
//  LAB7
//
//  Created by IMD 224 on 2024-02-22.
//

import Foundation
import SwiftUI
//paso 1
// clase o struct que me permite almacenar mis ids para identificar cada image definir el string osea mi ? y definir si esta revelada o no para tener el control
//struct GameImage: Identifiable , Hashable {// identifable es que tiene in id diferente cada instancia
//    //hashable es que puedo comparar con la misma clase siendo instacias diferentes me permitira saber si es la misma o no
//    var id = UUID() // genero el id para hacerlo identifable cuando pongo identifable esta linea es escencial
//
//    var name: String // espacio para mi string que lo definire mas adelante
//
//    var isRevealed: Bool = false // mi variab le iniicla mnet estara false para que que todads aparezcan volteadas en la funcion setup que voy a realizar mas adelante
//
//
//}

struct GameImage: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var isRevealed: Bool = false
    var isFirstRevealed: Bool = false // Indica si esta imagen fue la primera de su tipo en ser revelada
}

