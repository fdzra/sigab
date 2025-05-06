import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'map_banjir_page.dart';

class TambahInformasiBanjirPage extends StatefulWidget {
  const TambahInformasiBanjirPage({Key? key}) : super(key: key);

  @override
  State<TambahInformasiBanjirPage> createState() => _TambahInformasiBanjirPageState();
}

class _TambahInformasiBanjirPageState extends State<TambahInformasiBanjirPage> {
  String? selectedDepth;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  final TextEditingController depthController = TextEditingController();
  double? latitude;
  double? longitude;

  final List<String> depthLevels = ['Rendah', 'Sedang', 'Tinggi'];

  @override
  void initState() {
    super.initState();
    // Add listener to depth controller
    depthController.addListener(_updateDepthLevel);
  }

  @override
  void dispose() {
    depthController.removeListener(_updateDepthLevel);
    depthController.dispose();
    super.dispose();
  }

  void _updateDepthLevel() {
    if (depthController.text.isEmpty) {
      setState(() {
        selectedDepth = null;
      });
      return;
    }

    int depth = int.parse(depthController.text);
    String newDepth;

    if (depth <= 50) {
      newDepth = 'Rendah';
    } else if (depth <= 100) {
      newDepth = 'Sedang';
    } else {
      newDepth = 'Tinggi';
    }

    setState(() {
      selectedDepth = newDepth;
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
                  'Sukses ditambah!',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Informasi banjir telah berhasil\nditambah!',
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
          'Tambah Informasi Banjir',
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
            TextField(
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
            const SizedBox(height: 16),
            Text(
              'Tingkat Kedalaman (cm)',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: depthController,
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
            const SizedBox(height: 16),
            Text(
              'Tingkat Kedalaman',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedDepth,
              style: GoogleFonts.poppins(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Sedang',
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
              dropdownColor: Colors.white,
              icon: const SizedBox.shrink(),
              items: depthLevels.map((String depth) {
                return DropdownMenuItem<String>(
                  value: depth,
                  child: Text(
                    depth,
                    style: GoogleFonts.poppins(color: Colors.black),
                  ),
                );
              }).toList(),
              onChanged: null, // Disabled manual selection
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
            InkWell(
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
                      '${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}, ${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')} WIB',
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                    const Icon(Icons.calendar_today, color: Color(0xFF016FB9)),
                  ],
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
                        name: 'Koordinat Lokasi',
                        location: '',
                        latitude: latitude ?? -6.975368,
                        longitude: longitude ?? 107.631033,
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
                                name: 'Koordinat Lokasi',
                                location: '',
                                latitude: latitude ?? -6.975368,
                                longitude: longitude ?? 107.631033,
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
                              'Tentukan Koordinat Lokasi',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF016FB9),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
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
                    'Tambah',
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
}
