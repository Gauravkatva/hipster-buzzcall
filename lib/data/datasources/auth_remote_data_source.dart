import 'package:dio/dio.dart';

import '../../core/errors/exceptions.dart';
import '../../core/constants/app_constants.dart';
import '../models/auth_token_model.dart';

/// Abstract class defining remote auth operations
abstract class AuthRemoteDataSource {
  Future<AuthTokenModel> login({
    required String email,
    required String password,
  });
}

/// Implementation of remote auth data source using ReqRes API
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<AuthTokenModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        '${AppConstants.baseUrl}${AppConstants.loginEndpoint}',
        data: {'email': email, 'password': password},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'x-api-key': 'reqres-free-v1',
          },
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      if (response.statusCode == 200) {
        return AuthTokenModel.fromJson(response.data as Map<String, dynamic>);
      } else if (response.statusCode == 400) {
        throw AuthenticationException(
          response.data['error'] ?? 'Invalid credentials',
        );
      } else {
        throw ServerException(
          'Login failed with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException('Request timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException('No internet connection');
      } else {
        throw ServerException(e.message ?? 'Server error occurred');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
