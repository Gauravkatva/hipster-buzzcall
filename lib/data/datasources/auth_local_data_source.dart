import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/errors/exceptions.dart';
import '../../core/constants/app_constants.dart';

/// Abstract class defining local auth operations
abstract class AuthLocalDataSource {
  Future<String> getAuthToken();
  Future<void> cacheAuthToken(String token);
  Future<bool> isLoggedIn();
  Future<void> clearAuth();
}

/// Implementation of local auth data source
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;
  final Box box;

  AuthLocalDataSourceImpl({required this.sharedPreferences, required this.box});

  @override
  Future<String> getAuthToken() async {
    final token = sharedPreferences.getString(AppConstants.authTokenCacheKey);
    if (token != null) {
      return token;
    } else {
      throw CacheException('No auth token found');
    }
  }

  @override
  Future<void> cacheAuthToken(String token) async {
    await sharedPreferences.setString(AppConstants.authTokenCacheKey, token);
    await sharedPreferences.setBool(AppConstants.isLoggedInCacheKey, true);
    await box.put('token', token);
  }

  @override
  Future<bool> isLoggedIn() async {
    return sharedPreferences.getBool(AppConstants.isLoggedInCacheKey) ?? false;
  }

  @override
  Future<void> clearAuth() async {
    await sharedPreferences.remove(AppConstants.authTokenCacheKey);
    await sharedPreferences.setBool(AppConstants.isLoggedInCacheKey, false);
    await box.clear();
  }
}
