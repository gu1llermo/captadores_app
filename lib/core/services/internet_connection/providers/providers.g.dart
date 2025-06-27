// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$internetConnectionServiceHash() =>
    r'26d7d4280600bf4bb268b17f30d4e2a2bfed3ce6';

/// See also [internetConnectionService].
@ProviderFor(internetConnectionService)
final internetConnectionServiceProvider =
    Provider<InternetConnectionService>.internal(
      internetConnectionService,
      name: r'internetConnectionServiceProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$internetConnectionServiceHash,
      dependencies: const <ProviderOrFamily>[],
      allTransitiveDependencies: const <ProviderOrFamily>{},
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef InternetConnectionServiceRef = ProviderRef<InternetConnectionService>;
String _$internetConnectionNotifierHash() =>
    r'424433b90e74be1982e8028b445c8ee50ac1d98d';

/// See also [InternetConnectionNotifier].
@ProviderFor(InternetConnectionNotifier)
final internetConnectionNotifierProvider = NotifierProvider<
  InternetConnectionNotifier,
  InternetConnectionStatus
>.internal(
  InternetConnectionNotifier.new,
  name: r'internetConnectionNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$internetConnectionNotifierHash,
  dependencies: <ProviderOrFamily>[internetConnectionServiceProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    internetConnectionServiceProvider,
    ...?internetConnectionServiceProvider.allTransitiveDependencies,
  },
);

typedef _$InternetConnectionNotifier = Notifier<InternetConnectionStatus>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
