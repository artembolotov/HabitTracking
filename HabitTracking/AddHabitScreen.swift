//
//  AddHabitScreen.swift
//  HabitTracking
//
//  Created by artembolotov on 25.01.2023.
//

import SwiftUI

struct AddHabitScreen: View {
    @Binding var habits: [Habit]
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var description = ""
    @State private var desiredAmount = 1
    
    private var saveAllowed: Bool {
        !name.isEmpty
    }
    
    private enum Field: Hashable {
        case name, description
    }
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField("Your new habit", text: $name)
                            .submitLabel(.next)
                            .focused($focusedField, equals: .name)
                            .onSubmit {
                                focusedField = .description
                            }
                        
                        TextField("Add a description if you'd like", text: $description)
                            .submitLabel(.done)
                            .focused($focusedField, equals: .description)
                    } header: {
                        Text("Habit")
                    }
                    Section {
                        Stepper("\(desiredAmount)", value: $desiredAmount, in: 0...50)
                    } header: {
                        Text("Desired amount")
                    }
                }
            }
            .navigationTitle("New habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let newHabit = Habit(name: name, description: description, desiredAmount: desiredAmount)
                        habits.append(newHabit)
                        
                        dismiss()
                    }
                    .disabled(!saveAllowed)
                }
            }
        }
        .onAppear {
            focusedField = .name
        }
    }
}

struct AddHabitScreen_Previews: PreviewProvider {
    @StateObject var habits = Habits()
    static var previews: some View {
        AddHabitScreen(habits: .constant(Habits().items))
    }
}
