import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';

class EditTempatEvakuasiPage extends StatefulWidget {
  final String namaTempatAwal;
  final String gambarAwal;
  final String linkMapsAwal;

  const EditTempatEvakuasiPage({
    Key? key,
    required this.namaTempatAwal,
    required this.gambarAwal,
    required this.linkMapsAwal,
  }) : super(key: key);

  @override
  State<EditTempatEvakuasiPage> createState() => _EditTempatEvakuasiPageState();
}

class _EditTempatEvakuasiPageState extends State<EditTempatEvakuasiPage> {
  late TextEditingController _namaTempatController;
  late TextEditingController _linkMapsController;
  String? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  // Tambahkan variabel untuk error text
  String? _namaTempatError;
  String? _linkMapsError;
  String? _gambarError;

  @override
  void initState() {
    super.initState();
    _namaTempatController = TextEditingController(text: widget.namaTempatAwal);
    _linkMapsController = TextEditingController(text: "https://maps.app.goo.gl/beSCEvR4rQhvM3");
    _selectedImage = "https://images.unsplash.com/photo-1584438784894-089d6a62b8fa?q=80"; // Gunakan URL gambar yang valid
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70, // Menambahkan kompresi gambar
      );
      if (image != null) {
        String lowercasePath = image.path.toLowerCase();
        if (lowercasePath.endsWith('.jpg') || 
            lowercasePath.endsWith('.jpeg') || 
            lowercasePath.endsWith('.png')) {
          setState(() {
            _selectedImage = image.path;
            _gambarError = null;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Format file tidak didukung. Gunakan format JPG, JPEG atau PNG!'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal memilih gambar. Silakan coba lagi.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // Tambahkan fungsi validasi
  bool _validateInputs() {
    bool isValid = true;
    setState(() {
      _namaTempatError = null;
      _linkMapsError = null;
      _gambarError = null;

      if (_namaTempatController.text.isEmpty) {
        _namaTempatError = 'Nama tempat tidak boleh kosong';
        isValid = false;
      }

      if (_linkMapsController.text.isEmpty) {
        _linkMapsError = 'Link Google Maps tidak boleh kosong';
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
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF016FB9)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Edit Tempat Evakuasi',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama Tempat',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _namaTempatController,
              decoration: InputDecoration(
                hintText: 'Masukkan nama tempat',
                hintStyle: GoogleFonts.poppins(color: const Color(0xFFA0A0A0)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    color: _namaTempatError != null ? Colors.red : const Color(0xFF016FB9),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    color: _namaTempatError != null ? Colors.red : const Color(0xFF016FB9),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    color: _namaTempatError != null ? Colors.red : const Color(0xFF016FB9),
                  ),
                ),
              ),
            ),
            if (_namaTempatError != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                child: Text(
                  _namaTempatError!,
                  style: GoogleFonts.poppins(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
            const SizedBox(height: 24),
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
                          child: _selectedImage!.startsWith('http')
                              ? Image.network(
                                  _selectedImage!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                )
                              : Image.network(
                                  _selectedImage!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                        ),
                        Positioned(
                          right: 8,
                          top: 8,
                          child: IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white, // Mengubah warna icon menjadi putih
                            ),
                            onPressed: () {
                              // TODO: Implementasi edit gambar
                              _pickImage();
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
                              _pickImage();
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
            if (_gambarError != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                child: Text(
                  _gambarError!,
                  style: GoogleFonts.poppins(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
            const SizedBox(height: 24),
            Text(
              'Link Google Maps',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _linkMapsController,
              decoration: InputDecoration(
                hintText: 'Masukkan link google maps',
                hintStyle: GoogleFonts.poppins(color: const Color(0xFFA0A0A0)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    color: _linkMapsError != null ? Colors.red : const Color(0xFF016FB9),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    color: _linkMapsError != null ? Colors.red : const Color(0xFF016FB9),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    color: _linkMapsError != null ? Colors.red : const Color(0xFF016FB9),
                  ),
                ),
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
            if (_linkMapsError != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                child: Text(
                  _linkMapsError!,
                  style: GoogleFonts.poppins(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              ),
            const SizedBox(height: 32),
            Center(
              child: SizedBox(
                width: 136,
                height: 42,
                child: ElevatedButton(
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
                                    'Tempat evakuasi telah berhasil\ndiubah!',
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
                                          borderRadius: BorderRadius.circular(4),
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
                    };
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFA726),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
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

  @override
  void dispose() {
    _namaTempatController.dispose();
    _linkMapsController.dispose();
    super.dispose();
  }
}