import 'package:flutter/material.dart';
import 'dart:async'; // Diperlukan untuk Future.delayed

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            Navigator.pushReplacementNamed(context, '/login');
          }
        });
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0F4C5C), // Dark Teal
              Color(0xFF1B6B6D), // Medium Teal
              Color(0xFF427D79), // Lighter Teal/Green
            ],
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          // 1. Menggunakan Stack untuk menumpuk widget
          child: Stack(
            children: [
              // Konten utama (logo dan nama aplikasi) tetap di tengah
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 150,
                      width: 150,
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Album Store',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Your Music Collection',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),

              // 2. Menambahkan nama Anda di bagian bawah layar
              Positioned(
                bottom: 40, // Jarak dari bawah
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Text(
                      'Dibuat oleh',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(150), // Sedikit transparan
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Muhammad Dzacky Maulana Yahya',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}