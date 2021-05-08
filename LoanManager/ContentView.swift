//
//  ContentView.swift
//  LoanManager
//
//  Created by Home on 5/7/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            LoanView().tabItem {
                Label("Loans", systemImage: "square.and.arrow.down")
            }
            PaymentView().tabItem {
                Label("Payments", systemImage: "square.and.arrow.up")
            }
        }
    }
}
