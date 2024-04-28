import 'package:flutter/material.dart';
import 'package:puskesmas_cisadea/auth/auth_service.dart';
import 'package:puskesmas_cisadea/auth/login.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatelessWidget {
  Register({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    bool isKeyboardVisible = mediaQuery.viewInsets.bottom > 0;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              image: AssetImage('assets/images/bg1.jpg'),
              fit: BoxFit.cover,
              opacity: 0.3),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: !isKeyboardVisible,
                child: Image.asset('assets/images/logo.png'),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Puskesmas Cisandea',
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Text(
                'Melayani dengan sepenuh hati',
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              TextField(
                controller: _usernameController,
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                decoration: InputDecoration(
                  // hintText: 'Email',
                  label: const Text('Username'),
                  contentPadding: const EdgeInsets.all(15.0),
                  labelStyle: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  hintStyle: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: _emailController,
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                decoration: InputDecoration(
                  // hintText: 'Email',
                  label: const Text('Email'),
                  contentPadding: const EdgeInsets.all(15.0),
                  labelStyle: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  hintStyle: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: _passwordController,
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                decoration: InputDecoration(
                  // hintText: 'Email',
                  label: const Text('Password'),
                  contentPadding: const EdgeInsets.all(15.0),
                  labelStyle: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  hintStyle: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ));
                },
                child: Text("Sudah punya akun? Login",
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    )),
              ),
              InkWell(
                onTap: () async {
                  final message = await AuthService().register(
                    username: _usernameController.text,
                    email: _emailController.text,
                    password: _passwordController.text,
                  );

                  if (message == 'Registration Success') {
                    Navigator.of(context).pushReplacementNamed('/home');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message ?? 'An error occurred'),
                      ),
                    );
                  }
                },
                child: Container(
                  height: 45,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Color(0xFF578af5),
                      borderRadius: BorderRadius.circular(5)),
                  child: Text('Register',
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
