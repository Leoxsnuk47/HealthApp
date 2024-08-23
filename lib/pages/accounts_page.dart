import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../module/nameModule.dart';
import 'edits_page.dart';
import 'login_page.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});

  void signUserOut(BuildContext context) {
    FirebaseAuth.instance.signOut().then((_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) =>
            const LoginPage()), // Replace LoginPage with your login page widget
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return  Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: const Center(
          child: Text("No user signed in"),
        ),
      );
    }

    return Consumer<PreferredUserName>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    height: 420,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: value.image == null
                            ? const AssetImage('lib/images/profile.png')
                            : MemoryImage(value.image!) as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 420,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0.1),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -10,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(24),
                          topLeft: Radius.circular(24),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${value.userNameController.text} • ',
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Baseline(
                                baseline: 30,
                                baselineType: TextBaseline.alphabetic,
                                child: Expanded(
                                  child: Text(
                                    '${user.email}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )

                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                  height: 65,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(4)),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                  height: 65,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(4)),
                  child: TextButton(
                    onPressed: () => signUserOut(context),
                    child: const Text(
                      'Sign Out',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}


//Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 30),
//                   const Text(
//                     'John Doe', // Replace this with the user's name
//                     style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     '${user.email}', // Replace this with the user's email
//                     style: const TextStyle(fontSize: 18, color: Colors.grey),
//                   ),
//                   const SizedBox(height: 40),
//                   ElevatedButton.icon(
//                     onPressed: () {
//                       // Add functionality to edit profile
//                     },
//                     icon: const Icon(
//                       Icons.edit,
//                       color: Colors.white,
//                     ),
//                     label: const Text(
//                       'Edit Profile',
//                       style: TextStyle(
//                         color: Colors.blue,
//                       ),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.indigo, // Modern color palette
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 15, horizontal: 40),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   OutlinedButton.icon(
//                     onPressed: signUserOut,
//                     icon: Icon(Icons.logout),
//                     label: const Text('Sign Out'),
//                     style: OutlinedButton.styleFrom(
//                       foregroundColor: Colors.indigo,
//                       side: BorderSide(color: Colors.indigo),
//                       // Border color
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 15, horizontal: 40),
//                     ),
//                   )
//                 ],
//               ),
