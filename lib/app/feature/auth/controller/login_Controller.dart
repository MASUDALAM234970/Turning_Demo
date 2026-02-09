import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turningdemo/App/routes/routes_name.dart';
import 'package:turningdemo/app/core/const/app_notification.dart';
import 'package:turningdemo/app/core/endpoint/api_client.dart';
import 'package:turningdemo/app/core/endpoint/api_endpoint.dart';
import 'package:turningdemo/app/core/local_storage/user_info.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final isLoading = false.obs;

  final ApiClient _apiClient = ApiClient(baseUrl: ApiEndpoint.baseUrl);

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    isLoading.value = true;

    try {
      final response = await _apiClient.post(
        ApiEndpoint.signin,
        body: {"email": email, "password": password},
      );

      if (response is! Map) {
        AppNotification.error("Unexpected response");
        return;
      }

      final data = response['data'];
      final tokens = (data is Map) ? data['tokens'] : null;

      final accessToken = (tokens is Map) ? tokens['access'] : null;
      final refreshToken = (tokens is Map) ? tokens['refresh'] : null;

      if (accessToken == null || refreshToken == null) {
        AppNotification.error("Tokens missing in response");
        return;
      }

      await UserInfo.setAccessToken(accessToken.toString());
      await UserInfo.setRefreshToken(refreshToken.toString());

      final profile = (data is Map) ? data['profile'] : null;
      final onboardingCompleted = (profile is Map)
          ? (profile['onboarding_completed'] ?? false)
          : false;

      //    await UserInfo.setOnboardingCompleted(onboardingCompleted == true);

      Get.toNamed(RoutesName.home);
    } catch (e) {
      AppNotification.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
