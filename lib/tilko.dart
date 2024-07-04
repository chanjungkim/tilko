import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/export.dart';

String aesEncrypt(Uint8List key, Uint8List iv, String plainText) {
  final encrypter =
      Encrypter(AES(Key(key), mode: AESMode.cbc, padding: 'PKCS7'));
  final ivSpec = IV(iv);
  final encrypted = encrypter.encrypt(plainText, iv: ivSpec);
  return encrypted.base64;
}

String rsaEncrypt(String rsaPublicKey, Uint8List aesKey) {
  rsaPublicKey = ensurePemFormat(rsaPublicKey);
  final publicKey = RSAKeyParser().parse(rsaPublicKey) as RSAPublicKey;
  final encrypter = Encrypter(RSA(publicKey: publicKey));
  final encrypted = encrypter.encryptBytes(aesKey);
  return encrypted.base64;
}

String ensurePemFormat(String key) {
  const pemStart = '-----BEGIN PUBLIC KEY-----';
  const pemEnd = '-----END PUBLIC KEY-----';

  if (!key.startsWith(pemStart)) {
    key = key.replaceAll('\n', '');
    final chunkedKey = RegExp('.{1,64}')
        .allMatches(key)
        .map((match) => match.group(0))
        .join('\n');
    key = '$pemStart\n$chunkedKey\n$pemEnd';
  }

  return key;
}

String aesDecrypt(Uint8List key, Uint8List iv, String encryptedData) {
  final encrypter =
      Encrypter(AES(Key(key), mode: AESMode.cbc, padding: 'PKCS7'));
  final ivSpec = IV(iv);
  final decrypted = encrypter.decrypt64(encryptedData, iv: ivSpec);
  return decrypted;
}
