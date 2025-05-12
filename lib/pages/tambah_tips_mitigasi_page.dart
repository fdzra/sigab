import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class TambahTipsMitigasiPage extends StatefulWidget {
  const TambahTipsMitigasiPage({Key? key}) : super(key: key);

  @override
  State<TambahTipsMitigasiPage> createState() => _TambahTipsMitigasiPageState();
}

class _TambahTipsMitigasiPageState extends State<TambahTipsMitigasiPage> {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  String? _selectedImage;
  String? _judulError;
  String? _deskripsiError;
  String? _gambarError;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image.path;
      });
    }
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF016FB9)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Tambah Tips Mitigasi Bencana',
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
                hintText: 'Masukkan judul tips mitigasi',
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
              maxLines: 5,
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
            GestureDetector(
              onTap: _pickImage,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: _gambarError != null ? const Color(0xFFB00020) : const Color(0xFF016FB9),
                        width: 1.5
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: _selectedImage != null
                        ? Image.network(_selectedImage!, fit: BoxFit.cover)
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.add_photo_alternate_outlined,
                                    color: Color(0xFF016FB9),
                                  ),
                                  onPressed: _pickImage,
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
                  if (_gambarError != null)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        _gambarError!,
                        style: GoogleFonts.poppins(
                          color: const Color(0xFFB00020),
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Container(
                width: 136,
                height: 42,
                child: ElevatedButton(
                  onPressed: () {
                    if (_validateInputs()) {
                      // Tampilkan dialog sukses
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
                                    'Sukses ditambah!',
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Tips mitigasi bencana telah berhasil\nditambah!',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: const Color(0xFF666666),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // Tutup dialog
                                        Navigator.of(context).pop(); // Kembali ke halaman sebelumnya
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFFFFA726),
                                        padding: const EdgeInsets.symmetric(vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Text(
                                        'Okay',
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFA726),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Tambah',
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