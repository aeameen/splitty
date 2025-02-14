import Foundation

@MainActor
class ItemsViewModel: ObservableObject {
  @Published var receipt: Receipt
  
  init(receipt: Receipt = Receipt(totalAmount: 0, items: [])) {
    self.receipt = receipt
  }
  
  func addItem(name: String, amountString: String) {
    guard let amount = Decimal(string: amountString) else { return }
    
    let item = ReceiptItem(
      name: name,
      amount: amount
    )
    receipt.items.append(item)
    updateTotalAmount()
  }
  
  func deleteItems(at offsets: IndexSet) {
    receipt.items.remove(atOffsets: offsets)
    updateTotalAmount()
  }
  
  private func updateTotalAmount() {
    receipt.totalAmount = receipt.items.reduce(0) { $0 + $1.amount }
  }
  
  func calculateSplits() -> [Person: Decimal] {
    var splits: [Person: Decimal] = [:]
    
    for item in receipt.items {
      let splitAmount = item.amount / Decimal(item.assignedTo.count)
      
      for person in item.assignedTo {
        splits[person, default: 0] += splitAmount
      }
    }
    
    return splits
  }
} 
