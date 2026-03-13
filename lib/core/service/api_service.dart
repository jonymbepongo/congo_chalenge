import 'package:congo_chalenge/core/app/app_name.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../utils/logger.dart';

class ApiService {
  static const String baseUrl = AppName.baseUrl;
  static final FlutterSecureStorage _storage = const FlutterSecureStorage();

  late Dio dio;

  ApiService() {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      ),
    );

    _initializeInterceptors();
  }

  /// ===============================
  /// TOKEN MANAGEMENT
  /// ===============================

  Future<String?> getToken() async {
    return await _storage.read(key: "auth_token");
  }

  Future<void> saveToken(String token) async {
    await _storage.write(key: "auth_token", value: token);
  }

  Future<void> clearToken() async {
    await _storage.delete(key: "auth_token");
  }

  /// ===============================
  /// INTERCEPTORS
  /// ===============================

  void _initializeInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        /// REQUEST
        onRequest: (options, handler) async {
          final token = await getToken();

          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },

        /// RESPONSE
        onResponse: (response, handler) {
          return handler.next(response);
        },

        /// ERROR
        onError: (DioException error, handler) {
          if (error.response?.statusCode == 401) {
            clearToken();
          }

          return handler.next(error);
        },
      ),
    );

    /// LOGGER
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );
  }

  /// ===============================
  /// GENERIC GET
  /// ===============================

  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? query,
  }) async {
    try {
      final response = await dio.get(
        endpoint,
        queryParameters: query,
      );

      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// ===============================
  /// GENERIC POST
  /// ===============================

  Future<dynamic> post(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await dio.post(
        endpoint,
        data: data,
      );

      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// ===============================
  /// GENERIC PUT
  /// ===============================

  Future<dynamic> put(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await dio.put(
        endpoint,
        data: data,
      );

      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// ===============================
  /// GENERIC DELETE
  /// ===============================

  Future<dynamic> delete(String endpoint) async {
    try {
      final response = await dio.delete(endpoint);

      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// ===============================
  /// FILE UPLOAD
  /// ===============================

  Future<dynamic> uploadFile(
    String endpoint,
    String filePath,
  ) async {
    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(filePath),
      });

      final response = await dio.post(
        endpoint,
        data: formData,
      );

      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// ===============================
  /// ERROR HANDLER
  /// ===============================

  String _handleError(DioException error) {
    if (error.response != null) {
      return error.response?.data["message"] ?? "Erreur serveur";
    }

    if (error.type == DioExceptionType.connectionTimeout) {
      return "Connexion timeout";
    }

    if (error.type == DioExceptionType.receiveTimeout) {
      return "Serveur trop lent";
    }

    return "Erreur réseau";
  }
  Future<void> checkBackendConnection() async {
  try {
    final response = await dio.get("/health"); // ou ton endpoint de test
    if (response.statusCode == 200) {
      AppLogger.log("Backend connecté ✅");
    } else {
      AppLogger.log("Backend non disponible (code: ${response.statusCode})");
    }
  } catch (e) {
    AppLogger.log("Erreur de connexion au backend: $e");
    }
  }
}