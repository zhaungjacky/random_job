import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_job/firebase_options.dart';
import 'package:random_job/screens/auth/bloc/auth_bloc.dart';
import 'package:random_job/services/router/app_router.dart';
import 'package:random_job/services/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initSingleTon();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => singleton<AuthBloc>(),
      ),
      BlocProvider(
        create: (context) => singleton<ThemeBloc>()
          ..add(
            InitialThemeEvent(),
          ),
      ),
      BlocProvider(
        create: (context) => singleton<AccountingBloc>(),
      ),
      BlocProvider(
        create: (context) => singleton<TodoBloc>(),
      ),
      BlocProvider(
        create: (context) => singleton<UserChatBloc>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp.router(
          title: 'Random walk',
          debugShowCheckedModeBanner: false,
          theme: state.mode,
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
