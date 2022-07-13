import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pinmetar_app/api/api_component.dart';
import 'package:pinmetar_app/helper/shar_pref.dart';
import 'package:pinmetar_app/model/user_model.dart';
import 'package:pinmetar_app/model/user_profile_model.dart';
import 'package:pinmetar_app/repository/user_repository.dart' as user;
import 'package:pinmetar_app/screen/home/bottom_navigation_bar.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

class UserController extends ControllerMVC {
  late GlobalKey<ScaffoldState> scaffoldKey;
  late GlobalKey<FormState> formKey;

  UserDataModel userDataModel = UserDataModel();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();




  UserController() {
    formKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void loginApi(BuildContext context,
      {String? name,
      String? mobile,
      int? signupWith,
      String? signupId,
      String? deviceId,String? email}) async {
    FocusScope.of(context).unfocus();
    //if (formKey.currentState!.validate()) {
    // formKey.currentState!.save();
    showLoader();
    user
        .loginRep(
            name: name,
            mobile: mobile,
            deviceId: deviceId,
            signupId: signupId,
            signupWith: signupWith,
    email:email)
        .then((value) {
      if (value != null) {
        if (value.success == 1) {
          setState(() {
            userDataModel = value.data!;
          });
          Shared_Preferences.prefSetString(
              Shared_Preferences.keyApiToken, value.data!.apiToken.toString());
          Shared_Preferences.prefSetString(Shared_Preferences.keyUserData,
              jsonEncode(value.data).toString());
          showToast(value.message.toString());

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CustomBottomNavigationBar(4)));
        } else {
          showToast(value.message.toString());
        }
      }
    }).catchError((e) {
      hideLoader();
      print('catchError ->${e.toString()}');
    }).whenComplete(() {
      hideLoader();
    });
    // }
  }






  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User? user = authResult.user;
    late String name;
    late String email;
    late String imageUrl;

    if (user != null) {
      // Checking if email and name is null
      assert(user.email != null);
      assert(user.displayName != null);
      assert(user.photoURL != null);

      name = user.displayName!;
      email = user.email!;
      imageUrl = user.photoURL!;

      // Only taking the first part of the name, i.e., First Name
      if (name.contains(" ")) {
        name = name.substring(0, name.indexOf(" "));
      }

      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User? currentUser = _auth.currentUser;
      assert(user.uid == currentUser!.uid);
      print('signInWithGoogle succeeded: $user');
      print('signInWithGoogle succeeded: ${user.uid}');
      return user;
    }
    return null;
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();

    print("User Signed Out");
  }


  Future<UserCredential?> signInWithFacebook() async {
    try{
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    }catch(e){
      print('fbfbfbbfbbfbfbbfbf  ${e}');
    }
  }

  final _firebaseAuth = FirebaseAuth.instance;

  Future<User> signInWithApple({List<Scope> scopes = const []}) async {
    // 1. perform the sign-in request
    final result = await TheAppleSignIn.performRequests(
        [AppleIdRequest(requestedScopes: scopes)]);
    // 2. check the result
    switch (result.status) {
      case AuthorizationStatus.authorized:
        final appleIdCredential = result.credential!;
        final oAuthProvider = OAuthProvider('apple.com');
        final credential = oAuthProvider.credential(
          idToken: String.fromCharCodes(appleIdCredential.identityToken!),
          accessToken:
          String.fromCharCodes(appleIdCredential.authorizationCode!),
        );
        final userCredential =
        await _firebaseAuth.signInWithCredential(credential);
        final firebaseUser = userCredential.user!;
        if (scopes.contains(Scope.fullName)) {
          final fullName = appleIdCredential.fullName;
          if (fullName != null &&
              fullName.givenName != null &&
              fullName.familyName != null) {
            final displayName = '${fullName.givenName} ${fullName.familyName}';
            await firebaseUser.updateDisplayName(displayName);
          }
        }
        return firebaseUser;
      case AuthorizationStatus.error:
        throw PlatformException(
          code: 'ERROR_AUTHORIZATION_DENIED',
          message: result.error.toString(),
        );

      case AuthorizationStatus.cancelled:
        throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      default:
        throw UnimplementedError();
    }
  }
}
