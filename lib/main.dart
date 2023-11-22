import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<String> terms = ['Begriff1', 'Begriff2', 'Begriff3', 'Begriff4', 'Begriff5'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Index Except App'),
        ),
        body: MyListView(terms),
      ),
    );
  }
}

class MyListView extends StatefulWidget {
  final List<String> terms;

  MyListView(this.terms);

  @override
  _MyListViewState createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  TextEditingController _indexController = TextEditingController();
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.terms.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(widget.terms[index]),
                tileColor: index == _selectedIndex ? Colors.blue : null,
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _indexController,
            onChanged: (value) {
              _updateSelectedIndex(value);
            },
            decoration: InputDecoration(labelText: 'Listenindex eingeben'),
          ),
        ),
      ],
    );
  }

  void _updateSelectedIndex(String value) {
    try {
      int index = int.parse(value) - 1;
      if (index >= 0 && index < widget.terms.length) {
        setState(() {
          _selectedIndex = index;
        });
      } else {
        _showErrorSnackBar('Index außerhalb des Bereichs');
      }
    } catch (e) {
      _showErrorSnackBar('Keine gültige Zahl');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
    setState(() {
      _selectedIndex = -1;
    });
  }
}
