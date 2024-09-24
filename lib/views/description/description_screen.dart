import 'package:flutter/material.dart';
import 'package:movieapp/utils/text.dart';

class DescriptionScreen extends StatefulWidget {
  final String name;
  final String description;
  final String bannerUrl;
  final String posterUrl;
  final String vote;
  final String launchOn;
  final Function(Map<String, dynamic>) toggleFavorite;
  final bool isFavorite;

  const DescriptionScreen({
    super.key,
    required this.name,
    required this.description,
    required this.bannerUrl,
    required this.posterUrl,
    required this.vote,
    required this.launchOn,
    required this.toggleFavorite,
    required this.isFavorite,
  });

  @override
  _DescriptionScreenState createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          // Banner Image
          widget.bannerUrl.isNotEmpty
              ? Stack(
                  children: [
                    Image.network(
                      widget.bannerUrl,
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: ModefiedText(
                        text: '⭐ Average Rating - ${widget.vote}',
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              : Container(
                  height: 250,
                  color: Colors.grey, // Fallback for missing image
                ),
          const SizedBox(height: 50),

          // Movie Title and Favorite Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: ModefiedText(
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  text: widget.name,
                  size: 24,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isFavorite = !isFavorite;
                    widget.toggleFavorite({
                      'name': widget.name,
                      'posterUrl': widget.posterUrl,
                      'description': widget.description,
                    });
                  });
                },
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite
                      ? Colors.red
                      : Colors.white, // Change color based on state
                  size: 35,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Release Date
          ModefiedText(
            text: 'Release Date: ${widget.launchOn}',
            size: 18,
            color: Colors.white,
          ),
          const SizedBox(height: 30),

          // Poster Image and Description
          Row(
            children: [
              widget.posterUrl.isNotEmpty
                  ? Image.network(
                      widget.posterUrl,
                      height: 250,
                    )
                  : Container(
                      height: 250,
                      color: Colors.grey, // Fallback for missing poster
                    ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ModefiedText(
                    text: widget.description,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
