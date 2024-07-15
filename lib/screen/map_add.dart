import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:wefgis_app/model/location_model.dart';
// Pastikan path ini sesuai dengan path di proyek Anda

class MapFormScreen extends StatefulWidget {
  final LatLng initialPoint;

  const MapFormScreen({super.key, required this.initialPoint});

  @override
  _MapFormScreenState createState() => _MapFormScreenState();
}

class _MapFormScreenState extends State<MapFormScreen> {
  late TextEditingController _addressController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _addressController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveLocation() {
    final address = _addressController.text;
    final description = _descriptionController.text;

    if (address.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All fields are required.')),
      );
      return;
    }

    final location = LocationModel(
      point: widget.initialPoint,
      address: address,
      description: description,
    );

    Navigator.pop(context, location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Location')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: TextEditingController(
                  text: widget.initialPoint.latitude.toString()),
              decoration: const InputDecoration(
                  labelText: 'Latitude', border: OutlineInputBorder()),
              enabled: false,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: TextEditingController(
                  text: widget.initialPoint.longitude.toString()),
              decoration: const InputDecoration(
                  labelText: 'Longitude', border: OutlineInputBorder()),
              enabled: false,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(
                  labelText: 'Address', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                  labelText: 'Description', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveLocation,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
