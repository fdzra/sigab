import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailTempatEvakuasiPage extends StatefulWidget {
  final String namaTempat;
  final String gambar;
  final String linkMaps;
  final String tanggal; // Tambah parameter tanggal

  const DetailTempatEvakuasiPage({
    Key? key,
    required this.namaTempat,
    required this.gambar,
    required this.linkMaps,
    required this.tanggal, // Tambah parameter tanggal di constructor
  }) : super(key: key);

  @override
  State<DetailTempatEvakuasiPage> createState() => _DetailTempatEvakuasiPageState();
}

class _DetailTempatEvakuasiPageState extends State<DetailTempatEvakuasiPage> {
  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.black,
          ),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        title: Text(
          'Detail Tempat Evakuasi',
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF016FB9)),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informasi Tempat Evakuasi',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF016FB9),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow('Nama Tempat', widget.namaTempat),
                  const SizedBox(height: 12),
                  _buildInfoRow('Link Google Maps', widget.linkMaps),
                  const SizedBox(height: 12),
                  _buildInfoRow('Tanggal', widget.tanggal), // Pindahkan tanggal ke bawah
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Gambar',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF016FB9),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.gambar,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 48,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}