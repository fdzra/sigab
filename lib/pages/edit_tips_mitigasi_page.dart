import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditTipsMitigasiPage extends StatefulWidget {
  final String judul;
  final String deskripsi;
  final String? gambar;

  const EditTipsMitigasiPage({
    Key? key,
    required this.judul,
    required this.deskripsi,
    this.gambar,
  }) : super(key: key);

  @override
  State<EditTipsMitigasiPage> createState() => _EditTipsMitigasiPageState();
}

class _EditTipsMitigasiPageState extends State<EditTipsMitigasiPage> {
  late TextEditingController _judulController;
  late TextEditingController _deskripsiController;
  String? _selectedImage;
  String? _judulError;
  String? _deskripsiError;
  String? _gambarError;

  bool _validateInputs() {
    bool isValid = true;
    setState(() {
      _judulError = null;
      _deskripsiError = null;
      _gambarError = null;

      if (_judulController.text.isEmpty) {
        _judulError = 'Judul tidak boleh kosong';
        isValid = false;
      }

      if (_deskripsiController.text.isEmpty) {
        _deskripsiError = 'Deskripsi tidak boleh kosong';
        isValid = false;
      }

      if (_selectedImage == null) {
        _gambarError = 'Gambar harus diunggah';
        isValid = false;
      }
    });
    return isValid;
  }

  @override
  void initState() {
    super.initState();
    // Mengisi data contoh
    _judulController = TextEditingController(text: "Tips Aman Menghadapi Banjir, Ini yang Harus Dilakukan!");
    _deskripsiController = TextEditingController(
      text: "Musim penghujan seringkali membawa risiko bencana banjir. Oleh karena itu, masyarakat perlu mempersiapkan diri dengan baik agar terhindar dari dampak buruk yang dapat ditimbulkan.\n\n"
          "Berikut hal-hal yang bisa dilakukan sebelum banjir\n"
          "1. Ketahui potensi bahaya dan risiko sekitar\n"
          "2. Pahami rute evaluasi dan daerah aman\n"
          "3. Siapkan tas siaga bencana\n"
          "4. Lakukan penguatan dan peninggian rumah\n"
          "5. Pantau informasi cuaca"
    );
    _selectedImage = "https://images.unsplash.com/photo-1584438784894-089d6a62b8fa?q=80";
  }

  @override
  void dispose() {
    _judulController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

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
          'Edit Tips Mitigasi Bencana',
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Judul',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _judulController,
              style: GoogleFonts.poppins(),
              decoration: InputDecoration(
                hintText: 'Masukkan judul tips mitigasi bencana',
                hintStyle: GoogleFonts.poppins(color: const Color(0xFFA0A0A0)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: Color(0xFF016FB9), width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: Color(0xFF016FB9), width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: Color(0xFF016FB9), width: 1.5),
                ),
                errorText: _judulError,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Deskripsi',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _deskripsiController,
              style: GoogleFonts.poppins(),
              maxLines: null, // Mengubah maxLines menjadi null agar menyesuaikan dengan konten
              minLines: 8, // Menambahkan minLines untuk tinggi minimum
              decoration: InputDecoration(
                hintText: 'Masukkan deskripsi tips mitigasi bencana',
                hintStyle: GoogleFonts.poppins(color: const Color(0xFFA0A0A0)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: Color(0xFF016FB9), width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: Color(0xFF016FB9), width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: Color(0xFF016FB9), width: 1.5),
                ),
                errorText: _deskripsiError,
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Unggah Gambar',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: _gambarError != null ? Colors.red : const Color(0xFF016FB9),
                  width: 1.5
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: _selectedImage != null
                  ? Stack(
                      fit: StackFit.expand, 
                      children: [
                        ClipRRect( 
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            _selectedImage!,
                            fit: BoxFit.cover, 
                            width: double.infinity,
                            height: double.infinity,
                            alignment: Alignment.center, 
                          ),
                        ),
                        Positioned(
                          right: 8,
                          top: 8,
                          child: IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white, // Mengubah warna dari Color(0xFF016FB9) menjadi putih
                            ),
                            onPressed: () {
                              // TODO: Implementasi edit gambar
                            },
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.add_photo_alternate_outlined),
                            onPressed: () {
                              // TODO: Implementasi unggah gambar
                            },
                          ),
                          Text(
                            'Tambahkan Gambar',
                            style: GoogleFonts.poppins(
                              color: const Color(0xFF016FB9),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Container(
                width: 136,
                height: 42,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFA726),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    if (_validateInputs()) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: Colors.white,
                            child: Container(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF3F3F3),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(
                                      Icons.check_circle_outline,
                                      color: Color(0xFF4CAF50),
                                      size: 48,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Sukses diubah!',
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Tips mitigasi bencana telah berhasil\ndiubah!',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: const Color(0xFF666666),
                                    ),
                                  ),
                                  const SizedBox(height: 24), // Mengubah dari 16 menjadi 24
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // Tutup dialog
                                        Navigator.of(context).pop(); // Kembali ke halaman sebelumnya
                                      },
                                      style: ElevatedButton.styleFrom( // Pindahkan keluar dari onPressed
                                        backgroundColor: const Color(0xFFFFA726),
                                        padding: const EdgeInsets.symmetric(vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Text( // Pindahkan keluar dari onPressed
                                        'Ubah',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                  child: Text(
                    'Ubah',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}