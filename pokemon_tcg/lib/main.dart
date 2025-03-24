import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // HTTP client for API requests
import 'dart:convert'; // JSON utilities
import 'package:sqflite/sqflite.dart'; // SQLite database
import 'package:path/path.dart'; // Path manipulation for database

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List pokemonCards = []; // Stores Pokemon cards from API
  Database? database; // Local SQLite database
  List<Map<String, dynamic>> students = []; // Student records
  String name = ""; // Student name input
  String marks = ""; // Student marks input

  @override
  void initState() {
    super.initState();
    fetchPokemonCards(); // Load Pokemon data from API
    setupDatabase(); // Initialize local database
  }

  // Fetch Pokemon cards from external API
  Future<void> fetchPokemonCards() async {
    final response =
        await http.get(Uri.parse('https://api.pokemontcg.io/v2/cards'));
    if (response.statusCode == 200) {
      setState(() {
        pokemonCards = jsonDecode(response.body)['data'];
      });
    }
  }

  // Initialize SQLite database
  Future<void> setupDatabase() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'students.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE students(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, marks INTEGER);",
        );
      },
      version: 1,
    );
    loadStudents();
  }

  // Add a new student record
  Future<void> addStudent() async {
    if (name.isEmpty || marks.isEmpty) return;
    await database
        ?.insert('students', {'name': name, 'marks': int.parse(marks)});
    loadStudents();
  }

  // Load student records from database
  Future<void> loadStudents() async {
    final List<Map<String, dynamic>> studentsList =
        await database?.query('students') ?? [];
    setState(() {
      students = studentsList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Student Marks & Pokémon Cards')),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // Student data input fields
              TextField(
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) => name = value,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Marks'),
                keyboardType: TextInputType.number,
                onChanged: (value) => marks = value,
              ),
              ElevatedButton(
                onPressed: addStudent,
                child: Text('Add Student'),
              ),
              // Student list
              Expanded(
                child: ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('${students[index]['name']}'),
                      subtitle: Text('Marks: ${students[index]['marks']}'),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              // Pokemon card section
              Text('Pokémon Cards',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: pokemonCards.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: Image.network(
                                pokemonCards[index]['images']['large']),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.network(
                            pokemonCards[index]['images']['small'],
                            width: 100,
                            height: 150),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
