// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:quicknotes/core/constants/color_manager.dart';
// import 'package:quicknotes/presentration/common widget/custom_text_field.dart';
// import 'package:quicknotes/presentration/common widget/primary_button.dart';

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({super.key});

//   @override
//   State<SignupScreen> createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   final _formKey = GlobalKey<FormState>();

//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   bool isLoading = false;

//   Future<void> signUpUser(BuildContext context) async {
//     try {
//       setState(() => isLoading = true);

//       // 1. Firebase Auth e user create
//       UserCredential userCredential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(
//             email: emailController.text.trim(),
//             password: passwordController.text.trim(),
//           );

//       String uid = userCredential.user!.uid;

//       // 2. Firebase Auth e display name set
//       await userCredential.user!.updateDisplayName(nameController.text.trim());

//       // 3. Firestore e user data save
//       await FirebaseFirestore.instance.collection('users').doc(uid).set({
//         'name': nameController.text.trim(),
//         'email': emailController.text.trim(),
//         'uid': uid,
//         'createdAt': DateTime.now(),
//       });

//       setState(() => isLoading = false);

//       // 4. Success message
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Signup Successful ✅")));

//       // 5. Navigate (optional)
//       context.go('/home');
//     } on FirebaseAuthException catch (e) {
//       setState(() => isLoading = false);

//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text(e.message ?? "Signup Failed")));
//     }
//   }

//   @override
//   void dispose() {
//     nameController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Center(
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     "Register",
//                     style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//                   ),

//                   const SizedBox(height: 30),

//                   // NAME
//                   CustomTextField(
//                     hintText: "Your Name",
//                     keyboardType: TextInputType.name,
//                     controller: nameController,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Enter Name";
//                       }
//                       return null;
//                     },
//                   ),

//                   const SizedBox(height: 15),

//                   // EMAIL
//                   CustomTextField(
//                     hintText: "you@example.com",
//                     keyboardType: TextInputType.emailAddress,
//                     controller: emailController,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Enter email";
//                       }
//                       return null;
//                     },
//                   ),

//                   const SizedBox(height: 15),

//                   // PASSWORD
//                   CustomTextField(
//                     hintText: "Enter password",
//                     isPassword: true,
//                     controller: passwordController,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Enter password";
//                       }
//                       if (value.length < 6) {
//                         return "Password must be at least 6 characters";
//                       }
//                       return null;
//                     },
//                   ),

//                   const SizedBox(height: 25),

//                   // BUTTON
//                   // PrimaryButton(
//                   //   title: isLoading ? "Loading..." : "SignUp",
//                   //   onPressed: isLoading
//                   //       ? null
//                   //       : () {
//                   //           if (_formKey.currentState!.validate()) {
//                   //             signUpUser(context);
//                   //           }
//                   //         },
//                   // ),
//                   PrimaryButton(
//   title: isLoading ? "Loading..." : "SignUp",
//   onPressed: isLoading
//       ? null
//       : () async {
//           if (_formKey.currentState!.validate()) {
//             bool isSuccess = await signUpUser(context);

//             if (isSuccess) {
//               context.go('/signin'); // 🔥 use go, not push
//             }
//           }
//         },
// ),

//                   const SizedBox(height: 15),

//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Have an account?",
//                         style: TextStyle(
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.w300,
//                         ),
//                       ),
//                       SizedBox(width: 5.w),
//                       InkWell(
//                         onTap: () {
//                           context.push('/signin');
//                         },
//                         child: Text(
//                           "Login",
//                           style: TextStyle(
//                             color: ColorManager.primary,
//                             fontSize: 16.sp,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:quicknotes/core/constants/color_manager.dart';
import 'package:quicknotes/presentration/common widget/custom_text_field.dart';
import 'package:quicknotes/presentration/common widget/primary_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  // 🔥 FIXED → now returns bool
  Future<bool> signUpUser(BuildContext context) async {
    try {
      setState(() => isLoading = true);

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      String uid = userCredential.user!.uid;

      await userCredential.user!.updateDisplayName(nameController.text.trim());

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'uid': uid,
        'createdAt': DateTime.now(),
      });

      setState(() => isLoading = false);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Signup Successful ✅")));

      return true; // ✅ important
    } on FirebaseAuthException catch (e) {
      setState(() => isLoading = false);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? "Signup Failed")));

      return false; // ✅ important
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          // 🔥 prevent overflow
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // NAME
                    CustomTextField(
                      hintText: "Your Name",
                      keyboardType: TextInputType.name,
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Name";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

                    // EMAIL
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

                    // PASSWORD
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

                    // 🔥 BUTTON
                    PrimaryButton(
                      title: isLoading ? "Loading..." : "SignUp",
                      onPressed: isLoading
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                bool isSuccess = await signUpUser(context);

                                if (isSuccess) {
                                  context.go('/signin'); // ✅ correct
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
