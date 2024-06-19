import 'package:go_router/go_router.dart';
import 'package:random_job/screens/screens.dart';
import 'package:random_job/screens/todo/todo.dart';
import 'package:random_job/services/services.dart';

class AppRouter {
  static GoRouter router = GoRouter(routes: [
    GoRoute(
      path: AuthGate.route(),
      builder: (context, state) => const AuthGate(),
    ),
    GoRoute(
      path: AccountingScreen.route(),
      builder: (context, state) => const AccountingScreen(),
    ),
    GoRoute(
      path: MapScreen.route(),
      builder: (context, state) => const MapScreen(),
    ),
    GoRoute(
      path: TodoScreen.route(),
      builder: (context, state) => const TodoScreen(),
    ),
    GoRoute(
      path: ChatScreen.route(),
      builder: (context, state) => const ChatScreen(),
    ),
    GoRoute(
      path: ProfileScreen.route(),
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: ChatUserWidget.route(),
      builder: (context, state) => ChatRoomWidget(
        userInfo: state.pathParameters["userInfo"]!,
      ),
    ),
    GoRoute(
      path: AccountingCategoryDetailScreen.route(),
      builder: (context, state) => AccountingCategoryDetailScreen(
        accountingcategoryType: AccountingCategoryType.fromString(
          state.pathParameters['categoryType']!,
        )!,
      ),
    ),
  ]);
}
