import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionHelper {
  // In real production: store this in secure storage
  static final _key = encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows1');
  static final _encrypter = encrypt.Encrypter(encrypt.AES(_key));

  /// Encrypt text before saving to DB
  static String encryptText(String text) {
    final iv = encrypt.IV.fromSecureRandom(16);
    final encrypted = _encrypter.encrypt(text, iv: iv);

    // store iv + data together
    return '${iv.base64}:${encrypted.base64}';
  }

  /// Decrypt text after reading from DB
  static String decryptText(String text) {
    try {
      final parts = text.split(':');

      final iv = encrypt.IV.fromBase64(parts[0]);
      final encrypted = parts[1];

      return _encrypter.decrypt64(encrypted, iv: iv);
    } catch (e) {
      return text;
    }
  }
}
