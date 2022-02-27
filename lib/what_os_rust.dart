import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'dart:io';

typedef GreetingFunction = Pointer<Utf8> Function(Pointer<Utf8>);
typedef GreetingFunctionFFI = Pointer<Utf8> Function(Pointer<Utf8>);

typedef GetOsFunction = Pointer<Utf8> Function();
typedef GetOsFunctionFFI = Pointer<Utf8> Function();

final DynamicLibrary greeterNative = Platform.isAndroid
    ? DynamicLibrary.open("libgreeter.so")
    : DynamicLibrary.process();

final GreetingFunction rustGreeting = greeterNative
    .lookup<NativeFunction<GreetingFunctionFFI>>("rust_greeting")
    .asFunction();

final GetOsFunction rustGetOs = greeterNative
    .lookup<NativeFunction<GetOsFunctionFFI>>("rust_get_platform")
    .asFunction();

class Greeter {
  static String greet(String name) {
    final ptrName = name.toNativeUtf8();
    final Pointer<Utf8> resultPtr = rustGreeting(ptrName);

    return resultPtr.toDartString();
  }

  static String getOs() {
    final Pointer<Utf8> resultPtr = rustGetOs();

    return resultPtr.toDartString();
  }
}
