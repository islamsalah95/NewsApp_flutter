import 'package:flutter/material.dart';
import 'package:login/Models/article_model.dart';

class ArticleCard extends StatelessWidget {
  final ArticleModel article;

  ArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    // Check if the URL is valid and starts with http/https
    bool isValidUrl(String? url) {
      return url != null && (url.startsWith('http') || url.startsWith('https'));
    }

    return Container(
        margin: const EdgeInsets.only(bottom: 30),
      height: MediaQuery.of(context).size.height / 1.3,
      width: MediaQuery.of(context).size.width / 1.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue,
        boxShadow: const [
          BoxShadow(
            blurRadius: 40,
            color: Colors.white,
            offset: Offset(8, 10),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                isValidUrl(article.image)
                    ? article.image!
                    : "https://st4.depositphotos.com/14953852/24787/v/450/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg", // Default image
                width: MediaQuery.of(context).size.width / 1.3,
                errorBuilder: (context, error, stackTrace) {
                  return Image.network(
                    "https://st4.depositphotos.com/14953852/24787/v/450/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg", // Fallback in case of error
                    width: MediaQuery.of(context).size.width / 1.3,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title ?? "No Title",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    article.description ?? "No Description",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "By ${article.author ?? 'Unknown'}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Colors.white60,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "At ${article.data ?? 'Unk date'}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
