import 'package:flutter/material.dart';
import 'package:wefgis_app/model/basemap_option_model.dart';
import 'package:wefgis_app/widget/custom_card_oldest.dart';

class TrackModal extends StatefulWidget {
  const TrackModal({super.key});

  @override
  State<TrackModal> createState() => _TrackModalState();
}

class _TrackModalState extends State<TrackModal> {
  List<BasemapOption> basemaps = [
    BasemapOption(
      name: 'OpenStreetMap',
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      image: 'assets/icon-basemap/openstreetmap_de.png',
    ),
    BasemapOption(
      name: 'Satellite',
      urlTemplate:
          'https://tiles.satellite.map.yahoo.com/hybrid/{z}/{x}/{y}.jpg',
      image: 'assets/icon-basemap/google-hibrid.png',
    ),
    BasemapOption(
      name: 'Night Mode',
      urlTemplate:
          'https://tiles.staamen.com/terrain-background/{z}/{x}/{y}.png',
      image: 'assets/icon-basemap/google-terrain.png',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 400,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Basemap ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const Divider(),

            // Add your modal content here (e.g., map, track details, etc.)
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal, // Set horizontal scroll
                      itemCount: basemaps.length,
                      itemBuilder: (context, index) {
                        final basemap = basemaps[index];
                        return BasemapButton(
                            basemap:
                                basemap); // Replace with your button widget
                      },
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add your button action here (e.g., apply selection)
                },
                style: ElevatedButton.styleFrom(
                  minimumSize:
                      const Size(100, 40), // Adjust button size as needed
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // Set button corner radius
                  ),
                ),
                child: const Text('Apply'),
              ),
            )
            // ...
          ],
        ),
      ),
    );
  }
}

class BasemapButton extends StatelessWidget {
  final BasemapOption basemap;
  // final Function(BasemapOption) onTap; // Callback function for tap event

  const BasemapButton({
    super.key,
    required this.basemap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: InkWell(
        // onTap: () => onTap(basemap), // Call the onTap callback with basemap
        child: CustomCards(
          title: basemap.name,
          image: basemap.image,
        ),
      ),
    );
  }
}
