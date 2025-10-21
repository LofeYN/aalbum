// File: lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:album_store/providers/auth_provider.dart';
import 'package:album_store/providers/album_provider.dart';
import 'package:album_store/data/album_data.dart';
import 'package:album_store/models/product.dart';
import 'package:like_button/like_button.dart';

class _SliverSearchBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  _SliverSearchBarDelegate({required this.child});
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color: const Color(0xFF0F4C5C), child: child);
  }
  @override
  double get maxExtent => 60.0;
  @override
  double get minExtent => 60.0;
  @override
  bool shouldRebuild(_SliverSearchBarDelegate oldDelegate) {
    return child != oldDelegate.child;
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  String _selectedGenre = 'All';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<String> get genres {
    final albums = AlbumData.getAlbums();
    final genreSet = albums.map((a) => a.genre).toSet();
    return ['All', ...genreSet];
  }

  List<Album> getFilteredAlbums() {
    final albums = AlbumData.getAlbums();
    List<Album> filtered = albums;

    if (_selectedGenre != 'All') {
      filtered = filtered.where((a) => a.genre == _selectedGenre).toList();
    }

    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((a) =>
      a.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          a.artist.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    }
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final albumProvider = Provider.of<AlbumProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final filteredAlbums = getFilteredAlbums();

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            elevation: 2,
            backgroundColor: const Color(0xFF0F4C5C),
            automaticallyImplyLeading: false,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back! 👋',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withAlpha(200),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  authProvider.userEmail.split('@')[0],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: Badge(
                    label: Text(albumProvider.cartAlbumIds.length.toString()),
                    isLabelVisible: albumProvider.cartAlbumIds.isNotEmpty,
                    child: const Icon(Icons.shopping_cart_outlined, color: Colors.white)),
                onPressed: () {
                  Navigator.pushNamed(context, '/cart');
                },
              ),
              IconButton(
                icon: Badge(
                    label: Text(albumProvider.favoriteAlbumIds.length.toString()),
                    isLabelVisible: albumProvider.favoriteAlbumIds.isNotEmpty,
                    child: const Icon(Icons.favorite_border, color: Colors.white)),
                onPressed: () {
                  final allAlbums = AlbumData.getAlbums();
                  final favoriteAlbums = allAlbums
                      .where((album) => albumProvider.isFavorite(album.id))
                      .toList();
                  Navigator.pushNamed(context, '/favorites', arguments: favoriteAlbums);
                },
              ),
              IconButton(
                icon: const Icon(Icons.logout, color: Colors.white),
                onPressed: () {
                  authProvider.logout();
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
              const SizedBox(width: 8),
            ],
            flexibleSpace: const FlexibleSpaceBar(
              background: SizedBox.shrink(),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverSearchBarDelegate(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: 'Cari album atau artis...',
                    hintStyle: TextStyle(color: Colors.white.withAlpha(179)),
                    prefixIcon: Icon(Icons.search, color: Colors.white.withAlpha(204)),
                    filled: true,
                    fillColor: Colors.white.withAlpha(51),
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: genres.length,
                itemBuilder: (context, index) {
                  final genre = genres[index];
                  final isSelected = _selectedGenre == genre;
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: FilterChip(
                      label: Text(genre),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedGenre = genre;
                        });
                      },
                      backgroundColor: Colors.white,
                      selectedColor: const Color(0xFF1B6B6D),
                      checkmarkColor: Colors.white,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey.shade700,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      elevation: isSelected ? 4 : 1,
                      shadowColor: const Color(0xFF1B6B6D).withAlpha(102),
                    ),
                  );
                },
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.5,
              ),
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final album = filteredAlbums[index];
                  return _ModernAlbumCard(
                    album: album,
                    isFavorite: albumProvider.isFavorite(album.id),
                    onFavoriteTap: () => albumProvider.toggleFavorite(album.id),
                    onCartTap: () {
                      albumProvider.addToCart(album.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${album.name} ditambahkan ke keranjang!'),
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  );
                },
                childCount: filteredAlbums.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
        ],
      ),
    );
  }
}

// ### KARTU ALBUM DIKEMBALIKAN KE VERSI ASLI ANDA ###
class _ModernAlbumCard extends StatelessWidget {
  final Album album;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;
  final VoidCallback onCartTap;

  const _ModernAlbumCard({
    required this.album,
    required this.isFavorite,
    required this.onFavoriteTap,
    required this.onCartTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/detail', arguments: album);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.withAlpha(26),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: 'album-${album.id}',
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    child: Image.asset(
                      album.imageUrl,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 180,
                          color: Colors.grey.shade300,
                          child: const Center(
                            child: Icon(
                              Icons.broken_image_outlined,
                              color: Colors.grey,
                              size: 40,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: LikeButton(
                    size: 30,
                    isLiked: isFavorite,
                    onTap: (bool isLiked) async {
                      onFavoriteTap();
                      return !isLiked;
                    },
                    circleColor: const CircleColor(
                        start: Color(0xFFFF5722), end: Color(0xFFFFC107)),
                    bubblesColor: const BubblesColor(
                      dotPrimaryColor: Color(0xFFFF8A65),
                      dotSecondaryColor: Color(0xFFFFD54F),
                    ),
                    likeBuilder: (bool isLiked) {
                      return Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.red.shade400 : Colors.grey.shade700,
                        size: 20,
                      );
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    album.name,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    album.artist,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rp${(album.price / 1000).toStringAsFixed(0)}k',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F4C5C),
                        ),
                      ),
                      GestureDetector(
                        onTap: onCartTap,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1B6B6D),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.add_shopping_cart, size: 16, color: Colors.white),
                        ),
                      ),
                    ],
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