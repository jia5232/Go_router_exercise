import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_v7/screens/10_transition_screen_1.dart';
import 'package:go_router_v7/screens/10_transition_screen_2.dart';
import 'package:go_router_v7/screens/11_error_screen.dart';
import 'package:go_router_v7/screens/1_basic_screen.dart';
import 'package:go_router_v7/screens/2_named_screen.dart';
import 'package:go_router_v7/screens/3_push_screen.dart';
import 'package:go_router_v7/screens/4_pop_base_screen.dart';
import 'package:go_router_v7/screens/5_pop_return_screen.dart';
import 'package:go_router_v7/screens/6_path_param_screen.dart';
import 'package:go_router_v7/screens/7_query_param_screen.dart';
import 'package:go_router_v7/screens/8_nested_child_screen.dart';
import 'package:go_router_v7/screens/8_nested_screen.dart';
import 'package:go_router_v7/screens/9_login_screen.dart';
import 'package:go_router_v7/screens/9_private_screen.dart';
import 'package:go_router_v7/screens/root_screen.dart';

// 로그인이 됐는지 여부
bool authstate = false;

final router = GoRouter(
  // 1. Global level Redirect
  redirect: (context, state) {
    // return path(String값) -> 해당 라우트로 이동한다.
    // return null -> 원래 이동하려던 라우트로 이동한다.
    if (state.location == '/login/private' && !authstate) {
      // 이동하려던 위치가 '/login/private'이고 로그인이 안된 상태면 '/login'으로 이동
      return '/login';
    }
    return null; // 그렇지 않으면 이동하려던 곳으로 이동해라.
  },

  // 에러
  errorBuilder: (context, state){
    return ErrorScreen(error: state.error.toString());
  },

  // 로그 확인 옵션
  debugLogDiagnostics: true,

  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return RootScreen();
      },
      routes: [
        GoRoute(
            path: 'basic',
            builder: (context, state) {
              return BasicScreen();
            }),
        GoRoute(
            path: 'named',
            name: 'named_screen',
            builder: (context, state) {
              return NamedScreen();
            }),
        GoRoute(
          path: 'push',
          builder: (context, state) {
            return PushScreen();
          },
        ),
        GoRoute(
          path: 'pop',
          builder: (context, state) {
            return PopBaseScreen();
          },
          routes: [
            GoRoute(
                path: 'return',
                builder: (context, state) {
                  return PopReturnScreen();
                }),
          ],
        ),
        GoRoute(
          path: 'path_param/:id', // 뒤에 오는 값들을 id 변수로 받아서 사용
          builder: (context, state) {
            return PathParamScreen();
          },
          routes: [
            GoRoute(
                path: ':name',
                builder: (context, state) {
                  return PathParamScreen();
                }),
          ],
        ),
        GoRoute(
          path: 'query_param',
          builder: (context, state) {
            return QueryParamScreen();
          },
        ),
        ShellRoute(
          builder: (context, state, child) {
            return NestedScreen(child: child);
          },
          routes: [
            GoRoute(
              path: 'nested/a',
              builder: (_, state) => NestedChildScreen(
                routeName: 'nested/a',
              ),
            ),
            GoRoute(
              path: 'nested/b',
              builder: (_, state) => NestedChildScreen(
                routeName: 'nested/b',
              ),
            ),
            GoRoute(
              path: 'nested/c',
              builder: (_, state) => NestedChildScreen(
                routeName: 'nested/c',
              ),
            ),
          ],
        ),
        GoRoute(
          path: 'login',
          builder: (_, state) => LoginScreen(),
          routes: [
            GoRoute(
              path: 'private',
              builder: (_, state) => PrivateScreen(),
            ),
          ],
        ),
        GoRoute(
          path: 'login2',
          builder: (_, state) => LoginScreen(),
          routes: [
            GoRoute(
                path: 'private',
                builder: (_, state) => PrivateScreen(),
                // 2. Route level redirect
                redirect: (context, state) {
                  if (!authstate) {
                    return '/login2';
                  }
                  return null;
                }),
          ],
        ),
        GoRoute(
          path: 'transition',
          builder: (_, state) => TransitionScreenOne(),
          routes: [
            GoRoute(
              path: 'detail',
              // builder: (_, state) => TransitionScreenTwo(),
              // builder 대신 pageBuilder로 애니메이션 효과 가능.
              pageBuilder: (_, state) => CustomTransitionPage(
                child: TransitionScreenTwo(),
                transitionDuration: Duration(seconds: 1),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  // FadeTransition, ScaleTransition, RotationTransition ...
                  return FadeTransition(
                    opacity: animation, // 0->1
                    child: child,
                  );
                },
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
