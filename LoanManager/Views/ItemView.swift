//
//  ItemView.swift
//  LoanManager
//
//  Created by Home on 5/7/21.
//

import SwiftUI

struct ItemView: View {
    let colors: [Color] = [.gray, .blue, .green, .red, .purple, .orange]
    var item: Loan
    var body: some View {
        VStack {
             ZStack {
                HStack {
                    Image(systemName: "star").foregroundColor(.gray)
                    Text("\(item.date!, formatter: itemFormatter)").font(.caption)
                 }
                 .frame(width: UIScreen.main.bounds.width, height: 15, alignment: .leading)
                 HStack {
                    Text("\(item.title!)")
                        .foregroundColor(colors[min(Int(item.value/100000), 5)])
                        .shadow(radius: 3)
                        .frame(width: 150, height: 15, alignment: .leading)
                    
                    Text("\(item.value, specifier: "%1.0f")").foregroundColor(.red)
                         .font(.system(.subheadline))
                 }
                 .frame(width: UIScreen.main.bounds.width-125, height: 15, alignment: .trailing)
             }
             Text("\(item.dueDate!, formatter: itemFormatter)")
                 .font(.system(size: 12.0)).fontWeight(.regular).foregroundColor(.purple)
                 .frame(width: UIScreen.main.bounds.width-125, height: 15, alignment: .trailing)
         }
        .background(item.dueDate! > Date() ? Color.clear : Color(red: 1, green: 1, blue: 0)).cornerRadius(10)
    }
}

struct PaymView: View {
    let colors: [Color] = [.gray, .blue, .green, .red, .purple, .orange]
    var item: Payment
    var body: some View {
        VStack {
            ZStack {
               HStack {
                    Image(systemName: "star").foregroundColor(.gray)
                    Text("\(item.date!, formatter: itemFormatter)").font(.caption)
                }
                .frame(width: UIScreen.main.bounds.width, height: 15, alignment: .leading)
                
                HStack {
                    Text("\(item.title!)")
                        .foregroundColor(colors[min(Int(item.value/100000), 5)])
                        .shadow(radius: 3)
                        .frame(width: 150, height: 15, alignment: .leading)
                    
                    Text("\(item.value, specifier: "%1.0f")").foregroundColor(.red)
                        .font(.system(.subheadline))
                }
                .frame(width: UIScreen.main.bounds.width-125, height: 15, alignment: .trailing)
            }
            Text("\(item.dueDate!, formatter: itemFormatter)")
                .font(.system(size: 12.0)).fontWeight(.regular).foregroundColor(.purple)
                .frame(width: UIScreen.main.bounds.width-125, height: 15, alignment: .trailing)
         }
        .background(item.dueDate! > Date() ? Color.clear : Color(red: 1, green: 1, blue: 0)).cornerRadius(10)
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()
