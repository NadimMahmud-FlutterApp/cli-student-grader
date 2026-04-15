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

// ---------------- OPTION 5 ----------------
void viewAllStudents(List<Map<String, dynamic>> students) {
  if (students.isEmpty) {
    print("No students found.");
    return;
  }

  for (var student in students) {
    var tags = [
      student["name"],
      "${student["scores"].length} scores",
      if (student["bonus"] != null) "⭐ Has Bonus"
    ];

    print(tags.join(" | "));
  }
}

// ---------------- OPTION 6 ----------------
void viewReportCard(List<Map<String, dynamic>> students) {
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

  var scores = student["scores"] as List<int>;

  if (scores.isEmpty) {
    print("No scores available.");
    return;
  }

  int sum = 0;
  for (var s in scores) {
    sum += s;
  }

  double rawAvg = sum / scores.length;

  double finalAvg = rawAvg + (student["bonus"] ?? 0);

  if (finalAvg > 100) finalAvg = 100;

  String grade;

  if (finalAvg >= 90) {
    grade = "A";
  } else if (finalAvg >= 80) {
    grade = "B";
  } else if (finalAvg >= 70) {
    grade = "C";
  } else if (finalAvg >= 60) {
    grade = "D";
  } else {
    grade = "F";
  }

  String comment =
      student["comment"]?.toUpperCase() ?? "No comment provided";

  String feedback = switch (grade) {
    "A" => "Outstanding performance!",
    "B" => "Good work, keep it up!",
    "C" => "Satisfactory. Room to improve.",
    "D" => "Needs improvement.",
    "F" => "Failing. Please seek help.",
    _ => "Unknown grade"
  };

  print("""
╔══════════════════════════════╗
║       REPORT CARD            ║
╠══════════════════════════════╝
║  Name:    ${student["name"]}
║  Scores:  $scores
║  Bonus:   +${student["bonus"] ?? 0}
║  Average: ${finalAvg.toStringAsFixed(1)}
║  Grade:   $grade
║  Comment: $comment
╚══════════════════════════════╝

Feedback: $feedback
""");
}

// ---------------- OPTION 7 ----------------
void classSummary(List<Map<String, dynamic>> students) {
  if (students.isEmpty) return;

  double total = 0;
  double highest = 0;
  double lowest = 100;

  int count = 0;
  int passCount = 0;

  Set<String> gradeSet = {};

  for (var s in students) {
    var scores = s["scores"] as List<int>;
    if (scores.isEmpty) continue;

    int sum = 0;
    for (var sc in scores) {
      sum += sc;
    }

    double avg = sum / scores.length;

    total += avg;
    count++;

    if (avg > highest) highest = avg;
    if (avg < lowest) lowest = avg;

    if (scores.isNotEmpty && avg >= 60) {
      passCount++;
    }

    String grade;
    if (avg >= 90) {
      grade = "A";
    } else if (avg >= 80) {
      grade = "B";
    } else if (avg >= 70) {
      grade = "C";
    } else if (avg >= 60) {
      grade = "D";
    } else {
      grade = "F";
    }

    gradeSet.add(grade);
  }

  double classAvg = count > 0 ? total / count : 0;

  var summaryLines = [
    for (var s in students)
      "${s["name"]}: ${(s["scores"] as List).length} scores"
  ];

  print("""
===== CLASS SUMMARY =====
Total Students: ${students.length}
Class Average: ${classAvg.toStringAsFixed(2)}
Highest Avg: $highest
Lowest Avg: $lowest
Passing Students: $passCount
Grades Present: $gradeSet

Details:
${summaryLines.join("\n")}
""");
}
