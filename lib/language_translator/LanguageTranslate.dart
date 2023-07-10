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

  String Enter_Name = "Enter your name";
  String H_Enter_Name = "your name";

  String Enter_Surname = "Enter your surname";
  String H_Enter_Surname = " your surname";

  String Enter_Username = "Create a username";
  String H_Enter_Username = "your username";

  String Enter_Email = "Enter a valid email";
  String H_Enter_Email = "Enter email address";

  String Phone_Number = "Phone number";
  String Create_Passsword = "Create a password";
  String H_Create_Passsword = "Enter at least 6 characters";

  String Heath_Card_Code = "Enter Your health code";
  String Age = "Enter Age";
  String Weight = "Enter Weight";
  String Height = "Height";
  String Tax_Code = "Tax Code";
  String Birth_Place = "Bith place";
  String Gender = "Gender";
  String Male = "Male";
  String Female = "Female";

  String Go_On = "Go on";
  String Date_of_Birth = "Date of birth";
  String Select_Date = "Select date";
  String Place_of_Birth = "Place of birth";
  String University_Attended = "University attended";
  String Date_of_Enrollment = "Date of enrollment";
  String Date_of_Qualification = "Date of qualification";
  String Register_of_Belonging = "Register of belonging";
  String Select_Category = "Select your specializations";
  String Select_Sub_Category = "Select your sub-specializations";
  String Upload_your_Degree = "Upload your degree";
  String Select_Address = "Select your address";
  String SearchAddress = "Search City";

  /*medical center signup*/
  String MedicalName = "Enter your Medical center name";
  String HMedicalName = "Your Medical center name";

  /*Forgot password screen*/
  String forgot_Password = "Forgot password";
  String forgot_line = "Forgot your password? Create a new one by entering your email address. We will send you a security OTP code to certify your identity. Then you can set a new one";
  String forgot_line_otp = "Forgot your password? Please enter OTP number, we sent it on your email account.  Then you can set a new one.";
  String Enter_otp = "Enter OTP number";
  String Not_recived ="Not received??";
  String SendNewOtp ="Send a new OTP number";

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
          Enter_Name: "Enter your name",
          H_Enter_Name: "your name",
          Enter_Surname: "Enter your surname",
          H_Enter_Surname: " your surname",
          Enter_Username: "Create a username",
          H_Enter_Username: "your username",
          Enter_Email: "Enter a valid email",
          H_Enter_Email: "Enter email address",
          Phone_Number: "Phone number",
          Create_Passsword: "Create a password",
          H_Create_Passsword: "Enter at least 6 characters",
          Heath_Card_Code: "Enter Your health code",
          Age: "Enter Age",
          Weight: "Enter Weight",
          Height: "Height",
          Tax_Code: "Tax Code",
          Birth_Place: "Bith place",
          Gender: "Gender",
          Male: "Male",
          Female: "Female",
          Go_On: "Go on",
          Date_of_Birth: "Date of birth",
          Select_Date: "Select date",
          Place_of_Birth: "Place of birth",
          University_Attended: "University attended",
          Date_of_Enrollment: "Date of enrollment",
          Register_of_Belonging: "Register of belonging",
          Select_Category: "Select your specializations",
          Select_Sub_Category: "Select your sub-specializations",
          Upload_your_Degree: "Upload your degree",
          Select_Address: "Select your address or offices",
          SearchAddress: "Search City",
          /*medical center signup*/
          MedicalName: "Enter your Medical center name",
          HMedicalName: "Your Medical center name",
          /*Forgot password screen*/
  forgot_Password : "Forgot password",
  forgot_line : "Forgot your password? Create a new one by entering your email address. We will send you a security OTP code to certify your identity. Then you can set a new one",
/*Forgot password OTP*/
   forgot_line_otp : "Forgot your password? Please enter OTP number, we sent it on your email account.  Then you can set a new one.",
   Enter_otp : "Enter OTP number",
   Not_recived :"Not received??",
   SendNewOtp :"Send a new OTP number",
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
          Enter_Name: "Inserisci il tuo nome",
          H_Enter_Name: "il tuo nome",
          Enter_Surname: "Inserisci il tuo cognome",
          H_Enter_Surname: "il tuo cognome",
          Enter_Username: "Crea un nome utente",
          H_Enter_Username: "il tuo nome utente",
          Enter_Email: "Inserisci un'e-mail valida",
          H_Enter_Email: "Inserisci l'indirizzo email",
          Phone_Number: "Numero di telefono",
          Create_Passsword: "Crea una password",
          H_Create_Passsword: "Inserisci almeno 6 caratteri",
          Heath_Card_Code: "Inserisci il tuo codice sanitario",
          Age: "Inserisci Età",
          Weight: "Inserire il peso",
          Height: "Altezza",
          Tax_Code: "Codice Fiscale",
          Birth_Place: "Luogo di nascita",
          Gender: "Genere",
          Male: "Maschia",
          Female: "Femmina",
          Go_On: "Vai avanti",
          Date_of_Birth: "Data di nascita",
          Select_Date: "Seleziona la data",
          Place_of_Birth: "Luogo di nascita",
          University_Attended: "Università frequentata",
          Date_of_Enrollment: "Data di iscrizione",
          Register_of_Belonging: "Registro di appartenenza",
          Select_Category: "Seleziona le tue specializzazioni",
          Select_Sub_Category: "Seleziona le tue sotto-specializzazioni",
          Upload_your_Degree: "Carica la tua laurea",
          Select_Address: "Seleziona il tuo indirizzo o gli uffici",
          SearchAddress: "Cerca Città",
          /*medical center signup*/
          MedicalName: "Inserisci il nome del tuo centro medico",
          HMedicalName: "Il nome del tuo centro medico",
          /*Forgot password screen*/
          forgot_Password : "Ha dimenticato la password",
          forgot_line : "Hai dimenticato la password? Creane uno nuovo inserendo il tuo indirizzo email. Ti invieremo un codice OTP di sicurezza per certificare la tua identità. Quindi puoi impostarne uno nuovo",

          /*Forgot password OTP*/
          forgot_line_otp : "Hai dimenticato la password? Inserisci il numero OTP, lo abbiamo inviato sul tuo account e-mail. Quindi puoi impostarne uno nuovo.",
          Enter_otp : "Inserisci numero OTP",
          Not_recived :"Non ricevuto??",
          SendNewOtp :"Invia un nuovo numero OTP",
        },
      };
}
