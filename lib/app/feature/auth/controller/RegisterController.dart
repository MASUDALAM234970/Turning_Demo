import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turningdemo/App/routes/routes_name.dart';
import 'package:turningdemo/app/core/endpoint/api_client.dart';
import 'package:turningdemo/app/core/endpoint/api_endpoint.dart';

class RegisterControllers extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final isLoading = false.obs;

  final ApiClient _apiClient = ApiClient(baseUrl: ApiEndpoint.baseUrl);

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  Future<void> register() async {
    if (!formKey.currentState!.validate()) return;

    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (password != confirmPassword) {
      Get.snackbar("Error", "Passwords do not match");
      return;
    }

    isLoading.value = true;
    try {
      final res = await _apiClient.post(
        ApiEndpoint.signup,
        body: {
          "email": email,
          "password": password,
          "confirm_password": confirmPassword,
        },
      );


      if (res is! Map) {
        Get.snackbar("Error", "Unexpected server response");
        return;
      }

      final success = (res["success"] == true) || (res["status"] == true);
      final message = (res["message"] ?? "No message").toString();

      if (success) {
        Get.toNamed(RoutesName.login);
      } else {
        Get.snackbar("Error", message);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}