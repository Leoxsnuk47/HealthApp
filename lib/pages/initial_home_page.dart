
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hobi/pages/BMI_calculator.dart';
import 'package:hobi/pages/chat_page.dart';
import 'package:hobi/pages/health_news.dart';
import 'package:hobi/pages/health_todo.dart';
import 'package:hobi/pages/insurance_assistance_page.dart';
import 'package:hobi/pages/reminder_pag.dart';
import 'package:provider/provider.dart';

import '../module/nameModule.dart';
import 'leslie_page.dart';

class InitialHomePage extends StatefulWidget {
  const InitialHomePage({super.key});

  @override
  State<InitialHomePage> createState() => _InitialHomePageState();
}

class _InitialHomePageState extends State<InitialHomePage> {
  // final user = FirebaseAuth.instance.currentUser!;
  bool isBookMark = true;

  void toggleBookMark() {
    setState(() {
      isBookMark = !isBookMark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferredUserName>(
      builder: (context, value, child) {
        return Scaffold(
            backgroundColor:
                Get.isDarkMode ? Colors.grey.shade700 : const Color(0xffF6F6F6),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello,',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w200,
                                  color: Get.isDarkMode
                                      ? Colors.grey.shade300
                                      : const Color(0xFF0F4F64),
                                ),
                              ),
                              Text(
                                '${value.userNameController.text}!',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w200,
                                  color: Get.isDarkMode
                                      ? Colors.grey.shade300
                                      : const Color(0xFF0F4F64),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              value.image == null
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: GestureDetector(
                                        onTap: value.selectImage,
                                        child: Container(
                                          padding: const EdgeInsets.all(18),
                                          height: 65,
                                          width: 65,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.transparent,
                                            border: Border.all(
                                                color: Colors.grey.shade400),
                                            image: const DecorationImage(
                                              image: AssetImage(
                                                  'lib/images/profile.png'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: GestureDetector(
                                        onTap: value.selectImage,
                                        child: Container(
                                          padding: const EdgeInsets.all(18),
                                          height: 65,
                                          width: 65,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.transparent,
                                            border: Border.all(
                                                color: Colors.grey.shade400),
                                            image: DecorationImage(
                                              image: MemoryImage(value.image!),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Get.isDarkMode
                              ? const Color(0xff1067F5).withOpacity(0.2)
                              : const Color(0xff1067F5).withOpacity(0.8),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                width: 3,
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Discover Our HealthCare ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    'Chat Assistant',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: InkWell(
                                  focusColor: Colors.grey,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const ChatPage()));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(18),
                                    height: 65,
                                    width: 65,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.grey.shade400)),
                                    child: Image.asset(
                                      'lib/images/forward.png',
                                      width: 35,
                                      height: 35,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Our Features',
                            style: TextStyle(
                              color: Get.isDarkMode
                                  ? Colors.grey.shade300
                                  : const Color(0xFF0F4F64),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffFFFFFF),
                          borderRadius: BorderRadius.circular(44),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.295,
                            child: GridView.count(
                              mainAxisSpacing: 6.0,
                              crossAxisSpacing: 3.0,
                              crossAxisCount: 3,
                              childAspectRatio: 1,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HealthNews()));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(44),
                                      color: const Color(0xffF6F6F6),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          //image
                                          Image.asset(
                                            'lib/images/newspaper.png',
                                            width: 27,
                                            height: 27,
                                          ),
                                          const SizedBox(
                                            height: 4.0,
                                          ),
                                          // Name
                                          const Flexible(
                                            child: Text(
                                              'Hobi News',
                                              style: TextStyle(
                                                  color: Color(0xFF0F4F64),
                                                  letterSpacing: -1.0,
                                                  fontSize: 14.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ReminderPage(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(44),
                                      color: const Color(0xffF6F6F6),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          //image
                                          Image.asset(
                                            'lib/images/note.png',
                                            width: 27,
                                            height: 27,
                                          ),
                                          const SizedBox(
                                            height: 4.0,
                                          ),
                                          // Name
                                          const Flexible(
                                            child: Text(
                                              'Medication Reminders',
                                              style: TextStyle(
                                                  color: Color(0xFF0F4F64),
                                                  letterSpacing: -1.0,
                                                  fontSize: 14.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const InputPage()));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(44),
                                      color: const Color(0xffF6F6F6),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          //image
                                          Image.asset(
                                            'lib/images/pharmacy.png',
                                            width: 27,
                                            height: 27,
                                          ),
                                          const SizedBox(
                                            height: 4.0,
                                          ),
                                          // Name
                                          const Flexible(
                                            child: Text(
                                              'BMI-Calculator',
                                              style: TextStyle(
                                                  color: Color(0xFF0F4F64),
                                                  letterSpacing: -1.0,
                                                  fontSize: 14.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const InsuranceAssistanceForm(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(44),
                                      color: const Color(0xffF6F6F6),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          //image
                                          Image.asset(
                                            'lib/images/danger.png',
                                            width: 27,
                                            height: 27,
                                          ),
                                          const SizedBox(
                                            height: 4.0,
                                          ),
                                          // Name
                                          const Flexible(
                                            child: Text(
                                              'Insurance assistant',
                                              style: TextStyle(
                                                  color: Color(0xFF0F4F64),
                                                  letterSpacing: -1.0,
                                                  fontSize: 14.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const ChatPage(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(44),
                                      color: const Color(0xffF6F6F6),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          //image
                                          Image.asset(
                                            'lib/images/ai.png',
                                            width: 32,
                                            height: 32,
                                          ),
                                          const SizedBox(
                                            height: 4.0,
                                          ),
                                          // Name
                                          const Flexible(
                                            child: Text(
                                              'AI Assistance',
                                              style: TextStyle(
                                                  color: Color(0xFF0F4F64),
                                                  letterSpacing: -1.0,
                                                  fontSize: 14.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>const HealthTodo(),),);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(44),
                                      color: const Color(0xffF6F6F6),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          //image
                                          Image.asset(
                                            'lib/images/to-do.png',
                                            width: 27,
                                            height: 27,
                                          ),
                                          const SizedBox(
                                            height: 4.0,
                                          ),
                                          // Name
                                          const Flexible(
                                            child: Text(
                                              'Health To-D0',
                                              style: TextStyle(
                                                  color: Color(0xFF0F4F64),
                                                  letterSpacing: -1.0,
                                                  fontSize: 14.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Appointment Scheduling',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Get.isDarkMode
                                  ? Colors.grey.shade300
                                  : const Color(0xFF0F4F64),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Get.isDarkMode
                              ? const Color(0xff1067F5).withOpacity(0.4)
                              : const Color(0xff1067F5).withOpacity(0.8),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 28.0, horizontal: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Leslie Alexander',
                                    style: TextStyle(
                                      color: Get.isDarkMode
                                          ? Colors.grey.shade300
                                          : Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Headache and \nMigraines',
                                    style: TextStyle(
                                      color: Get.isDarkMode
                                          ? Colors.grey.shade300
                                          : Colors.white.withOpacity(0.8),
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Image.asset(
                                'lib/images/doctor.png',
                                width: 250,
                                height: 230,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14.0, horizontal: 14.0),
                                child: InkWell(
                                  onTap: toggleBookMark,
                                  child: isBookMark
                                      ? Image.asset(
                                          'lib/images/bookmark.png',
                                          width: 23,
                                          height: 23,
                                          color: Colors.white,
                                        )
                                      : Image.asset(
                                          'lib/images/bookmark-fill.png',
                                          width: 23,
                                          height: 23,
                                          color: Colors.white,
                                        ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 28,
                              left: 12,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(32),
                                onTap: () {
                                  // Add your onTap function here
                                },
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const DoctorsPage(),
                                        ));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(32),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: const Text(
                                      'See More',
                                      style: TextStyle(
                                        color: Color(0xFF0F4F64),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}

//Padding(
//                                 padding: const EdgeInsets.only(left: 16.0),
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) =>
//                                             const NotificationsPage(),
//                                       ),
//                                     );
//                                   },
//                                   child: Container(
//                                     padding: const EdgeInsets.all(18),
//                                     height: 65,
//                                     width: 65,
//                                     decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         color: Colors.transparent,
//                                         border: Border.all(
//                                             color: Colors.grey.shade400)),
//                                     child: Image.asset(
//                                       'lib/images/bell.png',
//                                       width: 35,
//                                       height: 35,
//                                       color: Get.isDarkMode
//                                           ? Colors.grey.shade300
//                                           : Colors.black,
//                                     ),
//                                   ),
//                                 ),
//                               ),
