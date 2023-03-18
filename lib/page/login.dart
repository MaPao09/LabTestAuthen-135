import 'package:authentest_135/page/profile.dart';
import 'package:authentest_135/page/register.dart';
import 'package:authentest_135/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscurePassword = true;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 238, 255),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Login Page',
            style: GoogleFonts.itim(
              textStyle: const TextStyle(color: Colors.black, fontSize: 30),
            ),
          ),
        ),
        body: Center(
          child: SizedBox(
            width: 380,
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 30),
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 250,
                  height: 250,
                ),
                // _loginHeader(),
                _loginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Container(
      height: 320,
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
                  icon: Icons.person_outline,
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
                  obscureText: _obscurePassword,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    child: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black,
                    ),
                  ),
                ),
                _loginButton(),
                _registerButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String labelText,
    required IconData icon,
    required TextEditingController controller,
    required FormFieldValidator validator,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
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

  Widget _loginButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
      child: ElevatedButton(
        onPressed: () {
          // Code for handling login button press
          if (_formKey.currentState!.validate()) {
            AuthService.loginUser(_email.text, _password.text).then((value) {
              if (value == 1) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Profile(),
                    ));
              } else {
                print("FAILED Login");
              }
            });
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Color.fromARGB(255, 0, 238, 255),
          ),
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
          'Login',
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _registerButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 20, 5, 0),
      child: ElevatedButton(
        onPressed: () {
          // Code for handling login button press
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => RegisterPage()));
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Color.fromARGB(255, 0, 238, 255),
          ),
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
          'Resgister',
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
