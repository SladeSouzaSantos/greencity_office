import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/account_entity.dart';
import '../../domain/usecases/usecases.dart';

import '../exceptions/exceptions.dart';

class FirebaseAuthRepository implements Authentication{
  @override
  Future<AccountEntity> auth({required AuthenticationParams params}) async{
    try{
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      UserCredential credential = await firebaseAuth.signInWithEmailAndPassword(email: params.email, password: params.password);
      String token = credential.user!.refreshToken!;
      return AccountEntity(token: token);
    }on FirebaseAuthException catch(error){
      throw DoNotReceiveAccountException();
    }


  }

}