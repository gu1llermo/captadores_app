// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recovery_password_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$recoveryPasswordNotifierHash() =>
    r'2103b1d0aaf39521a45deb066711c4159a45d75c';

/// See also [RecoveryPasswordNotifier].
@ProviderFor(RecoveryPasswordNotifier)
final recoveryPasswordNotifierProvider =
    AutoDisposeNotifierProvider<
      RecoveryPasswordNotifier,
      RecoveryPasswordState
    >.internal(
      RecoveryPasswordNotifier.new,
      name: r'recoveryPasswordNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$recoveryPasswordNotifierHash,
      dependencies: <ProviderOrFamily>[authNotifierProvider],
      allTransitiveDependencies: <ProviderOrFamily>{
        authNotifierProvider,
        ...?authNotifierProvider.allTransitiveDependencies,
      },
    );

typedef _$RecoveryPasswordNotifier = AutoDisposeNotifier<RecoveryPasswordState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
