import 'package:congo_chalenge/core/utils/logger.dart';
import 'package:get/get.dart';
import '../model/artiste_model.dart';
import '../repository/artiste_repository.dart';

class ArtisteController extends GetxController {

  final ArtisteRepository repository;

  ArtisteController(this.repository);

  RxBool isLoading = false.obs;

  RxList<ArtisteModel> artistes = <ArtisteModel>[].obs;

  RxSet<int> votedArtists = <int>{}.obs;

  int currentPhase = 1;

  @override
  void onInit() {
    super.onInit();
    fetchArtists();
  }

  Future<void> fetchArtists() async {

    try {

      isLoading.value = true;

      final data = await repository.getArtists();

      artistes.value = data;
      AppLogger.log("artistes recuperer avec success" );

    } catch (e) {

      Get.snackbar("Erreur", e.toString());
      AppLogger.error("Erreur lors de la récupération des artistes : $e", );

    } finally {

      isLoading.value = false;

    }

  }

  Future<void> vote(int artisteId) async {

    try {

      await repository.voteArtist(artisteId, currentPhase);

      votedArtists.add(artisteId);

      final index = artistes.indexWhere((a) => a.id == artisteId);

      if (index != -1) {

        final artiste = artistes[index];

        artistes[index] = ArtisteModel(
          id: artiste.id,
          userId: artiste.userId,
          nomComplet: artiste.nomComplet,
          nomArtiste: artiste.nomArtiste,
          dateNaissance: artiste.dateNaissance,
          sexe: artiste.sexe,
          discipline: artiste.discipline,
          adresse: artiste.adresse,
          quartier: artiste.quartier,
          telephone: artiste.telephone,
          email: artiste.email,
          biographie: artiste.biographie,
          photoUrl: artiste.photoUrl,
          videoUrl: artiste.videoUrl,
          pieceIdentiteUrl: artiste.pieceIdentiteUrl,
          statut: artiste.statut,
          festirasId: artiste.festirasId,
          province: artiste.province,
          ville: artiste.ville,
          pays: artiste.pays,
          hashtagOfficiel: artiste.hashtagOfficiel,
          totalVotes: artiste.totalVotes + 1,
          scoreJury: artiste.scoreJury,
          scoreFinal: artiste.scoreFinal,
          phaseActuelleId: artiste.phaseActuelleId,
          createdAt: artiste.createdAt,
          updatedAt: artiste.updatedAt,
        );

      }

      Get.snackbar("Vote", "Vote enregistré");

    } catch (e) {

      Get.snackbar("Erreur", e.toString());

    }

  }

  bool hasVoted(int artisteId) {
    return votedArtists.contains(artisteId);
  }
}