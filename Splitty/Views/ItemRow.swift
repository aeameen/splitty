import SwiftUI

struct ItemRow: View {
  let item: ReceiptItem
  
  var body: some View {
    HStack {
      Text(item.name)
        .font(.headline)
      Spacer()
      Text(item.amount.formatted(.currency(code: "USD")))
        .foregroundStyle(.secondary)
    }
    .contentShape(Rectangle())
  }
}

#Preview {
  ItemRow(item: ReceiptItem(
    name: "Pizza",
    amount: 15.99
  ))
  .padding()
} 
