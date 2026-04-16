// import 'package:flutter/material.dart';
// import 'package:quicknotes/core/constants/color_manager.dart';

// class CustomTextField extends StatefulWidget {
//   final String hintText;
//   final TextEditingController? controller;
//   final TextInputType keyboardType;
//   final bool isPassword;
//   final String? Function(String?)? validator;
//   final double? width;

//   const CustomTextField({
//     super.key,
//     required this.hintText,
//     this.controller,
//     this.keyboardType = TextInputType.text,
//     this.isPassword = false,
//     this.validator,
//     this.width,
//   });

//   @override
//   State<CustomTextField> createState() => _CustomTextFieldState();
// }

// class _CustomTextFieldState extends State<CustomTextField> {
//   bool obscureText = true;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: widget.width ?? double.infinity, // ✅ width control
//       child: TextFormField(
//         controller: widget.controller,
//         keyboardType: widget.keyboardType,
//         obscureText: widget.isPassword ? obscureText : false,
//         validator: widget.validator,

//         decoration: InputDecoration(
//           hintText: widget.hintText,

//           contentPadding: const EdgeInsets.symmetric(
//             vertical: 14,
//             horizontal: 12,
//           ),

//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide(color: ColorManager.grey, width: 1),
//           ),

//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide(color: ColorManager.second, width: 2),
//           ),

//           errorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: const BorderSide(color: Colors.red),
//           ),

//           focusedErrorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: const BorderSide(color: Colors.red, width: 2),
//           ),

//           suffixIcon: widget.isPassword
//               ? IconButton(
//                   icon: Icon(
//                     obscureText ? Icons.visibility_off : Icons.visibility,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       obscureText = !obscureText;
//                     });
//                   },
//                 )
//               : null,
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:quicknotes/core/constants/color_manager.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool isPassword;
  final String? Function(String?)? validator;
  final double? width;

  // 🔥 NEW
  final int maxLines;
  final int minLines;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.validator,
    this.width,
    this.maxLines = 1,
    this.minLines = 1,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? double.infinity,
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,

        obscureText: widget.isPassword ? obscureText : false,

        maxLines: widget.isPassword ? 1 : widget.maxLines,
        minLines: widget.minLines,

        validator: widget.validator,

        decoration: InputDecoration(
          hintText: widget.hintText,

          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 12,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ColorManager.grey, width: 1),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ColorManager.second, width: 2),
          ),

          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red),
          ),

          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),

          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
