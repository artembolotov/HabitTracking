//
//  Habits.swift
//  HabitTracking
//
//  Created by artembolotov on 24.01.2023.
//

import Foundation

class Habits: ObservableObject {
    @Published var items: [Habit] {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "habits")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "habits"),
           let decodedItems = try?  JSONDecoder().decode([Habit].self, from: savedItems) {
            items = decodedItems
        } else {
            items = [
                Habit(name: "Habit 1", desiredAmount: 5, amount: 2),
                Habit(name: "Habit 2", description: "Some description", desiredAmount: 1, amount: 1)
            ]
            //items = []
        }
    }
}
