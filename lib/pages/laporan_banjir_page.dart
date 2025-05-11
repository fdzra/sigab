import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'detail_laporan_banjir_page.dart';
import 'histori_verifikasi_page.dart';

class LaporanBanjir {
  final String id;
  final String whatsapp;  
  final String description;
  final DateTime date;
  final String time;
  final double latitude;
  final double longitude;

  LaporanBanjir({
    required this.id,
    required this.whatsapp,  
    required this.description,
    required this.date,
    required this.time,
    required this.latitude,
    required this.longitude,
  });
}

class LaporanBanjirPage extends StatefulWidget {
  const LaporanBanjirPage({Key? key}) : super(key: key);

  @override
  State<LaporanBanjirPage> createState() => _LaporanBanjirPageState();
}

class _LaporanBanjirPageState extends State<LaporanBanjirPage> {
  // Dummy data untuk development
  // Pada bagian list data:
  final List<LaporanBanjir> _laporanList = [
    LaporanBanjir(
      id: '1',
      whatsapp: '081234567890',  
      description: 'Terjadi banjir di daerah umayah 1 sukabirus sejak pagi jam setengan 9, kos saya kena banjir selutut.',
      date: DateTime(2025, 4, 1),
      time: '8:05 WIB',
      latitude: -6.975368,
      longitude: 107.631033,
    ),
    LaporanBanjir(
      id: '2', 
      whatsapp: '081234567891',  
      description: 'Ada tanda-tanda banjir di beberapa wilayah, seperti hujan deras yang berlangsung lama, genangan air di jalan.',
      date: DateTime(2025, 4, 1),
      time: '7:45 WIB',
      latitude: -6.974567,
      longitude: 107.632145,
    ),
    LaporanBanjir(
      id: '3',
      whatsapp: '081234567892',  
      description: 'Tadi pagi di sekitar rumah, terlihat genangan air akibat hujan lebat semalam. Beberapa saluran drainase tampak tersumbat, menyebabkan air meluap ke jalanan.',
      date: DateTime(2025, 4, 1),
      time: '7:38 WIB',
      latitude: -6.976234,
      longitude: 107.630789,
    ),
    LaporanBanjir(
      id: '4',
      whatsapp: '081234567893',  
      description: 'Banjir cukup besar dengan ketinggian air mencapai 1 meter di beberapa titik. Jalan utama terendam, menghambat akses transportasi.',
      date: DateTime(2025, 4, 1),
      time: '7:20 WIB',
      latitude: -6.973890,
      longitude: 107.633456,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF016FB9)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Laporan Banjir',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HistoriVerifikasiPage(),
                  ),
                );
              },
              child: const Text(
                'Lihat Histori Verifikasi',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF016FB9),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _laporanList.length,
              itemBuilder: (context, index) {
                final laporan = _laporanList[index];
                return FloodReportCard(
                  whatsapp: laporan.whatsapp,
                  location: 'Jl. Hj. Umayah 1 sukabirus, Citeureup, Dayeuhkolot, Bandung Regency, West Java 40257',
                  description: laporan.description,
                  imageUrl: 'https://picsum.photos/800/600',
                  latitude: laporan.latitude,
                  longitude: laporan.longitude,
                  date: laporan.date,
                  time: laporan.time,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FloodReportCard extends StatelessWidget {
  final String whatsapp;  
  final String location;
  final String description;
  final String imageUrl;
  final double latitude;
  final double longitude;
  final DateTime date;
  final String time;

  const FloodReportCard({
    Key? key,
    required this.whatsapp,  
    required this.location,
    required this.description,
    required this.imageUrl,
    required this.latitude,
    required this.longitude,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String shortDescription = description.length > 40 
        ? '${description.substring(0, 40)}...' 
        : description;

    return Container(
      width: double.infinity, 
      height: 112,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF016FB9),
            Color(0xFF015A96),
            Color(0xFF003253),
          ],
          stops: [0.0, 0.48, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailLaporanBanjirPage(
                  whatsapp: whatsapp,
                  location: location,
                  description: description,
                  imageUrl: imageUrl,
                  latitude: latitude,
                  longitude: longitude,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        whatsapp,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        shortDescription,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      DateFormat('dd/MM/yyyy').format(date),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14
                        ,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      time,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}