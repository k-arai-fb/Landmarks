//
//  RotatedBadgeSymbol.swift
//  Landmarks
//
//  Created by k.arai on 2025/06/06.
//

import SwiftUI

struct RotatedBadgeSymbol: View {
    let angle: Angle
    
    var body: some View {
        BadgeSymbol()
            .padding(60)
            .background(Color.yellow)
            .rotationEffect(angle, anchor: .bottomLeading)
    }
}

#Preview {
    RotatedBadgeSymbol(angle: Angle(degrees: 2))
}
