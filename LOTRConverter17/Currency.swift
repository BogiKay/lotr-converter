//
//  Currency.swift
//  LOTRConverter17
//
//  Created by Bogusz Kaszowski on 30/04/2024.
//
import SwiftUI

enum Currency: Double, CaseIterable, Identifiable, Codable {
    case copperPenny = 640
    case silverPenny = 64
    case silverPiece = 16
    case goldPenny = 4
    case goldPiece = 1
    
    var id: Currency { self }
    
    var image: ImageResource {
        switch self {
        case .copperPenny:
                .copperpenny
        case .silverPenny:
                .silverpenny
        case .silverPiece:
                .silverpiece
        case .goldPenny:
                .goldpenny
        case .goldPiece:
                .goldpiece
        }
    }
    
    var name: String {
        switch self {
        case .copperPenny:
                "Copper Penny"
        case .silverPenny:
                "Silver Penny"
        case .silverPiece:
                "Silver Piece"
        case .goldPenny:
                "Gold Penny"
        case .goldPiece:
                "Gold Piece"
        }
    }
    
    func convert(_ amountString: String, to currency: Currency) -> String {
        guard let amountNumber = Double(amountString) else {
            return ""
        }

        let convertedAmount = (amountNumber / self.rawValue) * currency.rawValue
        
        return String(format: "%.2f", convertedAmount)
    }
}
