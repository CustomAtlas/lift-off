// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: Container(
      alignment: Alignment.center,
      child: const LiftOff()),
    ),
  ));
}

class LiftOff extends StatefulWidget {

  const LiftOff({ super.key});

  @override
  // ignore: no_logic_in_create_state
  State<LiftOff> createState() => _LiftOffState(); 
}

class _LiftOffState extends State<LiftOff> {

  var _email = "";
  var _password = "";
  String? errorTextE;
  String? errorTextP;

  final controllerE = TextEditingController();
  final controllerP = TextEditingController(); 

  _changeEmail(){
    setState(() {
      _email = controllerE.text;
    });
  }

  _changePassword(){
    setState(() {
      _password = controllerP.text;
    });
  }

  Future _authF() async {                    
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: controllerE.text,
                        password: controllerP.text,
                        );
                      } on FirebaseAuthException catch(e) {
                    if (e.code == 'user-not-found') {
                      print('No user found for that email.');
                      setState(() {
                        errorTextE = 'No user found for that email.';
                        });
                    } else if (e.code == 'wrong-password') {
                      print('Wrong password provided for that user.');
                           setState(() {
                            errorTextP = 'Wrong password provided for that user.';
                            });
                     } 
                                  
                      }}

   Future _signUp() async {
                    try {
                     await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: controllerE.text, 
                      password: controllerP.text
                      );
                       } on FirebaseAuthException catch(e) {
                        if (e.code == 'weak-password') {
                        print('The password provided is too weak.'); 
                        setState(() {
                          errorTextP = 'The password provided is too weak.';
                          });
                        } else if (e.code == 'email-already-in-use') {
                           print('The account already exists for that email.');
                           setState(() {
                            errorTextE = 'The account already exists for that email.';
                            });
                            } 
                             }}                           

  @override
  void initState() {
    super.initState();
    controllerE.addListener(_changeEmail);
    controllerP.addListener(_changePassword);
  }

  @override
  void dispose() {
    controllerE.dispose();
    controllerP.dispose();
    super.dispose();
  }

  @override 
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
      padding: const EdgeInsets.only(top: 130, left: 45, right: 45),
      color: Colors.white,
        child: Column(
        verticalDirection: VerticalDirection.down,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
         TextField(
          controller: controllerE,
            style: const TextStyle(fontSize: 14),
             decoration: InputDecoration(
             hintStyle: const TextStyle(fontSize: 6),
             labelText: 'Email',
             errorText: errorTextE
             ),),
          TextField(
            keyboardType: TextInputType.emailAddress,
            controller: controllerP,
            style: const TextStyle(fontSize: 14),
              obscureText: true,
              decoration: InputDecoration(
              hintStyle: const TextStyle(fontSize: 6),
              labelText: 'Password',
              errorText: errorTextP
             ),),
          const SizedBox(height: 20,),
          Container(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () async {                    
                    await _authF();
                      if (FirebaseAuth.instance.currentUser != null) {
                        // ignore: use_build_context_synchronously
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Authorized(email: _email, password: _password,)));
                        setState(() {
                            errorTextP = null;
                            errorTextE = null;
                            });
                         }
                         },

                    child: Container(
                    color: Colors.blue,
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.all(8),
                      child: const Text('LOGIN', style: TextStyle(color: Colors.white, fontSize: 13),)
                      ),
                    ),
                    const SizedBox(width: 10,),
                    GestureDetector(
                  onTap: () async {
                    await _signUp();              
                         if (FirebaseAuth.instance.currentUser != null) {
                     // ignore: use_build_context_synchronously
                     Navigator.push(context, MaterialPageRoute(builder: (context) => Authorized(email: _email, password: _password,)));
                     setState(() {
                            errorTextP = null;
                            errorTextE = null;
                            });
                         }
                    },
                  
                    child: Container(
                    color: Colors.blue,
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.all(8),
                      child: const Text('SIGN UP', style: TextStyle(color: Colors.white, fontSize: 13),)
                      ),
                    ),
              ],
            ),
          ),
        ],
      ),));
  }
}

class Authorized extends StatelessWidget {
// ignore: prefer_typing_uninitialized_variables
final email;
// ignore: prefer_typing_uninitialized_variables
final password; 

const Authorized({super.key, required this.email, required this.password});

@override
Widget build(BuildContext context) {

  return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          actions: [GestureDetector(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.only(right: 15),
                  child: const Text(
                    'Logout', 
                    style: TextStyle(fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
                    ),
                )
              )],
          backgroundColor: Colors.blue,
          title: const Text(
                  'Flutter login demo',
                  textAlign: TextAlign.end, 
                  style: TextStyle(fontSize: 20, 
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
                  ),
                  centerTitle: true,
            ),
        body: Column(
          children: [
            const SizedBox(height: 40),
            Container(
              alignment: Alignment.topCenter, 
              child: 
               const Text('Welcome', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),)),
            const SizedBox(height: 100,),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('email: $email'),
                  Text('password: $password')
                ],
              ),
            )
          ]
          ),
          ),
    );
}

}


// class Authorized extends LiftOff{

//   // ignore: prefer_typing_uninitialized_variables
//   final email;
//   // ignore: prefer_typing_uninitialized_variables
//   final password;
// const Authorized({super.key, required this.email, required this.password} );

// @override
// // ignore: no_logic_in_create_state
// State<Authorized> createState() => _AuthorizedState(email, password);
// }


// class _AuthorizedState extends State<Authorized>{

//   var email = "";
//   var password = "";
//   _AuthorizedState(this.email, this.password);
    
//   @override
//   Widget build(BuildContext context) {

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           actions: [GestureDetector(
//                 onTap: () async {
//                   await FirebaseAuth.instance.signOut();
//                   // ignore: use_build_context_synchronously
//                   Navigator.pop(context);
//                 },
//                 child: Container(
//                   padding: const EdgeInsets.only(right: 15),
//                   child: const Text(
//                     'Logout', 
//                     style: TextStyle(fontSize: 15,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.white),
//                     ),
//                 )
//               )],
//           backgroundColor: Colors.blue,
//           title: const Text(
//                   'Flutter login demo',
//                   textAlign: TextAlign.end, 
//                   style: TextStyle(fontSize: 20, 
//                   fontWeight: FontWeight.w400,
//                   color: Colors.white),
//                   ),
//                   centerTitle: true,
//             ),
//         body: Column(
//           children: [
//             const SizedBox(height: 40),
//             Container(
//               alignment: Alignment.topCenter, 
//               child: 
//                const Text('Welcome', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),)),
//             const SizedBox(height: 100,),
//             Container(
//               alignment: Alignment.centerLeft,
//               padding: const EdgeInsets.only(left: 40),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('email: $email'),
//                   Text('password: $password')
//                 ],
//               ),
//             )
//           ]
//           ),
//           ),
//     );
//   }
// }
