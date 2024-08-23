import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hobi/db/db_helper.dart';
import 'package:hobi/pages/home_page.dart';
import 'package:hobi/screens/splashScreen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'module/nameModule.dart';

var box;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await DBHelper.initDb();
  await GetStorage.init();
  await dotenv.load(fileName: ".env");
  await Hive.initFlutter();
  //create a box  to store and manage data
  box = await Hive.openBox('my box');

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PreferredUserName()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          // Listen to authentication state changes
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const HomePage(); // User is signed in, show HomePage
              } else {
                return const Splashscreen(); // User is not signed in, show LoginPage
              }
            } else {
              return const Center(
                  child:
                      CircularProgressIndicator()); // Show a loading spinner while waiting for authentication state
            }
          },
        ),
      ),
    );
  }
}
