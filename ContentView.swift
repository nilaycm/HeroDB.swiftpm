import SwiftUI
import SwiftData

@Model class Hero: Identifiable, Hashable {
    var id: String
    var logo: String 
    var power: Int
    
    init(id: String, logo: String, power: Int) {
        self.id = id
        self.logo = logo
        self.power = power
    }
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var heroes: [Hero]
    @State private var isPresented = false
    @State private var selection = Set<String>()
    
    var body: some View {
        NavigationStack {
            list
                .toolbar {
                    Button("+") {
                        isPresented = true
                    }
                    .buttonStyle(.borderedProminent )
                    .font(.largeTitle)
                    .fullScreenCover(isPresented: $isPresented) {
                        HeroEditView(hero: Hero(id: "", logo: "person", power: 1))
                    }
                    EditButton()
                    if !selection.isEmpty {
                        Button("", systemImage: "trash") { 
                            for id in selection {
                                try! modelContext.delete(model: Hero.self, where: #Predicate {
                                    $0.id == id
                                })
                            }
                        }
                    }
                }
        }
    }
    //TODO add atrributes to heroes
    //if possible make it possible to use an image as the icon for the //heroes instead off the personfill
    @ViewBuilder
    var list: some View {
        if heroes.isEmpty {
            ContentUnavailableView("No heroes yet", systemImage: "person.fill.questionmark", description:  Text("Tap the + buttton to add your first hero"))
        } else {
            List(selection: $selection) {
                ForEach(heroes) { hero in
                    HStack {
                        Image(systemName: hero.logo)
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                        Spacer()
                        Text(hero.id)
                            .bold()
                            .fontDesign(.rounded)
                            .foregroundStyle(Color.blue.opacity(0.5))
                    }   
                    .font(.title)
                }
                .onDelete { modelContext.delete(heroes[$0.first!]) }
            }   
        }
    }
}
