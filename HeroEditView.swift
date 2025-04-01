import SwiftUI

struct HeroEditView: View {
    @Bindable var hero: Hero
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focused: Bool
    private let logos = ["person", "medal", "key.horizontal.fill"]
    var isPresented = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Enter a name", text: $hero.id)
                        .focused($focused)
                        .textFieldStyle(.roundedBorder)
                    ForEach(1...5, id: \.self) { power in
                        Circle()
                            .frame(width: 25)
                            .foregroundStyle(power <= hero.power ? Color.accentColor : .primary)
                    }
                }
                HStack {
                    ForEach(logos, id:\.self) { logo in
                        Button {
                            hero.logo = logo
                        } label: {
                            Image(systemName: logo)
                                .resizable()
                                .scaledToFit() 
                                .foregroundStyle(hero.logo == logo ? Color.accentColor : .primary)   
                        }
                    }
                }   
            }
            .disabled(isPresented)
            .padding()
            .toolbar {
                if isPresented {
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
        }
        .onAppear {
            focused = true 
        }
    }
}
//
//#Preview {
//    @Previewable @State var hero = Hero(id: "", logo: "person", power: 3)
//    HeroEditView(hero: hero)
//}
