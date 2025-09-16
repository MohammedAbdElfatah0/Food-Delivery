import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery/core/contents/text_string.dart';
import 'package:food_delivery/features/auth/presentation/widget/custom_app_bar.dart';
import 'package:food_delivery/features/auth/presentation/widget/custom_button_auth.dart';
import 'package:food_delivery/features/auth/presentation/widget/custom_header_auth.dart';
import '../../../../core/router/contents_router.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> with SingleTickerProviderStateMixin {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  String _otpCode = '';
  bool _isCorrect = false;
  bool _isError = false;

  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  // Timer variables
  int _secondsRemaining = 60;
  bool _canResend = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.stop();
      }
    });
    // Start timer
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _canResend = true;
        });
        _timer.cancel();
      }
    });
  }

  void _resendOTP() {
    if (_canResend) {
      setState(() {
        _secondsRemaining = 60;
        _canResend = false;
      });
      _startTimer();
      // Add your API call or logic to resend OTP here
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('OTP Resent!')));
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    _animationController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _verifyOTP() {
    _otpCode = _controllers.map((c) => c.text).join();
    if (_otpCode == '9627') {
      setState(() {
        _isCorrect = true;
        _isError = false;
      });
      _animationController.forward(from: 0.0);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('OTP Verified!')));
      Future.delayed(Duration(milliseconds: 1200), () {
        Navigator.pushReplacementNamed(context, ContentsRouter.resetPassword);
      });
    } else {
      setState(() {
        _isCorrect = false;
        _isError = true;
      });
      _animationController.stop();
      HapticFeedback.vibrate();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Invalid OTP')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final String email = ModalRoute.of(context)!.settings.arguments as String;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double fieldWidth = screenWidth * 0.12;
    final double paddingHorizontal = screenWidth * 0.05;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: paddingHorizontal,
            vertical: 32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(text: TextString.submit),
              CustomHeaderAuth(
                text: TextString.emailVerify,
                subText: "${TextString.subEmailVerify} \n$email",
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return ScaleTransition(
                    scale:
                        _isCorrect
                            ? _scaleAnimation
                            : AlwaysStoppedAnimation(1.0),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              _isError
                                  ? Colors.red
                                  : (_isCorrect ? Colors.green : Colors.grey),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SizedBox(
                        width: fieldWidth,
                        child: TextField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          decoration: InputDecoration(
                            counterText: '',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            if (value.length == 1 && index < 3) {
                              FocusScope.of(
                                context,
                              ).requestFocus(_focusNodes[index + 1]);
                            } else if (value.isEmpty && index > 0) {
                              FocusScope.of(
                                context,
                              ).requestFocus(_focusNodes[index - 1]);
                            }
                          },
                        ),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 20),
              // Timer and Resend OTP
              if (!_canResend)
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Resend OTP in ${_secondsRemaining}s',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              if (_canResend)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Center(
                    child: GestureDetector(
                      onTap: _resendOTP,
                      child: Text(
                        'Resend OTP',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ),
              // CustomButtonAuth
              Center(
                child: CustomButtonAuth(
                  onTap: _verifyOTP,
                  text: TextString.verifyAccount,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
