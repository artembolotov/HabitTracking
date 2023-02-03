//
//  HabitProgressView.swift
//  HabitTracking
//
//  Created by artembolotov on 28.01.2023.
//

import SwiftUI

struct HabitProgressView: View {
    let actualAmount: Int
    let desiredAmount: Int
    
    var body: some View {
        GeometryReader { proxy in
            let fullWidth = proxy.size.width
            let actualWidth = fullWidth * CGFloat(actualAmount) / CGFloat(desiredAmount)
            
            let isNotFilled = actualAmount < desiredAmount
            VStack(alignment: .center){
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(isNotFilled ? .gray : .green)
                        .frame(width: fullWidth)
                    if isNotFilled {
                        Rectangle()
                            .fill(.yellow)
                            .frame(width: actualWidth)
                    }
                }
            }
        }
        .frame(maxHeight: 4)
    }
}

struct HabitProgressView_Previews: PreviewProvider {
    static var previews: some View {
        HabitProgressView(actualAmount: 3, desiredAmount: 8)
            .previewLayout(.fixed(width: 300, height: 20))
    }
}
