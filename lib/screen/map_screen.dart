// map_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:wefgis_app/model/histori_banjir_model.dart';
import 'package:wefgis_app/model/location_model.dart';
import 'package:wefgis_app/screen/map_add.dart';
import 'package:wefgis_app/service/histori_banjir_service.dart';
import 'package:wefgis_app/widget/modal_map_controller.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:wefgis_app/screen/histori_detail_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final List<LocationModel> _locations = [];
  final MapController _mapController = MapController();
  // final PopupController _popupController = PopupController();
  double _currentZoom = 10;

  List<HistoriData> _historiData = [];
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

  Future<void> _fetchHistoriData() async {
    try {
      final data = await HistoriService().getAllHistory();
      setState(() {
        _historiData = data;
      });
    } catch (e) {
      print('Failed to fetch histori data: $e');
    }
  }

  Future<void> _navigateToAddLocation() async {
    final LatLng initialPoint = _mapController.center;
    final LocationModel? location = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapFormScreen(initialPoint: initialPoint),
      ),
    );

    if (location != null) {
      setState(() {
        _locations.add(location);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchHistoriData();
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
                markers: _locations.map((location) {
                  return Marker(
                    point: location.point,
                    builder: (ctx) => Container(
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 40.0,
                      ),
                    ),
                  );
                }).toList(),
              ),
              PopupMarkerLayer(
                options: PopupMarkerLayerOptions(
                  markers: _historiData
                      .map((histori) {
                        final coords = histori.koordinat
                            ?.split(',')
                            .map((e) => double.tryParse(e.trim()))
                            .toList();
                        if (coords == null ||
                            coords.length != 2 ||
                            coords.contains(null)) return null;

                        return Marker(
                          point: LatLng(coords[0]!, coords[1]!),
                          builder: (ctx) => Container(
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 40.0,
                            ),
                          ),
                        );
                      })
                      .whereType<Marker>()
                      .toList(),
                  popupDisplayOptions: PopupDisplayOptions(
                    builder: (BuildContext context, Marker marker) {
                      // Mencari data histori berdasarkan koordinat marker yang dipilih
                      final historiData = _historiData.firstWhere(
                        (data) {
                          final coords = data.koordinat
                              ?.split(',')
                              .map((e) => double.tryParse(e.trim()))
                              .toList();
                          return coords != null &&
                              coords.length == 2 &&
                              !coords.contains(null) &&
                              LatLng(coords[0]!, coords[1]!) == marker.point;
                        },
                        orElse: () => HistoriData(
                          // Menampilkan data kosong jika tidak ada data yang cocok
                          keterangan: '',
                          koordinat: '',
                        ),
                      );

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HistoriDetailScreen(
                                historiData: historiData,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          constraints: const BoxConstraints(
                            maxHeight: 150.0, // Ubah sesuai kebutuhan
                            maxWidth: 250.0, // Ubah sesuai kebutuhan
                          ),
                          padding: const EdgeInsets.all(
                              12.0), // Menambahkan padding di dalam container
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                12.0), // Menambahkan sudut rounded
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Text(
                              //   'Tanggal: ${historiData.tanggal}', // Menampilkan tanggal histori banjir
                              //   style: Theme.of(context).textTheme.subtitle1,
                              // ),
                              Text(
                                  "jenis Kejadian : ${historiData.jenisKejadian}"),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HistoriDetailScreen(
                                        historiData: historiData,
                                      ),
                                    ),
                                  );
                                },
                                child: const Text(
                                    'Lihat Detail'), // Tombol untuk melihat detail histori banjir
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
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
              onPressed: _navigateToAddLocation,
              child: const Icon(Icons.add),
            ),
          ),
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
