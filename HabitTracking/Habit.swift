//
//  Habit.swift
//  HabitTracking
//
//  Created by artembolotov on 24.01.2023.
//

import Foundation

struct Habit: Identifiable, Codable {
    var id = UUID()
    
    var name: String
    var description = ""
    
    var desiredAmount: Int
    var amount = 0
}
