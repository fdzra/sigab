import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart' show LatLng;
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geocoding/geocoding.dart';

class MapBanjirPage extends StatefulWidget {
  final String name;
  final String location;
  final double latitude;
  final double longitude;
  final Function(double, double)? onLocationSelected;
  final String buttonText;

  const MapBanjirPage({
    Key? key,
    required this.name,
    required this.location,
    required this.latitude,
    required this.longitude,
    this.onLocationSelected,
    this.buttonText = 'Konfirmasi',
  }) : super(key: key);

  @override
  State<MapBanjirPage> createState() => _MapBanjirPageState();
}

class _MapBanjirPageState extends State<MapBanjirPage> {
  late MapController mapController;
  late LatLng _center;
  late LatLng _selectedLocation;
  double _currentZoom = 15.0;
  bool _isDragging = false;
  String _currentAddress = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _center = LatLng(widget.latitude, widget.longitude);
    _selectedLocation = _center;
    mapController = MapController();
    _updateAddress(_center);
  }

  Future<void> _updateAddress(LatLng position) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final Placemark place = placemarks.first;
        setState(() {
          _currentAddress = [
            if (place.street?.isNotEmpty == true) place.street,
            if (place.subLocality?.isNotEmpty == true) place.subLocality,
            if (place.locality?.isNotEmpty == true) place.locality,
            if (place.subAdministrativeArea?.isNotEmpty == true) 
              'Kec. ${place.subAdministrativeArea}',
            if (place.administrativeArea?.isNotEmpty == true) 
              place.administrativeArea,
            if (place.postalCode?.isNotEmpty == true) place.postalCode,
          ].where((element) => element != null).join(', ');
        });
      }
    } catch (e) {
      debugPrint('Error getting address: $e');
      setState(() {
        _currentAddress = 'Tidak dapat memuat alamat';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _updateMarker(LatLng position) {
    setState(() {
      _selectedLocation = position;
    });
    _updateAddress(position);
  }

  void _zoomIn() {
    _currentZoom = mapController.zoom + 1;
    mapController.move(mapController.center, _currentZoom);
  }

  void _zoomOut() {
    _currentZoom = mapController.zoom - 1;
    mapController.move(mapController.center, _currentZoom);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF016FB9)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.name,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              center: _center,
              zoom: _currentZoom,
              minZoom: 4,
              maxZoom: 18,
              onTap: (_, position) {
                _updateMarker(position);
              },
              enableScrollWheel: true,
              interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
              onPositionChanged: (MapPosition position, bool hasGesture) {
                if (hasGesture && position.center != null) {
                  _updateMarker(position.center!);
                }
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.sigab',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _selectedLocation,
                    child: GestureDetector(
                      onPanStart: (details) {
                        setState(() {
                          _isDragging = true;
                        });
                      },
                      onPanEnd: (details) {
                        setState(() {
                          _isDragging = false;
                        });
                      },
                      child: AnimatedScale(
                        scale: _isDragging ? 1.3 : 1.0,
                        duration: const Duration(milliseconds: 200),
                        child: const Icon(
                          Icons.location_on,
                          color: Color(0xFF016FB9),
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Zoom controls
          Positioned(
            right: 16,
            bottom: 200,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: "zoomIn",
                  onPressed: _zoomIn,
                  mini: true,
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.add, color: Color(0xFF016FB9)),
                ),
                const SizedBox(height: 8),
                FloatingActionButton(
                  heroTag: "zoomOut",
                  onPressed: _zoomOut,
                  mini: true,
                  backgroundColor: Colors.white,
                  child: const Icon(Icons.remove, color: Color(0xFF016FB9)),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Tentukan Koordinat lokasi',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Color(0xFF016FB9),
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (_isLoading)
                              const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF016FB9)),
                                ),
                              )
                            else
                              Text(
                                _currentAddress.isNotEmpty ? _currentAddress : widget.location,
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
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.onLocationSelected?.call(
                          _selectedLocation.latitude,
                          _selectedLocation.longitude,
                        );
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFA726),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        widget.buttonText,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}