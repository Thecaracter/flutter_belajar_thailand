import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../modules/artikebookmark/bindings/artikebookmark_binding.dart';
import '../modules/artikebookmark/views/artikebookmark_view.dart';
import '../modules/bacaArtikel/bindings/baca_artikel_binding.dart';
import '../modules/bacaArtikel/views/baca_artikel_view.dart';
import '../modules/book/bindings/book_binding.dart';
import '../modules/book/views/book_view.dart';
import '../modules/bottomNavBar/bindings/bottom_nav_bar_binding.dart';
import '../modules/bottomNavBar/views/bottom_nav_bar_view.dart';
import '../modules/forgotPassword/bindings/change_password_binding.dart';
import '../modules/forgotPassword/bindings/check_otp_binding.dart';
import '../modules/forgotPassword/bindings/forgot_password_binding.dart';
import '../modules/forgotPassword/views/change_password_view.dart';
import '../modules/forgotPassword/views/check_otp_view.dart';
import '../modules/forgotPassword/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/lesson/bindings/lesson_binding.dart';
import '../modules/lesson/views/lesson_view.dart';
import '../modules/lessonList/bindings/lesson_list_binding.dart';
import '../modules/lessonList/views/lesson_list_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/utils/constant_color.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: Routes.BOTTOM_NAV_BAR,
      page: () => Container(
        color: ConstanColor.primaryColor,
        child: const BottomNavBarView(),
      ),
      binding: BottomNavBarBinding(),
    ),
    GetPage(
      name: _Paths.BACA_ARTIKEL,
      page: () => const BacaArtikelView(),
      binding: BacaArtikelBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: Routes.CHECK_OTP,
      page: () => const CheckOtpView(),
      binding: CheckOtpBinding(),
    ),
    GetPage(
      name: Routes.CHANGE_PASSWORD,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.BOOK,
      page: () => const BookView(),
      binding: BookBinding(),
    ),
    GetPage(
      name: _Paths.ARTIKEBOOKMARK,
      page: () => const ArtikelBookmarkView(),
      binding: ArtikebookmarkBinding(),
    ),
    GetPage(
      name: _Paths.LESSON,
      page: () => const LessonView(),
      binding: LessonBinding(),
    ),
    GetPage(
      name: _Paths.LESSON_LIST,
      page: () => const LessonListView(),
      binding: LessonListBinding(),
    ),
  ];
}
