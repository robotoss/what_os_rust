import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:what_os_rust/what_os_rust.dart';

void main() {
  const MethodChannel channel = MethodChannel('what_os_rust');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await WhatOsRust.platformVersion, '42');
  });
}
