import 'package:flutter/material.dart';

class LaporanPage extends StatelessWidget {
  const LaporanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8F8F8),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              children: const [
                // Card Banjir
                Expanded(
                  child: LaporanCard(
                    title: 'Banjir',
                    imagePath: 'assets/img/house.png',
                  ),
                ),
                SizedBox(width: 16),
                // Card Kerusakan Infrastruktur
                Expanded(
                  child: LaporanCard(
                    title: 'Kerusakan\nInfrastruktur',
                    imagePath: 'assets/img/infra.png',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LaporanCard extends StatefulWidget {
  final String title;
  final IconData? icon;
  final String? imagePath;

  const LaporanCard({
    Key? key,
    required this.title,
    this.icon,
    this.imagePath,
  }) : super(key: key);

  @override
  State<LaporanCard> createState() => _LaporanCardState();
}

class _LaporanCardState extends State<LaporanCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: InkWell(
        onTap: () {
          // Navigasi ke halaman yang sesuai berdasarkan judul
          if (widget.title == 'Banjir') {
            Navigator.pushNamed(context, '/laporan-banjir');
          } else if (widget.title.contains('Infrastruktur')) {
            Navigator.pushNamed(context, '/laporan-kerusakan');
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 160,
          decoration: BoxDecoration(
            color: isHovered ? const Color(0xFF0077B6) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: !isHovered
                ? Border.all(
                    color: const Color(0xFF0077B6),
                    width: 2,
                  )
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isHovered
                      ? Colors.white.withOpacity(0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: widget.imagePath != null
                    ? Image.asset(
                        widget.imagePath!,
                        width: 40,
                        height: 40,
                        color: isHovered ? Colors.white : const Color(0xFF0077B6),
                      )
                    : Icon(
                        widget.icon,
                        color: isHovered ? Colors.white : const Color(0xFF0077B6),
                        size: 40,
                      ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isHovered ? Colors.white : const Color(0xFF0077B6),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}