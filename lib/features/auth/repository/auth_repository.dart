import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/common/utils/utils.dart';
import 'package:whatsapp_ui/features/auth/screens/otp_screen.dart';
import 'package:whatsapp_ui/features/auth/screens/user_info_screen.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(auth: FirebaseAuth.instance, firebaseFirestore: FirebaseFirestore.instance));

class AuthRepository{
  final FirebaseAuth auth;
  final FirebaseFirestore firebaseFirestore;

  AuthRepository({required this.auth, required this.firebaseFirestore});

  void signInWithPhone(BuildContext context, String phoneNumber) async{

    try{
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async{
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (e){
          throw Exception(e.message);
        },
        codeSent: ((String verificationId, int? resendToken) async{
          Navigator.pushNamed(
              context,
              OtpScreen.routeName,
              arguments: verificationId,
          );
        }),
        codeAutoRetrievalTimeout: (String verificationId){}
      );
    } catch(e){
      showSnackBar(context: context, content: e.toString());
    }
  }

  void verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP,
  }) async {
     try{
       PhoneAuthCredential credential = PhoneAuthProvider.credential(
           verificationId: verificationId,
           smsCode: userOTP
       );
       await auth.signInWithCredential(credential);
       Navigator.pushNamedAndRemoveUntil(context, UserInformationScreen.routeName, (route) => false);

     }on FirebaseAuthException catch(e){
       showSnackBar(context: context, content: e.toString());
     }
  }

}