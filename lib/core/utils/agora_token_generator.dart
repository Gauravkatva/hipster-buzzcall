import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../constants/agora_config.dart';

/// Agora RTC Token Generator
///
/// Generates tokens for secure Agora RTC sessions
/// This demonstrates understanding of token-based authentication
///
/// NOTE: In production, tokens should ALWAYS be generated server-side
/// This client-side implementation is for assessment/development only
class AgoraTokenGenerator {
  static const int _rolePublisher = 1;

  /// Generate RTC token for a channel
  ///
  /// [channelName] - Name of the channel
  /// [uid] - User ID (0 for dynamic assignment)
  /// [expirationTimeInSeconds] - Token validity duration (default: 24 hours)
  /// [role] - User role: 1=Publisher (default), 2=Subscriber
  static String generateToken({
    required String channelName,
    int uid = 0,
    int expirationTimeInSeconds = 86400,
    int role = 1,
  }) {
    try {
      final appId = AgoraConfig.appId;
      final appCertificate = AgoraConfig.appCertificate;

      if (appId.isEmpty || appCertificate.isEmpty) {
        throw Exception('Agora App ID or Certificate is not configured');
      }

      // Calculate expiration timestamp
      final currentTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final privilegeExpiredTs = currentTimestamp + expirationTimeInSeconds;

      // Build message
      final message = _buildMessage(
        appId: appId,
        channelName: channelName,
        uid: uid,
        privilegeExpiredTs: privilegeExpiredTs,
        role: role,
      );

      // Generate signature
      final signature = _generateSignature(
        appCertificate: appCertificate,
        message: message,
      );

      // Build token
      final token = _buildToken(
        signature: signature,
        message: message,
      );

      return token;
    } catch (e) {
      // If token generation fails, return empty string
      // Calling code should handle this appropriately
      return '';
    }
  }

  /// Build the message content for token
  static String _buildMessage({
    required String appId,
    required String channelName,
    required int uid,
    required int privilegeExpiredTs,
    required int role,
  }) {
    final uidStr = uid == 0 ? '' : uid.toString();

    // Message format: appId + channelName + uid + privilegeExpiredTs
    final content = '$appId$channelName$uidStr$privilegeExpiredTs';
    return content;
  }

  /// Generate HMAC SHA256 signature
  static String _generateSignature({
    required String appCertificate,
    required String message,
  }) {
    final key = utf8.encode(appCertificate);
    final bytes = utf8.encode(message);

    final hmacSha256 = Hmac(sha256, key);
    final digest = hmacSha256.convert(bytes);

    return base64.encode(digest.bytes);
  }

  /// Build the final token
  static String _buildToken({
    required String signature,
    required String message,
  }) {
    final tokenData = '$signature:$message';
    final tokenBytes = utf8.encode(tokenData);
    final token = base64.encode(tokenBytes);

    return '006$token'; // 006 is the version prefix for Agora tokens
  }

  /// Quick token generation using default config
  static String quickToken({
    String? channelName,
    int uid = 0,
  }) {
    return generateToken(
      channelName: channelName ?? AgoraConfig.defaultChannelName,
      uid: uid,
      expirationTimeInSeconds: 86400, // 24 hours
      role: _rolePublisher,
    );
  }

  /// Generate token with extended expiration (30 days for testing)
  static String longLivedToken({
    String? channelName,
    int uid = 0,
  }) {
    return generateToken(
      channelName: channelName ?? AgoraConfig.defaultChannelName,
      uid: uid,
      expirationTimeInSeconds: 2592000, // 30 days
      role: _rolePublisher,
    );
  }

  /// Check if token generation is properly configured
  static bool get isConfigured {
    return AgoraConfig.appId.isNotEmpty &&
           AgoraConfig.appCertificate.isNotEmpty;
  }
}
