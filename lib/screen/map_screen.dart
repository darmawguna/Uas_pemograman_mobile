import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:wefgis_app/widget/modal_map_controller.dart'; // Pastikan path ini sesuai dengan path di proyek Anda

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final List<LatLng> floodPoints = [
    const LatLng(-8.240004857164257, 115.1266612161339), // Jakarta
    const LatLng(-8.279360626503047, 115.17889418202755), // Surabaya
    const LatLng(-8.2746616365954, 115.38723248917154), // Bandung
    const LatLng(-8.259039643919046, 115.09435086455711), // Bali
  ];
  double _currentZoom = 10;
  final MapController _mapController = MapController();
 

  void _zoomIn() {
    setState(() {
      _currentZoom++;
      _mapController.move(_mapController.center, _currentZoom);
    });
  }

  void _zoomOut() {
    setState(() {
      _currentZoom--;
      _mapController.move(_mapController.center, _currentZoom);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: const LatLng(-8.197707726277871, 115.16227460197047),
              enableMultiFingerGestureRace: true,
              zoom: _currentZoom,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: floodPoints.map((point) {
                  return Marker(
                    width: 80.0,
                    height: 80.0,
                    point: point,
                    builder: (ctx) => Container(
                      child: const Icon(Icons.location_on,
                          color: Colors.red, size: 40.0),
                    ),
                  );
                }).toList(),
              ),
              
            ],
          ),
          Positioned(
            top: 40,
            left: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Search places and addresses",
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          Positioned(
            top: 100,
            right: 10,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => const TrackModal(),
                    );
                  },
                  child: const Icon(Icons.layers),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: _zoomIn,
                  mini: true,
                  heroTag: 'zoom_in',
                  child: const Icon(Icons.add),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: _zoomOut,
                  mini: true,
                  heroTag: 'zoom_out',
                  child: const Icon(Icons.remove, size: 20),
                ),
              ],
            ),
          ),
          Positioned(
            top: 100,
            left: 10,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: _zoomIn,
                  mini: true,
                  heroTag: 'zoom_in_left',
                  child: const Icon(Icons.add),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: _zoomOut,
                  mini: true,
                  heroTag: 'zoom_out_left',
                  child: const Icon(Icons.remove, size: 20),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 50,
            right: 10,
            child: FloatingActionButton(
              onPressed: () {
               Navigator.pushNamed(context, '/mapAdd');
              },
              child: const Icon(Icons.add),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.share),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box_outline_blank_outlined),
            label: 'Data',
          ),
        ],
      ),
    );
  }
}
