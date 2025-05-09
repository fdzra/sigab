import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailTipsMitigasiBencanaPage extends StatefulWidget {
  final String judul;
  final String deskripsi;
  final String? gambar;
  final String tanggal;

  const DetailTipsMitigasiBencanaPage({
    Key? key,
    required this.judul,
    required this.deskripsi,
    this.gambar,
    required this.tanggal,
  }) : super(key: key);

  @override
  State<DetailTipsMitigasiBencanaPage> createState() => _DetailTipsMitigasiBencanaPageState();
}

class _DetailTipsMitigasiBencanaPageState extends State<DetailTipsMitigasiBencanaPage> {
  late String _judul;
  late String _deskripsi;

  @override
  void initState() {
    super.initState();
    _judul = "Tips Aman Menghadapi Banjir, Ini yang Harus Dilakukan!";
    _deskripsi = "Musim penghujan seringkali membawa risiko bencana banjir. Oleh karena itu, masyarakat perlu mempersiapkan diri dengan baik agar terhindar dari dampak buruk yang dapat ditimbulkan.\n\n"
        "Berikut hal-hal yang bisa dilakukan sebelum banjir\n"
        "1. Ketahui potensi bahaya dan risiko sekitar\n"
        "2. Pahami rute evaluasi dan daerah aman\n"
        "3. Siapkan tas siaga bencana\n"
        "4. Lakukan penguatan dan peninggian rumah\n"
        "5. Pantau informasi cuaca";
  }

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
          'Detail Tips Mitigasi Bencana',
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
                    'Tips Mitigasi Bencana',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF016FB9),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoRow('Judul', _judul),
                  const SizedBox(height: 12),
                  _buildInfoRow('Deskripsi', _deskripsi),
                  const SizedBox(height: 12),
                  _buildInfoRow('Tanggal', widget.tanggal),
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
                  "https://images.unsplash.com/photo-1584438784894-089d6a62b8fa?q=80",
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