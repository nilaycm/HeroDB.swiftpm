import SwiftUI

struct HeroEditView: View {
    @Bindable var hero: Hero
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focused: Bool
    
    var body: some View {
        NavigationStack {
            TextField("Enter a name", text: $hero.id)
                .focused($focused)
                .textFieldStyle(.roundedBorder)
                .padding()
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) { 
                        Button("Cancel") { 
                            dismiss()
                        }   
                    } 
                    ToolbarItem {
                        Button("Save") { 
                            modelContext.insert(hero)
                            dismiss()
                        }
                    }
                }
        }
        .onAppear {
            focused = true 
        }
    }
}

#Preview {
    @Previewable @State var hero = Hero(id: "", logo: "person.fill.turn.down")
    HeroEditView(hero: hero)
}
