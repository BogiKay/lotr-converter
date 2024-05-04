//
//  CurrencyTip.swift
//  LOTRConverter17
//
//  Created by Bogusz Kaszowski on 04/05/2024.
//

import Foundation
import TipKit

struct CurrencyTip: Tip {
    let title = Text("Change Currency")
    var message: Text? = Text("Tap the left or right currency to bring up the Select currency screen.")
}
