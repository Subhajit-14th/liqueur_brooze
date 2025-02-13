import 'package:flutter/material.dart';
import 'package:liqueur_brooze/dashboard_screen.dart';
import 'package:liqueur_brooze/utlis/assets/app_colors.dart';
import 'package:liqueur_brooze/utlis/widgets/common_button.dart';
import 'package:liqueur_brooze/utlis/widgets/common_passwordfield.dart';
import 'package:liqueur_brooze/utlis/widgets/common_textfield.dart';
import 'package:liqueur_brooze/viewModel/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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

            CommonTextField(
              controller: context.read<AuthProvider>().emailContoller,
              hintText: 'Enter your email',
              labelText: 'Email',
            ),
            const SizedBox(height: 20),
            CommonPasswordField(
              controller: context.read<AuthProvider>().passwordController,
              hintText: 'Enter your password',
              labelText: 'Password',
            ),
            SizedBox(height: height * 0.05),

            // Login Button
            CommonButton(
              buttonText: 'Login',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DashboardScreen()));
              },
              width: width / 1.4,
              buttonColor: AppColor.secondaryColor,
              borderRadius: 50,
            ),
            SizedBox(height: height * 0.02),
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
}
