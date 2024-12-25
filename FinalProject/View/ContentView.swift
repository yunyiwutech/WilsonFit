import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isDarkMode: Bool = false // Dark mode toggle

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Gradient Header
                GradientHeader()

                // Main Content
                ScrollView {
                    VStack(spacing: 16) {
                        // Foods to Avoid Link
                        NavigationLink(destination: FoodListView()
                            .environment(\.managedObjectContext, viewContext)
                            .navigationTitle("Foods to Avoid")
                            .navigationBarTitleDisplayMode(.inline)) {
                                LinkCard(
                                    title: "Foods to Avoid",
                                    subtitle: "Explore the list of foods to avoid based on dietary guidelines.",
                                    icon: "list.bullet.rectangle"
                                )
                            }

                        // Recipe List Link
                        NavigationLink(destination: RecipeListView()
                            .navigationTitle("Recipes")
                            .navigationBarTitleDisplayMode(.inline)) {
                                LinkCard(
                                    title: "Recipe List",
                                    subtitle: "Browse a curated list of recipes that are safe to consume.",
                                    icon: "fork.knife"
                                )
                            }

                        // Generate Meal Plan Link
                        NavigationLink(destination: MealPlanTestView()
                            .environment(\.managedObjectContext, viewContext)
                            .navigationTitle("Generate Meal Plan")
                            .navigationBarTitleDisplayMode(.inline)) {
                                LinkCard(
                                    title: "Generate Meal Plan",
                                    subtitle: "Create a daily meal plan based on your preferences.",
                                    icon: "calendar"
                                )
                            }

                        // Saved Meal Plans Link
                        NavigationLink(destination: SavedMealPlansView()
                            .environment(\.managedObjectContext, viewContext)
                            .navigationTitle("Saved Meal Plans")
                            .navigationBarTitleDisplayMode(.inline)) {
                                LinkCard(
                                    title: "Saved Meal Plans",
                                    subtitle: "View and manage your previously saved meal plans.",
                                    icon: "folder"
                                )
                            }

                        // Features Link
                        NavigationLink(destination: FeaturesPage()) {
                            LinkCard(
                                title: "Features",
                                subtitle: "Discover the app's features and functionalities.",
                                icon: "star"
                            )
                        }

                        // Profile/Login Link
                        if viewModel.userSession != nil {
                            NavigationLink(destination: ProfileView()) {
                                LinkCard(
                                    title: "Profile",
                                    subtitle: "View and edit your profile information.",
                                    icon: "person.crop.circle"
                                )
                            }
                        } else {
                            NavigationLink(destination: LoginView()) {
                                LinkCard(
                                    title: "Login",
                                    subtitle: "Sign in to access your account.",
                                    icon: "lock"
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 20) // Add spacing below the header
                }

                // Dark Mode Toggle
                Toggle(isOn: $isDarkMode) {
                    Text("Dark Mode")
                        .font(.headline)
                }
                .padding(.vertical, 16)
            }
            .navigationBarHidden(true) // Hide default navigation bar
            .preferredColorScheme(isDarkMode ? .dark : .light) // Apply color scheme
        }
    }
}

// Updated Gradient Header
struct GradientHeader: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color.blue, Color.purple]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .frame(height: 300) // Adjusted height for better spacing
        .overlay(
            VStack(spacing: 16) {
                Text("Welcome to WilsonFit!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
                    

                WelcomePage()
                    .padding(.bottom)
                                      
                                      .padding(.horizontal, 20)

          
            }
            .padding(.top, 30)
        )
    }
}

// Link Card Style
struct LinkCard: View {
    let title: String
    let subtitle: String
    let icon: String

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundColor(.blue)
                .frame(width: 50, height: 50)
                .background(Circle().fill(Color.blue.opacity(0.2)))

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary) // Adapt to dark mode
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.body)
                .foregroundColor(.gray)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color("CardBackground")) // Dynamic color for dark mode
                .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
    }
}

// Preview
#Preview {
    let mockContext = PersistenceController.preview.container.viewContext

    return ContentView()
        .environmentObject(AuthViewModel()) // Mock AuthViewModel
        .environment(\.managedObjectContext, mockContext) // Inject mock Core Data context
}

