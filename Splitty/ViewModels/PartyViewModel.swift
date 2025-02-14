import Foundation

@MainActor
class PartyViewModel: ObservableObject {
  @Published var receipt: Receipt
  @Published var partyMembers: [Person] = []
  
  init(receipt: Receipt) {
    self.receipt = receipt
  }
  
  func addPartyMember(name: String) {
    let person = Person(name: name)
    partyMembers.append(person)
  }
  
  func removePartyMember(at offsets: IndexSet) {
    partyMembers.remove(atOffsets: offsets)
  }
  
  func assignItem(_ item: ReceiptItem, to person: Person) {
    if let index = receipt.items.firstIndex(where: { $0.id == item.id }) {
      var updatedItem = item
      updatedItem.assignedTo.append(person)
      receipt.items[index] = updatedItem
    }
  }
  
  func unassignItem(_ item: ReceiptItem, from person: Person) {
    if let index = receipt.items.firstIndex(where: { $0.id == item.id }) {
      var updatedItem = item
      updatedItem.assignedTo.removeAll(where: { $0.id == person.id })
      receipt.items[index] = updatedItem
    }
  }
} 