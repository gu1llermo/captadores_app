// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registros_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$registrosNotifierHash() => r'bdaa6fb28894486f1c02a5b60d8887bbb1b07d54';

/// See also [RegistrosNotifier].
@ProviderFor(RegistrosNotifier)
final registrosNotifierProvider =
    AsyncNotifierProvider<RegistrosNotifier, RegistrosState>.internal(
      RegistrosNotifier.new,
      name: r'registrosNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$registrosNotifierHash,
      dependencies: <ProviderOrFamily>[
        registrosRepositoryProvider,
        authNotifierProvider,
        internetConnectionServiceProvider,
      ],
      allTransitiveDependencies: <ProviderOrFamily>{
        registrosRepositoryProvider,
        ...?registrosRepositoryProvider.allTransitiveDependencies,
        authNotifierProvider,
        ...?authNotifierProvider.allTransitiveDependencies,
        internetConnectionServiceProvider,
        ...?internetConnectionServiceProvider.allTransitiveDependencies,
      },
    );

typedef _$RegistrosNotifier = AsyncNotifier<RegistrosState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
