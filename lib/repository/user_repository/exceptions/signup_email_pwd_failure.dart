class SignUpWithEmailAndPasswordFailure{
  final String message;

  const SignUpWithEmailAndPasswordFailure([this.message = "an unkonwn error occured"]);
  factory SignUpWithEmailAndPasswordFailure.code(String code){
    switch (code){
case 'Weak password' : return SignUpWithEmailAndPasswordFailure('please enter a stronger password');
case 'invalid email' : return SignUpWithEmailAndPasswordFailure('please enter a valid email');
case 'email already in use' : return SignUpWithEmailAndPasswordFailure('an account already exists for that email');
case 'operation not allowed' : return SignUpWithEmailAndPasswordFailure('operation is not allowed , you can contact the support');
case 'user disabled' : return SignUpWithEmailAndPasswordFailure('this user has been disabled , please contact support for help');
default : 
return const SignUpWithEmailAndPasswordFailure();
    }
  }

}