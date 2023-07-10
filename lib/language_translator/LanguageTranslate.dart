import 'package:get/get.dart';

class LocalString extends Translations {
  /*Sign In Page*/
  String SIGN_IN = "Sign in";
  String ENTER_USER_EMAIL = "Enter your username/email";
  String HINT_ENTER_USER_EMAIL = "Enter Email ID/User Id";
  String Enter_Password = "Enter your Password";
  String HINT_ENTER_Password = "Enter Password";
  String Forgot_Password = "Forgot password?";
  String Create_New_One = "Create a new one";
  String Dont_have_an_account = "Don’t have an account?";
  String Sign_UP = "Sign up";

  /*Sign In Page Validation text*/
  String Required_Email_or_Username = "Required Email or Username";
  String Required_Password = "Required Password";

  /*Create an Account Screen*/
  String I_Patinet = "I'm a patient";

  String I_Doctor = "I'm a doctor";

  String I_Center = "I'm a center";

  String Create_An_Account = "Create an account";

  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          /*Sign IN Page*/
          SIGN_IN: "Sign in",
          ENTER_USER_EMAIL: "Enter your username/email",
          HINT_ENTER_USER_EMAIL: "Enter Email ID/User Id",
          Enter_Password: "Enter your Password",
          HINT_ENTER_Password: "Enter Password",
          Forgot_Password: "Forgot password?",
          Create_New_One: "Create a new one",
          Dont_have_an_account: "Don’t have an account?",
          Sign_UP: "Sign up",
          Required_Email_or_Username: "Required Email or Username",
          Required_Password: "Required Password",

          /*Create an Account Screen*/
          I_Patinet: "I'm a patient",
          I_Doctor: "I'm a doctor",
          I_Center: "I'm a center",
          Create_An_Account: "Create an account",
        },
        'it_IT': {
          /*Sign IN Page*/
          SIGN_IN: "Registrazione",
          ENTER_USER_EMAIL: "Inserisci il tuo nome utente/e-mail",
          HINT_ENTER_USER_EMAIL: "Inserisci ID e-mail/ID utente",
          Enter_Password: "Inserisci la tua password",
          HINT_ENTER_Password: "Inserire la password",
          Forgot_Password: "Ha dimenticato la password?",
          Create_New_One: "Creane uno nuovo",
          Dont_have_an_account: "Non hai un account?",
          Sign_UP: "Iscrizione",
          Required_Email_or_Username: "Email o nome utente obbligatori",
          Required_Password: "Password obbligatoria",

          /*Create an Account Screen*/
          I_Patinet: "Sono un paziente",
          I_Doctor: "sono un medico",
          I_Center: "sono un centro",
          Create_An_Account: "Creare un account",
        },
      };
}
