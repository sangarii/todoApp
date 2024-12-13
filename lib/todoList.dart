import 'package:flutter/material.dart';

class Todolist extends StatefulWidget {
  const Todolist({super.key});

  @override
  State<Todolist> createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  @override
  Widget build(BuildContext context,) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      margin: const EdgeInsets.symmetric(vertical: 8), // Spacing between items
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: ListTile(
          leading: Icon(
            Icons.check_box,
            size: 32,
            color: Colors.purple.shade300,
          ),
          title: Text(
            "Another Test",
            style: TextStyle(
              fontSize: 22,
              color: Colors.black.withOpacity(0.6),
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: const Icon(
            Icons.delete,
            size: 34,
            color: Colors.red,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16), // Padding
          onTap: () {
            // Action when tapped
            print('Todo item tapped!');
          },
        ),
      ),
    );
  }
}
