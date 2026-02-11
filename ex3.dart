import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// --------- STATIC TITLE USING STATELESS WIDGET ----------
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Student Record",
      home: StudentPage(),
    );
  }
}

// --------- MODEL CLASS ----------
class Student {
  String name;
  String roll;
  String dept;

  Student({required this.name, required this.roll, required this.dept});
}

// --------- MAIN PAGE ----------
class StudentPage extends StatefulWidget {
  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  List<Student> students = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController rollController = TextEditingController();
  TextEditingController deptController = TextEditingController();

  // -------- ADD OR UPDATE DIALOG ----------
  void showForm({int? index}) {
    if (index != null) {
      nameController.text = students[index].name;
      rollController.text = students[index].roll;
      deptController.text = students[index].dept;
    } else {
      nameController.clear();
      rollController.clear();
      deptController.clear();
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(index == null ? "Add Student" : "Update Student"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: rollController,
                decoration: InputDecoration(labelText: "Roll No"),
              ),
              TextField(
                controller: deptController,
                decoration: InputDecoration(labelText: "Department"),
              ),
            ],
          ),
          actions: [
            // -------- CANCEL BUTTON ----------
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),

            // -------- SAVE BUTTON ----------
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (index == null) {
                    students.add(Student(
                      name: nameController.text,
                      roll: rollController.text,
                      dept: deptController.text,
                    ));
                  } else {
                    students[index].name = nameController.text;
                    students[index].roll = rollController.text;
                    students[index].dept = deptController.text;
                  }
                });

                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  // -------- DELETE FUNCTION ----------
  void deleteStudent(int index) {
    setState(() {
      students.removeAt(index);
    });
  }

  // -------- UI ----------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Record Management"),
        centerTitle: true,
      ),

      body: students.isEmpty
          ? Center(child: Text("No Records Added"))
          : ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(students[index].name),
                    subtitle: Text(
                        "Roll: ${students[index].roll}\nDept: ${students[index].dept}"),

                    // -------- UPDATE BUTTON ----------
                    leading: IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        showForm(index: index);
                      },
                    ),

                    // -------- DELETE BUTTON (DUSTBIN) ----------
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        deleteStudent(index);
                      },
                    ),
                  ),
                );
              },
            ),

      // -------- FLOATING ACTION BUTTON ----------
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showForm();
        },
      ),
    );
  }
}
