//
//  SettingsView.swift
//  LAB7
//
//  Created by IMD 224 on 2024-02-22.
//

import SwiftUI

// paso 4 aca voy a implementar la vista del setting view que segun el lab dice que debo tener dos steeper y parar con un binding a cada steeper al numero a mi gameView para definir el numero de columnas y filas y cuantos debe de adivinar
struct SettingsView: View {
    @ObservedObject var gameSettings: GameSettings  // llamo mi clase de gameSetting donde tengo todas mis variables  que voy a usar para almacenar los valores osea cantidad de cada steeper y tipo de imagen cada una con su respectivo id
    @State private var stepperItems: [StepperItem] = [] // lamo mi clase steeper que tambien tiene su propio id en cada instancia  le estoy pasando un alista ya que est tipo array y el tipo es de la clase osea que cada elemento contiene todas las propiedades de la clase asi cada vez que le de al mas se agragara un steeper pero con estas caracteristicas y se pasa como estado por que obviamente puede cambiar

    
  
    
    var body: some View {
        
        
        NavigationView {
            //este me permite mostrar los elementos dentro de mi vista para que me muestre los botones arriba luego el titulo y luego si la lista de steepers
            List {  //este componnete basicamente es el mismo de ul en html que me permite mostrar en una lista verticalmente de los elementos asi como funciona la ul con los li solo que aca no hay que poner el li
                ForEach($stepperItems.indices, id: \.self) { index in  //y aca estoy iterando sobre cada uno de los stteper item que pase al incio con el parametro de mi clase para que me traiga las properties por eso le paso dos parametros el primero es que indice osea cada valor que esre eb esta variable y segundo el id  de cada uno luego por cada item osea index creo una seccion que me permite mostrar de una manera mas organizada cada steeper con sus propiedades
                    Section { // aca inicia la seccion de cada steeper
                        Picker("", selection: $stepperItems[index].type) { // este simplemente es el encabezado de capa steeper que mepermite elegir entre las opciones que tengo en mi enum como type osea me permite elegir en cada una de los tipos dog cats and circles // tiene un bug por que en realidad nunca muestra el label en la seleccion lo que hago es pasar a mi steeper que es mi variable de arrays tipo steeper su index y entrar al type pero aun no se cual ha elegido solo almaceno el indice y los types
                            ForEach(StepperItem.ItemType.allCases) { type in // La propiedad allCases es una característica de las enumeraciones en Swift que conforman al protocolo CaseIterable. Al declarar tu enumeración ItemType con CaseIterable, Swift automáticamente te proporciona esta propiedad, la cual incluye todas las instancias de los casos de enumeración.
                                Text(type.rawValue).tag(type) //Text(type.rawValue): Crea una vista de texto para la opción actual en la iteración.
                                   //type.rawValue se refiere al valor asociado de String para el caso de enumeración actual, que sería "Dog", "Cat", o "Circle" en tu ejemplo.
                                  // El valor del tag debe ser del mismo tipo que la propiedad a la que está vinculada la selección del Picker ($stepperItems[index].type)
                            }
                        } // acaba mi picker de la parte superiro de mi steeper que es la primera parte de cada una de mis secciones
                        .pickerStyle(SegmentedPickerStyle()) //me permite visualizar en un segmento tipo titulo
                        
                        // aca simplemete agrego un steeper en cada seccion despues del picker el label sera el que me entrege el picker usando rawValue y el value inicial es el que tenga dentro de esa instancia que inicialmente lo puso 0 en la clase pero luego me va a mostarr si tenga mas cantidad por ejemplo elegi 1 esa instacia tiene 1 entonces me lo actualiza en ese steeper
                        Stepper("\(stepperItems[index].type.rawValue): \(stepperItems[index].value)", value: $stepperItems[index].value, in: 0...10, onEditingChanged: { _ in
                            updateGameSettings() // en cada on edit change osea cada vez que haga un cambio en edit sea que aumente el valor o lo disminuya  me llama la funcionupdateGameSettings() que me permite actualizar mis variables individuales de dogs cats and circles
                        })
                    }//aca finaliza la seccion de cada steeper
                } // aca termina mi for each
                
                .onDelete(perform: deleteItems) // funciona cuando tenemos una lista y permite la eliminacion en este caso pasamos un offset osea el indice que queremos eliminar en este caso pase una funcion que es la que me elimina private
                //func deleteItems(at offsets: IndexSet) {
                //stepperItems.remove(atOffsets: offsets)
                //}
                
            } // aca termina mi lista
            .listStyle(GroupedListStyle()) // simplemente para que me le de formato a mi lista sin tener que crearlo yo
            .navigationTitle("Settings") //  este es mi titulo dentro de navigation view
            .toolbar { // mi barra de opciones superior
                ToolbarItem(placement: .navigationBarTrailing) { // boton de edit que llama su propia funcoon EditBottun()
                    EditButton().foregroundColor(.cyan)
                }
                ToolbarItem(placement: .navigationBarTrailing) { // boton de plus o sumar para agregar un nuevo steeper y llama la funcion de adicionar
                    Button(action: addStepperItem) {
                        Image(systemName: "plus")
                    }.foregroundColor(.cyan)
                }
            }
        }
    }
  /// esta funcion privada simplemetante me toma los valores de dogs and cats separados
    private func updateGameSettings() {
        gameSettings.numberOfCats = stepperItems.filter { $0.type == .cat }.reduce(0) { $0 + $1.value }
        gameSettings.numberOfDogs = stepperItems.filter { $0.type == .dog }.reduce(0) { $0 + $1.value }
        gameSettings.numberOfCircles = stepperItems.filter { $0.type == .circle }.reduce(0) { $0 + $1.value }
        gameSettings.isGameOver = false
        gameSettings.remains = 0
        gameSettings.attempts = 0
    }

    private func addStepperItem() {
        stepperItems.append(StepperItem(label: "New Item", type: .circle)) //agrega un nuevo steeper usando append con el label que elegi en mi picker y por default el circulo pero lo puedo cambiar sin problem
    }

    private func deleteItems(at offsets: IndexSet) {  //esta funcion usa como parametro el indexSet que basicamente adjunta el indice seleccionado
        stepperItems.remove(atOffsets: offsets)  // aca elimino con la funcioon remove que usa atoffset para tener todos los indices pero le paso el propio indice osea el del mismo steeper con el que estoy interactuando
    }
}


