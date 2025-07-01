// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registros_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$registrosNotifierHash() => r'04059e9e564ff4e51d15d892ab0ba5fc58f3061a';

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
