import 'package:flutter/material.dart';
import 'package:football_news/screens/menu.dart';
import 'package:football_news/screens/newlist_form.dart';
import 'package:football_news/screens/news_entry_list.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              children: [
                Text(
                  'Football News',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text(
                  "Seluruh berita sepak bola terkini di sini!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            // Bagian redirection ke MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.post_add),
            title: const Text('Add News'),
            // Bagian redirection ke NewsFormPage
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => NewsFormPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.newspaper),
            title: const Text('See Football News'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_reaction_rounded),
            title: const Text('News List'),
            onTap: () {
              // Route to news list page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewsEntryListPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
