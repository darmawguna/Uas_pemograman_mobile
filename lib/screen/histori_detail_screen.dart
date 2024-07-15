import 'package:flutter/material.dart';
import 'package:wefgis_app/model/histori_banjir_model.dart';

class HistoriDetailScreen extends StatelessWidget {
  final HistoriData historiData;

  const HistoriDetailScreen({super.key, required this.historiData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Banjir'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Menampilkan gambar jika ada
            // if (historiData.dokumentasiPath?.isNotEmpty) ...[
            //   Image.network(
            //     'https://your-server-url.com/${historiData.dokumentasiPath}', // Ganti dengan URL server Anda
            //     fit: BoxFit.cover,
            //     height: 200,
            //     width: double.infinity,
            //   ),
            //   const SizedBox(height: 16.0),
            // ],
            Text(
              'Tanggal Kejadian: ${historiData.waktuKejadian?.toLocal().toString().split(' ')[0]}', // Menampilkan tanggal kejadian
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              'Waktu Asesmen: ${historiData.waktuAsesmen?.toLocal().toString().split(' ')[1]}', // Menampilkan waktu asesmen
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Waktu Laporan: ${historiData.waktuLaporan}', // Menampilkan waktu laporan
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Waktu Tiba: ${historiData.waktuTiba}', // Menampilkan waktu tiba
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Jenis Kejadian: ${historiData.jenisKejadian}', // Menampilkan jenis kejadian
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Lokasi: ${historiData.lokasi}', // Menampilkan lokasi
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Koordinat: ${historiData.koordinat}', // Menampilkan koordinat
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Meninggal: ${historiData.meninggal}', // Menampilkan jumlah meninggal
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Luka Berat: ${historiData.lukaBerat}', // Menampilkan jumlah luka berat
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Luka Ringan: ${historiData.lukaRingan}', // Menampilkan jumlah luka ringan
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Korban: ${historiData.korban}', // Menampilkan informasi korban
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Perkiraan Kerugian: ${historiData.perkiraanKerugian}', // Menampilkan perkiraan kerugian
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Keterangan: ${historiData.keterangan}', // Menampilkan keterangan
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Level: ${historiData.level}', // Menampilkan level
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
