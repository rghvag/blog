import 'package:flutter/material.dart';
import 'package:blogger/model/model.dart';
import 'package:flutter/services.dart';

class DetailedBlogScreen extends StatelessWidget {
  final List<Blog> blogList;
  final int index;

  DetailedBlogScreen(this.blogList, this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SUB SPACE',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Image.network(
              blogList[index].imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              blogList[index].title,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
