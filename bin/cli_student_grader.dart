import 'dart:io';

void main() {
  const String appTitle = "Student Grader v1.0";

  var isRunning = true;

  do {
    print("""
===== $appTitle =====

1. Add Student
2. Record Score
3. Add Bonus Points
4. Add Comment
5. View All Students
6. View Report Card
7. Class Summary
8. Exit
""");

    stdout.write("Choose an option: ");
    var choice = stdin.readLineSync();

    switch (choice) {
      case "8":
        print("Exiting app...");
        isRunning = false;
        break;

      default:
        print("Feature coming soon...");
    }
  } while (isRunning);
}