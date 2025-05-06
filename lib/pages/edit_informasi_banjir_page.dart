import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'map_banjir_page.dart';

class EditInformasiBanjirPage extends StatefulWidget {
  const EditInformasiBanjirPage({Key? key}) : super(key: key);

  @override
  State<EditInformasiBanjirPage> createState() => _EditInformasiBanjirPageState();
}

class _EditInformasiBanjirPageState extends State<EditInformasiBanjirPage> {
  final TextEditingController _wilayahController = TextEditingController();
  final TextEditingController _kedalaman1Controller = TextEditingController();
  final TextEditingController _kedalaman2Controller = TextEditingController();
  final TextEditingController _waktuController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  double? latitude;
  double? longitude;

  @override
  void initState() {
    super.initState();
    // Initialize with example data
    _wilayahController.text = 'Jl. H. Umayah 1 No.20';
    _kedalaman1Controller.text = '125';
    _kedalaman2Controller.text = 'Tinggi';
    _waktuController.text = '01/04/2025, 8:30 WIB';
    latitude = -6.975368;
    longitude = 107.631033;

    // Parse the initial date and time from _waktuController
    try {
      // Parse date in format "dd/MM/yyyy, HH:mm WIB"
      List<String> parts = _waktuController.text.split(', ');
      List<String> dateParts = parts[0].split('/');
      List<String> timeParts = parts[1].split(' ')[0].split(':');
      
      selectedDate = DateTime(
        int.parse(dateParts[2]),
        int.parse(dateParts[1]),
        int.parse(dateParts[0])
      );
      
      selectedTime = TimeOfDay(
        hour: int.parse(timeParts[0]),
        minute: int.parse(timeParts[1])
      );
    } catch (e) {
      // If parsing fails, use current date and time
      selectedDate = DateTime.now();
      selectedTime = TimeOfDay.now();
    }

    // Add listener to kedalaman1Controller
    _kedalaman1Controller.addListener(_updateTingkatKedalaman);
  }

  @override
  void dispose() {
    // Remove listener before disposing
    _kedalaman1Controller.removeListener(_updateTingkatKedalaman);
    _wilayahController.dispose();
    _kedalaman1Controller.dispose();
    _kedalaman2Controller.dispose();
    _waktuController.dispose();
    super.dispose();
  }

  void _updateTingkatKedalaman() {
    if (_kedalaman1Controller.text.isEmpty) {
      setState(() {
        _kedalaman2Controller.text = '';
      });
      return;
    }

    int depth = int.parse(_kedalaman1Controller.text);
    String newDepth;

    if (depth <= 50) {
      newDepth = 'Rendah';
    } else if (depth <= 100) {
      newDepth = 'Sedang';
    } else {
      newDepth = 'Tinggi';
    }

    setState(() {
      _kedalaman2Controller.text = newDepth;
    });
  }

  void _updateDateTime() {
    setState(() {
      _waktuController.text = '${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}, ${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')} WIB';
    });
  }

  void _showSuccessDialog(BuildContext context) {
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
                  'Informasi banjir telah berhasil\ndiubah!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: const Color(0xFF666666),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close dialog
                      Navigator.of(context).pop(); // Return to previous screen
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        title: Text(
          'Edit Informasi Banjir',
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF016FB9)),
          onPressed: () => Navigator.pop(context),
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
              'Wilayah Banjir',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              child: TextField(
                controller: _wilayahController,
                style: GoogleFonts.poppins(),
                decoration: InputDecoration(
                  hintText: 'Masukkan wilayah banjir',
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
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Tingkat Kedalaman (cm)',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              child: TextField(
                controller: _kedalaman1Controller,
                style: GoogleFonts.poppins(),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  hintText: 'Masukkan tingkat kedalaman',
                  hintStyle: GoogleFonts.poppins(color: const Color(0xFFA0A0A0)),
                  filled: true,
                  fillColor: Colors.white,
                  suffixText: 'cm',
                  suffixStyle: GoogleFonts.poppins(color: const Color(0xFF016FB9)),
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
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Tingkat Kedalaman',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              child: TextField(
                controller: _kedalaman2Controller,
                style: GoogleFonts.poppins(color: Colors.black),
                enabled: false,
                decoration: InputDecoration(
                  hintText: 'Tingkat kedalaman akan terisi otomatis',
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
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Color(0xFF016FB9), width: 1.5),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Waktu Kejadian',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              child: InkWell(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: Color(0xFF016FB9),
                            onPrimary: Colors.white,
                            surface: Colors.white,
                            onSurface: Colors.black,
                          ),
                          dialogBackgroundColor: Colors.white,
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (picked != null) {
                    final TimeOfDay? timePicked = await showTimePicker(
                      context: context,
                      initialTime: selectedTime,
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            timePickerTheme: TimePickerThemeData(
                              backgroundColor: Colors.white,
                              hourMinuteShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: const BorderSide(color: Color(0xFF016FB9)),
                              ),
                              dayPeriodBorderSide: const BorderSide(color: Color(0xFF016FB9)),
                              dayPeriodColor: Colors.transparent,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                side: BorderSide(color: Color(0xFF016FB9)),
                              ),
                            ),
                            colorScheme: const ColorScheme.light(
                              primary: Color(0xFF016FB9),
                              onPrimary: Colors.white,
                              surface: Colors.white,
                              onSurface: Colors.black,
                            ),
                            dialogBackgroundColor: Colors.white,
                          ),
                          child: MediaQuery(
                            data: MediaQuery.of(context).copyWith(
                              alwaysUse24HourFormat: true,
                            ),
                            child: child!,
                          ),
                        );
                      },
                    );
                    if (timePicked != null) {
                      setState(() {
                        selectedDate = picked;
                        selectedTime = timePicked;
                        _updateDateTime();
                      });
                    }
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFF016FB9), width: 1.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _waktuController.text,
                        style: GoogleFonts.poppins(fontSize: 16),
                      ),
                      const Icon(Icons.calendar_today, color: Color(0xFF016FB9)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Koordinat Lokasi',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFF016FB9), width: 1.5),
                borderRadius: BorderRadius.circular(4),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapBanjirPage(
                        name: 'Lokasi Banjir',
                        location: '',
                        latitude: latitude ?? -6.975368,
                        longitude: longitude ?? 107.631033,
                        buttonText: 'Okay',
                        onLocationSelected: (lat, lng) {
                          setState(() {
                            latitude = lat;
                            longitude = lng;
                          });
                        },
                      ),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    FlutterMap(
                      options: MapOptions(
                        center: LatLng(
                          latitude ?? -6.975368,
                          longitude ?? 107.631033,
                        ),
                        zoom: 13.0,
                        onTap: (_, __) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MapBanjirPage(
                                name: 'Lokasi Banjir',
                                location: '',
                                latitude: latitude ?? -6.975368,
                                longitude: longitude ?? 107.631033,
                                buttonText: 'Okay',
                                onLocationSelected: (lat, lng) {
                                  setState(() {
                                    latitude = lat;
                                    longitude = lng;
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      children: [
                        TileLayer(
                          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.sigab',
                        ),
                        if (latitude != null && longitude != null)
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: LatLng(latitude!, longitude!),
                                child: const Icon(
                                  Icons.location_on,
                                  color: Color(0xFF016FB9),
                                  size: 40,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                    if (latitude == null)
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.location_on, color: Color(0xFF016FB9), size: 48),
                            const SizedBox(height: 8),
                            Text(
                              'Pilih Lokasi',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF016FB9),
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: SizedBox(
                width: 136,
                height: 35,
                child: ElevatedButton(
                  onPressed: () {
                    // Show success dialog
                    _showSuccessDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFA726),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Ubah',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 2,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF0077B6),
        unselectedItemColor: const Color(0xFF8C8C8C),
        selectedLabelStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
        ),
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/laporan');
          }
        },
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