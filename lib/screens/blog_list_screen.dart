import 'package:blogger/screens/detailed_blog_screen.dart';
import 'package:flutter/material.dart';
import 'package:blogger/model/model.dart';

ListView bloglistscreen(List<Blog> blogList) {
  return ListView.builder(
    itemCount: blogList.length,
    itemBuilder: (context, index) {
      return Card(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DetailedBlogScreen(blogList, index),
              ),
            );
          },
          child: Column(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4.0),
                ),

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: Image.network(
                    blogList[index].imageUrl,
                    fit: BoxFit.cover,
                    width: double
                        .infinity, 
                    height: 200,
                  ),
                ),
              ),
              Container(
                height: 50,
                child: Text(
                  blogList[index].title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
