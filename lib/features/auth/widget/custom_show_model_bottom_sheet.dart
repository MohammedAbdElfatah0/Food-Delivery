import 'package:flutter/material.dart';
import 'package:food_delivery/core/Colors/color_manager.dart';
import 'package:food_delivery/core/router/contents_router.dart';
import 'package:food_delivery/core/service/firestore_type_service.dart';

class ForgotPasswordBottomSheet extends StatefulWidget {
  @override
  State<ForgotPasswordBottomSheet> createState() =>
      _ForgotPasswordBottomSheetState();
  final String titleEmail;
  final String? titlePhone;

  const ForgotPasswordBottomSheet({
    super.key,
    required this.titleEmail,
    this.titlePhone,
  });
}

class _ForgotPasswordBottomSheetState extends State<ForgotPasswordBottomSheet> {
  String selectedOption = "whatsapp"; // default selected option

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Forgot password?",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            "Select which contact details should we use to reset your password",
          ),
          SizedBox(height: 20),

          // WhatsApp Option
          GestureDetector(
            onTap: () {
              setState(() {
                selectedOption = "whatsapp";
              });
            },
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(
                  color:
                      selectedOption == "whatsapp"
                          ? ColorManager.primary
                          : ColorManager.grey,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.messenger, color: ColorManager.green),
                  SizedBox(width: 10),
                  Expanded(child: Text(widget.titlePhone ?? "No there phone")),
                  if (selectedOption == "whatsapp")
                    Icon(Icons.check_circle, color: ColorManager.primary),
                ],
              ),
            ),
          ),
          SizedBox(height: 12),

          // Email Option
          GestureDetector(
            onTap: () {
              setState(() {
                selectedOption = "email";
              });
            },
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(
                  color:
                      selectedOption == "email"
                          ? ColorManager.primary
                          : ColorManager.grey,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.email, color: ColorManager.blue),
                  SizedBox(width: 10),
                  Expanded(child: Text(widget.titleEmail)),
                  if (selectedOption == "email")
                    Icon(Icons.check_circle, color: ColorManager.primary),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),

          // Continue Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primary,
              minimumSize: Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              if (selectedOption == "whatsapp") {
                if (widget.titlePhone != null) {
                  Navigator.pushNamed(
                    context,
                    ContentsRouter.otpView,
                    arguments:
                        widget.titlePhone, //TODO:: give data from last screen
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("there is no phone number")),
                  );
                }
              } else {
                Navigator.pushNamed(
                  context,
                  ContentsRouter.otpView,
                  arguments:
                      widget.titleEmail, 
                );
              }
            },
            child: Text(
              "Continue",
              style: TextStyle(color: ColorManager.white),
            ),
          ),
        ],
      ),
    );
  }
}
