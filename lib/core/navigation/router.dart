import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/authentication/presentation/providers/auth_provider.dart';
import '../../features/authentication/presentation/screens/screens.dart';
import '../../features/registros/presentation/screens/screens.dart';
import '../../features/shared/presentation/screens/screens.dart';
import 'rutas.dart';

part 'router.g.dart';

final navigatorKey = GlobalKey<NavigatorState>();

@Riverpod(dependencies: [AuthNotifier])
GoRouter router(Ref ref) {
  final authNotifier = ref.watch(authNotifierProvider);
  //final user = authNotifier.value?.user;
  

  return GoRouter(
    navigatorKey: navigatorKey,
    // initialLocation: Rutas.userAccountExpired,
    initialLocation: Rutas.splash,
    routes: [
      GoRoute(
        path: Rutas.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: Rutas.login,
        pageBuilder:
            (context, state) => buildPageWithTransition(
              context: context,
              state: state,
              child: const LoginScreen(),
              transitionType: TransitionType.scale,
            ),
        routes: [
          GoRoute(
            path: Rutas.recoveryPassword,
            // path: 'recovery-password',
            pageBuilder:
                (context, state) => buildPageWithTransition(
                  context: context,
                  state: state,
                  child: const RecoveryPasswordScreen(),
                  transitionType: TransitionType.slideRight,
                ),
          ),
        ],
      ),
      GoRoute(
        path: Rutas.registros,
        pageBuilder: (context, state) {
          return buildPageWithTransition(
            context: context,
            state: state,
            child: const RegistrosScreen(),
            transitionType: TransitionType.slideRight,
          );
        },
      ),
      GoRoute(
        path: Rutas.newRecord,
        pageBuilder: (context, state) {
          return buildPageWithTransition(
            context: context,
            state: state,
            child: const NewRecordScreen(),
            transitionType: TransitionType.slideRight,
          );
        },
      ),
     
    ],
    redirect: (context, state) {
      final isGoingTo = state.matchedLocation;
      final status = authNotifier.value?.status;

      if ((isGoingTo == Rutas.splash || isGoingTo == Rutas.login) &&
          status == AuthStatus.authenticated) {
        
        return Rutas.registros;
      }
      if (status == AuthStatus.unauthenticated && isGoingTo != Rutas.login) {
        // if (isGoingTo == Rutas.recoveryPassword) {
        if (isGoingTo == '${Rutas.login}/${Rutas.recoveryPassword}') {
          return null;
        }
        return Rutas.login;
      }
      // entonces lo deja quieto para que siga a donde quiere ir
      return null; // si llega aqui, en éste momento es casi seguro que es un splash
    },
    errorBuilder: (context, state) => const ErrorScreen(),
  );
}

CustomTransitionPage<void> buildPageWithTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
  required TransitionType transitionType,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      switch (transitionType) {
        case TransitionType.fade:
          return FadeTransition(opacity: animation, child: child);
        case TransitionType.slideRight:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        // slideUp
        case TransitionType.slideUp:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        case TransitionType.scale:
          return ScaleTransition(scale: animation, child: child);
        case TransitionType.rotate:
          return RotationTransition(turns: animation, child: child);
        // default:
        //   return FadeTransition(opacity: animation, child: child);
      }
    },
  );
}

enum TransitionType { fade, slideRight, slideUp, scale, rotate }
