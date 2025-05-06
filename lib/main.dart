import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/login_page.dart';
import 'pages/laporan_page.dart';
import 'pages/laporan_banjir_page.dart';
import 'pages/informasi_banjir_page.dart';
import 'pages/laporan_kerusakan_page.dart';
import 'pages/detail_laporan_kerusakan_page.dart';
import 'pages/detail_laporan_banjir_page.dart';
import 'pages/beranda_page.dart';  // Pastikan file ini mengexport HomePage
import 'pages/detail_riwayat_banjir_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIGAB',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFBB03B)),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialRoute: '/login',
      onGenerateRoute: (settings) {
        if (settings.name == '/detail-laporan-banjir') {
          return DetailLaporanBanjirPage.route(settings);
        }
        if (settings.name == '/detail-riwayat-banjir') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => DetailRiwayatBanjirPage(
              koordinat: args['koordinat'] as String,
              tanggal: args['tanggal'] as String,
              tingkatKedalaman: args['tingkatKedalaman'] as String,
              jarak: args['jarak'] as String,
              wilayah: args['wilayah'] as String,
              warna: args['warna'] as Color,
            ),
          );
        }
        return MaterialPageRoute(
          builder: (context) {
            switch (settings.name) {
              case '/':
                return const LoginPage();
              case '/home':
                return const HomePage();
              case '/laporan':
                return const LaporanPage();
              case '/laporan-banjir':
                return const LaporanBanjirPage();
              case '/laporan-kerusakan':
                return const LaporanKerusakanPage();
              case '/login':
                return const LoginPage();
              case '/info-banjir':
                return const InformasiBanjirPage();
              default:
                return const LoginPage();
            }
          },
        );
      },
    );
  }
}
