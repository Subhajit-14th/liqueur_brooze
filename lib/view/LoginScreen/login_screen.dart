import 'package:flutter/material.dart';
import 'package:liqueur_brooze/view/DashboardScreen/dashboard_screen.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/utlis/widgets/common_button.dart';
import 'package:liqueur_brooze/utlis/widgets/common_passwordfield.dart';
import 'package:liqueur_brooze/utlis/widgets/common_textfield.dart';
import 'package:liqueur_brooze/viewModel/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _emailController;
  late AnimationController _passwordController;
  late AnimationController _buttonController;
  late Animation<Offset> _emailAnimation;
  late Animation<Offset> _passwordAnimation;
  late Animation<Offset> _buttonAnimation;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();

    // Initialize controllers
    _emailController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _passwordController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    // Create slide animations
    _emailAnimation = Tween<Offset>(
      begin: const Offset(-1.5, 0), // Start off-screen (left)
      end: Offset.zero, // Move to its original position
    ).animate(CurvedAnimation(parent: _emailController, curve: Curves.easeOut));

    _passwordAnimation = Tween<Offset>(
      begin: const Offset(-1.5, 0), // Start off-screen (left)
      end: Offset.zero, // Move to its original position
    ).animate(
        CurvedAnimation(parent: _passwordController, curve: Curves.easeOut));

    _buttonAnimation = Tween<Offset>(
      begin: const Offset(0, 1.5), // Start off-screen (bottom)
      end: Offset.zero, // Move to its original position
    ).animate(
        CurvedAnimation(parent: _buttonController, curve: Curves.easeOut));

    // Delay animations for smooth effect
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() => _isVisible = true);
      _emailController.forward();
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      _passwordController.forward();
    });

    Future.delayed(const Duration(milliseconds: 700), () {
      _buttonController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height * 0.06),
            // Header with orange background
            Image.asset(
              'assets/app_logo/app_logo.png',
              scale: 2,
            ),

            /// Welcome Text
            RichText(
              text: TextSpan(
                text: 'Welcome! \n',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  fontFamily: 'Monserat',
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'to ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontFamily: 'Monserat',
                    ),
                  ),
                  TextSpan(
                    text: 'Liquor Brooze',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColor.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.05),

            /// Email Textfield
            SlideTransition(
              position: _emailAnimation,
              child: AnimatedOpacity(
                opacity: _isVisible ? 1.0 : 0.0,
                duration: const Duration(seconds: 2),
                child: CommonTextField(
                  controller: context.read<AuthProvider>().emailContoller,
                  hintText: 'Enter your email',
                  labelText: 'Email',
                ),
              ),
            ),
            const SizedBox(height: 20),

            /// Password Textfield
            SlideTransition(
              position: _passwordAnimation,
              child: AnimatedOpacity(
                opacity: _isVisible ? 1.0 : 0.0,
                duration: const Duration(seconds: 2),
                child: CommonPasswordField(
                  controller: context.read<AuthProvider>().passwordController,
                  hintText: 'Enter your password',
                  labelText: 'Password',
                ),
              ),
            ),
            SizedBox(height: height * 0.05),

            // Login Button
            SlideTransition(
              position: _buttonAnimation,
              child: AnimatedOpacity(
                opacity: _isVisible ? 1.0 : 0.0,
                duration: const Duration(seconds: 2),
                child: CommonButton(
                  buttonText: 'Login',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DashboardScreen()));
                  },
                  width: width / 1.4,
                  buttonColor: AppColor.secondaryColor,
                  borderRadius: 50,
                ),
              ),
            ),
            SizedBox(height: height * 0.02),

            /// I forgot my password button
            Text(
              'I forgot my password',
              style: TextStyle(
                color: AppColor.secondaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Dispose method
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _buttonController.dispose();
    super.dispose();
  }
}
