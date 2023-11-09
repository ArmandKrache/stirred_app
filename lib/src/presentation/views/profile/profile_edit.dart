import 'dart:io';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stirred_app/src/config/router/app_router.dart';
import 'package:stirred_app/src/presentation/cubits/drink/drink_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stirred_app/src/presentation/cubits/profile/profile_edit_cubit.dart';
import 'package:stirred_app/src/presentation/widgets/rating_dialog_widget.dart';
import 'package:stirred_app/src/utils/constants/functions.dart';
import 'package:stirred_app/src/utils/constants/global_data.dart';
import 'package:stirred_app/src/utils/constants/strings_format.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


@RoutePage()
class ProfileEditView extends StatefulHookWidget {

  const ProfileEditView({Key? key}) : super (key: key);

  @override
  State<ProfileEditView> createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends State<ProfileEditView> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  File? selectedImage;
  DateTime birthdate = DateTime.now();
  bool isEdited = false;
  int _shouldCheckValue = 0;

  @override
  void initState() {
    super.initState();
    nameController.text = currentProfile.name ?? "";
    descriptionController.text = currentProfile.description ?? "";
    birthdate = DateTime.parse(currentProfile.dateOfBirth);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileEditCubit = BlocProvider.of<ProfileEditCubit>(context);

    useEffect(() {
      nameController.addListener(() {
        setState(() {
          _shouldCheckValue += 1;
        });
      });
      descriptionController.addListener(() {
        setState(() {
          _shouldCheckValue += 1;
        });
      });
      return;
    }, const []);


    useEffect(() {
      bool tmp = false;
      if (nameController.text != currentProfile.name) {
        tmp = true;
      }
      else if (descriptionController.text != currentProfile.description) {
        tmp = true;
      }
      else if (formatDateTime(birthdate) != currentProfile.dateOfBirth) {
        tmp = true;
      }
      else if (selectedImage != null) {
        tmp = true;
      }
      setState(() {
        isEdited = tmp;
      });
      return ;
    }, [_shouldCheckValue, birthdate, selectedImage]);

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            /// TODO: Display warning before leaving if un patched changes
            appRouter.pop();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Icon(Icons.arrow_back_ios, size: 28, color: Colors.black.withOpacity(0.7),),
          ),
        ),
        title: const Text("Edit Profile", style: TextStyle(color: Colors.black),),
        actions: [
          Visibility(
            visible: isEdited,
            child: GestureDetector(
              onTap: () async {
                Map<String, dynamic> data = {};
                data["name"] = nameController.text;
                data["description"] = descriptionController.text;
                data["birthdate"] = formatDateTime(birthdate);
                if (selectedImage != null) {
                  MultipartFile multipartImage = await MultipartFile.fromFile(selectedImage!.path);
                  data["picture"] = multipartImage;
                }
                var res = await profileEditCubit.patchProfile(currentProfile.id, data);
                if (res != null) {
                  appRouter.pop();
                } else {
                  ///TODO: Display error toast
                }
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Icon(Icons.check, size: 32, color: Colors.green),
              ),
            ),
          )
        ],
      ),
      body : SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: BlocBuilder<ProfileEditCubit, ProfileEditState>(
                    builder: (context, state) {
                      if (state.runtimeType == ProfileEditFailed) {
                        /// TODO: exit view and display toast
                        return const Center(
                          heightFactor: 50,
                          child: Text("Profile Edit couldn't be loaded"),
                        );
                      } else if (state.runtimeType == ProfileEditLoading) {
                        return const Center(
                          heightFactor: 50,
                          child: Text("Profile Edit is loading"),
                        );
                      } else {
                        return _buildDataWidgets(profileEditCubit);
                      }
                    })
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataWidgets(ProfileEditCubit drinksCubit ) {

    final Widget picturePreviewWidget;

    if (selectedImage == null) {
      picturePreviewWidget = Image.network(preprocessPictureUrl(currentProfile.picture, baseUrl), width: 128, height: 128,);
    } else {
      picturePreviewWidget = Image.file(selectedImage!, width: 128, height: 128, fit: BoxFit.contain,);
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Username", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              const SizedBox(height: 2,),
              TextField(
                controller: nameController,
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
          const SizedBox(height: 16,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///TODO: Display remove button to set back selectedImage to null if it s not
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
                    picturePreviewWidget,
                  ],
                ),
              ),
              const Expanded(child: SizedBox(width: 16,)),
              GestureDetector(
                onTap: () async {
                  DateTime newDate = await showDialog(context: context, builder: (context) {
                    return DatePickerDialog(
                        initialDate: birthdate,
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
          const SizedBox(height: 16,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Description", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              const SizedBox(height: 2,),
              TextField(
                controller: descriptionController,
                cursorColor: Colors.deepOrangeAccent,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrangeAccent, style: BorderStyle.solid, width: 1.5),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
                maxLines: 5,
                keyboardType: TextInputType.multiline,
              ),
            ],
          ),
        ],
      ),
    );
  }

}