import 'dart:io';

void main() {
  const String appTitle = "Student Grader v1.0";

  final Set<String> availableSubjects = {
    "Math",
    "English",
    "Science",
    "History"
  };

  var students = <Map<String, dynamic>>[];
  var running = true;

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

Choose an option:
""");

    var choice = stdin.readLineSync();

    switch (choice) {
      case "8":
        running = false;
        print("Exiting...");
        break;
      default:
        print("Feature not added yet.");
    }
  } while (running);
}

// ---------------- OPTION 1 ----------------
void addStudent(List<Map<String, dynamic>> students,
    Set<String> availableSubjects) {
  print("Enter student name:");
  var name = stdin.readLineSync();

  var student = {
    "name": name,
    "scores": <int>[],
    "subjects": {...availableSubjects}, // spread operator
    "bonus": null, // int?
    "comment": null // String?
  };

  students.add(student);

  print("Student $name added successfully!");
}

// ---------------- OPTION 2 ----------------
void recordScore(
    List<Map<String, dynamic>> students, Set<String> subjects) {
  if (students.isEmpty) {
    print("No students available.");
    return;
  }

  for (int i = 0; i < students.length; i++) {
    print("$i. ${students[i]["name"]}");
  }

  print("Select student index:");
  var index = int.parse(stdin.readLineSync()!);

  if (index < 0 || index >= students.length) {
    print("Invalid index.");
    return;
  }

  var student = students[index];

  print("Available subjects: $subjects");

  int score;

  while (true) {
    print("Enter score (0-100):");
    score = int.parse(stdin.readLineSync()!);

    if (score >= 0 && score <= 100) break;
    print("Invalid score. Try again.");
  }

  student["scores"].add(score);

  print("Score added.");
}

// ---------------- OPTION 3 ----------------
void addBonus(List<Map<String, dynamic>> students) {
  if (students.isEmpty) return;

  for (int i = 0; i < students.length; i++) {
    print("$i. ${students[i]["name"]}");
  }

  print("Select student:");
  var index = int.parse(stdin.readLineSync()!);

  if (index < 0 || index >= students.length) {
    print("Invalid index.");
    return;
  }

  var student = students[index];

  print("Enter bonus (1-10):");
  var bonusValue = int.parse(stdin.readLineSync()!);

  // REQUIRED: ??= usage
  student["bonus"] ??= bonusValue;

  if (student["bonus"] == bonusValue) {
    print("Bonus added.");
  } else {
    print("Bonus already exists.");
  }
}

// ---------------- OPTION 4 ----------------
void addComment(List<Map<String, dynamic>> students) {
  if (students.isEmpty) return;

  for (int i = 0; i < students.length; i++) {
    print("$i. ${students[i]["name"]}");
  }

  print("Select student:");
  var index = int.parse(stdin.readLineSync()!);

  if (index < 0 || index >= students.length) {
    print("Invalid index.");
    return;
  }

  var student = students[index];

  print("Enter comment:");
  var comment = stdin.readLineSync();

  student["comment"] = comment;
}

