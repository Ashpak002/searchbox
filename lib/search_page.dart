import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'search_provider.dart';

class SearchPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(
            color: Color(0xFF212121),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchBar(searchProvider),
            const SizedBox(height: 16),
            searchProvider.isLoading
                ? Center(child: CircularProgressIndicator())
                : _buildSearchResults(searchProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(SearchProvider searchProvider) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextField(
        controller: _controller,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.black54),
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                searchProvider.search(_controller.text);
              }
            },
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
      ),
    );
  }

  Widget _buildSearchResults(SearchProvider searchProvider) {
    if (searchProvider.results.isEmpty) {
      return Center(
        child: Text(
          'No results found',
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: searchProvider.results.length,
        itemBuilder: (context, index) {
          final item = searchProvider.results[index];
          return _buildListItem(item);
        },
      ),
    );
  }

  Widget _buildListItem(dynamic item) {
    final title = item['title'] ?? item['name'] ?? 'Unknown';
    final releaseDate = item['release_date'] ?? item['first_air_date'] ?? 'Unknown';
    final posterPath = item['poster_path'] != null
        ? 'https://image.tmdb.org/t/p/w500${item['poster_path']}'
        : 'https://via.placeholder.com/150';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                posterPath,
                width: 100,
                height: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 100,
                    height: 150,
                    color: Colors.grey[300],
                    child: Icon(Icons.broken_image, color: Colors.grey[700]),
                  );
                },
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  }
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF262E2E),
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      releaseDate,
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
