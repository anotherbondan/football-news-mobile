import 'package:flutter/material.dart';
import 'package:football_news/models/news_entry.dart';
import 'package:football_news/widgets/left_drawer.dart';
import 'package:football_news/screens/news_detail.dart';
import 'package:football_news/widgets/news_entry_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class NewsEntryListPage extends StatefulWidget {
  const NewsEntryListPage({super.key});

  @override
  State<NewsEntryListPage> createState() => _NewsEntryListPageState();
}

class _NewsEntryListPageState extends State<NewsEntryListPage> {
  Future<List<NewsEntry>> fetchNews(CookieRequest request) async {
    // To connect Android emulator with Django on localhost, use URL http://10.0.2.2/
    // If you using chrome,  use URL http://localhost:8000

    final response = await request.get('http://localhost:8000/json/');

    // Decode response to json format
    var data = response;

    // Convert json data to NewsEntry objects
    List<NewsEntry> listNews = [];
    for (var d in data) {
      if (d != null) {
        listNews.add(NewsEntry.fromJson(d));
      }
    }
    return listNews;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(title: const Text('News Entry List')),
      drawer: const LeftDrawer(),
      // ... (Widget build) ...
      body: FutureBuilder(
        future: fetchNews(request),
        builder: (context, AsyncSnapshot<List<NewsEntry>> snapshot) {
          // 1. Cek status Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } 
          
          // 2. Cek jika ada Error
          else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error.toString()}'),
            );
          } 
          
          // 3. Cek jika data ada dan tidak null
          else if (snapshot.hasData) {
            // 4. Cek jika datanya kosong (Empty State)
            if (snapshot.data!.isEmpty) {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center, // Opsional: pusatkan
                children: [
                  Text(
                    'There are no news in football news yet.',
                    style: TextStyle(fontSize: 20, color: Color(0xff59A5D8)),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } 
            
            // 5. Jika ada data dan tidak kosong (Success State)
            else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => NewsEntryCard(
                  news: snapshot.data![index],
                  onTap: () {
                    // Navigate to news detail page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NewsDetailPage(news: snapshot.data![index]),
                      ),
                    );
                  },
                ),
              );
            }
          } 
          
          // 6. Fallback jika snapshot.data == null (meskipun koneksi selesai)
          else {
            return const Center(
              child: Text('No data received from server.'),
            );
          }
        },
      ),
// ... (sisa Scaffold) ...
    );
  }
}