//
//  FavoriteButton.swift
//  Landmarks
//
//  Created by k.arai on 2025/06/05.
//

import SwiftUI

struct FavoriteButton: View {
    //別の場所での変更も反映できるように　値型に対して
    @Binding var isSet: Bool
    var body: some View {
        Button {
            isSet.toggle()
        } label: {
            Label("Toggle Favorite", systemImage: isSet ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .foregroundColor(isSet ? .yellow : .gray)
        }

    }
}

#Preview {
    FavoriteButton(isSet: .constant(true))
}
