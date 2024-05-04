//
//  ExchangeRate.swift
//  LOTRConverter17
//
//  Created by Bogusz Kaszowski on 21/04/2024.
//

import SwiftUI

struct ExchangeRate: View {
    let leftImage: ImageResource;
    let rightImage: ImageResource;
    let text: String;
    
    var body: some View {
        HStack {
            Image(leftImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
            
            Text(text)
            
            Image(rightImage)
                .resizable()
                .scaledToFit()
                .frame(height: 33)
        }
    }
}

#Preview {
    ExchangeRate(leftImage: .goldpiece, rightImage: .goldpenny, text: "1 Gold Piece = 4 Gold Pennies")
}
