import 'package:flutter/material.dart';
import 'package:movieapp/helper/sqflite/sqflite_db.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movieapp/utils/text.dart';

class Offline extends StatefulWidget {
  const Offline({super.key});

  @override
  State<Offline> createState() => _OfflineState();
}

class _OfflineState extends State<Offline> {
  bool isLoading = true;
  List<Map<String, dynamic>> offlineData = [];

  @override
  void initState() {
    super.initState();
    fetchOfflineData();
  }

  // Fetch data from SQLite and update the UI
  Future<void> fetchOfflineData() async {
    setState(() {
      isLoading = true; // Show loading indicator
    });

    offlineData = await SqfliteDb.instance.getRecordsFromDB();
    setState(() {
      isLoading = false; // Hide loading indicator
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Offline Movies',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : offlineData.isEmpty
              ? const Center(
                  child: Text('No data available',
                      style: TextStyle(color: Colors.white)))
              : ListView.builder(
                  itemCount: offlineData.length,
                  itemBuilder: (context, index) {
                    final movie = offlineData[index];
                    return Container(
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: movie['image'] != null &&
                                        movie['image'].isNotEmpty
                                    ? CachedNetworkImageProvider(
                                        'https://image.tmdb.org/t/p/w500${movie['image']}')
                                    : const AssetImage(
                                            'assets/images/placeholder.png')
                                        as ImageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ModefiedText(
                            text: movie['title'] ?? 'Unknown Title',
                            size: 18,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 5),
                          ModefiedText(
                            text: movie['description'] ??
                                'No description available',
                            size: 14,
                            color: Colors.grey,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
