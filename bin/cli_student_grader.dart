import 'dart:io';

void main() {
  // 1. const and final
  const String appTitle = "Student Grader v1.0";
  final Set<String> availableSubjects = {
    "Math",
    "English",
    "Science",
    "History"
  };

  // 2. var (mutable state)
  var students = <Map<String, dynamic>>[];
  var running = true;

  // 18. do-while loop
  do {
    // 12. multi-line string + 11. interpolation
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

Choose an option:
""");

    var choice = stdin.readLineSync();

    // 14. switch statement
    switch (choice) {
      case "1":
        addStudent(students, availableSubjects);
        break;
      case "8":
        running = false;
        print("Exiting...");
        break;
      default:
        print("Feature coming soon.");
    }
  } while (running);
}

void addStudent(
    List<Map<String, dynamic>> students,
    Set<String> availableSubjects) {
  print("Enter student name:");
  var name = stdin.readLineSync();

  var student = {
    "name": name,
    "scores": <int>[],
    "subjects": {...availableSubjects},
    "bonus": null,
    "comment": null
  };

  students.add(student);

  print("Student $name added successfully!");
}