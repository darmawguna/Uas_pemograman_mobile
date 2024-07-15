import 'package:flutter/material.dart';
import 'package:wefgis_app/service/histori_banjir_service.dart';

import 'package:wefgis_app/model/histori_banjir_model.dart';

class HistoriListPage extends StatefulWidget {
  @override
  _HistoriListPageState createState() => _HistoriListPageState();
}

class _HistoriListPageState extends State<HistoriListPage> {
  late Future<List<HistoriData>> futureHistoriData;

  @override
  void initState() {
    super.initState();
    futureHistoriData = HistoriService().getAllHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histori Banjir'),
      ),
      body: FutureBuilder<List<HistoriData>>(
        future: futureHistoriData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Tidak ada data tersedia.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final histori = snapshot.data![index];
                return ListTile(
                  title: Text(histori.jenisKejadian ??
                      'Jenis Kejadian tidak diketahui'),
                  subtitle: Text(histori.lokasi ?? 'Lokasi tidak diketahui'),
                  trailing: Text(histori.level ?? 'Level tidak diketahui'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
