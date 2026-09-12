import 'package:go_router/go_router.dart';

import '../../features/starter/presentation/screens/starter_screen.dart';
import 'app_routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.root,
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutes.root,
      name: 'starter',
      builder: (context, state) => const StarterScreen(),
    ),
  ],
);
