import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../components/my_textfield.dart';
import '../module/nameModule.dart';

class InsuranceAssistanceForm extends StatefulWidget {
  const InsuranceAssistanceForm({super.key});

  @override
  State<InsuranceAssistanceForm> createState() =>
      _InsuranceAssistanceFormState();
}

class _InsuranceAssistanceFormState extends State<InsuranceAssistanceForm> {
  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(message),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferredUserName>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Insurance Assistance Form'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyTextField(
                  hintText: 'Full Name',
                  controller: value.nameController,
                  obscureText: false,
                ),
                const SizedBox(height: 16),
                MyTextField(
                  hintText: 'Email Address',
                  controller: value.emailController,
                  obscureText: false,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'\s'))
                  ],
                ),
                const SizedBox(height: 16),
                MyTextField(
                  keyboardType: TextInputType.number,
                  hintText: 'Phone Number',
                  controller: value.phoneController,
                  obscureText: false,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                const SizedBox(height: 16),
                MyTextField(
                  keyboardType: TextInputType.number,
                  hintText: 'Policy Number',
                  controller: value.policyNumberController,
                  obscureText: false,
                ),
                const SizedBox(height: 16),
                MyTextField(
                  hintText: 'Type of Assistance Needed',
                  controller: value.typeController,
                  obscureText: false,
                  inputFormatters: [LengthLimitingTextInputFormatter(250)],
                ),
                const SizedBox(height: 16),
                MyTextField(
                  hintText: 'Description of Assistance Needed',
                  controller: value.descriptionController,
                  obscureText: false,
                  inputFormatters: [LengthLimitingTextInputFormatter(250)],
                ),
                const SizedBox(height: 16),
                MyTextField(
                  hintText: 'Reason For Assistance',
                  controller: value.reasonController,
                  obscureText: false,
                  inputFormatters: [LengthLimitingTextInputFormatter(250)],
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Container(
                    height: 65,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: TextButton(
                      onPressed: () => value.submitForm(context),
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      );
    });
  }
}
