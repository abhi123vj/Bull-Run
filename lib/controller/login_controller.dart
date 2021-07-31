import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  var _googleSignin = GoogleSignIn();
  var googleAccount = Rx<GoogleSignInAccount?>(null);
  @override
  void onInit() async {
    print("object");
    googleAccount.value = await _googleSignin.signInSilently();
    super.onInit();
  }

  Future login() async {
 
      googleAccount.value = await _googleSignin.signIn();
  }

  Future logout() async {
    googleAccount.value = await _googleSignin.signOut();
  }
}
