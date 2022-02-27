import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'dart:io';

typedef GreetingFunction = Pointer<Utf8> Function(Pointer<Utf8>);
typedef GreetingFunctionFFI = Pointer<Utf8> Function(Pointer<Utf8>);

final DynamicLibrary greeterNative = Platform.isAndroid
    ? DynamicLibrary.open("libgreeter.so")
    : DynamicLibrary.process();

final GreetingFunction rustGreeting = greeterNative
    .lookup<NativeFunction<GreetingFunctionFFI>>("rust_greeting")
    .asFunction();

/// Wraps the native functions and converts specific data types in order to
/// handle C strings.
class Greeter {
  /// Computes a greeting for the given name using the native function
  static String greet(String name) {
    final ptrName = name.toNativeUtf8();
    final Pointer<Utf8> resultPtr = rustGreeting(ptrName);

    return resultPtr.toDartString();
  }
}
