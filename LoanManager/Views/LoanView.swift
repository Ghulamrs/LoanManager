//
//  LoanView.swift
//  LoanManager
//
//  Created by Home on 5/7/21.
//

import SwiftUI

struct LoanView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Loan.date, ascending: true)], animation: .default)
    private var loans: FetchedResults<Loan>
    @ObservedObject var ld = LoanData()
    
    var body: some View {
        NavigationView {
            VStack {
                Section {
                    HStack {
                        TextField("Title", text: $ld.title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        DatePicker("", selection: $ld.date, displayedComponents: .date).labelsHidden()
                    }
                    HStack {
                        TextField("Amount", text: $ld.value)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        DatePicker("", selection: $ld.dueDate, displayedComponents: .date).labelsHidden()
                    }.foregroundColor(.red)
                }
                .padding(.horizontal, 20)

                List {
                    ForEach(loans) { loan in
                        NavigationLink(
                            destination: LinkLoanView(loan: loan),
                            label: {
                                ItemView(item: loan)
                            })
                    }
                    .onDelete(perform: deleteItems)
                }
                Spacer()
                Text("Total. \(SumOf(items: self.loans), specifier: "%3.0f")").font(.caption).foregroundColor(.red)
                Text("©2021 Loan Manager 4.0, G. R. Akhtar, Islamabad").font(.caption).foregroundColor(.gray)
            }
            .navigationTitle("Loans")
            .navigationBarItems(trailing:
                Button(action: {
                    addItem(data: ld)
                }, label: {
                    Image(systemName: "plus.circle").font(.system(.title))
                })
            )
        }
    }
    
    private func SumOf(items: FetchedResults<Loan>) -> Float {
        var total: Float = 0
        for item in items {
            total += item.value
        }
        return total
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { loans[$0] }.forEach(viewContext.delete)

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
        let newItem = Loan(context: viewContext)
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
