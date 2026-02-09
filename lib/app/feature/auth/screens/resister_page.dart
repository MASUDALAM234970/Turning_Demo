import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/RegisterController.dart';

class ResisterPage extends StatelessWidget {
  ResisterPage({super.key});

  final c = Get.put(RegisterControllers());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff74efe1),
      appBar: AppBar(
        elevation: 10,
        title: const Text("Nothing"),
        centerTitle: true,

        backgroundColor: Color(0xffe8ada3),
      ),
      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Form(
            key: c.formKey,
            child: Column(

              children: [
                TextFormField(
                  controller: c.emailController,
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: "Enter Email here",
                    hintText: "example@gmail.com",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? "Email required" : null,
                ),
                const SizedBox(height: 10),

                TextFormField(
                  controller: c.passwordController,
                  // obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: "Enter password here",
                    hintText: "123456",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty)
                      return "Password required";
                    if (v.length < 6) return "Min 6 characters";
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                TextFormField(
                  controller: c.confirmPasswordController,
                  // obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: "Enter Re-Password",
                    hintText: "Re type Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty)
                      return "Confirm password required";
                    if (v != c.passwordController.text)
                      return "Passwords not match";
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                Obx(
                  () => ElevatedButton(
                    onPressed: c.isLoading.value ? null : c.register,
                    child: Text(
                      c.isLoading.value ? "Loading..." : "Create Account",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
