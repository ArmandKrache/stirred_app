
import 'dart:developer';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stirred_app/src/presentation/cubits/login/login_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stirred_app/src/presentation/cubits/signup/signup_cubit.dart';
import 'package:stirred_app/src/utils/constants/functions.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';

@RoutePage()
class SignupView extends StatefulWidget {

  const SignupView({Key? key}) : super (key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool obscurePassword = true;
  bool usernameIsValid = false;
  bool passwordIsValid = false;
  int stepIndex = 0;

  File? selectedImage;
  DateTime birthdate = DateTime.now();
  final displayedNameController = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final signupCubit = BlocProvider.of<SignupCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Signup', style: TextStyle(color: Colors.black.withOpacity(0.7)),),
      ),
      body: BlocBuilder<SignupCubit, SignupState>(
        builder: (context, state) {
          if (state.runtimeType == LoginLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.runtimeType == LoginFailed) {
            return const Center(child: Text("An error as occurred"));
          } else {
            return _buildSignupBody(signupCubit);
          }
        },
      ),
    );
  }

  Widget _buildSignupBody(SignupCubit signupCubit) {
    Widget body = Column(
      children: [
        const Expanded(child: SizedBox()),
        bottomRowWidget(),
      ],
    );
    switch (stepIndex) {
      case (0):
        body = firstStepBodyWidget();
        break;
      case (1):
        body = secondStepBodyWidget();
        break;
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: body,
      ),
    );
  }

  Widget firstStepBodyWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(flex: 4, child: SizedBox()),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Username", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            const SizedBox(height: 2,),
            TextField(
              onChanged: (value) {
                setState(() {
                  ///TODO : Check unicity of username + Debouncer
                  usernameIsValid = usernameController.text != "";
                });
              },
              controller: usernameController,
              cursorColor: Colors.deepOrangeAccent,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(style: BorderStyle.solid, width: 1),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 32,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Password", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            const SizedBox(height: 2,),
            TextField(
              onChanged: (value) {
                setState(() {
                  ///TODO : Check password rules
                  passwordIsValid = passwordController.text != "";
                });
              },
              controller: passwordController,
              cursorColor: Colors.deepOrangeAccent,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(style: BorderStyle.solid, width: 1),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      }, child: Icon(Icons.remove_red_eye, color: obscurePassword ? Colors.grey : Colors.black,)
                  )
              ),
              obscureText: obscurePassword,
            ),
          ],
        ),
        const Expanded(child: SizedBox()),
        bottomRowWidget(),
      ],
    );
  }

  Widget secondStepBodyWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(flex: 2, child: SizedBox()),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image = await picker.pickImage(source: ImageSource.gallery, maxWidth: 1024, maxHeight: 1024);
                if (image != null) {
                  logger.d(image.name);
                  File pic = File(image.path);
                  setState(() {
                    selectedImage = pic;
                  });
                } else {
                  ///TODO : display error toast : Image couldn't be loaded
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Profile Picture", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(256),
                    child: selectedImage != null ?
                    Image.file(selectedImage!, width: 128, height: 128, fit: BoxFit.fill,)
                        : Container(width: 128, height: 128, color: Colors.grey.withOpacity(0.4),),
                  )
                ],
              ),
            ),
            const Expanded(child: SizedBox(width: 16,)),
            GestureDetector(
              onTap: () async {
                DateTime newDate = await showDialog(context: context, builder: (context) {
                  return DatePickerDialog(
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now()
                  );
                });
                setState(() {
                  birthdate = newDate;
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Birthdate", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 2,),
                  Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black.withOpacity(0.4)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(formatDateTime(birthdate), style: const TextStyle(fontSize: 18),),
                          const SizedBox(width: 4,),
                          Icon(Icons.edit, color: Colors.black.withOpacity(0.7),)
                        ],
                      )
                  ),
                ],
              ),
            ),
            const Expanded(child: SizedBox(width: 16,)),
          ],
        ),
        const SizedBox(height: 32,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Displayed Name", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            const SizedBox(height: 2,),
            TextField(
              onChanged: (value) {
                setState(() {
                  /// V2: Check that displayedUsername is Safe
                });
              },
              controller: displayedNameController,
              cursorColor: Colors.deepOrangeAccent,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(style: BorderStyle.solid, width: 1),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ],
        ),
        const Expanded(child: SizedBox()),
        bottomRowWidget(),
      ],
    );
  }

  Widget bottomRowWidget() {
    bool canContinue = false;
    Function _continue = () {};
    switch (stepIndex) {
      case (0):
        canContinue = (usernameIsValid && passwordIsValid);
        _continue = () {
          stepIndex += 1;
          if (displayedNameController.text == "") {
            setState(() {
              displayedNameController.text = usernameController.text;
              displayedNameController.selection = TextSelection.fromPosition(
                TextPosition(offset: displayedNameController.text.length),
              );
            });
          }
        };
        break;
      case (1):
        canContinue = (usernameIsValid && passwordIsValid
            && selectedImage != null && displayedNameController.text != "");
        _continue () {
          /// TODO: Signup Logic
        }
        break;
    }
    String continueText = stepIndex == 1 ? "Signup" : "Continue >";
    
    return Row(
      children: [
        Visibility(
          visible: stepIndex > 0,
          child: TextButton(
              onPressed: () {
                setState(() {
                  stepIndex -= 1;
                });
              },
              child: const Text("< Back",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrangeAccent
                ),

              )
          ),
        ),
        const Expanded(child: SizedBox()),
        TextButton(
            onPressed: () {
              if (canContinue) {
                setState(() {
                  _continue.call();
                });
              }
            },
          style: ButtonStyle(overlayColor: MaterialStateProperty.all(Colors.transparent)),
            child: Text(continueText,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: canContinue ? Colors.deepOrangeAccent : Colors.grey
              ),
            ),
        ),
      ],
    );
  }
}
