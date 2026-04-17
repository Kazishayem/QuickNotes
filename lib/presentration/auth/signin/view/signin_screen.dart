// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:quicknotes/core/constants/color_manager.dart';
// import 'package:quicknotes/presentration/common widget/custom_text_field.dart';
// import 'package:quicknotes/presentration/common widget/primary_button.dart';

// class SigninScreen extends StatefulWidget {
//   const SigninScreen({super.key});

//   @override
//   State<SigninScreen> createState() => _SigninScreenState();
// }

// class _SigninScreenState extends State<SigninScreen> {
//   final _formKey = GlobalKey<FormState>();

//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   bool isLoading = false;

//   // 🔥 LOGIN FUNCTION
//   Future<bool> signinUser() async {
//     try {
//       setState(() => isLoading = true);

//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: emailController.text.trim(),
//         password: passwordController.text.trim(),
//       );

//       setState(() => isLoading = false);

//       return true;
//     } on FirebaseAuthException catch (e) {
//       setState(() => isLoading = false);

//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text(e.message ?? "Login Failed")));

//       return false;
//     }
//   }

//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           // 🔥 overflow safe
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Center(
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       "Login",
//                       style: TextStyle(
//                         fontSize: 28,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),

//                     const SizedBox(height: 30),

//                     // EMAIL
//                     CustomTextField(
//                       hintText: "you@example.com",
//                       keyboardType: TextInputType.emailAddress,
//                       controller: emailController,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return "Enter email";
//                         }
//                         return null;
//                       },
//                     ),

//                     const SizedBox(height: 15),

//                     // PASSWORD
//                     CustomTextField(
//                       hintText: "Enter password",
//                       isPassword: true,
//                       controller: passwordController,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return "Enter password";
//                         }
//                         if (value.length < 6) {
//                           return "Minimum 6 characters";
//                         }
//                         return null;
//                       },
//                     ),

//                     const SizedBox(height: 25),

//                     // 🔥 LOGIN BUTTON
//                     PrimaryButton(
//                       title: isLoading ? "Loading..." : "Login",
//                       onPressed: isLoading
//                           ? null
//                           : () async {
//                               if (_formKey.currentState!.validate()) {
//                                 bool isSuccess = await signinUser();

//                                 if (isSuccess) {
//                                   context.go('/notes'); // ✅ correct
//                                 }
//                               }
//                             },
//                     ),

//                     const SizedBox(height: 15),

//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Don't have an account?",
//                           style: TextStyle(
//                             fontSize: 16.sp,
//                             fontWeight: FontWeight.w300,
//                           ),
//                         ),
//                         SizedBox(width: 5.w),
//                         InkWell(
//                           onTap: () {
//                             context.push('/signup');
//                           },
//                           child: Text(
//                             "Register",
//                             style: TextStyle(
//                               color: ColorManager.primary,
//                               fontSize: 16.sp,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quicknotes/core/constants/color_manager.dart';
import 'package:quicknotes/presentration/auth/viewmodel/auth_viewmodel.dart';
import 'package:quicknotes/presentration/common widget/custom_text_field.dart';
import 'package:quicknotes/presentration/common widget/primary_button.dart';

class SigninScreen extends HookConsumerWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
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
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 30),

                    CustomTextField(
                      hintText: "you@example.com",
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
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
                      title: isLoading ? "Loading..." : "Login",
                      onPressed: isLoading
                          ? null
                          : () async {
                              if (formKey.currentState!.validate()) {
                                bool isSuccess = await ref
                                    .read(authViewModelProvider.notifier)
                                    .signIn(
                                      emailController.text.trim(),
                                      passwordController.text.trim(),
                                    );

                                if (isSuccess) {
                                  context.go('/notes');
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Login Failed"),
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
                          "Don't have an account?",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        InkWell(
                          onTap: () {
                            context.push('/signup');
                          },
                          child: Text(
                            "Register",
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
