import SwiftUI
import SwiftData

@Model class Hero: Identifiable, Hashable {
    var id: String
    var logo: String 
    
    init(id: String, logo: String) {
        self.id = id
        self.logo = logo
    }
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var heroes: [Hero]
    
    var body: some View {
        NavigationStack {
            list
                .toolbar {
                    Button("+") {
                        modelContext.insert(Hero(id: "new Hero", logo: "person.fill"))
                    }
                    .font(.largeTitle)
                }
        }
    }
    
    @ViewBuilder
    var list: some View {
        if heroes.isEmpty {
            ContentUnavailableView("No heroes yet", systemImage: "person.fill.questionmark", description:  Text("Tap the + buttton to add your first hero"))
        } else {
            List(heroes) { hero in
                HStack {
                    Image(systemName: hero.logo)
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Spacer()
                    Text(hero.id)
                }
            }
        }
    }
}
