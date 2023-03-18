import 'package:authentest_135/page/login.dart';
import 'package:authentest_135/service/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  CollectionReference users =
      FirebaseFirestore.instance.collection('users'); // Add CollectionReference
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _username = TextEditingController();

  String _selectedRadioTile = "";
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 238, 255),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Register Page',
            style: GoogleFonts.itim(
              textStyle: const TextStyle(color: Colors.black, fontSize: 30),
            ),
          ),
        ),
        body: Center(
          child: SizedBox(
            width: 380,
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 0),
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 250,
                  height: 250,
                ),
                _registerForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _registerForm() {
    return Container(
      height: 430,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 10),
          children: [
            Column(
              children: [
                _buildTextField(
                  labelText: 'Email',
                  icon: Icons.email,
                  controller: _email,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Email";
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  labelText: 'Password',
                  icon: Icons.password,
                  controller: _password,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Password";
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  labelText: 'Username',
                  icon: Icons.person_outline,
                  controller: _username,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Username";
                    }
                    return null;
                  },
                ),
                _buildTextField(
                  labelText: 'Telephone',
                  icon: Icons.phone,
                  controller: _phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Telephone";
                    }
                    return null;
                  },
                ),
                RadioListTile(
                  value: "อาจารย์",
                  groupValue: _selectedRadioTile,
                  title: Text('อาจารย์'),
                  onChanged: (value) {
                    setState(() {
                      _selectedRadioTile = value!;
                    });
                  },
                ),
                RadioListTile(
                  value: "เจ้าหน้าที่",
                  groupValue: _selectedRadioTile,
                  title: Text('เจ้าหน้าที่'),
                  onChanged: (value) {
                    setState(() {
                      _selectedRadioTile = value!;
                    });
                  },
                ),
                RadioListTile(
                  value: "นิสิต",
                  groupValue: _selectedRadioTile,
                  title: Text('นิสิต'),
                  onChanged: (value) {
                    setState(() {
                      _selectedRadioTile = value!;
                    });
                  },
                ),
                _registerButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      {required String labelText,
      required IconData icon,
      required TextEditingController controller,
      required FormFieldValidator validator,
      Widget? suffixIcon}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black), // Set border color
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                BorderSide(color: Colors.black), // Set focused border color
          ),
          labelText: labelText,
          labelStyle: GoogleFonts.itim(
            textStyle: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 18,
            ),
          ),
          prefixIcon: Icon(icon, color: Colors.black),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }

  Widget _registerButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
      child: ElevatedButton(
        onPressed: () {
          // Code for handling register button press

          if (_formKey.currentState!.validate()) {
            AuthService.registerUser(_email.text, _password.text).then((value) {
              if (value == 1) {
                final uid = FirebaseAuth.instance.currentUser!.uid;
                users.doc(uid).set({
                  "Phone": _phone.text,
                  "email": _email.text,
                  "username": _username.text,
                  "password": _password.text,
                  "User Type": '${_selectedRadioTile}',
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ));
              } else {
                print("FAILED Register");
              }
            });
          }
        },
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Color.fromARGB(255, 0, 238, 255)),
          textStyle: MaterialStateProperty.all(
            const TextStyle(color: Colors.black),
          ),
          fixedSize: MaterialStateProperty.all(
            const Size(double.maxFinite, 50),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        child: const Text(
          'register',
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
