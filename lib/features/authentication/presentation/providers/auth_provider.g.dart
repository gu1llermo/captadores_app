// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authNotifierHash() => r'df501fea6b2bb6fe38b028c3ce9126046e54f846';

/// See also [AuthNotifier].
@ProviderFor(AuthNotifier)
final authNotifierProvider =
    AsyncNotifierProvider<AuthNotifier, AuthState>.internal(
      AuthNotifier.new,
      name: r'authNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$authNotifierHash,
      dependencies: <ProviderOrFamily>[
        keyValueStorageServiceProvider,
        authRepositoryProvider,
        internetConnectionNotifierProvider,
      ],
      allTransitiveDependencies: <ProviderOrFamily>{
        keyValueStorageServiceProvider,
        ...?keyValueStorageServiceProvider.allTransitiveDependencies,
        authRepositoryProvider,
        ...?authRepositoryProvider.allTransitiveDependencies,
        internetConnectionNotifierProvider,
        ...?internetConnectionNotifierProvider.allTransitiveDependencies,
      },
    );

typedef _$AuthNotifier = AsyncNotifier<AuthState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
