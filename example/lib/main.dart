import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tilko/tilko.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _aesEncrypt = 'Unknown';
  String _rsaEncrypt = 'Unknown';

  @override
  void initState() {
    super.initState();
    initEncrypt();
  }

  Future<void> initEncrypt() async {
    String aesEncryptText;
    String rsaEncryptText;

    final plainText = 'Hello, World!';
    final rsaPublicKey = '''-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA7VJ2T0sJ3orH7BJYpZBd
kPdXtklP5pS3Rm0FIWcCZd/ZkR9tLSzL0QZHTVt62PbNuV8tGTm0yYXl7CQF+TxG
7dhd8yF1sLj8mN+pB8xSOEBl6YtppqFqJFXVvv91Qoq2vHxuGdMLLls7+3VRjtrp
T3iA7ql+2ThtcbE6WNC6hC7NLjJx7W6/o7bxmAY7RB8Ahv9/Xzj5fwxUoPH4MlsQ
8XE7mSxBAsrd8j6RvWivMdXykS+U4Ec4/KK+l5FNvPVh0RIrczXS/qweWjErf7bP
MDZCwFbE/7d3LRcX8vnmK58CGIHJeqMCjOTMDDlRyyg8GjM18/rpmNzDg2cYP0G0
QwIDAQAB
-----END PUBLIC KEY-----''';

    final aesKey = Uint8List(16);
    final random = Random();
    for (int i = 0; i < aesKey.length; i++) {
      aesKey[i] = random.nextInt(256);
    }
    final aesIv = Uint8List(16);

    try {
      aesEncryptText =
          aesEncrypt(aesKey, aesIv, plainText) ?? 'Unknown aes encrypt';
    } on PlatformException {
      aesEncryptText = 'Failed to aes encrypt.';
    } catch (e) {
      aesEncryptText = 'Failed to aes encrypt.';
    }

    try {
      rsaEncryptText = rsaEncrypt(rsaPublicKey, aesIv) ?? 'Unknown rsa encrypt';
    } on PlatformException {
      rsaEncryptText = 'Failed to rsa encrypt.';
    } catch (e) {
      rsaEncryptText = 'Failed to rsa encrypt.';
    }

    if (!mounted) return;

    setState(() {
      _aesEncrypt = aesEncryptText;
      _rsaEncrypt = rsaEncryptText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Text('rsa: ${_rsaEncrypt}'),
            Text('aes: ${_aesEncrypt}'),
          ],
        ),
      ),
    );
  }
}
