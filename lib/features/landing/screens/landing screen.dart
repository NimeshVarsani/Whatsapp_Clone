import 'package:flutter/material.dart';
import 'package:whatsapp_ui/colors.dart';
import 'package:whatsapp_ui/common/widgets/cusotm_button.dart';
import 'package:whatsapp_ui/features/auth/screens/login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50.0),
            const Text(
              'Welcome to Whatsapp',
              style: TextStyle(
                fontSize: 33,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: size.height/9),
            Center(child: Image.asset('assets/bg.png', height: 340, width: 340 ,color: tabColor,)),
            SizedBox(height: size.height/9,),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Read our Privacy Policy. Tap "Agree and Continue" to accept the terms of services',
                style: TextStyle(color: greyColor,),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10,),
            SizedBox(
              width: size.width * 0.75,
              child: CustomButton(
                  text: 'Agree and Continue',
                  onPressed: (){
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  }
              ),
            ),


          ],
        ),
      ),
    );
  }
}
