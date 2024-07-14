import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:wefgis_app/model/location_model.dart'; // Pastikan path ke model/location_model.dart sudah benar

class MapFormScreen extends StatefulWidget {
  const MapFormScreen({super.key});

  @override
  _MapFormScreenState createState() => _MapFormScreenState();
}

class _MapFormScreenState extends State<MapFormScreen> {
  final MapController _mapController = MapController();
  LatLng? _selectedPoint;
  String _address = '';
  final TextEditingController _descriptionController = TextEditingController();
  final List<LocationModel> _locations = []; // Daftar untuk menyimpan lokasi

  void _handleTap(TapPosition tapPosition, LatLng latLng) async {
    setState(() {
      _selectedPoint = latLng;
    });

    List<Placemark> placemarks =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    if (placemarks.isNotEmpty) {
      final placemark = placemarks.first;
      setState(() {
        _address =
            '${placemark.street ?? ''}, ${placemark.locality ?? ''}, ${placemark.postalCode ?? ''}, ${placemark.country ?? ''}';
      });
    } else {
      setState(() {
        _address = 'No address found';
      });
    }

    // Menambahkan marker baru ke dalam daftar _locations
    setState(() {
       _locations.clear();
      _locations.add(
        LocationModel(
          point: latLng,
          address: _address,
          description:
              '', // Kosongkan deskripsi pada saat ini, atau Anda bisa menambahkan deskripsi default
        ),
      );
    });
  }


  void _showForm() {
    if (_selectedPoint == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a point on the map first.'),
        ),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context)
              .viewInsets
              .bottom, // Menyesuaikan padding dengan tinggi keyboard
        ),
        child: SingleChildScrollView(
          // Menambahkan SingleChildScrollView agar konten bisa digulir
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                 const SizedBox(height: 10),
                Text(
                  'Add Information for $_address',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Location Name or Description',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  autofocus: true,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    final description = _descriptionController.text;
                    if (description.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Description cannot be empty.'),
                        ),
                      );
                      return;
                    }
            
                    // Mengambil _selectedPoint yang tidak null
                    if (_selectedPoint != null) {
                      final location = LocationModel(
                        point: _selectedPoint!,
                        address: _address,
                        description: description,
                      );
            
                      setState(() {
                        _locations.add(location); // Menambahkan lokasi ke daftar
                        _descriptionController
                            .clear(); // Menghapus teks di TextField
                        _selectedPoint = null; // Menghapus titik yang dipilih
                        _address = ''; // Menghapus alamat yang ditampilkan
                      });
            
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Saved location at ${_selectedPoint} with address $_address and description "$description"'),
                        ),
                      );
                      Navigator.of(context).pop(); // Menutup form
                    }
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Location'),
      ),
      body: Stack(
        children: <Widget>[
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: const LatLng(-8.197707726277871, 115.16227460197047),
              zoom: 10,
              onTap: _handleTap,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: _locations
                    .map((location) => Marker(
                          width: 80.0,
                          height: 80.0,
                          point: location.point,
                          builder: (ctx) => Container(
                            child: Icon(Icons.location_on,
                                color: Colors.red, size: 40.0),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
          Positioned(
            bottom: 50,
            right: 10,
            child: FloatingActionButton(
              onPressed: _showForm,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
