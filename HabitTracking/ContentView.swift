//
//  ContentView.swift
//  HabitTracking
//
//  Created by artembolotov on 23.01.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var habits = Habits()
    
    @State private var isShowingAddHabit = false
    @State private var indexToEdit: Int?
    
    var body: some View {
        NavigationView {
            Group {
                if habits.items.isEmpty {
                    Text("Add new habits")
                        .font(.callout)
                } else {
                   
                    let colums = [
                        GridItem(.adaptive(minimum: 250))
                    ]
                    
                    ScrollView {
                        LazyVGrid(columns: colums) {
                            ForEach(habits.items.indices, id: \.self) { index in
                                let habit = habits.items[index]
                                
                                HStack(alignment: .center, spacing: 0) {
                                    VStack(alignment: .leading) {
                                        Text(habit.name)
                                            .font(.headline)
                                        if let description = habit.description, !description.isEmpty {
                                            Text(description)
                                                .font(.subheadline)
                                        }
                                        HStack {
                                            Text("\(habit.amount) / \(habit.desiredAmount)")
                                                .font(.subheadline)
                                                .fontWeight(.bold)
                                                .padding(.vertical, 1)
                                            HabitProgressView(actualAmount: habit.amount, desiredAmount: habit.desiredAmount)
                                                .padding(.trailing, -16)
                                        }
                                        .padding(.trailing, 0)
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        indexToEdit = index
                                    }
                                    Button {
                                        habits.items[index].amount += 1
                                    } label: {
                                        Image(systemName: "plus.app")
                                            .font(.largeTitle)
                                    }
                                    .padding()
                                }
                                .background {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.accentColor)
                                        .shadow(radius: 8)
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }
            }
            .navigationTitle("My habits")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Reset amount", action: resetAmount)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingAddHabit = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingAddHabit) {
            AddHabitScreen(habits: $habits.items)
        }
        .sheet(item: $indexToEdit) { index in
            EditHabitScreen(allHabits: $habits.items, index: index)
        }
    }
    
    private func resetAmount() {
        habits.items.indices.forEach { index in
            habits.items[index].amount = 0
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
