import 'package:flutter_test/flutter_test.dart';
import 'package:expense_tracker_app/core/security/encryption_helper.dart';

void main() {
  group('EncryptionHelper Test', () {
    test('Encryption and decryption should return original text', () {
      const text = 'Food';

      final encrypted = EncryptionHelper.encryptText(text);
      final decrypted = EncryptionHelper.decryptText(encrypted);

      expect(decrypted, text);
    });

    test('Amount encryption should work correctly', () {
      const amount = '500';

      final encrypted = EncryptionHelper.encryptText(amount);
      final decrypted = EncryptionHelper.decryptText(encrypted);

      expect(decrypted, amount);
    });
  });
}
