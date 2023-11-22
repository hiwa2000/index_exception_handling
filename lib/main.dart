// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   final List<String> terms = ['Begriff1', 'Begriff2', 'Begriff3', 'Begriff4', 'Begriff5'];

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Index Except App'),
//         ),
//         body: MyListView(terms),
//       ),
//     );
//   }
// }

// class MyListView extends StatefulWidget {
//   final List<String> terms;

//   MyListView(this.terms);

//   @override
//   _MyListViewState createState() => _MyListViewState();
// }

// class _MyListViewState extends State<MyListView> {
//   TextEditingController _indexController = TextEditingController();
//   int _selectedIndex = -1;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           child: ListView.builder(
//             itemCount: widget.terms.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(widget.terms[index]),
//                 tileColor: index == _selectedIndex ? Colors.blue : null,
//               );
//             },
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: TextField(
//             controller: _indexController,
//             onChanged: (value) {
//               _updateSelectedIndex(value);
//             },
//             decoration: InputDecoration(labelText: 'Listenindex eingeben'),
//           ),
//         ),
//       ],
//     );
//   }

//   void _updateSelectedIndex(String value) {
//     try {
//       int index = int.parse(value) - 1;
//       if (index >= 0 && index < widget.terms.length) {
//         setState(() {
//           _selectedIndex = index;
//         });
//       } else {
//         _showErrorSnackBar('Index außerhalb des Bereichs');
//       }
//     } catch (e) {
//       _showErrorSnackBar('Keine gültige Zahl');
//     }
//   }

//   void _showErrorSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//       ),
//     );
//     setState(() {
//       _selectedIndex = -1;
//     });
//   }
// }


import 'package:flutter/material.dart';

class AgeException implements Exception {
  String get message => 'Age must be between 0 and 100';
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AgeScreen(),
    );
  }
}

class AgeScreen extends StatefulWidget {
  @override
  _AgeScreenState createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  TextEditingController _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check Age'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter your age'),
            ),
          ),
          TextButton(
            onPressed: () {
              _checkAge();
            },
            child: Text('Check Age'),
          ),
        ],
      ),
    );
  }

  void _checkAge() {
    try {
      int age = int.parse(_ageController.text);
      if (age <= 0 || age >= 95) {
        throw AgeException();
      } else {
        _showSuccessSnackBar('Age: $age');
      }
    } catch (e) {
      if (e is AgeException) {
        _showErrorSnackBar(e.message);
      } else {
        _showErrorSnackBar('Invalid Age');
      }
    }
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
