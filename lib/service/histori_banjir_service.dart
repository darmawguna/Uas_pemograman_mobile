import 'package:http/http.dart' as http;
import 'package:wefgis_app/model/histori_banjir_model.dart';
import 'dart:convert';

class HistoriService {
  static const String baseUrl = 'http://192.168.100.166:3000';

  Future<List<HistoriData>> getAllHistory() async {
    final response = await http.get(Uri.parse('$baseUrl/api/histori'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      print(body);
      List<HistoriData> historiData = body
          .map(
            (dynamic item) => HistoriData.fromJson(item),
          )
          .toList();

      print("data berhasil di load");

      return historiData;
    } else {
      throw Exception('Failed to load histori data');
    }
  }
}
