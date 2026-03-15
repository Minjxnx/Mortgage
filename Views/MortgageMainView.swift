//
//  MortgageMainView.swift
//  Mortgage
//
//  Created by Philip Trwoga on 14/10/2024 and October 2025
// Mock Test 

import SwiftUI
import SwiftData

struct MortgageMainView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    // Persist values even when app closes
    @AppStorage("lender") var lender: String = "None"
    @AppStorage("amount") var amount: Double = 300000
    @AppStorage("interestPercent") var interestPercent: Double = 4
    @AppStorage("periodYears") var periodYears: Int = 25
    
    // Payment output
    @State private var payment: Double?
    
    // Alert
    @State private var showAlert = false
    
    var body: some View {
        
        VStack(spacing: 20){
            
            Text("Mortgage Calculator")
                .font(.title)
                .padding()
            
            // Lender
            HStack{
                Label("Lender", systemImage: "house.fill")
                TextField("Enter lender", text: $lender)
                    .textFieldStyle(.roundedBorder)
            }
            
            // Amount
            HStack{
                Label("Amount", systemImage: "banknote")
                TextField("Enter amount", value: $amount, format: .number)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)
            }
            
            // Interest
            HStack{
                Label("Interest", systemImage: "percent")
                TextField("Enter interest", value: $interestPercent, format: .number)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)
            }
            
            // Period
            HStack{
                Label("Period (years)", systemImage: "calendar")
                TextField("Enter period", value: $periodYears, format: .number)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
            }
            
            // Button
            Button("Calculate Payment") {
                
                if lender.isEmpty {
                    showAlert = true
                } else {
                    calculateMortgage()
                }
            }
            .padding()
            
            // Payment output
            if let payment = payment {
                Text("Payment is: £\(payment, specifier: "%.2f")")
                    .font(.headline)
            }
            
            Spacer()
        }
        .padding()
        
        .alert("Empty Fields", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("One or more text fields are empty. Please fill in all fields.")
        }
    }
    
    
    // Mortgage Calculation
    func calculateMortgage() {
        
        let principal = max(0,amount)
        let annualRate = max(0,interestPercent) / 100.0
        let monthlyRate = annualRate / 12.0
        let n = Double(max(0,periodYears) * 12)
        
        guard principal > 0, n > 0 else {
            payment = nil
            hideKeyboard()
            return
        }
        
        if monthlyRate == 0 {
            payment = principal / n
        } else {
            let factor = pow(1.0 + monthlyRate, n)
            payment = (principal * monthlyRate * factor) / (factor - 1.0)
        }
        
        // Save to SwiftData
        let newQuote = MortgageModel(
            lender: lender,
            amount: amount,
            interestPercent: interestPercent,
            periodYears: periodYears,
            payment: payment ?? 0
        )
        
        modelContext.insert(newQuote)
        
        hideKeyboard()
    }
    
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    MortgageMainView()
}
  
