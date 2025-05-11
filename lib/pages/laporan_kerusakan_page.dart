import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'detail_laporan_kerusakan_page.dart';

class LaporanKerusakanCard extends StatelessWidget {
  final String whatsapp;  
  final String location;
  final String description;
  final String imageUrl;
  final double latitude;
  final double longitude;
  final DateTime date;
  final String time;

  const LaporanKerusakanCard({
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
      width: 365,
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
                builder: (context) => DetailLaporanKerusakanPage(
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
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                        fontSize: 14,
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

class LaporanKerusakanPage extends StatelessWidget {
  const LaporanKerusakanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        title: const Text(
          'Laporan Kerusakan Infrastruktur',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF016FB9),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          LaporanKerusakanCard(
            whatsapp: '081234567890',  
            location: 'Jl. Hj. Umayah 1 sukabirus, Citeureup, Dayeuhkolot, Bandung Regency, West Java 40257',
            description: 'Jembatan penghubung antar desa mengalami kerusakan akibat banjir, perlu perbaikan segera untuk akses warga.',
            imageUrl: 'https://picsum.photos/800/600',
            date: DateTime(2025, 4, 1),
            time: '8:30 WIB',
            latitude: -6.975368,
            longitude: 107.631033,
          ),
          LaporanKerusakanCard(
            whatsapp: '081234567891',  
            location: 'Jl. Hj. Umayah 1 sukabirus, Citeureup, Dayeuhkolot, Bandung Regency, West Java 40257',
            description: 'Retakan besar di jalan utama desa setelah banjir surut, membahayakan pengendara yang melintas.',
            imageUrl: 'https://picsum.photos/800/600',
            date: DateTime(2025, 4, 1),
            time: '8:30 WIB',
            latitude: -6.974567,
            longitude: 107.632145,
          ),
          LaporanKerusakanCard(
            whatsapp: '081234567892',  
            location: 'Jl. Hj. Umayah 1 sukabirus, Citeureup, Dayeuhkolot, Bandung Regency, West Java 40257',
            description: 'Saluran drainase rusak parah di beberapa titik, perlu perbaikan untuk mencegah banjir susulan.',
            imageUrl: 'https://picsum.photos/800/600',
            date: DateTime(2025, 4, 1),
            time: '8:30 WIB',
            latitude: -6.976234,
            longitude: 107.630789,
          ),
          LaporanKerusakanCard(
            whatsapp: '081234567893',  
            location: 'Jl. Hj. Umayah 1 sukabirus, Citeureup, Dayeuhkolot, Bandung Regency, West Java 40257',
            description: 'Tanggul sungai jebol di beberapa lokasi, perlu penanganan cepat untuk mencegah banjir susulan.',
            imageUrl: 'https://picsum.photos/800/600',
            date: DateTime(2025, 4, 1),
            time: '8:30 WIB',
            latitude: -6.973890,
            longitude: 107.633456,
          ),
        ],
      ),
    );
  }
}