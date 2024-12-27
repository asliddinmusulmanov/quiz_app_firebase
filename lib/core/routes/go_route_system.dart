import 'package:go_router/go_router.dart';

import '../../data/models/auth_model.dart';
import '../../pages/departments/departments_page.dart';
import '../../pages/home/darajalar_menu.dart';
import '../../pages/home/natija_page.dart';
import '../../pages/home/savollar_page.dart';
import '../../pages/menu/menu.dart';
import '../../pages/mylevel/level_page.dart';
import '../../pages/profile/profile_edit_page.dart';
import '../../pages/reyting/reyting_page.dart';
import '../../pages/sign/login_page.dart';
import '../../pages/sign/otp_page.dart';
import '../../pages/sign/register_page.dart';
import '../../pages/sign/splash_page.dart';
import '../widgets/primary.dart';
import 'approutesname.dart';

final class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: AppRouteName.splash,
    routes: [
      ShellRoute(
        builder: (context, state, child) => Primary(child),
        routes: [
          GoRoute(
            path: AppRouteName.menu,
            builder: (context, state) => const MenuPage(),
            routes: [
              GoRoute(
                path: AppRouteName.department,
                builder: (context, state) {
                  final data = state.extra as Map<String, dynamic>?;
                  if (data == null) {
                    // Handle error or provide default values
                    return const Departments(
                        languagename: 'Default', languageimage: 'default.png');
                  }
                  return Departments(
                    languagename: data['languagename'] as String,
                    languageimage: data['languageimage'] as String,
                  );
                },
                routes: [
                  GoRoute(
                    path: AppRouteName.darajalar,
                    builder: (context, state) {
                      final extra = state.extra as Map<String, dynamic>?;
                      if (extra == null) {
                        // Handle error or provide default values
                        return const DarajalarMenu(
                            collectionpath: '', modul: 0, dars: 0);
                      }
                      return DarajalarMenu(
                        collectionpath: extra['collectionpath'] as String,
                        modul: extra['modul'] as int,
                        dars: extra['dars'] as int,
                      );
                    },
                    routes: [
                      GoRoute(
                        path: AppRouteName.savollar,
                        builder: (context, state) {
                          final extra = state.extra as Map<String, dynamic>?;
                          if (extra == null) {
                            // Handle error or provide default values
                            return const SavollarPage(questionLevel: 'Default');
                          }
                          return SavollarPage(
                            questionLevel: extra['questionLevel'] as String,
                          );
                        },
                        routes: [
                          GoRoute(
                            path: AppRouteName.natija,
                            builder: (context, state) {
                              final extra = state.extra
                                      as Map<String, dynamic>? ??
                                  {'correctAnswers': 0, 'incorrectAnswers': 0};
                              return NatijaPage(
                                correctAnswers: extra['correctAnswers'],
                                incorrectAnswers: extra['incorrectAnswers'],
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: AppRouteName.level,
            builder: (context, state) => const LevelPage(),
            routes: [
              GoRoute(
                path: AppRouteName.reyting,
                builder: (context, state) => const ReytingPage(),
              ),
            ],
          ),
          GoRoute(
            path: AppRouteName.profile,
            builder: (context, state) => const ProfileEditPage(),
          ),
        ],
      ),
      GoRoute(
        path: AppRouteName.splash,
        builder: (context, state) => const SplashPages(),
      ),
      GoRoute(
        path: AppRouteName.login,
        builder: (context, state) => const LoginPage(),
        routes: [
          GoRoute(
            path: AppRouteName.register,
            builder: (context, state) => const RegisterPage(),
            routes: [
              GoRoute(
                path: AppRouteName.otp,
                builder: (context, state) =>
                    VerifyAccount(authModel: state.extra as AuthModel),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
