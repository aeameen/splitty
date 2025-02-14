import Foundation

struct Receipt: Identifiable {
  let id: UUID
  var totalAmount: Decimal
  var items: [ReceiptItem]
  let dateScanned: Date
  
  init(id: UUID = UUID(), totalAmount: Decimal, items: [ReceiptItem], dateScanned: Date = Date()) {
    self.id = id
    self.totalAmount = totalAmount
    self.items = items
    self.dateScanned = dateScanned
  }
}

struct ReceiptItem: Identifiable {
  let id: UUID
  let name: String
  let amount: Decimal
  var assignedTo: [Person]
  
  init(id: UUID = UUID(), name: String, amount: Decimal, assignedTo: [Person] = []) {
    self.id = id
    self.name = name
    self.amount = amount
    self.assignedTo = assignedTo
  }
}
