// File: lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:album_store/providers/auth_provider.dart';
import 'package:album_store/providers/album_provider.dart';
import 'package:album_store/screens/splash_screen.dart';
import 'package:album_store/screens/login_screen.dart';
import 'package:album_store/screens/home_screen.dart';
import 'package:album_store/screens/favorites_screen.dart';
import 'package:album_store/screens/detail_screen.dart';
import 'package:album_store/screens/cart_screen.dart'; // <-- Tambah import untuk cart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AuthProvider()),
        ChangeNotifierProvider(create: (ctx) => AlbumProvider()),
      ],
      child: MaterialApp(
        title: 'Album Store',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
          '/favorites': (context) => const FavoritesScreen(),
          '/detail': (context) => const DetailScreen(),
          '/cart': (context) => const CartScreen(), // <-- Daftarkan rute baru
        },
      ),
    );
  }
}