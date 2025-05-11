import 'package:flutter/material.dart';

class HistoriVerifikasiPage extends StatefulWidget {
  final bool initialShowAccepted;
  
  const HistoriVerifikasiPage({
    Key? key,
    this.initialShowAccepted = true,
  }) : super(key: key);

  @override
  State<HistoriVerifikasiPage> createState() => _HistoriVerifikasiPageState();
}

class _HistoriVerifikasiPageState extends State<HistoriVerifikasiPage> {
  late bool _showAccepted;

  @override
  void initState() {
    super.initState();
    _showAccepted = widget.initialShowAccepted;
  }

  // Dummy data untuk laporan yang diterima
  final List<VerificationItem> _acceptedReports = [
    VerificationItem(
      whatsapp: '08123456789',
      description: 'Terjadi banjir di daerah umayah 1 sukabirus sejak pagi jam setengan 9, kos saya kena banjir selutut.',
      date: '01/04/2025',
      time: '8:05 WIB',
      isValid: true,
    ),
    VerificationItem(
      whatsapp: '08234567890',
      description: 'Ada tanda-tanda banjir di beberapa wilayah, seperti hujan deras yang berlangsung lama, genangan air di jalan.',
      date: '01/04/2025',
      time: '7:45 WIB',
      isValid: true,
    ),
    VerificationItem(
      whatsapp: '08345678901',
      description: 'Tadi pagi di sekitar rumah, terlihat genangan air akibat hujan lebat semalam. Beberapa saluran drainase tampak tersumbat, menyebabkan air meluap ke jalanan.',
      date: '01/04/2025',
      time: '7:38 WIB',
      isValid: true,
    ),
    VerificationItem(
      whatsapp: '08456789012',
      description: 'Banjir cukup besar dengan ketinggian air mencapai 1 meter di beberapa titik. Jalan utama terendam, menghambat akses transportasi.',
      date: '01/04/2025',
      time: '7:20 WIB',
      isValid: true,
    ),
  ];

  // Dummy data untuk laporan yang ditolak
  final List<VerificationItem> _rejectedReports = [
    VerificationItem(
      whatsapp: '08567890123',
      description: 'Ada banjir tapi boong papale pale pale paleee',
      date: '26/03/2025',
      time: '7:00 WIB',
      isValid: false,
    ),
    VerificationItem(
      whatsapp: '08678901234',
      description: 'Banjir banjirrr banjir Banjir banjir banjirrr',
      date: '19/03/2025',
      time: '6:12 WIB',
      isValid: false,
    ),
    VerificationItem(
      whatsapp: '08789012345',
      description: 'tes tes tes tess Afaan tuch?????...',
      date: '18/03/2025',
      time: '01:30 WIB',
      isValid: false,
    ),
    VerificationItem(
      whatsapp: '08890123456',
      description: 'Test Test tEST',
      date: '05/03/2025',
      time: '4:15 WIB',
      isValid: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF016FB9)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Histori Verifikasi',
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
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFF016FB9),
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _showAccepted = true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _showAccepted ? const Color(0xFF016FB9) : Colors.white,
                        borderRadius: BorderRadius.horizontal(left: Radius.circular(8.5)),
                      ),
                      child: Text(
                        'Diterima',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _showAccepted ? Colors.white : const Color(0xFF016FB9),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _showAccepted = false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: !_showAccepted ? const Color(0xFF016FB9) : Colors.white,
                        borderRadius: BorderRadius.horizontal(right: Radius.circular(8.5)),
                      ),
                      child: Text(
                        'Ditolak',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: !_showAccepted ? Colors.white : const Color(0xFF016FB9),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _showAccepted ? _acceptedReports.length : _rejectedReports.length,
              itemBuilder: (context, index) {
                final report = _showAccepted ? _acceptedReports[index] : _rejectedReports[index];
                return VerificationCard(report: report);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class VerificationItem {
  final String whatsapp;
  final String description;
  final String date;
  final String time;
  final bool isValid;

  VerificationItem({
    required this.whatsapp,
    required this.description,
    required this.date,
    required this.time,
    required this.isValid,
  });
}

class VerificationCard extends StatelessWidget {
  final VerificationItem report;

  const VerificationCard({
    Key? key,
    required this.report,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF016FB9),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: report.isValid ? const Color(0xFF0EDD06) : const Color(0xFFE92A2A),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        report.isValid ? 'Valid' : 'Tidak Valid',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      report.whatsapp,
                      style: const TextStyle(
                        color: Color(0xFF016FB9),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      report.description.length > 40 
                          ? '${report.description.substring(0, 40)}...'
                          : report.description,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      report.date,
                      style: const TextStyle(
                        color: Color(0xFF016FB9),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      report.time,
                      style: const TextStyle(
                        color: Color(0xFF016FB9),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
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