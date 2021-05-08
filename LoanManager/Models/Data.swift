//
//  Data.swift
//  LoanManager
//
//  Created by Home on 5/7/21.
//

import Foundation

class Data: ObservableObject {
    @Published var date = Date()
    @Published var dueDate = Date().addingTimeInterval(2592000) // After a month
    @Published var title: String = ""
    @Published var value: String = ""
    
    init(){}
//    init(data: Data) {
  ///      self.date = data.date
     //   self.title = data.title
       // self.value = String(data.value)
        //self.dueDate = data.dueDate
    //}
    func reset_title() {
        self.title = ""
    }
    func update_value(value: Float) {
        self.value = String(value)
    }
    func update_duedate(date: Date) {
        self.dueDate = date
    }
}

class LoanData: Data {
    override init() {
        super.init()
    }
    init(loan: Loan) {
        super.init()
        self.date = loan.date!
        self.title = loan.title!
        self.value = String(loan.value)
        self.dueDate = loan.dueDate!
    }
}

class PaymentData: Data {
    override init() {
        super.init()
    }
    init(payment: Payment) {
        super.init()
        self.date = payment.date!
        self.title = payment.title!
        self.value = String(payment.value)
        self.dueDate = payment.dueDate!
    }
}
