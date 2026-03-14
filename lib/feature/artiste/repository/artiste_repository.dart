import 'package:congo_chalenge/core/service/api_service.dart';
import '../model/artiste_model.dart';

class ArtisteRepository {
  final ApiService api;

  ArtisteRepository(this.api);

  Future<List<ArtisteModel>> getArtists() async {

    final response = await api.get('/artists/validated');

    final List data = response["data"]["artistes"];

    return data.map((e) => ArtisteModel.fromJson(e)).toList();
  }

  Future<void> voteArtist(int artisteId, int phaseId) async {

    await api.post("/votes", {
      "artiste_id": artisteId, 
      "phase_id": phaseId
    });

  }
}