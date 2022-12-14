import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/colors.dart';
import 'package:whatsapp_ui/common/utils/utils.dart';
import 'package:whatsapp_ui/common/widgets/cusotm_button.dart';
import 'package:whatsapp_ui/features/auth/controller/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phoneController = TextEditingController();
  Country? country;

  @override
  void dispose(){
    super.dispose();
    phoneController.dispose();
  }

  void pickCountry(){
    showCountryPicker(
      context: context,
      // showPhoneCode: true, // optional. Shows phone code before the country name.
      onSelect: (Country _country) {
        setState((){
          country = _country;
        });
      },
    );
  }

  void sendPhoneNumber(){
    String phoneNumber = phoneController.text.trim();
    if(country!=null && phoneNumber.isNotEmpty){
      const CircularProgressIndicator(
        backgroundColor: tabColor,
      );
      ref.read(authControllerProvider).signInWithPhone(context, '+${country!.phoneCode}$phoneNumber');
    }
    else{
      showSnackBar(context: context, content: 'Fill all the Details');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Enter your phone number'),
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10,),
            const Text(
              'WhatsApp will need to verify your phone number',
              style: TextStyle(),
            ),
            const SizedBox(height: 10,),
            TextButton(
                onPressed: (){
                  pickCountry();
                },

                child: const Text('Pick Country',
                style: TextStyle(color: Colors.blue),)
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                if(country!=null)
                  Text('${country!.countryCode}   +${country!.phoneCode}'),
                const SizedBox(width: 10,),
                SizedBox(
                  width: size.width * 0.7,
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    controller: phoneController,
                    decoration: const InputDecoration(
                      hintText: 'phone number',
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: size.height*0.55),
            SizedBox(
              width: 100,
              child: CustomButton(
                text: 'NEXT',
                onPressed: sendPhoneNumber,
              ),
            ),
          ],
        ),
      ),

    );
  }
}