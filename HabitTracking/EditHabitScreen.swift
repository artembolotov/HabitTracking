//
//  EditHabitScreen.swift
//  HabitTracking
//
//  Created by artembolotov on 30.01.2023.
//

import SwiftUI

struct EditHabitScreen: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var allHabits: [Habit]
    @State var index: Int?
    
    @State private var showDeletingAlert = false
    
    var body: some View {
        NavigationView {
            if let index = index {
                Form {
                    Section {
                        TextField("Your habbit", text: $allHabits[index].name)                        
                        TextField("Description", text: $allHabits[index].description)
                    }
                    Section {
                        Stepper("\(allHabits[index].desiredAmount)", value: $allHabits[index].desiredAmount, in: 0...50)
                    } header: {
                        Text("Desired amount")
                    }
                    
                    Section {
                        Stepper("\(allHabits[index].amount)", value: $allHabits[index].amount, in: 0...50)
                    } header: {
                        Text("Actual amount")
                    }
                }
                .navigationTitle("Edit the habbit")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(role: .destructive) {
                            showDeletingAlert = true
                        } label: {
                            Image(systemName: "trash")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Done")
                        }
                    }
                }
            } else {
                EmptyView()
            }
        }
        .confirmationDialog("Really delete the habbit?", isPresented: $showDeletingAlert) {
            Button("Delete", role: .destructive, action: deleteHabbit)
        }
    }
    
    private func deleteHabbit() {
        guard let index = index else { return }
        self.index = nil
        allHabits.remove(at: index)
        dismiss()
    }
}

struct EditHabitScreen_Previews: PreviewProvider {
    static var previews: some View {
        let habits = Habits().items
        EditHabitScreen(allHabits: .constant(habits), index: 0)
    }
}
