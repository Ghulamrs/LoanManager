//
//  LinkLoanView.swift
//  LoanManager
//
//  Created by Home on 5/7/21.
//

import SwiftUI

struct LinkLoanView: View {
    @State var loan: Loan
    @State private var ld = LoanData()
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        VStack {
            Text("\(ld.title)")
                .font(.system(size: 36))
                .foregroundColor(Color(red: 0, green: 0.4, blue: 0))
                .shadow(radius: 5)
                .padding()
            HStack {
                TextField("", text: $ld.value).textFieldStyle(RoundedBorderTextFieldStyle())
                DatePicker("", selection: $ld.dueDate, displayedComponents: .date).labelsHidden()
            }.foregroundColor(.red)
        
            VStack {
                HStack {
                    Button( "Update") {
                        if loan.value != Float(ld.value)  {
                            updateItem() // uses ld, set above TextField()
                            deleteItem(item: loan)
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(Color(red: 0, green: 0.5, blue: 0, opacity: 1))
                    .padding()
                    
                    Button("Cancel") {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.red)
                }
            }
        }
        .padding()
        .onAppear() {
            ld = LoanData(loan: loan)
        }
    }
    
    private func updateItem() {
        if ld.title.isEmpty { return }
        
        withAnimation {
        let newItem = Loan(context: viewContext)
            newItem.date = ld.date
            newItem.title = ld.title
            newItem.value = Float(ld.value)!
            newItem.dueDate = ld.dueDate
            save()
        }
    }
    
    private func save() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    private func deleteItem(item: Loan) {
        viewContext.delete(item)
        save()
    }
}
