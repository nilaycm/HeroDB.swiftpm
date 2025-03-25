import SwiftUI

struct HeroEditView: View {
    @Bindable var hero: Hero
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focused: Bool
    let logos = ["person", "medal", "key.horizontal.fill"]
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Enter a name", text: $hero.id)
                    .focused($focused)
                    .textFieldStyle(.roundedBorder)
                HStack {
                    ForEach(logos, id:\.self) { logo in
                        Button {
                            
                        } label: {
                            Image(systemName: logo)
                                .resizable()
                                .scaledToFit() 
                                .foregroundStyle(hero.logo == logo ? Color.accentColor : .primary)   
                        }
                    }
                }   
            }
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
    @Previewable @State var hero = Hero(id: "", logo: "person")
    HeroEditView(hero: hero)
}
