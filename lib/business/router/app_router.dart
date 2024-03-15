import 'package:go_router/go_router.dart';
import 'package:loveguru_ai/presentation/pages/ai_guru_choice_screen.dart';
import 'package:loveguru_ai/presentation/pages/chat_screen.dart';
import 'package:loveguru_ai/presentation/pages/guru_details_screen.dart';
import 'package:loveguru_ai/presentation/pages/name_screen.dart';
import 'package:loveguru_ai/presentation/pages/splash_screen.dart';

class AppRouter{
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/name',
        builder: (context, state) =>  NameScreen(),
      ),
      GoRoute(
        path: '/choice',
        builder: (context, state) => const AIGuruChoiceScreen(),
      ),
       GoRoute(
        path: '/guru',
        builder: (context, state) => const GuruDetailsScreen(),
      ),
      GoRoute(
        path: '/chat',
        builder: (context, state) => const ChatScreen(),
      ),
      
    ],
  );
}