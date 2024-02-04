import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_v7/layout/default_layout.dart';
import 'package:go_router_v7/route/router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: ListView(
        children: [
          Text('Login State: ${authstate}'),
          ElevatedButton(
            onPressed: () {
              setState(() {
                authstate = !authstate;
              });
            },
            child: Text(authstate ? 'logout' : 'login'),
          ),
          ElevatedButton(
            onPressed: () {
              if(GoRouterState.of(context).location == '/login'){
                context.go('/login/private');
              } else{
                context.go('/login2/private');
              }
            },
            child: Text('Go to private Route'),
          ),
        ],
      ),
    );
  }
}
