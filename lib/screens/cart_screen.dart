// File: lib/screens/cart_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:album_store/providers/album_provider.dart';
import 'package:album_store/data/album_data.dart';
import 'package:intl/intl.dart';
// Library qr_flutter tidak kita perlukan lagi untuk menampilkan gambar statis
// import 'package:qr_flutter/qr_flutter.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final albumProvider = Provider.of<AlbumProvider>(context);
    final allAlbums = AlbumData.getAlbums();
    final cartAlbums = allAlbums.where((album) => albumProvider.isInCart(album.id)).toList();
    final totalPrice = cartAlbums.fold<double>(0.0, (sum, album) => sum + album.price);
    final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
    final formattedTotalPrice = currencyFormatter.format(totalPrice).replaceAll(',00', '');

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Keranjang Belanja',
              style: TextStyle(color: Colors.black87, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              '${cartAlbums.length} Item',
              style: TextStyle(color: Colors.grey[600], fontSize: 14, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: cartAlbums.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(color: Colors.grey[200], shape: BoxShape.circle),
              child: Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey[400]),
            ),
            const SizedBox(height: 24),
            Text('Keranjang Kosong', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey[700])),
            const SizedBox(height: 8),
            Text('Belum ada album yang ditambahkan', style: TextStyle(fontSize: 16, color: Colors.grey[500])),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: cartAlbums.length,
        itemBuilder: (context, index) {
          final album = cartAlbums[index];
          return Dismissible(
            key: Key(album.id),
            direction: DismissDirection.endToStart,
            background: Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(color: Colors.red.shade400, borderRadius: BorderRadius.circular(20)),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 24),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.delete_outline, color: Colors.white, size: 32),
                  SizedBox(height: 4),
                  Text('Hapus', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            onDismissed: (direction) {
              albumProvider.removeFromCart(album.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${album.name} dihapus dari keranjang'),
                  backgroundColor: Colors.red[600],
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  margin: const EdgeInsets.all(16),
                  action: SnackBarAction(
                    label: 'Batal',
                    textColor: Colors.white,
                    onPressed: () => albumProvider.toggleCart(album.id),
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black.withAlpha(13), blurRadius: 10, offset: const Offset(0, 2))],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(album.imageUrl, width: 90, height: 90, fit: BoxFit.cover),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(album.name, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black87), maxLines: 1, overflow: TextOverflow.ellipsis),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.person_rounded, size: 14, color: Colors.grey[600]),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(album.artist, style: TextStyle(fontSize: 14, color: Colors.grey[600]), maxLines: 1, overflow: TextOverflow.ellipsis),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            currencyFormatter.format(album.price).replaceAll(',00', ''),
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: cartAlbums.isEmpty ? null : _CheckoutBottomBar(totalPrice: totalPrice, formattedTotalPrice: formattedTotalPrice, cartItemCount: cartAlbums.length),
    );
  }
}

class _CheckoutBottomBar extends StatelessWidget {
  final double totalPrice;
  final String formattedTotalPrice;
  final int cartItemCount;

  const _CheckoutBottomBar({
    required this.totalPrice,
    required this.formattedTotalPrice,
    required this.cartItemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(20), blurRadius: 15, offset: const Offset(0, -5))],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.deepPurple.withAlpha(26), Colors.deepPurple.withAlpha(13)]),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Belanja', style: TextStyle(fontSize: 14, color: Colors.grey[700], fontWeight: FontWeight.w500)),
                        const SizedBox(height: 4),
                        Text(
                          formattedTotalPrice,
                          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: Colors.deepPurple.withAlpha(38), borderRadius: BorderRadius.circular(12)),
                      child: Text('$cartItemCount item', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _showPaymentOptions(context, totalPrice, formattedTotalPrice),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.payment_rounded, size: 24),
                      SizedBox(width: 12),
                      Text('Checkout', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_rounded, size: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPaymentOptions(BuildContext context, double totalPrice, String formattedTotalPrice) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
            ),
            const SizedBox(height: 24),
            const Text('Pilih Metode Pembayaran', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 24),
            _PaymentOptionCard(
              icon: Icons.qr_code_2_rounded,
              title: 'QRIS',
              subtitle: 'Scan untuk membayar',
              color: Colors.purple,
              onTap: () {
                Navigator.pop(context);
                _showQRISPayment(context, formattedTotalPrice);
              },
            ),
            const SizedBox(height: 12),
            _PaymentOptionCard(
              icon: Icons.account_balance_rounded,
              title: 'Transfer Bank',
              subtitle: 'BCA, Mandiri, BNI, BRI',
              color: Colors.blue,
              onTap: () {
                Navigator.pop(context);
                _showBankTransfer(context, formattedTotalPrice);
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _showQRISPayment(BuildContext context, String formattedTotalPrice) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          padding: const EdgeInsets.all(28),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.purple[400]!, Colors.purple[600]!]),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(Icons.qr_code_2_rounded, size: 40, color: Colors.white),
                ),
                const SizedBox(height: 20),
                const Text('Scan QRIS', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
                const SizedBox(height: 8),
                Text('Total Pembayaran', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                const SizedBox(height: 4),
                Text(formattedTotalPrice, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.purple)),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.purple.withAlpha(77), width: 2),
                  ),
                  // ### PERUBAHAN UTAMA DI SINI ###
                  // Mengganti QrImageView dengan Image.asset
                  child: Image.asset(
                    'assets/images/Qris.jpg', // Pastikan nama file sesuai
                    width: 220,
                    height: 220,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text('Tutup', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showBankTransfer(BuildContext context, String formattedTotalPrice) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.account_balance_rounded, size: 50, color: Colors.blue[600]),
              const SizedBox(height: 16),
              const Text('Transfer Bank', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              const _BankAccountCard(
                bankName: 'BCA',
                accountNumber: '1234567890',
                accountName: 'Album Store Indonesia',
                color: Colors.blue,
              ),
              const SizedBox(height: 12),
              Text('Total: $formattedTotalPrice', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('Tutup', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PaymentOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _PaymentOptionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withAlpha(20),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withAlpha(77), width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: color.withAlpha(38), borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.grey[800])),
                  const SizedBox(height: 2),
                  Text(subtitle, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 18, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}

class _InstructionRow extends StatelessWidget {
  final String number;
  final String text;
  const _InstructionRow({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(color: Colors.purple, borderRadius: BorderRadius.circular(6)),
          child: Center(
            child: Text(number, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(text, style: TextStyle(fontSize: 14, color: Colors.grey[700], height: 1.4)),
        ),
      ],
    );
  }
}

class _BankAccountCard extends StatelessWidget {
  final String bankName;
  final String accountNumber;
  final String accountName;
  final Color color;

  const _BankAccountCard({
    required this.bankName,
    required this.accountNumber,
    required this.accountName,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withAlpha(77), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(bankName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 8),
          Text(accountNumber, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87, letterSpacing: 1.5)),
          const SizedBox(height: 4),
          Text(accountName, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
        ],
      ),
    );
  }
}