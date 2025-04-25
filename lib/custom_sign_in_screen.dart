import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class CustomSignInScreen extends StatefulWidget {
  const CustomSignInScreen({super.key});

  @override
  _CustomSignInScreenState createState() => _CustomSignInScreenState();
}

class _CustomSignInScreenState extends State<CustomSignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isPasswordVisible = false;
  String? _errorMessage;

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        if (mounted) {
          context.pushReplacement('/');
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          final l10n = AppLocalizations.of(context)!;
          if (e.code == 'user-not-found' || e.code == 'wrong-password') {
            _errorMessage = l10n.signInError;
          } else if (e.code == 'invalid-email') {
            _errorMessage = l10n.invalidEmailError;
          } else {
            _errorMessage = e.message ?? l10n.signInError;
          }
        });
      }
    }
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        if (mounted) {
          context.pushReplacement('/');
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          final l10n = AppLocalizations.of(context)!;
          if (e.code == 'email-already-in-use') {
            _errorMessage = l10n.emailInUseError;
          } else if (e.code == 'weak-password') {
            _errorMessage = l10n.weakPasswordError;
          } else {
            _errorMessage = e.message ?? l10n.signInError;
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isRTL = Localizations.localeOf(context).languageCode == 'ar';

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.lock, size: 100, color: Colors.green),
            const SizedBox(height: 20),
            Text(
              l10n.signInTitle,
              style: const TextStyle(
                fontSize: 24,
                fontFamily: "Segoe UI",
                color: Colors.green,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: l10n.emailLabel,
                labelStyle: const TextStyle(color: Colors.green, fontFamily: "Segoe UI"),
                border: const OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              textAlign: isRTL ? TextAlign.right : TextAlign.left,
              style: const TextStyle(color: Colors.green, fontSize: 18, fontFamily: "Segoe UI"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.insertEmailError;
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: l10n.passwordLabel,
                labelStyle: const TextStyle(color: Colors.green, fontFamily: "Segoe UI"),
                border: const OutlineInputBorder(),
                alignLabelWithHint: true,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.green,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              textAlign: isRTL ? TextAlign.right : TextAlign.left,
              style: const TextStyle(color: Colors.green, fontSize: 18, fontFamily: "Segoe UI"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.insertPasswordError;
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            Align(
              alignment: isRTL ? Alignment.centerLeft : Alignment.centerRight,
              child: TextButton(
                onPressed: () => context.push('/forgot-password'),
                child: Text(
                  l10n.forgotPassword,
                  style: const TextStyle(color: Colors.green, fontFamily: "Segoe UI"),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _signIn,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text(
                l10n.signInButton,
                style: const TextStyle(color: Colors.white, fontSize: 18, fontFamily: "Segoe UI"),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  l10n.signUpPrompt,
                  style: const TextStyle(color: Colors.green, fontFamily: "Segoe UI"),
                ),
                TextButton(
                  onPressed: _signUp,
                  child: Text(
                    l10n.registerButton,
                    style: const TextStyle(color: Colors.green, fontFamily: "Segoe UI"),
                  ),
                ),
              ],
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 10),
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red, fontFamily: "Segoe UI"),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}