import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';
import 'dart:convert';

/// Auth Local Data Source Interface
abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getCachedUser();
  Future<void> clearCache();
  Future<bool> isLoggedIn();
}

/// Auth Local Data Source Implementation
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> cacheUser(UserModel user) async {
    try {
      await sharedPreferences.setString(
        AppConstants.userIdKey,
        json.encode(user.toJson()),
      );
      await sharedPreferences.setBool(AppConstants.isLoggedInKey, true);
      if (user.token != null) {
        await sharedPreferences.setString(
          AppConstants.authTokenKey,
          user.token!,
        );
      }
    } catch (e) {
      throw CacheException(message: 'Failed to cache user data');
    }
  }

  @override
  Future<UserModel?> getCachedUser() async {
    try {
      final userJson = sharedPreferences.getString(AppConstants.userIdKey);
      if (userJson != null) {
        return UserModel.fromJson(json.decode(userJson));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await sharedPreferences.remove(AppConstants.userIdKey);
      await sharedPreferences.remove(AppConstants.authTokenKey);
      await sharedPreferences.setBool(AppConstants.isLoggedInKey, false);
    } catch (e) {
      throw CacheException(message: 'Failed to clear cache');
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    return sharedPreferences.getBool(AppConstants.isLoggedInKey) ?? false;
  }
}
