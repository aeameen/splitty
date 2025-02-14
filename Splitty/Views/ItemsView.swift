import SwiftUI

struct ItemsView: View {
  @StateObject private var viewModel = ItemsViewModel()
  @State private var showingAddItem = false
  @State private var showingPartyView = false
  @State private var newItemName = ""
  @State private var newItemAmount = ""
  @State private var hapticEngine = UINotificationFeedbackGenerator()
  
  private var hasItems: Bool {
    !viewModel.receipt.items.isEmpty
  }
  
  var body: some View {
    List {
      Section(Strings.Common.items) {
        if viewModel.receipt.items.isEmpty {
          Text(Strings.ItemsList.noItems)
            .foregroundStyle(.secondary)
        }
        ForEach(viewModel.receipt.items) { item in
          ItemRow(item: item)
        }
        .onDelete(perform: deleteItems)
      }
    }
    .navigationTitle(Strings.ItemsList.title)
    .safeAreaInset(edge: .bottom) {
      VStack(spacing: 12) {
        if hasItems {
          Button(action: {
            hapticEngine.notificationOccurred(.success)
            showingPartyView = true
          }) {
            Text(Strings.ItemsList.continueToParty)
              .font(.headline)
              .frame(maxWidth: .infinity)
              .padding()
              .background(Color.accentColor.gradient)
              .foregroundColor(.white)
              .clipShape(RoundedRectangle(cornerRadius: 10))
          }
          .transition(.move(edge: .top).combined(with: .opacity))
        }
        
        Button(action: {
          hapticEngine.prepare()
          showingAddItem = true
        }) {
          Text(hasItems ? Strings.ItemsList.addAnotherItem : Strings.ItemsList.addItem)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding()
            .background(hasItems ? 
              Color.accentColor.opacity(0.2).gradient : 
              Color.accentColor.gradient
            )
            .foregroundColor(hasItems ? .accentColor : .white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .animation(.smooth, value: hasItems)
      }
      .padding()
      .animation(.smooth, value: hasItems)
    }
    .navigationDestination(isPresented: $showingPartyView) {
      PartyView(receipt: viewModel.receipt)
    }
    .sheet(isPresented: $showingAddItem) {
      AddItemView(isPresented: $showingAddItem) { name, amount in
        viewModel.addItem(name: name, amountString: amount)
        hapticEngine.notificationOccurred(.success)
      }
      .presentationDragIndicator(.visible)
      .presentationDetents([.large])
    }
  }
  
  private func deleteItems(at offsets: IndexSet) {
    viewModel.deleteItems(at: offsets)
    hapticEngine.notificationOccurred(.warning)
  }
}
