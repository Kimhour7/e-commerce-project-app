import 'package:dio/dio.dart';
import 'package:e_comers/app/service/storage_service.dart';

class APIProvider {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://10.0.2.2:8000/api",
      // baseUrl: "http://192.168.1.1:8000/api",
      contentType: 'application/json',
      responseType: ResponseType.json,
      validateStatus: (status) {
        return status! < 500;
      },
    ),
  );

  Future<Response> login({
    required String email,
    required String password,
  }) async {
    try {
      return await _dio.post(
        "/login",
        data: {"email": email, "password": password},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> logout({required String token}) async {
    try {
      final response = await _dio.post(
        "/user/logout",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    try {
      return _dio.post(
        '/register',
        data: {
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getProduct({int page = 1, int limit = 10}) {
    try {
      return _dio.get(
        '/productofcategory',
        queryParameters: {'page': page, 'limit': limit},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> searchProduct({required String keyword}) async {
    try {
      return _dio.get(
        '/products/search',
        data: {"search": keyword},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getAddress() async {
    try {
      return _dio.get(
        '/addresses',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization':
                'Bearer ${await StorageService.read(key: 'token')}',
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getCartItem() async {
    try {
      return _dio.get(
        '/carts',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization':
                'Bearer ${await StorageService.read(key: 'token')}',
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> addCard({required int id, required int quantity}) async {
    try {
      return await _dio.post(
        '/carts',
        data: {'product_id': id, 'quantity': quantity},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization':
                'Bearer ${await StorageService.read(key: 'token')}',
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> updateCard({required int id, required int quantity}) async {
    try {
      return await _dio.put(
        '/cart-items/$id',
        data: {'quantity': quantity},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization':
                'Bearer ${await StorageService.read(key: 'token')}',
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> deleteCard({required int id}) async {
    try {
      return await _dio.delete(
        '/cart-items/$id',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization':
                'Bearer ${await StorageService.read(key: 'token')}',
          },
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
