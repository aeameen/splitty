import SwiftUI

struct HomeView: View {
  @State private var showingItemsList = false
  @State private var showingComingSoonAlert = false
  @State private var showingAboutSheet = false
  
  var body: some View {
    NavigationStack {
      List {
        Section(Strings.Home.Instructions.title) {
          ForEach([
            Strings.Home.Instructions.items,
            Strings.Home.Instructions.assign,
            Strings.Home.Instructions.extras,
            Strings.Home.Instructions.payment,
            Strings.Home.Instructions.magic
          ], id: \.self) { instruction in
            Text(instruction)
              .padding(.vertical, 4)
          }
        }
        .listStyle(.insetGrouped)
      }
      .scrollContentBackground(.hidden)
      .background(
        LinearGradient(
          colors: [
            Color("BackgroundGradient"),
            Color("BackgroundGradient").opacity(0.5)
          ],
          startPoint: .topLeading,
          endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
      )
      .safeAreaInset(edge: .bottom) {
        Button(action: {
          showingItemsList = true
        }) {
          Text(Strings.Home.getStarted)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.accentColor.gradient)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .padding()
      }
      .navigationTitle(Strings.Home.title)
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          HStack(spacing: 16) {
            Button(action: {
              showingComingSoonAlert = true
            }) {
              Image(systemName: "camera")
                .foregroundStyle(Color.accentColor)
            }
            
            Button(action: {
              showingAboutSheet = true
            }) {
              Image(systemName: "info.circle")
                .foregroundStyle(Color.accentColor)
            }
          }
        }
      }
      .tint(Color.accentColor)
      .alert(Strings.Scanner.comingSoon, isPresented: $showingComingSoonAlert) {
        Button(Strings.Common.ok, role: .cancel) {}
      } message: {
        Text(Strings.Scanner.featureInProgress)
      }
      .navigationDestination(isPresented: $showingItemsList) {
        ItemsView()
      }
      .alert(Strings.Common.about, isPresented: $showingAboutSheet) {
        Button(Strings.Common.ok, role: .cancel) {}
      } message: {
        Text(Strings.Common.madeWithLove)
      }
    }
  }
}

#Preview {
  HomeView()
}
