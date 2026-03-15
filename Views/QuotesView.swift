//
//  ContentView.swift
//  Mortgage
//
//  Created by Philip Trwoga on 14/10/2024.
//
    
import SwiftUI
import SwiftData

struct QuotesView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query var quotes: [MortgageModel]
    
    var body: some View {
        
        VStack {
            
            Text("Quotes List")
                .font(.title)
                .padding()
            
            List(quotes) { quote in
                
                VStack(alignment: .leading, spacing: 6) {
                    
                    Label("Lender \(quote.lender)", systemImage: "house.fill")
                    
                    Label("Loan amount £\(quote.amount, specifier: "%.0f")", systemImage: "banknote")
                    
                    Label("Interest \(quote.interestPercent, specifier: "%.1f")%", systemImage: "percent")
                    
                    Label("Period \(quote.periodYears) years", systemImage: "calendar")
                    
                    Label("Payment £\(quote.payment, specifier: "%.2f")", systemImage: "sterlingsign")
                }
                .padding(.vertical, 5)
            }
        }
    }
}

#Preview {
    QuotesView()
}

