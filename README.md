# WilsonFit

WilsonFit is an iOS application prototype that turns structured dietary information into personalized meal-plan guidance for people living with Wilson's disease.

The project explores a human-centered software question: how can specialized health information be organized into a tool that is easier to navigate and act on?

## Features

- Loads structured recipe data from JSON
- Filters recipes by dietary preference and copper content
- Generates breakfast, lunch, dinner, and snack suggestions
- Saves and edits meal plans with Core Data
- Includes searchable food guidance and account interfaces
- Uses a SwiftUI interface throughout the application

## Technology

- Swift and SwiftUI
- Core Data
- Codable and JSON decoding
- Firebase Authentication
- Xcode

## Project structure

```text
FinalProject/
├── Controller/   Persistence setup and data initialization
├── Model/        Recipes, users, and meal-plan logic
├── View/         SwiftUI screens and reusable views
└── recipes.json  Structured recipe records
```

## Local setup

1. Open `FinalProject.xcodeproj` in Xcode.
2. Add your own Firebase iOS configuration as `FinalProject/GoogleService-Info.plist`.
3. Build and run the application on an iOS simulator or device.

## Status and scope

This repository contains a beta portfolio project. The dietary rules and recipe data are demonstrations of application logic and have not been clinically validated.

## Medical disclaimer

WilsonFit is not a medical device and does not provide medical advice. People with Wilson's disease should make dietary and treatment decisions with qualified healthcare professionals.
