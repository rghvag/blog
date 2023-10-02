import 'package:blogger/screens/blog_list_screen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'model/model.dart';

class BlogListScreen extends StatefulWidget {
  @override
  _BlogListScreenState createState() => _BlogListScreenState();
}

class _BlogListScreenState extends State<BlogListScreen> {
  late Future<List<Blog>> blogs;

  @override
  void initState() {
    super.initState();
    blogs = fetchBlogs();
  }

  static const String apiUrl =
      'https://intent-kit-16.hasura.app/api/rest/blogs';
  static const String adminSecret =
      '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

  Future<List<Blog>> fetchBlogs() async {
    final response = await http.get(Uri.parse(apiUrl), headers: {
      'x-hasura-admin-secret': adminSecret,
    });

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['blogs'];
      List<Blog> blogs = data.map((json) => Blog.fromJson(json)).toList();
      return blogs;
    } else {
      throw Exception('Failed to fetch blogs');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sub Space',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      endDrawer: Drawer(
        child: Container(
          color: Colors.transparent,
          child: Container(
            color: Colors.black.withOpacity(0.2),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  height: 75,
                  decoration: const BoxDecoration(
                    color:
                        Colors.black, 
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Hello reader!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                ListTile(
                  title: const Center(
                      child: Text(
                    'Home Page',
                    style: TextStyle(fontSize: 18),
                  )),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Center(
                      child: Text(
                    'Favorites',
                    style: TextStyle(fontSize: 18),
                  )),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Center(
                      child: Text(
                    'Download App',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  )),
                  onTap: () {
                    _launchUrl();
                  },
                ),
                ListTile(
                  title: const Center(
                      child: Text(
                    'Subspace official',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  )),
                  onTap: () {
                    _launchUrl2();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: FutureBuilder<List<Blog>>(
          future: blogs,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<Blog> blogList = snapshot.data!;
              return bloglistscreen(blogList);
            }
          },
        ),
      ),
    );
  }
}

final Uri _url2 = Uri.parse('https://subspace.money/');
final Uri _url = Uri.parse(
    'https://play.google.com/store/apps/details?id=org.grow90.whatsub&pli=1');

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}

Future<void> _launchUrl2() async {
  if (!await launchUrl(_url2)) {
    throw Exception('Could not launch $_url2');
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    darkTheme: ThemeData.dark(),
    home: BlogListScreen(),
  ));
}
