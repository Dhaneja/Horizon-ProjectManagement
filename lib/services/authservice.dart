import 'package:firebase_auth/firebase_auth.dart';
import 'package:horizon/model/employee.dart';

class AuthService{



  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create Employee object based on FirebaseUser
  Employee _userfromFirebaseUser(User user){
    return user != null ? Employee(eid: user.uid) : null;
  }

  //Auth Change User Stream
  Stream<Employee> get employee{
    return _auth.authStateChanges()
        //.map((User user) => _userfromFirebaseUser(user));
        .map(_userfromFirebaseUser);
  }


  //Sign in Anonymously

  Future signInAnonymous() async {

    try{

      UserCredential credential = await _auth.signInAnonymously();
      User user = credential.user;
      return _userfromFirebaseUser(user);

    }catch(error){

      print(error.toString());
      return null;

    }

  }

  //Sign in with Email & Password

  //Sign Out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(error){
      print(error.toString());
      return null;
    }
  }

}