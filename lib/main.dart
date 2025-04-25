import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'bmi_history.dart';
import 'home.dart';
import 'firebase_options.dart';
import 'locale_notifier.dart';
import 'custom_sign_in_screen.dart';
import 'custom_forgot_password_screen.dart'; // Importer le nouveau widget

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    final localeNotifier = LocaleNotifier();
    await localeNotifier.setLocale(const Locale('ar')); // Forcer l'arabe au démarrage

    runApp(
      ChangeNotifierProvider.value(
        value: localeNotifier,
        child: const MyApp(),
      ),
    );
  } catch (err) {
    print("Firebase initialization failed: $err");
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => Home(),
      ),
      GoRoute(
        path: '/sign-in',
        builder: (context, state) {
          final l10n = AppLocalizations.of(context)!;
          return Scaffold(
            appBar: AppBar(
              title: Text(l10n.signInTitle, style: const TextStyle(fontFamily: "Segoe UI")),
              centerTitle: true,
              backgroundColor: Colors.green,
              actions: [
                PopupMenuButton<Locale>(
                  icon: const Icon(Icons.language),
                  onSelected: (Locale locale) {
                    final notifier = Provider.of<LocaleNotifier>(context, listen: false);
                    notifier.setLocale(locale);
                    final appState = context.findRootAncestorStateOfType<MyAppState>();
                    appState?.refresh();
                  },
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem(value: Locale('en'), child: Text('English')),
                    const PopupMenuItem(value: Locale('fr'), child: Text('Français')),
                    const PopupMenuItem(value: Locale('ar'), child: Text('العربية')),
                  ],
                ),
              ],
            ),
            body: const CustomSignInScreen(),
          );
        },
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) {
          final l10n = AppLocalizations.of(context)!;
          final email = state.extra as String?;
          return Scaffold(
            appBar: AppBar(
              title: Text(l10n.forgotPasswordTitle, style: const TextStyle(fontFamily: "Segoe UI")),
              centerTitle: true,
              backgroundColor: Colors.green,
              actions: [
                PopupMenuButton<Locale>(
                  icon: const Icon(Icons.language),
                  onSelected: (Locale locale) {
                    final notifier = Provider.of<LocaleNotifier>(context, listen: false);
                    notifier.setLocale(locale);
                    final appState = context.findRootAncestorStateOfType<MyAppState>();
                    appState?.refresh();
                  },
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem(value: Locale('en'), child: Text('English')),
                    const PopupMenuItem(value: Locale('fr'), child: Text('Français')),
                    const PopupMenuItem(value: Locale('ar'), child: Text('العربية')),
                  ],
                ),
              ],
            ),
            body: CustomForgotPasswordScreen(email: email), // Utiliser CustomForgotPasswordScreen
          );
        },
      ),
      GoRoute(
        path: '/history',
        builder: (context, state) => BMIHistoryScreen(),
      ),
    ],
  );

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final localeNotifier = Provider.of<LocaleNotifier>(context);
    print("Current locale: ${localeNotifier.locale}"); // Log pour vérifier la langue

    return MaterialApp.router(
      routerConfig: _router,
      locale: localeNotifier.locale,
      theme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('fr'),
        Locale('ar'),
      ],
      builder: (context, child) {
        final isRTL = localeNotifier.locale.languageCode == 'ar';
        return Directionality(
          textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
          child: child!,
        );
      },
    );
  }
}