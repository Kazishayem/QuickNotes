import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quicknotes/core/constants/color_manager.dart';
import 'package:quicknotes/presentration/auth/viewmodel/auth_viewmodel.dart';
import 'package:quicknotes/presentration/common widget/custom_text_field.dart';
import 'package:quicknotes/presentration/common widget/primary_button.dart';

class SignupScreen extends HookConsumerWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isLoading = ref.watch(authViewModelProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 50.h),
                    const Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 30),

                    CustomTextField(
                      hintText: "Your Name",
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Name";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

                    CustomTextField(
                      hintText: "you@example.com",
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter email";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

                    CustomTextField(
                      hintText: "Enter password",
                      isPassword: true,
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter password";
                        }
                        if (value.length < 6) {
                          return "Minimum 6 characters";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 25),

                    PrimaryButton(
                      title: isLoading ? "Loading..." : "SignUp",
                      onPressed: isLoading
                          ? null
                          : () async {
                              if (formKey.currentState!.validate()) {
                                bool isSuccess = await ref
                                    .read(authViewModelProvider.notifier)
                                    .signUp(
                                      nameController.text.trim(),
                                      emailController.text.trim(),
                                      passwordController.text.trim(),
                                    );

                                if (isSuccess) {
                                  if (!context.mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Signup Successful ✅"),
                                    ),
                                  );
                                  if (!context.mounted) return;
                                  context.go('/signin');
                                } else {
                                  if (!context.mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Signup Failed"),
                                    ),
                                  );
                                }
                              }
                            },
                    ),

                    const SizedBox(height: 15),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Have an account?",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        InkWell(
                          onTap: () {
                            context.push('/signin');
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: ColorManager.primary,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
