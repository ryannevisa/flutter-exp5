# Monthly Expense Manager - Ex. 5: Navigation and Routing

Two-screen Flutter app using **named routes** (`'/'` -> InputScreen, `'/result'` -> ResultScreen).
The Budget object entered on screen 1 is passed with
`Navigator.pushNamed(context, '/result', arguments: budget)` and read on screen 2 with
`ModalRoute.of(context)!.settings.arguments as Budget`. Balance = Income - (Rent + Food +
Transport + Others); negative -> red + "You are overspending!", otherwise green + success message.
`Navigator.pop()` on the Back button returns to the Input Screen.

## Run

```bash
cd expense_manager_app
flutter create .        # generates android/ios/web/etc. (keeps lib/ and pubspec.yaml)
flutter pub get
flutter run             # or: flutter run -d chrome
flutter test            # optional tests
```

## Structure

```
lib/main.dart            ExpenseApp, MaterialApp with initialRoute and routes
lib/budget_model.dart    Budget model (totalExpenses, balance)
lib/input_screen.dart    InputScreen - Form, validators, CALCULATE / RESET
lib/result_screen.dart   ResultScreen - reads route arguments, shows balance
test/widget_test.dart    Unit + widget tests (validation, green, red, Back)
screenshots/             Output screenshots from the lab record
```
