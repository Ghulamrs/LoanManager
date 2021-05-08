//
//  PaymentView.swift
//  LoanManager
//
//  Created by Home on 5/7/21.
//

import SwiftUI

struct PaymentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Payment.date, ascending: true)], animation: .default)
    private var payments: FetchedResults<Payment>
    
    @ObservedObject var pd = PaymentData()
    var body: some View {
        NavigationView {
            VStack {
                Section {
                    HStack {
                        TextField("Title", text: $pd.title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        DatePicker("", selection: $pd.date, displayedComponents: .date).labelsHidden()
                    }
                    HStack {
                        TextField("Amount", text: $pd.value)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        DatePicker("", selection: $pd.dueDate, displayedComponents: .date).labelsHidden()
                    }.foregroundColor(.red)
                }
                .padding(.horizontal, 20)

                List {
                    ForEach(payments) { payment in
                        NavigationLink(
                            destination: LinkPaymentView(loan: payment),
                            label: {
                                PaymView(item: payment)
                            })
                    }
                    .onDelete(perform: deleteItems)
                }
                Spacer()
                Text("Total. \(SumOf(items: self.payments), specifier: "%3.0f")").font(.caption).foregroundColor(.red)
                Text("©2021 Loan Manager 4.0, G. R. Akhtar, Islamabad").font(.caption).foregroundColor(.gray)
            }
            .navigationTitle("Payments")
            .navigationBarItems(trailing:
                Button(action: {
                    addItem(data: pd)
                    pd.reset_title()
                }, label: {
                    Image(systemName: "plus.circle").font(.system(.title))
                })
            )
        }
    }
    
    func SumOf(items: FetchedResults<Payment>) -> Float {
        var total: Float = 0
        for item in items {
            total += item.value
        }
        return total
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { payments[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func addItem(data: Data) {
        if data.title.isEmpty { return }
        
        withAnimation {
        let newItem = Payment(context: viewContext)
            newItem.date = data.date
            newItem.title = data.title
            newItem.value = Float(data.value)!
            newItem.dueDate = data.dueDate

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()
