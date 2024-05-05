//
//  ContentView.swift
//  LOTRConverter17
//
//  Created by Bogusz Kaszowski on 04/04/2024.
//

import SwiftUI
import TipKit

struct ContentView: View {
    @State var showExchangeInfo = false
    @State var showSelectCurrency = false
    
    @State var leftAmount = ""
    @State var rightAmount = ""
    
    @FocusState var leftTyping
    @FocusState var rightTyping
    
    @State var leftCurrency: Currency
    @State var rightCurrency: Currency
    
    private var leftCurrencySaved: Currency?
    private var rightCurrencySaved: Currency?
    
    
    init() {
        if let storedLeftCurrencyData = UserDefaults.standard.data(forKey: "leftCurrency") {
            do {
                let decoder = JSONDecoder()
                                
                leftCurrencySaved = try? decoder.decode(Currency.self, from: storedLeftCurrencyData)
                
                if leftCurrencySaved != nil {
                    leftCurrency = leftCurrencySaved ?? Currency.copperPenny

                } else {
                    leftCurrency = Currency.copperPenny
                }
                
            }
        } else {
            leftCurrency = Currency.copperPenny
        }
        
        if let storedRightCurrencyData = UserDefaults.standard.data(forKey: "rightCurrency") {
            do {
                let decoder = JSONDecoder()
                
                rightCurrencySaved = try? decoder.decode(Currency.self, from: storedRightCurrencyData)
                if rightCurrencySaved != nil {
                    rightCurrency = rightCurrencySaved ?? Currency.goldPiece
                } else {
                    rightCurrency = Currency.silverPenny
                }
                
            }
        } else {
            rightCurrency = Currency.silverPenny
        }
    }
    



    
    var body: some View {
        ZStack {
            // Background image
            Image(.background)
                .resizable()
                .ignoresSafeArea()
            VStack {
                // Prancing pony image
                Image(.prancingpony)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                // Currency exchange text
                Text("Currenct Exchange")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .keyboardType(.decimalPad)

                // Currenct conversion section
                HStack {
                    // Left conversion
                    VStack {
                        // Currency
                        HStack {
                            // Currency image
                            Image(leftCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                            
                            // Currency text
                            Text(leftCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                        }
                        .padding(.bottom, -5)
                        .onTapGesture {
                            showSelectCurrency.toggle()
                        }
                        .popoverTip(CurrencyTip(), arrowEdge: .bottom)
                        // Text
                        TextField("Amount", text: $leftAmount)
                            .textFieldStyle(.roundedBorder)
                            .focused($leftTyping)
                            .keyboardType(.decimalPad)
                    }

                    // Equal sign
                    Image(systemName: "equal")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .symbolEffect(.pulse)

                    // Right conversion
                    VStack {
                        // Currency
                        HStack {
                            // Currency text
                            Text(rightCurrency.name)
                                .font(.headline)
                                .foregroundStyle(.white)
                            // Currency image
                            Image(rightCurrency.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 33)
                        }
                        .padding(.bottom, -5)
                        .onTapGesture {
                            showSelectCurrency.toggle()
                        }
                        // Text
                        TextField("Amount", text: $rightAmount)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.trailing)
                            .focused($rightTyping)
                    }
                }
                    .padding()
                    .background(.black.opacity(0.5))
                    .clipShape(.capsule)

                Spacer()
                
                // Info button
                HStack {
                    Spacer()
                    Button {
                        showExchangeInfo.toggle()
                    } label: {
                        Image(systemName: "info.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            
                    }.padding(.trailing)
                        .task {
                            try? Tips.configure()
                        }
                        .onChange(of: leftAmount) {
                            if (leftTyping) {
                                rightAmount = leftCurrency.convert(leftAmount, to: rightCurrency)
                            }
                            
                        }
                        .onChange(of: rightAmount) {
                            if rightTyping {
                                leftAmount = rightCurrency.convert(rightAmount, to: leftCurrency)
                            }
                            
                        }
                        .onChange(of: rightCurrency) {
                            rightAmount = leftCurrency.convert(leftAmount, to: rightCurrency)
                            let encoder = JSONEncoder()
                            let data = try? encoder.encode(rightCurrency)
                            
                            if (data != nil) {
                                UserDefaults.standard.set(data, forKey: "rightCurrency")
                            }
                        }
                        .onChange(of: leftCurrency) {
                            leftAmount = rightCurrency.convert(rightAmount, to: leftCurrency)
                            
                            let encoder = JSONEncoder()
                            let data = try? encoder.encode(leftCurrency)
                            
                            if (data != nil) {
                                UserDefaults.standard.set(data, forKey: "leftCurrency")
                            }
                        }
                        .sheet(isPresented: $showExchangeInfo, content: {
                            ExchangeInfo()
                        })
                        .sheet(isPresented: $showSelectCurrency) {
                            SelectCurrency(topCurrency: $leftCurrency, bottomCurrency: $rightCurrency)
                        }
               
                }

            }
        }
    }
}

#Preview {
    ContentView()
}
