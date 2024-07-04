import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:tilko/tilko.dart';

void main() {
  final aesKey = Uint8List.fromList(List.generate(32, (index) => index));
  final aesIv = Uint8List.fromList(List.generate(16, (index) => index));
  final rsaPublicKeyPem = '''-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA7VJ2T0sJ3orH7BJYpZBd
kPdXtklP5pS3Rm0FIWcCZd/ZkR9tLSzL0QZHTVt62PbNuV8tGTm0yYXl7CQF+TxG
7dhd8yF1sLj8mN+pB8xSOEBl6YtppqFqJFXVvv91Qoq2vHxuGdMLLls7+3VRjtrp
T3iA7ql+2ThtcbE6WNC6hC7NLjJx7W6/o7bxmAY7RB8Ahv9/Xzj5fwxUoPH4MlsQ
8XE7mSxBAsrd8j6RvWivMdXykS+U4Ec4/KK+l5FNvPVh0RIrczXS/qweWjErf7bP
MDZCwFbE/7d3LRcX8vnmK58CGIHJeqMCjOTMDDlRyyg8GjM18/rpmNzDg2cYP0G0
QwIDAQAB
-----END PUBLIC KEY-----''';

  test('AES encryption test', () {
    final plainText = 'Hello, World!';
    final encryptedText = aesEncrypt(aesKey, aesIv, plainText);
    print('AES Encrypted: $encryptedText');
    expect(encryptedText, isNotNull);
    expect(encryptedText, isNot(plainText));
  });

  test('RSA encryption test', () {
    final aesKeyToEncrypt =
        Uint8List.fromList(utf8.encode('your-aes-key-to-encrypt'));
    final encryptedText = rsaEncrypt(rsaPublicKeyPem, aesKeyToEncrypt);
    print('RSA Encrypted: $encryptedText');
    expect(encryptedText, isNotNull);
    expect(encryptedText, isNot(aesKeyToEncrypt));
  });
}
