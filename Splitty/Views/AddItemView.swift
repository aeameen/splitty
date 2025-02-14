import SwiftUI

struct AddItemView: View {
  @Environment(\.dismiss) private var dismiss
  @Binding var isPresented: Bool
  let onAdd: (String, String) -> Void
  
  @State private var itemName = ""
  @State private var amount = ""
  @FocusState private var focusedField: Field?
  
  enum Field {
    case itemName
    case amount
  }
  
  var body: some View {
    NavigationStack {
      Form {
        TextField(Strings.ItemsList.itemName, text: $itemName)
          .focused($focusedField, equals: .itemName)
          .submitLabel(.next)
          .onSubmit {
            focusedField = .amount
          }
        TextField(Strings.ItemsList.amount, text: $amount)
          .keyboardType(.decimalPad)
          .focused($focusedField, equals: .amount)
      }
      .navigationTitle(Strings.ItemsList.addItem)
      .navigationBarTitleDisplayMode(.inline)
      .onAppear {
        focusedField = .itemName
      }
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button(Strings.Common.cancel) {
            dismiss()
          }
        }
        ToolbarItem(placement: .confirmationAction) {
          Button(Strings.ItemsList.add) {
            onAdd(itemName, amount)
            dismiss()
          }
          .disabled(itemName.isEmpty || amount.isEmpty)
        }
      }
    }
    .presentationDetents([.medium])
  }
}

#Preview {
  AddItemView(isPresented: .constant(true)) { _, _ in }
} 