import 'package:flutter/material.dart';
import 'package:petland/share/import.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Category',
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                size: 21,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.message,
                size: 21,
              ),
              onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
