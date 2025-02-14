import SwiftUI

struct PartyView: View {
  @StateObject private var viewModel: PartyViewModel
  
  init(receipt: Receipt) {
    _viewModel = StateObject(wrappedValue: PartyViewModel(receipt: receipt))
  }
  
  var body: some View {
    Text("Party View - Coming Soon")
      .navigationTitle("Party Details")
  }
} 