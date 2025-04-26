import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutech/screens/home_page.dart';
import 'package:flutech/screens/project_detail_page.dart';
import 'package:flutech/data/projects_data.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const HomePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          maintainState: true,
        );
      },
    ),
    GoRoute(
      path: '/project/:index',
      pageBuilder: (context, state) {
        // URL'den index alınır
        final indexStr = state.pathParameters['index'];
        final index = int.tryParse(indexStr ?? '0') ?? 0;

        // Geçersiz index kontrolü
        if (index < 0 || index >= projectsData.length) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: Scaffold(
              body: Center(
                child: Text('Proje bulunamadı: $indexStr'),
              ),
            ),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          );
        }

        // Projeye erişim
        final project = Project.fromJson(projectsData[index]);
        return CustomTransitionPage(
          key: state.pageKey,
          child: ProjectDetailPage(project: project, index: index),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          maintainState: true,
        );
      },
    ),
  ],
  navigatorKey: GlobalKey<NavigatorState>(),
  routerNeglect: true,
  debugLogDiagnostics: true,
  restorationScopeId: 'router',
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Sayfa bulunamadı: ${state.uri.path}'),
    ),
  ),
);
