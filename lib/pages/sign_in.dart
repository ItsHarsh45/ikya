import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'home_page.dart';

// Color constants
const Color backgroundColor1 = Color(0xffE9EAF7);
const Color backgroundColor2 = Color(0xffF4EEF2);
const Color backgroundColor3 = Color(0xffEBEBF2);
const Color backgroundColor4 = Color(0xffE3EDF5);
const Color primaryColor = Color(0xffD897FD);
const Color textColor1 = Color(0xff353047);
const Color textColor2 = Color(0xff6F6B7A);
const Color buttonColor = Color(0xffFD6B68);

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _authService = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _showError('Please fill in all fields');
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authService.signInWithEmail(
        _emailController.text.trim(),
        _passwordController.text,
      );
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    } catch (e) {
      if (mounted) {
        _showError(e.toString());
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() => _isLoading = true);

    try {
      await _authService.signInWithGoogle();
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    } catch (e) {
      if (mounted) {
        _showError(e.toString());
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleForgotPassword() async {
    if (_emailController.text.isEmpty) {
      _showError('Please enter your email address');
      return;
    }

    try {
      await _authService.resetPassword(_emailController.text.trim());
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password reset email sent. Please check your inbox.'),
          ),
        );
      }
    } catch (e) {
      _showError(e.toString());
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showRegistrationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: RegistrationDialog(authService: _authService),
        );
      },
    );
  }

  void _showForgotPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Forgot Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Enter your email address to reset your password.'),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _handleForgotPassword();
                Navigator.of(context).pop();
              },
              child: const Text('Submit'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLoginFields(Size size) {
    return Column(
      children: [
        MyTextField(
          "Email address",
          Icons.email_outlined,
          false,
          size,
          null,
          controller: _emailController,
        ),
        SizedBox(height: size.height * 0.02),
        MyTextField(
          "Password",
          Icons.lock_outline,
          !_isPasswordVisible,
          size,
          IconButton(
            icon: Icon(
              _isPasswordVisible
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: Colors.black45,
              size: size.width * 0.055,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
          controller: _passwordController,
        ),
      ],
    );
  }

  Widget _buildSignInButton(Size size, bool isSmallScreen) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleSignIn,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(
            vertical: size.height * 0.022,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 0,
        ),
        child: _isLoading
            ? const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(color: Colors.white),
        )
            : Text(
          "Sign In",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: isSmallScreen ? 18 : 20,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleSignIn(Size size, bool isSmallScreen) {
    return ElevatedButton(
      onPressed: _isLoading ? null : _handleGoogleSignIn,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        padding: EdgeInsets.symmetric(
          vertical: size.height * 0.018,
        ),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: _isLoading
          ? const SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(),
      )
          : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/google.png",
            height: size.width * 0.06,
          ),
          SizedBox(width: size.width * 0.03),
          Text(
            "Continue with Google",
            style: TextStyle(
              fontSize: isSmallScreen ? 15 : 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 380;

    return Scaffold(
      backgroundColor: backgroundColor1,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.1,
            vertical: size.height * 0.1,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome Back",
                style: TextStyle(
                  fontSize: isSmallScreen ? 26 : 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height * 0.04),
              _buildLoginFields(size),
              SizedBox(height: size.height * 0.02),
              _buildSignInButton(size, isSmallScreen),
              SizedBox(height: size.height * 0.02),
              _buildGoogleSignIn(size, isSmallScreen),
              SizedBox(height: size.height * 0.02),
              GestureDetector(
                onTap: () => _showForgotPasswordDialog(context),
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(color: primaryColor),
                ),
              ),
              SizedBox(height: size.height * 0.02),
              GestureDetector(
                onTap: () => _showRegistrationDialog(context),
                child: const Text(
                  "Don't have an account? Register",
                  style: TextStyle(color: primaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool isObscure;
  final Size size;
  final Widget? suffixIcon;
  final TextEditingController? controller;

  const MyTextField(
      this.hintText,
      this.icon,
      this.isObscure,
      this.size,
      this.suffixIcon, {
        super.key,
        this.controller,
      });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon, color: Colors.black45),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class RegistrationDialog extends StatefulWidget {
  final AuthService authService;

  const RegistrationDialog({super.key, required this.authService});

  @override
  State<RegistrationDialog> createState() => _RegistrationDialogState();
}

class _RegistrationDialogState extends State<RegistrationDialog> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegistration() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await widget.authService.signUpWithEmail(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        fullName: _nameController.text.trim(),
      );
      if (mounted) {
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 380;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Register",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: isSmallScreen ? 24 : 28,
                color: textColor1,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            MyTextField(
              "Full Name",
              Icons.person_outline,
              false,
              size,
              null,
              controller: _nameController,
            ),
            SizedBox(height: size.height * 0.015),
            MyTextField(
              "Email Address",
              Icons.email_outlined,
              false,
              size,
              null,
              controller: _emailController,
            ),
            SizedBox(height: size.height * 0.015),
            MyTextField(
              "Password",
              Icons.lock_outline,
              !_isPasswordVisible,
              size,
              IconButton(
                icon: Icon(
                  _isPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.black45,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
              controller: _passwordController,
            ),
            SizedBox(height: size.height * 0.02),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleRegistration,
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.022,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(color: Colors.white),
                )
                    : Text(
                  "Register",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: isSmallScreen ? 18 : 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}