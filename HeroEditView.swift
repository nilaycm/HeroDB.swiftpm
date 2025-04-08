import SwiftUI

struct HeroEditView: View {
    @Bindable var hero: Hero
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Environment(\.editMode) private var editMode
    @FocusState private var focused: Bool
    private let logos = ["person", "medal", "key.horizontal.fill"]
    var isNew = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("Enter a name", text: $hero.id)
                        .focused($focused)
                        .textFieldStyle(.roundedBorder)
                    ForEach(1...5, id: \.self) { power in
                        Button {
                            hero.power = power
                        } label: {
                            Circle()
                                .frame(width: 25)
                                .foregroundStyle(power <= hero.power ? Color.accentColor : .primary)
                        }
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
            .disabled(editMode?.wrappedValue == .inactive)
            .navigationBarBackButtonHidden(editMode?.wrappedValue == .active)
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    if editMode?.wrappedValue == .active {
                        Button("Cancel") {
                            if isNew {
                                dismiss()
                            } else {
                                modelContext.rollback()
                                editMode?.wrappedValue = .inactive
                            }
                        }
                    }
                }
                ToolbarItem {
                    if isNew {
                        Button("Save") {
                            modelContext.insert(hero)
                            dismiss()
                        }
                        .disabled(hero.id.isEmpty)
                    } else {
                        EditButton()
                    }
                }
            }
        }
        .onAppear {
            focused = true
            if hero.id.isEmpty {
                editMode?.wrappedValue = .active
            }
        }
    }
}

#Preview {
    @Previewable @State var hero = Hero(id: "", logo: "person", power: 3)
    HeroEditView(hero: hero)
}
