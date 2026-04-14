import 'dart:io';

void main() {
  // 1. const
  const String appTitle = "Student Grader v1.0";

  // 2. final
  final Set<String> availableSubjects = {
    "Math",
    "English",
    "Science",
    "ICT"
  };

  // 3. var
  var students = <Map<String, dynamic>>[];
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
      case "1":
        addStudent(students, availableSubjects);
        break;

      case "2":
        recordScore(students);
        break;

      case "3":
        addBonus(students);
        break;

      case "4":
        addComment(students);
        break;

      case "5":
        viewAllStudents(students);
        break;

      case "6":
        viewReportCard(students);
        break;

      case "7":
        classSummary(students);
        break;

      case "8":
        print("Exiting app...");
        isRunning = false;
        break;

      default:
        print("Invalid option. Try again.");
    }
  } while (isRunning);
}

void addStudent(
    List<Map<String, dynamic>> students,
    Set<String> availableSubjects,
    ) {
  stdout.write("Enter student name: ");
  var name = stdin.readLineSync() ?? "";

  var student = {
    "name": name,
    "scores": <int>[],
    "subjects": {...availableSubjects}, // spread operator
    "bonus": null, // int?
    "comment": null, // String?
  };

  students.add(student);

  print("$name added successfully.");
}

void recordScore(List<Map<String, dynamic>> students) {
  if (students.isEmpty) {
    print("No students available.");
    return;
  }

  print("\nStudent List:");
  for (int i = 0; i < students.length; i++) {
    print("${i + 1}. ${students[i]["name"]}");
  }

  stdout.write("Choose student number: ");
  int index = int.parse(stdin.readLineSync()!) - 1;

  int score;
  while (true) {
    stdout.write("Enter score (0-100): ");
    score = int.parse(stdin.readLineSync()!);

    if (score >= 0 && score <= 100) {
      break;
    } else {
      print("Invalid score. Try again.");
    }
  }

  students[index]["scores"].add(score);

  print("Score added successfully.");
}

void addBonus(List<Map<String, dynamic>> students) {
  if (students.isEmpty) {
    print("No students available.");
    return;
  }

  for (int i = 0; i < students.length; i++) {
    print("${i + 1}. ${students[i]["name"]}");
  }

  stdout.write("Choose student number: ");
  int index = int.parse(stdin.readLineSync()!) - 1;

  stdout.write("Enter bonus points (1-10): ");
  int bonus = int.parse(stdin.readLineSync()!);

  if (students[index]["bonus"] == null) {
    students[index]["bonus"] ??= bonus;
    print("Bonus added.");
  } else {
    print("Bonus already exists.");
  }
}

void addComment(List<Map<String, dynamic>> students) {
  if (students.isEmpty) {
    print("No students available.");
    return;
  }

  for (int i = 0; i < students.length; i++) {
    print("${i + 1}. ${students[i]["name"]}");
  }

  stdout.write("Choose student number: ");
  int index = int.parse(stdin.readLineSync()!) - 1;

  stdout.write("Enter comment: ");
  String? comment = stdin.readLineSync();

  students[index]["comment"] = comment;

  print("Comment added.");
}

void viewAllStudents(List<Map<String, dynamic>> students) {
  if (students.isEmpty) {
    print("No students available.");
    return;
  }

  print("\nAll Students:");
  for (var student in students) {
    var tags = [
      student["name"],
      "${student["scores"].length} scores",
      if (student["bonus"] != null) "⭐ Has Bonus",
    ];

    print(tags.join(" | "));
  }
}

void viewReportCard(List<Map<String, dynamic>> students) {
  if (students.isEmpty) {
    print("No students available.");
    return;
  }

  for (int i = 0; i < students.length; i++) {
    print("${i + 1}. ${students[i]["name"]}");
  }

  stdout.write("Choose student number: ");
  int index = int.parse(stdin.readLineSync()!) - 1;

  var student = students[index];
  List<int> scores = List<int>.from(student["scores"]);

  if (scores.isEmpty) {
    print("No scores available.");
    return;
  }

  int sum = 0;
  for (int score in scores) {
    sum += score;
  }

  double average = sum / scores.length;

  average += (student["bonus"] ?? 0);

  if (average > 100) average = 100;

  String grade;

  if (average >= 90) {
    grade = "A";
  } else if (average >= 80) {
    grade = "B";
  } else if (average >= 70) {
    grade = "C";
  } else if (average >= 60) {
    grade = "D";
  } else {
    grade = "F";
  }

  String comment =
      student["comment"]?.toUpperCase() ?? "NO COMMENT PROVIDED";

  String feedback = switch (grade) {
    "A" => "Outstanding performance!",
    "B" => "Good work, keep it up!",
    "C" => "Satisfactory. Room to improve.",
    "D" => "Needs improvement.",
    "F" => "Failing. Please seek help.",
    _ => "Unknown grade."
  };

  print("""
╔══════════════════════════════╗
║       REPORT CARD            ║
╠══════════════════════════════╝
║  Name:    ${student["name"]}
║  Scores:  $scores
║  Bonus:   +${student["bonus"] ?? 0}
║  Average: ${average.toStringAsFixed(1)}
║  Grade:   $grade
║  Comment: $comment
║  Feedback: $feedback
╚══════════════════════════════╝
""");
}

void classSummary(List<Map<String, dynamic>> students) {
  if (students.isEmpty) {
    print("No students available.");
    return;
  }

  double totalAverage = 0;
  double highest = 0;
  double lowest = 100;
  int passCount = 0;

  Set<String> uniqueGrades = {};

  for (var student in students) {
    List<int> scores = List<int>.from(student["scores"]);

    if (scores.isEmpty) continue;

    int sum = 0;
    for (var score in scores) {
      sum += score;
    }

    double average = sum / scores.length;
    average += (student["bonus"] ?? 0);

    if (average > 100) average = 100;

    totalAverage += average;

    if (average > highest) highest = average;
    if (average < lowest) lowest = average;

    if (scores.isNotEmpty && average >= 60) {
      passCount++;
    }

    String grade;
    if (average >= 90) {
      grade = "A";
    } else if (average >= 80) {
      grade = "B";
    } else if (average >= 70) {
      grade = "C";
    } else if (average >= 60) {
      grade = "D";
    } else {
      grade = "F";
    }

    uniqueGrades.add(grade);
  }

  double classAverage = totalAverage / students.length;

  var summaryLines = [
    for (var s in students)
      "${s["name"]}: ${s["scores"].isNotEmpty ? s["scores"] : "No scores"}",
  ];

  print("""
===== CLASS SUMMARY =====
Total Students: ${students.length}
Class Average: ${classAverage.toStringAsFixed(1)}
Highest Average: ${highest.toStringAsFixed(1)}
Lowest Average: ${lowest.toStringAsFixed(1)}
Passing Students: $passCount
Unique Grades: $uniqueGrades
""");

  for (var line in summaryLines) {
    print(line);
  }
}