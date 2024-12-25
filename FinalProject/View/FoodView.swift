import SwiftUI
import CoreData

enum FoodFilter: Hashable {
    case all
    case category(String)
    case reason(String)

    static let allFilters: [FoodFilter] = [
        .all,
        .category("Meats"),
        .category("Vegetables"),
        .reason("Contains copper"),
        .reason("High in copper")
    ]

    var rawValue: String {
        switch self {
        case .all:
            return "All"
        case .category(let category):
            return category
        case .reason(let reason):
            return reason
        }
    }
}

struct FoodListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State var selectedFilter: FoodFilter = .all // Default filter
    @State private var searchQuery: String = "" // Search query


    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                                TextField("Search foods...", text: $searchQuery)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding()
                // Filter Picker
                Picker("Filter", selection: $selectedFilter.animation()) {
                    ForEach(FoodFilter.allFilters, id: \.self) { filter in
                        Text(filter.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                // Food List
                                List {
                           
                                    ForEach(filteredFoods(), id: \.self) { food in
                                        FoodCell(food: food)
                                    }
                                    .onDelete(perform: deleteItems)
                                }
                                
                                .onAppear {
                                    print("FoodListView appeared!")
                                    let foods = filteredFoods()
                                    print("Foods fetched: \(foods.count)")
                                }

                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button(action: addSampleFood) {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .navigationTitle("Foods to Avoid")
        }
    }

    // Filter foods based on selected filter and search query
        private func filteredFoods() -> [Food] {
            let fetchRequest: NSFetchRequest<Food> = Food.fetchRequest()
            var predicates: [NSPredicate] = []

            // Apply filter based on selected category/reason
            switch selectedFilter {
            case .category(let category):
                predicates.append(NSPredicate(format: "category == %@", category))
            case .reason(let reason):
                predicates.append(NSPredicate(format: "reason CONTAINS[cd] %@", reason))
            case .all:
                break
            }

            // Apply search query filter
            if !searchQuery.isEmpty {
                predicates.append(NSPredicate(format: "name CONTAINS[cd] %@ OR reason CONTAINS[cd] %@", searchQuery, searchQuery))
            }

            // Combine predicates
            if !predicates.isEmpty {
                fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
            }

            do {
                return try viewContext.fetch(fetchRequest)
            } catch {
                print("Error fetching foods: \(error.localizedDescription)")
                return []
            }
        }


    // Delete food items
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { filteredFoods()[$0] }.forEach(viewContext.delete)
            saveContext()
        }
    }

    // Add a sample food item
    private func addSampleFood() {
        let newFood = Food(context: viewContext)
        newFood.name = "Sample Food"
        newFood.category = "Snacks"
        newFood.reason = "Contains copper"
        saveContext()
    }

    // Save context changes
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving context: \(error.localizedDescription)")
        }
    }
}

extension PersistenceController {
    static var preview: PersistenceController = {
        let controller = PersistenceController()
        let context = controller.container.viewContext
        // Add sample data here if needed for previews
        return controller
    }()
}
struct FoodListView_Previews: PreviewProvider {
    static var previews: some View {
        FoodListView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


