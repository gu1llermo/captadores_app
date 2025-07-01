// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$loginNotifierHash() => r'9593f3698fbf2e7d8093a198d6c5198f127478d6';

/// See also [LoginNotifier].
@ProviderFor(LoginNotifier)
final loginNotifierProvider =
    AutoDisposeNotifierProvider<LoginNotifier, LoginState>.internal(
      LoginNotifier.new,
      name: r'loginNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$loginNotifierHash,
      dependencies: <ProviderOrFamily>[authNotifierProvider],
      allTransitiveDependencies: <ProviderOrFamily>{
        authNotifierProvider,
        ...?authNotifierProvider.allTransitiveDependencies,
      },
    );

typedef _$LoginNotifier = AutoDisposeNotifier<LoginState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
