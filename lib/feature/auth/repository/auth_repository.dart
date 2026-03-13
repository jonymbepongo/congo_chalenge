import 'package:congo_chalenge/core/service/api_service.dart';
import 'package:congo_chalenge/core/utils/logger.dart';

class AuthRepository {

  final ApiService api;

  AuthRepository(this.api);

  /// LOGIN
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {

    try {

      final response = await api.post(
        "/auth/login",
        {
          "emailOrUsername": email,
          "password": password,
        },
      );

      AppLogger.log("Login response: $response");

      return response;

    } catch (e) {

      AppLogger.error("Erreur login: $e");

      rethrow;
    }
  }

  /// REGISTER
  Future<Map<String, dynamic>> register(Map<String, dynamic> data) async {

    try {

      final response = await api.post(
        "/auth/register",
        data,
      );

      return response;

    } catch (e) {

      AppLogger.error("Erreur register: $e");

      rethrow;
    }
  }

  /// PROFILE
  Future<Map<String, dynamic>> getProfile() async {

    try {

      final response = await api.get("/auth/profile");

      return response;

    } catch (e) {

      AppLogger.error("Erreur profile: $e");

      rethrow;
    }
  }
}