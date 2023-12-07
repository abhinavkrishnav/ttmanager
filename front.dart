import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String username = _usernameController.text;
                String password = _passwordController.text;

                // Check for username and password
                if (username == 'user' && password == 'admin') {
                  // Navigate to the home screen
                  _navigateToHome();
                } else {
                  // Show an error message
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Login Failed'),
                        content: Text('Invalid username or password'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _tabs = [
      // Home Page
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // First big container on the left (5:2 ratio)
            Expanded(
              flex: 5,
              child: Container(
                color: Color.fromARGB(255, 113, 132, 149),
                child: Center(
                  child: Text(
                    'SUBSTITUTION TIME TABLE',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16), // Add some spacing
            // Second big container on the right (5:2 ratio)
            Expanded(
              flex: 2,
              child: Container(
                color: Color.fromARGB(255, 90, 145, 92),
                child: Center(
                  child: Text(
                    'ABSENTEES',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      Container(
        child: Center(
          child: Container(
            width: 0.75 * MediaQuery.of(context).size.width,
            height: 0.75 *
                MediaQuery.of(context).size.height, // Set the desired height
            color: Colors.blue, // Set the color as needed
            child: Center(
              child: Text(
                'Time Table Content',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
      Container(
        child: Center(
          child: buildTeachersTable(),
        ),
      ),

      Container(
        child: Center(
          child: Text('Class Time Table Page'),
        ),
      ),
      Container(
        child: Center(
          child: buildAttendanceTable(),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('SUBSTITUTION'),
        centerTitle: true,
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(CupertinoIcons.home),
          ),
          BottomNavigationBarItem(
            label: 'Time Table',
            icon: Icon(CupertinoIcons.clock),
          ),
          BottomNavigationBarItem(
            label: 'Teachers',
            icon: Icon(CupertinoIcons.person),
          ),
          BottomNavigationBarItem(
            label: 'Class Time Table',
            icon: Icon(CupertinoIcons.calendar),
          ),
          BottomNavigationBarItem(
            label: 'Attendance',
            icon: Icon(CupertinoIcons.check_mark),
          ),
        ],
      ),
    );
  }

  Widget buildTeachersTable() {
    List<TableRow> rows = [];

    // Add the header row
    rows.add(
      TableRow(
        children: [
          TableCell(
            child: Center(
              child: Text('Serial Number'),
            ),
          ),
          TableCell(
            child: Center(
              child: Text('Teacher Name'),
            ),
          ),
          TableCell(
            child: Center(
              child: Text('ID'),
            ),
          ),
        ],
      ),
    );

    // Add data rows
    for (int i = 1; i <= 28; i++) {
      rows.add(
        TableRow(
          children: [
            TableCell(
              child: Center(
                child: Text('$i'),
              ),
            ),
            TableCell(
              child: Text(''), // Empty for Teacher Name
            ),
            TableCell(
              child: Center(
                child: Text('ID$i'),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      width: 0.8 *
          MediaQuery.of(context)
              .size
              .width, // Set the width to 80% of the screen width
      child: Table(
        border: TableBorder.all(),
        children: rows,
      ),
    );
  }

  Widget buildAttendanceTable() {
    List<bool> attendanceCheckboxState = List.generate(28, (index) => true);

    List<TableRow> rows = [];

    // Add the header row
    rows.add(
      TableRow(
        children: [
          TableCell(
            child: Center(
              child: Text('Serial Number'),
            ),
          ),
          TableCell(
            child: Center(
              child: Text(''),
            ),
          ),
          TableCell(
            child: Center(
              child: Text('Attendance'),
            ),
          ),
        ],
      ),
    );

    // Add data rows
    for (int i = 1; i <= 28; i++) {
      rows.add(
        TableRow(
          children: [
            TableCell(
              child: Center(
                child: Text('$i'),
              ),
            ),
            TableCell(
              child: Center(
                child: Text(''),
              ),
            ),
            TableCell(
              child: Center(
                child: Checkbox(
                  value: attendanceCheckboxState[i - 1],
                  onChanged: (value) {
                    setState(() {
                      attendanceCheckboxState[i - 1] = value ?? false;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      width: 0.5 *
          MediaQuery.of(context)
              .size
              .width, // Set the width to 50% of the screen width
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Table(
          border: TableBorder.all(),
          children: rows,
        ),
      ),
    );
  }
}
