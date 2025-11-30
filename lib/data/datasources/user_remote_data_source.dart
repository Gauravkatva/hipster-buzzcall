import 'package:dio/dio.dart';

import '../../core/errors/exceptions.dart';
import '../../core/constants/app_constants.dart';
import '../models/user_model.dart';

/// Abstract class defining remote user operations
abstract class UserRemoteDataSource {
  Future<List<UserModel>> getUsers({int page = 1});
}

/// Implementation of remote user data source using ReqRes API
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio dio;

  UserRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<UserModel>> getUsers({int page = 1}) async {
    try {
      final response = await dio.get(
        '${AppConstants.baseUrl}${AppConstants.usersEndpoint}',
        queryParameters: {'page': page},
        options: Options(headers: {
          'Content-Type': 'application/json',
          'x-api-key': 'reqres-free-v1',
        }),
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final List<dynamic> usersJson = data['data'] as List<dynamic>;

        return usersJson
            .map((json) => UserModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException('Failed to fetch users: ${response.statusCode}');
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
