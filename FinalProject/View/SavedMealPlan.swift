import SwiftUI
import CoreData

struct SavedMealPlansView: View {
    @Environment(\.managedObjectContext) var context
    @State private var savedMealPlans: [MealPlan] = []
    @State private var isEditingPlan: Bool = false
    @State private var selectedPlan: MealPlan?

    var body: some View {
        VStack {
            // Generate New Meal Plan Button
            NavigationLink(destination: MealPlanTestView()
                .environment(\.managedObjectContext, context)
                .navigationTitle("Generate Meal Plan")
            ) {
                Text("Generate New Meal Plan")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()

            // List of Saved Meal Plans
            List {
                ForEach(savedMealPlans, id: \.self) { mealPlan in
                    Section(header: Text(mealPlan.date ?? Date(), style: .date)) {
                        Text("Breakfast: \(mealPlan.breakfast ?? "No Meal")")
                        Text("Lunch: \(mealPlan.lunch ?? "No Meal")")
                        Text("Dinner: \(mealPlan.dinner ?? "No Meal")")
                        Text("Snack: \(mealPlan.snack ?? "No Meal")")

                        // Edit Button
                        Button(action: {
                            selectedPlan = mealPlan
                            isEditingPlan = true
                        }) {
                            Text("Edit Plan")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            .onAppear {
                savedMealPlans = fetchMealPlans(context: context)
            }
            .sheet(isPresented: $isEditingPlan) {
                if let selectedPlan = selectedPlan {
                    EditMealPlanView(mealPlan: selectedPlan, context: _context, isEditingPlan: $isEditingPlan)
                }
            }
        }
        .navigationTitle("Saved Meal Plans")
    }
}

#Preview {
    let mockContext = PersistenceController.preview.container.viewContext
    return SavedMealPlansView()
        .environment(\.managedObjectContext, mockContext)
}

struct EditMealPlanView: View {
    @ObservedObject var mealPlan: MealPlan
    @Environment(\.managedObjectContext) var context
    @Binding var isEditingPlan: Bool

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Breakfast")) {
                    TextField("Enter breakfast", text: Binding(
                        get: { mealPlan.breakfast ?? "" },
                        set: { mealPlan.breakfast = $0 }
                    ))
                }
                Section(header: Text("Lunch")) {
                    TextField("Enter lunch", text: Binding(
                        get: { mealPlan.lunch ?? "" },
                        set: { mealPlan.lunch = $0 }
                    ))
                }
                Section(header: Text("Dinner")) {
                    TextField("Enter dinner", text: Binding(
                        get: { mealPlan.dinner ?? "" },
                        set: { mealPlan.dinner = $0 }
                    ))
                }
                Section(header: Text("Snack")) {
                    TextField("Enter snack", text: Binding(
                        get: { mealPlan.snack ?? "" },
                        set: { mealPlan.snack = $0 }
                    ))
                }
            }
            .navigationTitle("Edit Meal Plan")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        isEditingPlan = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveContext()
                        isEditingPlan = false
                    }
                }
            }
        }
    }

    private func saveContext() {
        do {
            try context.save()
            print("Meal plan updated successfully!")
        } catch {
            print("Error saving meal plan: \(error.localizedDescription)")
        }
    }
}
