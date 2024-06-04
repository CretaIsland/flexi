// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_edit_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$recordDataHash() => r'a2986fd264f6761c143a6e6bd94fd6dea98d65ca';

/// See also [recordData].
@ProviderFor(recordData)
final recordDataProvider = AutoDisposeProvider<String>.internal(
  recordData,
  name: r'recordDataProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$recordDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RecordDataRef = AutoDisposeProviderRef<String>;
String _$textEditControllerHash() =>
    r'0791a3a45cef740e986d338851734e205ec384a4';

/// See also [TextEditController].
@ProviderFor(TextEditController)
final textEditControllerProvider =
    AutoDisposeNotifierProvider<TextEditController, ContentInfo>.internal(
  TextEditController.new,
  name: r'textEditControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$textEditControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TextEditController = AutoDisposeNotifier<ContentInfo>;
String _$currentInputLanguagesControllerHash() =>
    r'55d8db2b39055354d4686c22ed294c89cac0c8cc';

/// See also [CurrentInputLanguagesController].
@ProviderFor(CurrentInputLanguagesController)
final currentInputLanguagesControllerProvider = AutoDisposeNotifierProvider<
    CurrentInputLanguagesController, List<Map<String, String>>>.internal(
  CurrentInputLanguagesController.new,
  name: r'currentInputLanguagesControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentInputLanguagesControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentInputLanguagesController
    = AutoDisposeNotifier<List<Map<String, String>>>;
String _$currentOutputLanguagesControllerHash() =>
    r'e85a4a6711ce7560de6217235c0892bec7c34588';

/// See also [CurrentOutputLanguagesController].
@ProviderFor(CurrentOutputLanguagesController)
final currentOutputLanguagesControllerProvider = AutoDisposeNotifierProvider<
    CurrentOutputLanguagesController, List<Map<String, String>>>.internal(
  CurrentOutputLanguagesController.new,
  name: r'currentOutputLanguagesControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentOutputLanguagesControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentOutputLanguagesController
    = AutoDisposeNotifier<List<Map<String, String>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
