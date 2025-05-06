import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'laporan_page.dart';
import 'informasi_banjir_page.dart';
import 'laporan_banjir_page.dart';
import 'package:flutter_map/flutter_map.dart' as flutterMap;
import 'package:latlong2/latlong.dart' as latlong;
import 'detail_riwayat_banjir_page.dart';
import 'riwayat_banjir_page.dart';
import 'detail_banjir_terkini_page.dart';  

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleMapController? mapController;
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const BerandaContent(),
    const LaporanPage(),
    const InformasiBanjirPage(),
    const Center(child: Text('Mitigasi Page - Coming Soon')),
    const Center(child: Text('Evakuasi Page - Coming Soon')),
  ];

  String _getTitle(int index) {
    switch (index) {
      case 0:
        return 'Beranda';
      case 1:
        return 'Laporan';
      case 2:
        return 'Informasi Banjir';
      case 3:
        return 'Mitigasi';
      case 4:
        return 'Evakuasi';
      default:
        return 'Beranda';
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _showLogoutDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.logout,
                  size: 48,
                  color: Colors.black54,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Apakah Anda yakin ingin\nkeluar dari aplikasi?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFA726),
                    minimumSize: const Size.fromHeight(45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // Close the dialog first
                    Navigator.of(context).pop();
                    // Then navigate to login page and clear the navigation stack
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/login',
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: const Text(
                    'Ya, Keluar',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(45),
                    side: const BorderSide(color: Color(0xFFFFA726)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close dialog
                  },
                  child: const Text(
                    'Tetap di Aplikasi',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFFFA726),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        title: Text(
          _getTitle(_selectedIndex),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/img/sigab_logo.png',
            fit: BoxFit.contain,
          ),
        ),
        actions: [
          if (_selectedIndex == 0)
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Color(0xFF0077B6),
              ),
              onPressed: () {
                _showLogoutDialog(context);
              },
            ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF0077B6),
        unselectedItemColor: const Color(0xFF8C8C8C),
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Laporan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Info Banjir',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning),
            label: 'Mitigasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_run),
            label: 'Evakuasi',
          ),
        ],
      ),
    );
  }
}

class BerandaContent extends StatefulWidget {
  const BerandaContent({Key? key}) : super(key: key);

  @override
  State<BerandaContent> createState() => _BerandaContentState();
}

class _BerandaContentState extends State<BerandaContent> {
  GoogleMapController? mapController;
  late flutterMap.MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = flutterMap.MapController();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Banjir Terkini',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      backgroundColor: Colors.white,
                      body: SafeArea(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.arrow_back),
                                    color: const Color(0xFF016FB9),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  const Expanded(
                                    child: Text(
                                      'Lokasi Banjir Terkini',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 48), // Untuk menyeimbangkan dengan lebar IconButton
                                ],
                              ),
                            ),
                            Expanded(
                              child: Stack(
                                children: [
                                  flutterMap.FlutterMap(
                                    mapController: _mapController,
                                    options: flutterMap.MapOptions(
                                      center: latlong.LatLng(-6.9175, 107.6191),
                                      zoom: 15.0,
                                      interactiveFlags: flutterMap.InteractiveFlag.all,
                                    ),
                                    children: [
                                      flutterMap.TileLayer(
                                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                        userAgentPackageName: 'com.example.sigab',
                                      ),
                                      flutterMap.MarkerLayer(
                                        markers: [
                                          // Marker untuk banjir terkini (merah)
                                          flutterMap.Marker(
                                            point: latlong.LatLng(-6.9175, 107.6191),
                                            width: 80,
                                            height: 80,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => DetailBanjirTerkiniPage(  // Ubah ini
                                                      koordinat: 'Citeureup (-6.9175 LS, 107.6191 BT)',
                                                      tanggal: '20 Januari 2024, 08:30 WIB',
                                                      tingkatKedalaman: 'Tinggi',
                                                      jarak: '10 Km dari lokasi anda',
                                                      wilayah: 'Jl. Radio Palasari, Sebagian hulu sungai Cigede',
                                                      warna: const Color(0xFFE60000),
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Container(
                                                    width: 80,
                                                    height: 80,
                                                    decoration: const BoxDecoration(
                                                      color: Color(0x4DE60000),
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 40,
                                                    height: 40,
                                                    decoration: const BoxDecoration(
                                                      color: Color(0xFFE60000),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: const Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Icon(
                                                          Icons.home,
                                                          color: Colors.white,
                                                          size: 20,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          // Marker untuk banjir kedua (sedang)
                                          flutterMap.Marker(
                                            point: latlong.LatLng(-6.9200, 107.6150),
                                            width: 80,
                                            height: 80,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => DetailBanjirTerkiniPage(
                                                      koordinat: 'Citeureup (-6.9200 LS, 107.6150 BT)',
                                                      tanggal: '15 Januari 2024, 14:20 WIB',
                                                      tingkatKedalaman: 'Sedang',
                                                      jarak: '8 Km dari lokasi anda',
                                                      wilayah: 'Jl. Radio Palasari, Sebagian hulu sungai Cigede',
                                                      warna: const Color(0xFFF6AE2D),
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Container(
                                                    width: 80,
                                                    height: 80,
                                                    decoration: const BoxDecoration(
                                                      color: Color(0x4DF6AE2D),
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 40,
                                                    height: 40,
                                                    decoration: const BoxDecoration(
                                                      color: Color(0xFFF6AE2D),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: const Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Icon(
                                                          Icons.home,
                                                          color: Colors.white,
                                                          size: 20,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          // Marker untuk banjir ketiga (rendah)
                                          flutterMap.Marker(
                                            point: latlong.LatLng(-6.9150, 107.6170),
                                            width: 80,
                                            height: 80,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => DetailBanjirTerkiniPage(
                                                      koordinat: 'Citeureup (-6.9150 LS, 107.6170 BT)',
                                                      tanggal: '10 Januari 2024, 10:15 WIB',
                                                      tingkatKedalaman: 'Rendah',
                                                      jarak: '12 Km dari lokasi anda',
                                                      wilayah: 'Jl. Sukabirus, sebagian Jl. Radio Palasari, sebagian area hulu sungai Cigede',
                                                      warna: const Color(0xFF0EDD06),
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Container(
                                                    width: 80,
                                                    height: 80,
                                                    decoration: const BoxDecoration(
                                                      color: Color(0x4D0EDD06),
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 40,
                                                    height: 40,
                                                    decoration: const BoxDecoration(
                                                      color: Color(0xFF0EDD06),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: const Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Icon(
                                                          Icons.home,
                                                          color: Colors.white,
                                                          size: 20,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          // Marker untuk lokasi pengguna
                                          flutterMap.Marker(
                                            point: latlong.LatLng(-6.9200, 107.6191), // Koordinat contoh untuk lokasi pengguna
                                            width: 40,
                                            height: 40,
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.blue,
                                              ),
                                              child: const Icon(
                                                Icons.location_on,
                                                color: Colors.white,
                                                size: 24,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                   ),
                                  Positioned(
                                    right: 16,
                                    bottom: 16,
                                    child: Column(
                                      children: [
                                        FloatingActionButton(
                                          heroTag: "zoomIn",
                                          mini: true,
                                          backgroundColor: Colors.white,
                                          child: const Icon(
                                            Icons.add,
                                            color: Color(0xFF016FB9),
                                          ),
                                          onPressed: () {
                                            final zoom = _mapController.zoom + 1;
                                            _mapController.move(
                                              _mapController.center,
                                              zoom > 18 ? 18 : zoom,
                                            );
                                          },
                                        ),
                                        const SizedBox(height: 8),
                                        FloatingActionButton(
                                          heroTag: "zoomOut",
                                          mini: true,
                                          backgroundColor: Colors.white,
                                          child: const Icon(
                                            Icons.remove,
                                            color: Color(0xFF016FB9),
                                          ),
                                          onPressed: () {
                                            final zoom = _mapController.zoom - 1;
                                            _mapController.move(
                                              _mapController.center,
                                              zoom < 4 ? 4 : zoom,
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              child: Stack(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.transparent, width: 1.5),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF016FB9), Color(0xFF003253)],
                        stops: [0.0, 1.0],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Container(
                          color: Colors.white,
                          child: flutterMap.FlutterMap(
                            options: flutterMap.MapOptions(
                              center: latlong.LatLng(-6.9175, 107.6191),
                              zoom: 12,
                              interactiveFlags: flutterMap.InteractiveFlag.none,
                            ),
                            children: [
                              flutterMap.TileLayer(
                                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                userAgentPackageName: 'com.example.sigab',
                              ),
                              flutterMap.MarkerLayer(
                                markers: [
                                  // Marker untuk lokasi banjir
                                  flutterMap.Marker(
                                    point: latlong.LatLng(-6.9175, 107.6191),
                                    width: 80,
                                    height: 80,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          width: 80,
                                          height: 80,
                                          decoration: const BoxDecoration(
                                            color: Color(0x4DE60000),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFE60000),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.home,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Marker untuk lokasi pengguna
                                  flutterMap.Marker(
                                    point: latlong.LatLng(-6.9200, 107.6191), // Koordinat contoh untuk lokasi pengguna
                                    width: 40,
                                    height: 40,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.blue,
                                      ),
                                      child: const Icon(
                                        Icons.location_on,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x1A000000),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.fullscreen,
                        color: Color(0xFF016FB9),
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Riwayat Banjir',
                  style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RiwayatBanjirPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Lihat Lainnya',
                    style: TextStyle(color: Colors.black),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
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
                        koordinat: 'Citeureup (0.07 LS, 109.37 BT)',
                        tanggal: 'Senin, 7 April 2025, 12.27 WIB',
                        tingkatKedalaman: 'Rendah',
                        jarak: '10 Km dari lokasi anda',
                        wilayah: 'Jl. Sukabirus, sebagian Jl. Radio Palasari, sebagian area hulu sungai Cigede',
                        warna: const Color(0xFF0EDD06),
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined, color: Colors.grey[600], size: 16),
                          const SizedBox(width: 4),
                          Text(
                            'Citeureup (0.07 LS, 109.37 BT)',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Banjir',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Senin, 7 April 2025, 12.27 WIB',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0EDD06),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Tingkat Kedalaman: Rendah',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(Icons.swap_horiz, color: Colors.orange[400], size: 20),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Jarak',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                              Text(
                                '10 Km dari lokasi anda',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.flag, color: Colors.orange[400], size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Wilayah Banjir',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                Text(
                                  'Jl. Sukabirus, sebagian Jl. Radio Palasari, sebagian area hulu sungai Cigede',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
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
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Laporan Banjir',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LaporanBanjirPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'Lihat lainnya',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            FloodReportCard(
              name: 'Fadhilah',
              location: 'Cileunyi',
              description: 'Terjadi banjir di daerah umayah 1 sukabirus sejak pagi jam setengan 9, kos saya kena banjir selutut.',
              imageUrl: 'https://picsum.photos/800/600',
              latitude: -6.975368,
              longitude: 107.631033,
              date: DateTime(2025, 4, 1),
              time: '8:05 WIB',
            ),
            const SizedBox(height: 2), // Mengubah height dari 8 menjadi 2
            FloodReportCard(
              name: 'Farel',
              description: 'Ada tanda-tanda banjir di beberapa wilayah, seperti hujan deras yang berlangsung lama, genangan air di jalan.',
              location: 'Bojongsoang',
              imageUrl: 'https://picsum.photos/800/600',
              latitude: -6.974567,
              longitude: 107.630521,
              date: DateTime(2025, 4, 1),
              time: '7:45 WIB',
            ),
          ],
        ),
      ),
    );
  }
}
