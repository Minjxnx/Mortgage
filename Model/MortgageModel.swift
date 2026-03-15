//
//  MortgageModel.swift
//  Mortgage
//
//  Created by Philip Trwoga on 16/10/2024.
//

import Foundation
import SwiftData

@Model
class MortgageModel: Identifiable {
    
    var lender: String
    var amount: Double
    var interestPercent: Double
    var periodYears: Int
    var payment: Double
    
    init(
        lender: String,
        amount: Double,
        interestPercent: Double,
        periodYears: Int,
        payment: Double
    ) {
        self.lender = lender
        self.amount = amount
        self.interestPercent = interestPercent
        self.periodYears = periodYears
        self.payment = payment
    }
}
