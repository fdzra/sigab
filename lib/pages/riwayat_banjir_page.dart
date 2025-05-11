import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'detail_riwayat_banjir_page.dart';

class RiwayatBanjirPage extends StatelessWidget {
  const RiwayatBanjirPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF016FB9)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Riwayat Banjir',
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildRiwayatBanjirCard(
            context,
            koordinat: 'Citeureup (0.07 LS, 109.37 BT)',  // Format yang lebih mudah di-parse
            tanggal: 'Senin, 7 April 2025, 12.27 WIB',
            tingkatKedalaman: 'Rendah',
            jarak: '10 Km dari lokasi anda',
            wilayah: 'Jl. Sukabirus, sebagian Jl. Radio Palasari, sebagian area hulu sungai Cigede',
            warna: const Color(0xFF0EDD06),
          ),
          const SizedBox(height: 16),
          _buildRiwayatBanjirCard(
            context,
            koordinat: 'Citeureup (0.07 LS, 109.37 BT)',
            tanggal: 'Senin, 10 Maret 2025, 23.33 WIB',
            tingkatKedalaman: 'Tinggi',
            jarak: '10 Km dari lokasi anda',
            wilayah: 'Jl. Radio Palasari, Sebagian hulu sungai Cigede',
            warna: Color(0xFFE60000),
          ),
          const SizedBox(height: 16),
          _buildRiwayatBanjirCard(
            context,
            koordinat: 'Citeureup (0.07 LS, 109.37 BT)',
            tanggal: 'Senin, 24 Maret 2025, 12.56 WIB',
            tingkatKedalaman: 'Sedang',
            jarak: '10 Km dari lokasi anda',
            wilayah: 'Jl. Radio Palasari, Sebagian hulu sungai Cigede',
            warna: const Color(0xFFF6AE2D),
          ),
        ],
      ),
    );
  }

  Widget _buildRiwayatBanjirCard(
    BuildContext context, {
    required String koordinat,
    required String tanggal,
    required String tingkatKedalaman,
    required String jarak,
    required String wilayah,
    required Color warna,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF016FB9)),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailRiwayatBanjirPage(
                koordinat: koordinat,
                tanggal: tanggal,
                tingkatKedalaman: tingkatKedalaman,
                jarak: jarak,
                wilayah: wilayah,
                warna: warna,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12), // Mengubah padding dari 16 menjadi 12
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on_outlined, color: Colors.grey[600], size: 16), // Mengubah size dari 20 menjadi 16
                  const SizedBox(width: 4),
                  Text(
                    koordinat,
                    style: GoogleFonts.poppins(
                      fontSize: 12, // Mengubah fontSize dari 14 menjadi 12
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6), // Mengubah height dari 8 menjadi 6
              Text(
                'Banjir',
                style: GoogleFonts.poppins(
                  fontSize: 18, // Mengubah fontSize dari 20 menjadi 18
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                tanggal,
                style: GoogleFonts.poppins(
                  fontSize: 12, // Mengubah fontSize dari 14 menjadi 12
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 6), // Mengubah height dari 8 menjadi 6
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), // Mengubah padding
                decoration: BoxDecoration(
                  color: warna,
                  borderRadius: BorderRadius.circular(12), // Mengubah radius dari 16 menjadi 12
                ),
                child: Text(
                  'Tingkat Kedalaman: $tingkatKedalaman',
                  style: GoogleFonts.poppins(
                    fontSize: 12, // Mengubah fontSize dari 14 menjadi 12
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 12), // Mengubah height dari 16 menjadi 12
              Row(
                children: [
                  Icon(Icons.swap_horiz, color: Colors.orange[400], size: 20), // Mengubah size dari 24 menjadi 20
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jarak',
                        style: GoogleFonts.poppins(
                          fontSize: 12, // Mengubah fontSize dari 14 menjadi 12
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        jarak,
                        style: GoogleFonts.poppins(
                          fontSize: 14, // Mengubah fontSize dari 16 menjadi 14
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10), // Mengubah height dari 12 menjadi 10
              Row(
                children: [
                  Icon(Icons.flag, color: Colors.orange[400], size: 20), // Mengubah size dari 24 menjadi 20
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Wilayah Banjir',
                          style: GoogleFonts.poppins(
                            fontSize: 12, // Mengubah fontSize dari 14 menjadi 12
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          wilayah,
                          style: GoogleFonts.poppins(
                            fontSize: 14, // Mengubah fontSize dari 16 menjadi 14
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}