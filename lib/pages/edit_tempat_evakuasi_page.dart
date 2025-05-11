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

  @override
  void initState() {
    super.initState();
    _namaTempatController = TextEditingController(text: widget.namaTempatAwal);
    _linkMapsController = TextEditingController(text: "https://maps.app.goo.gl/beSCEvR4rQhvM3");
    _selectedImage = "https://images.unsplash.com/photo-1584438784894-089d6a62b8fa?q=80"; // Gunakan URL gambar yang valid
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image.path;
      });
      // Tambahkan pengecekan format file
      if (!_selectedImage!.toLowerCase().endsWith('.jpg') && 
          !_selectedImage!.toLowerCase().endsWith('.jpeg') && 
          !_selectedImage!.toLowerCase().endsWith('.png')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Format file tidak didukung. Gunakan format JPG atau PNG.'),
          ),
        );
        setState(() {
          _selectedImage = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF016FB9)),
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
            Text(
              'Nama Tempat',
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
                  borderSide: const BorderSide(color: Color(0xFF016FB9)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: Color(0xFF016FB9)),
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
                border: Border.all(color: Color(0xFF016FB9), width: 1.5),
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
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.error_outline, color: Colors.red),
                                    SizedBox(height: 8),
                                    Text(
                                      'Gagal memuat gambar',
                                      style: GoogleFonts.poppins(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
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
                  borderSide: const BorderSide(color: Color(0xFF016FB9)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: Color(0xFF016FB9)),
                ),
                contentPadding: const EdgeInsets.all(16),
              ),
              onChanged: (value) {
                setState(() {
                  _linkMapsController.text = value;
                });
              },
            ),
            const SizedBox(height: 32),
            Center(
              child: SizedBox(
                width: 136,
                height: 42,
                child: ElevatedButton(
                  onPressed: () {
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