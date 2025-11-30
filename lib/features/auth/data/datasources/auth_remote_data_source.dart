import 'package:dio/dio.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';

/// Auth Remote Data Source Interface
abstract class AuthRemoteDataSource {
  Future<UserModel> login({
    required String email,
    required String password,
  });
}

/// Auth Remote Data Source Implementation
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      // Using ReqRes API for mock authentication
      final response = await dio.post(
        AppConstants.loginEndpoint,
        data: {
          'email': email,
          'password': password,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'x-api-key': 'reqres-free-v1',
          },
        ),
      );

      if (response.statusCode == 200) {
        return UserModel.fromJson({
          ...response.data,
          'email': email,
          'id': 1, // Mock ID
        });
      } else {
        throw ServerException(
          message: 'Login failed',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException();
      }

      throw ServerException(
        message: e.response?.data['error'] ?? 'Login failed',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
