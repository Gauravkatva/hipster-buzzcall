/// Unified App Constants
/// Contains all application-wide constants
class AppConstants {
  // ============ App Info ============
  static const String appName = 'BuzzCall';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Video calling app with Agora SDK';

  // ============ API Constants ============
  static const String baseUrl = 'https://reqres.in/api';
  static const String usersEndpoint = '/users';
  static const String loginEndpoint = '/login';
  static const String registerEndpoint = '/register';

  // ============ Agora Constants ============
  static const String agoraAppId = '30288f649270441bb5c838a1c321c853';
  static const String? agoraToken = null; // For testing, use null or temp token
  static const String agoraChannelName = 'buzzcall_test_channel';

  // ============ Mock Credentials ============
  // Hardcoded credentials for mock login (as per requirements)
  static const String mockEmail = 'eve.holt@reqres.in';
  static const String mockPassword = 'cityslicka';

  // ============ Storage Keys ============
  static const String authTokenKey = 'auth_token';
  static const String authTokenCacheKey = 'AUTH_TOKEN';
  static const String userIdKey = 'user_id';
  static const String userEmailKey = 'user_email';
  static const String isLoggedInKey = 'is_logged_in';
  static const String isLoggedInCacheKey = 'IS_LOGGED_IN';
  static const String userListCacheKey = 'CACHED_USER_LIST';

  // ============ Hive Box Names ============
  static const String userBoxName = 'users';
  static const String authBoxName = 'auth';
  static const String userCacheBox = 'user_cache';
  static const String settingsBox = 'settings';

  // ============ Timeouts ============
  static const int connectionTimeout = 30000; // 30 seconds
  static const int connectTimeout = 30000; // 30 seconds (alias for Dio)
  static const int receiveTimeout = 30000; // 30 seconds
  static const int sendTimeout = 30000; // 30 seconds

  // ============ Navigation Routes ============
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
  static const String usersRoute = '/users';
  static const String videoCallRoute = '/video-call';

  // ============ Animation Durations ============
  static const int splashDuration = 2000;
  static const int shortAnimationDuration = 200;
  static const int mediumAnimationDuration = 300;
  static const int longAnimationDuration = 500;

  // ============ UI Constants ============
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 12.0;
  static const double defaultElevation = 2.0;
  static const String defaultAvatarUrl = 'https://via.placeholder.com/150';

  // ============ Pagination ============
  static const int defaultPageSize = 10;
  static const int defaultPage = 1;

  // ============ Headers ============
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'x-api-key': 'reqres-free-v1',
  };
}
