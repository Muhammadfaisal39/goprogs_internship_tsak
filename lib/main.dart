import 'package:firebase_core/firebase_core.dart';
import 'package:goprogs_internship_task/Provider_Services/categories_selection.dart';
import 'package:goprogs_internship_task/Provider_Services/icon_provider.dart';
import 'package:goprogs_internship_task/UI_Screens/mainscreen.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=> CategorySelection()),
          ChangeNotifierProvider(create: (_)=> CategoryIconProvider())
        ],
    child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Personal Budgeting App",
      home: MainScreen(),
    ),
    );
  }
}
