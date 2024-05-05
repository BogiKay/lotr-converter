//
//  CurrencyField.swift
//  LOTRConverter17
//
//  Created by Bogusz Kaszowski on 05/05/2024.
//

import SwiftUI
import TipKit

struct CurrencyField: View {
    @Binding var currency: Currency
    @FocusState.Binding var typing: Bool
    @Binding var amount: String
    @Binding var showSelectCurrency: Bool
    var showTip: Bool? = false
    

    var body: some View {
        VStack {
            // Currency
            HStack {
                // Currency image
                Image(currency.image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 33)
                
                // Currency text
                Text(currency.name)
                    .font(.headline)
                    .foregroundStyle(.white)
            }
            .popoverTip(CurrencyTip(), arrowEdge: .bottom)
            .padding(.bottom, -5)
            .onTapGesture {
                showSelectCurrency.toggle()
            }
            
            // Text
            TextField("Amount", text: $amount)
                .textFieldStyle(.roundedBorder)
                .focused($typing)
                .keyboardType(.decimalPad)
                .onTapGesture {
                    $typing.wrappedValue = true
                }
                
        }
        .task {
            try? Tips.configure()
        }
    }
}

#Preview {
    CurrencyField(currency: .constant(Currency.silverPenny), typing: FocusState<Bool>().projectedValue, amount: .constant("145"), showSelectCurrency: .constant(false), showTip: true)
}
