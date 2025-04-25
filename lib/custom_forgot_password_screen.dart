import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class CustomForgotPasswordScreen extends StatefulWidget {
  final String? email;
  const CustomForgotPasswordScreen({super.key, this.email});

  @override
  _CustomForgotPasswordScreenState createState() => _CustomForgotPasswordScreenState();
}

class _CustomForgotPasswordScreenState extends State<CustomForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _errorMessage;
  String? _successMessage;

  @override
  void initState() {
    super.initState();
    if (widget.email != null) {
      _emailController.text = widget.email!;
    }
  }

  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.sendPasswordResetEmail(email: _emailController.text.trim());
        setState(() {
          final l10n = AppLocalizations.of(context)!;
          _successMessage = l10n.resetPasswordSuccess;
          _errorMessage = null;
        });
      } on FirebaseAuthException catch (e) {
        setState(() {
          final l10n = AppLocalizations.of(context)!;
          if (e.code == 'user-not-found') {
            _errorMessage = l10n.userNotFoundError;
          } else if (e.code == 'invalid-email') {
            _errorMessage = l10n.invalidEmailError;
          } else {
            _errorMessage = e.message ?? l10n.resetPasswordError;
          }
          _successMessage = null;
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
            const Icon(Icons.lock_open, size: 100, color: Colors.green),
            const SizedBox(height: 20),
            Text(
              l10n.forgotPasswordTitle,
              style: const TextStyle(
                fontSize: 24,
                fontFamily: "Segoe UI",
                color: Colors.green,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              l10n.forgotPasswordPrompt,
              style: const TextStyle(
                fontSize: 16,
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
            ElevatedButton(
              onPressed: _resetPassword,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text(
                l10n.resetPasswordButton ?? '',
                style: const TextStyle(color: Colors.white, fontSize: 18, fontFamily: "Segoe UI"),
              ),
            ),
            if (_successMessage != null) ...[
              const SizedBox(height: 10),
              Text(
                _successMessage!,
                style: const TextStyle(color: Colors.green, fontFamily: "Segoe UI"),
                textAlign: TextAlign.center,
              ),
            ],
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

extension on AppLocalizations {
  String? get resetPasswordButton => null;
  
  get resetPasswordError => null;
  
  String? get userNotFoundError => null;
  
  String? get resetPasswordSuccess => null;
}