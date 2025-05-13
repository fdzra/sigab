import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as flutterMap;
import 'package:latlong2/latlong.dart' as latlong;
import 'package:google_fonts/google_fonts.dart';

class DetailRiwayatBanjirPage extends StatefulWidget {
  final String koordinat;
  final String tanggal;
  final String tingkatKedalaman;
  final String wilayah;
  final Color warna;

  const DetailRiwayatBanjirPage({
    Key? key,
    required this.koordinat,
    required this.tanggal,
    required this.tingkatKedalaman,
    required this.wilayah,
    required this.warna,
  }) : super(key: key);

  @override
  State<DetailRiwayatBanjirPage> createState() => _DetailRiwayatBanjirPageState();
}

class _DetailRiwayatBanjirPageState extends State<DetailRiwayatBanjirPage> {
  late flutterMap.MapController _mapController;
  late flutterMap.MapController _fullScreenMapController;
  late latlong.LatLng _center;

  @override
  void initState() {
    super.initState();
    _mapController = flutterMap.MapController();
    _fullScreenMapController = flutterMap.MapController();
    
    // Perbaikan pengecekan koordinat
    try {
      if (widget.koordinat.isNotEmpty) {
        final parts = widget.koordinat.split(',');
        if (parts.length == 2) {
          final lat = double.tryParse(parts[0].trim());
          final lng = double.tryParse(parts[1].trim());
          if (lat != null && lng != null) {
            _center = latlong.LatLng(lat, lng);
          } else {
            _center = latlong.LatLng(-6.9175, 107.6191); // koordinat default
          }
        } else {
          _center = latlong.LatLng(-6.9175, 107.6191); // koordinat default
        }
      } else {
        _center = latlong.LatLng(-6.9175, 107.6191); // koordinat default
      }
    } catch (e) {
      _center = latlong.LatLng(-6.9175, 107.6191); // koordinat default jika terjadi error
    }
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
          'Detail Riwayat Banjir',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFF016FB9), width: 1.5),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  children: [
                    flutterMap.FlutterMap(
                      mapController: _mapController,
                      options: flutterMap.MapOptions(
                        center: _center,
                        zoom: 15.0,
                      ),
                      children: [
                        flutterMap.TileLayer(
                          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.sigab',
                        ),
                        flutterMap.MarkerLayer(
                          markers: [
                            flutterMap.Marker(
                              point: _center,
                              width: 80,
                              height: 80,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: widget.warna.withOpacity(0.3),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: widget.warna,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.flood,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Scaffold(
                                appBar: AppBar(
                                  leading: IconButton(
                                    icon: const Icon(Icons.close, color: Color(0xFF016FB9)),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  title: Text(
                                    widget.koordinat,
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  backgroundColor: Colors.white,
                                  elevation: 0,
                                ),
                                body: Stack(
                                  children: [
                                    flutterMap.FlutterMap(
                                      mapController: _fullScreenMapController,
                                      options: flutterMap.MapOptions(
                                        center: _center,  // Gunakan _center yang sudah diinisialisasi
                                        zoom: 15.0,
                                      ),
                                      children: [
                                        flutterMap.TileLayer(
                                          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                          userAgentPackageName: 'com.example.sigab',
                                        ),
                                        flutterMap.MarkerLayer(
                                          markers: [
                                            flutterMap.Marker(
                                              point: _center,  // Gunakan _center yang sudah diinisialisasi
                                              width: 80,
                                              height: 80,
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Container(
                                                    width: 80,
                                                    height: 80,
                                                    decoration: BoxDecoration(
                                                      color: widget.warna.withOpacity(0.3),
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 40,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color: widget.warna,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: const Icon(
                                                      Icons.flood,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ],
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
                                            heroTag: "zoomInFull",
                                            onPressed: () {
                                              final currentZoom = _fullScreenMapController.zoom;
                                              _fullScreenMapController.move(
                                                _fullScreenMapController.center,
                                                currentZoom + 1,
                                              );
                                            },
                                            mini: true,
                                            backgroundColor: Colors.white,
                                            child: const Icon(Icons.add, color: Color(0xFF016FB9)),
                                          ),
                                          const SizedBox(height: 8),
                                          FloatingActionButton(
                                            heroTag: "zoomOutFull",
                                            onPressed: () {
                                              final currentZoom = _fullScreenMapController.zoom;
                                              _fullScreenMapController.move(
                                                _fullScreenMapController.center,
                                                currentZoom - 1,
                                              );
                                            },
                                            mini: true,
                                            backgroundColor: Colors.white,
                                            child: const Icon(Icons.remove, color: Color(0xFF016FB9)),
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
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.fullscreen,
                            color: Color(0xFF016FB9),
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
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
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.grey, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          widget.koordinat,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Banjir',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.tanggal,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: widget.warna,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Tingkat Kedalaman: ${widget.tingkatKedalaman}',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.flag,
                          color: Colors.orange[700],
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(  // Tambahkan Expanded di sini
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Wilayah Banjir',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.wilayah,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                softWrap: true,  // Tambahkan ini untuk memastikan text bisa wrap
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
          ],
        ),
      ),
    );
  }
}
