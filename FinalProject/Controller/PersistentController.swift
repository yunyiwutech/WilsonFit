import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "FoodModel")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }

        // Prepopulate if empty
        if isDatabaseEmpty() {
            prepopulateDatabase()
        }
    }

    private func isDatabaseEmpty() -> Bool {
        let fetchRequest: NSFetchRequest<Food> = Food.fetchRequest()
        do {
            return try container.viewContext.count(for: fetchRequest) == 0
        } catch {
            print("Error checking database: \(error.localizedDescription)")
            return false
        }
    }

    private func prepopulateDatabase() {
        let context = container.viewContext
        let foods = [
            ("Liver", "Meats", "High in copper"),
            ("Oysters", "Seafood", "High in copper"),
            ("Chocolate", "Snacks", "Contains copper"),
            ("Spinach", "Vegetables", "Contains copper"),
            ("Nuts", "Snacks", "High in copper")
        ]

        for food in foods {
            let newFood = Food(context: context)
            newFood.name = food.0
            newFood.category = food.1
            newFood.reason = food.2
        }

        do {
            try context.save()
        } catch {
            print("Error prepopulating database: \(error.localizedDescription)")
        }
    }
}
