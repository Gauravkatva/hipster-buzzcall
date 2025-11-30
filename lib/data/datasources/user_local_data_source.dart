import 'package:hive/hive.dart';

import '../../core/errors/exceptions.dart';
import '../../core/constants/app_constants.dart';
import '../models/user_model.dart';

/// Abstract class defining local user operations
abstract class UserLocalDataSource {
  Future<List<UserModel>> getCachedUsers();
  Future<void> cacheUsers(List<UserModel> users);
}

/// Implementation of local user data source using Hive
class UserLocalDataSourceImpl implements UserLocalDataSource {
  final Box box;

  UserLocalDataSourceImpl({required this.box});

  @override
  Future<List<UserModel>> getCachedUsers() async {
    final cachedData = box.get(AppConstants.userListCacheKey);

    if (cachedData != null) {
      // Hive stores lists as dynamic
      if (cachedData is List) {
        return cachedData
            .map((json) => UserModel.fromJson(Map<String, dynamic>.from(json)))
            .toList();
      } else {
        throw CacheException('Invalid cache data format');
      }
    } else {
      throw CacheException('No cached users found');
    }
  }

  @override
  Future<void> cacheUsers(List<UserModel> users) async {
    final usersJson = users.map((user) => user.toJson()).toList();
    await box.put(AppConstants.userListCacheKey, usersJson);
  }
}
