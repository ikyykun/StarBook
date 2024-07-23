// import 'package:flutter/material.dart';
// import 'package:starbook/main.dart';
// // import 'package:supabase_flutter/supabase_flutter.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _redirect();
//   }

//   Future<void> _redirect() async {
//     await Future.delayed(Duration.zero);
//     if (!mounted) {
//       return;
//     }

//     final session = supabase.auth.currentSession;
//     if (session != null) {
//       Navigator.of(context).pushReplacementNamed('/home');
//     } else {
//       Navigator.of(context).pushReplacementNamed('/login');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }
