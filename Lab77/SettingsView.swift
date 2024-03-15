//
//  SettingsView.swift
//  LAB7
//
//  Created by IMD 224 on 2024-02-22.
//

import SwiftUI



struct SettingsView: View {
    /// Here it is storaging all my GameSettings with all the properties
    @ObservedObject var gameSettings: GameSettings
    /// Here I am creating an empty array to storage my steepers usign my stepperItem as datatype for all my items inside the array
    @State private var stepperItems: [StepperItem] = []

    
  
    
    var body: some View {
        
        ///This allows you to display elements within your view so that it shows the buttons at the top, then the title, and then the list of steppers
        NavigationView {
          
            ///This component is essentially the same as the ul in HTML, allowing me to display elements in a vertical list, similar to how ul works with li, except here there's no need to include the li.
            List {
                ///Here, I am iterating over each stepper item that I passed at the beginning with the parameter of my class to bring in the properties, which is why I pass two parameters: the first is the index, meaning each value in this variable, and the second is the id of each one. Then, for each item, i.e., index, I create a section that allows me to display in a more organized manner each stepper with its properties
                ForEach($stepperItems.indices, id: \.self) { index in
                    ///Here begins the section of each stepper.
                    Section {
                        ///This is simply the header of each stepper, which allows me to choose among the options I have in my enum, such as type, meaning it lets me choose among the types like dog, cats, and circles. There is a bug because it never actually shows the label in the selection. What I do is pass the index to my stepper, which is my array variable of type stepper, and access the type, but I still don't know which one has been chosen; I only store the index and the types.
                        Picker("", selection: $stepperItems[index].type) {
                            ForEach(StepperItem.ItemType.allCases) { type in /// The allCases property is a feature of enumerations in Swift that conform to the CaseIterable protocol. By declaring your enumeration ItemType with CaseIterable, Swift automatically provides you with this property, which includes all instances of the enumeration cases
                                Text(type.rawValue).tag(type) ///Text(type.rawValue): Creates a text view for the current option in the iteration.
                                   ///type.rawValue refers to the associated String value for the current enumeration case, which would be "Dog", "Cat", or "Circle" in your example.
                                  /// The value of the tag must be of the same type as the property to which the Picker's selection ($stepperItems[index].type) is bound.
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle()) ///It allows me to visualize in a title-type segment
                        
                        
                        ///Here, I simply add a stepper in each section after the picker. The label will be provided by the picker using rawValue, and the initial value is what is held within that instance, which was initially set to 0 in the class. But later, it will update me if there is a greater quantity; for example, if I chose 1 and that instance has 1, then it updates me on that stepper
                        Stepper("\(stepperItems[index].type.rawValue): \(stepperItems[index].value)", value: $stepperItems[index].value, in: 0...10, onEditingChanged: { _ in
                            updateGameSettings() ///In each onEditChange, meaning every time I make a change in edit, whether increasing or decreasing the value, it calls the updateGameSettings() function, which allows me to update my individual variables for dogs, cats, and circles.
                        })
                    }//aca finaliza la seccion de cada steeper
                } // aca termina mi for each
                
                .onDelete(perform: deleteItems)
                
                
            } // aca termina mi lista
            .listStyle(GroupedListStyle()) // simplemente para que me le de formato a mi lista sin tener que crearlo yo
            .navigationTitle("Settings") //  este es mi titulo dentro de navigation view
            .toolbar { // mi barra de opciones superior
                ToolbarItem(placement: .navigationBarTrailing) { /// boton de edit que llama su propia funcoon EditBottun()
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
    /// esta funcion privada simplemetante me toma los valores de dogs and cats separados using a map of mi steeper item and taking each type and updateing the variable with the amount
    private func updateGameSettings() {
        gameSettings.numberOfCats = stepperItems.filter { $0.type == .cat }.reduce(0) { $0 + $1.value }
        gameSettings.numberOfDogs = stepperItems.filter { $0.type == .dog }.reduce(0) { $0 + $1.value }
        gameSettings.numberOfCircles = stepperItems.filter { $0.type == .circle }.reduce(0) { $0 + $1.value }
        gameSettings.isGameOver = false
        gameSettings.remains = 0
        gameSettings.attempts = 0
    }
    
    
    /// Add a new stepper using append with the label I chose in my picker, and by default the circle, but I can change it without a problem
    private func addStepperItem() {
        stepperItems.append(StepperItem(label: "New Item", type: .circle))
    }
    
    
    /// This function allows to delete each steeper
    /// - Parameter offsets: indexSet as a parameter, which essentially attaches the selected index.
    private func deleteItems(at offsets: IndexSet) {  //
        stepperItems.remove(atOffsets: offsets)  // aca elimino con la funcioon remove que usa atoffset para tener todos los indices pero le paso el propio indice osea el del mismo steeper con el que estoy interactuando
    }
}


