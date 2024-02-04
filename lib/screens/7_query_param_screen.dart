import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_v7/layout/default_layout.dart';

class QueryParamScreen extends StatelessWidget {
  const QueryParamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: ListView(
        children: [
          Text('Query Parameter: ${GoRouterState.of(context).queryParameters}'),
          //query-parameter?utm=google&source=123
          ElevatedButton(
            onPressed: () {
              context.push(
                Uri(
                  path: '/query_param',
                  queryParameters: {
                    'name': 'jia',
                    'age': '26',
                  }
                ).toString(),
              );
            },
            child: Text('Query Parameter'),
          ),
        ],
      ),
    );
  }
}
