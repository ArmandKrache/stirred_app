import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:stirred_app/src/config/router/app_router.dart';
import 'package:stirred_app/src/presentation/cubits/drink/drink_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stirred_app/src/presentation/cubits/profile/profile_cubit.dart';
import 'package:stirred_app/src/presentation/widgets/rating_dialog_widget.dart';
import 'package:stirred_app/src/utils/constants/functions.dart';
import 'package:stirred_app/src/utils/constants/global_data.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


@RoutePage()
class ProfileView extends StatefulHookWidget {
  const ProfileView({Key? key}) : super (key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileCubit = BlocProvider.of<ProfileCubit>(context);
    final rebuildFlag = useState<bool>(false);
    triggerRebuild() {
      rebuildFlag.value = true;
    }


    useEffect(() {
      if (rebuildFlag.value) {
        profileCubit.rebuild();
        rebuildFlag.value = false;
      }
      return ;
    }, [rebuildFlag.value]);

    return Scaffold(
      body : SafeArea(
        child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state.runtimeType == ProfileFailed) {
                    return const Center(
                      heightFactor: 50,
                      child: Text("Profile couldn't be loaded"),
                    );
                  } else if (state.runtimeType == ProfileLoading) {
                    return const Center(
                      heightFactor: 50,
                      child: Text("Profile is loading"),
                    );
                  } else {
                    return _buildProfileDataWidgets(profileCubit, triggerRebuild);
                  }
                })
        ),
      ),
    );
  }


  Widget _buildProfileDataWidgets(ProfileCubit profileCubit, Function() triggerRebuild) {

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(256),
                  child: Image.network(currentProfile.picture, width: 192, height: 192, fit: BoxFit.fill,)
                ),
                const SizedBox(height: 8,),
                Text(currentProfile.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ExpandableText(currentProfile.description,
                  expandText: "read more",
                  collapseText: "reduce",
                  maxLines: 3,
                  textAlign: TextAlign.start,
                  linkStyle: const TextStyle(fontWeight: FontWeight.bold),
                  linkEllipsis: false,
                ),
              ],
            ),
          ),
        ),
        settingsButton(triggerRebuild),
      ],
    );
  }

  Widget settingsButton(Function() triggerRebuild) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: () {
            showModalBottomSheet<void>(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24),
                    topLeft: Radius.circular(24)
                ),
              ),
              builder: (BuildContext context) {
                return SafeArea(
                  child: Container(
                    padding: const EdgeInsets.only(top: 24),
                    height: 108,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () async {
                              await appRouter.push(const ProfileEditRoute());
                              triggerRebuild.call();
                            },
                            child: Container(
                              color: Colors.transparent,
                              padding: const EdgeInsets.all(8),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Edit Profile", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 0.4),),
                                  Icon(Icons.arrow_forward_ios)
                                ],
                              ),
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          GestureDetector(
                            onTap: () {
                              /// TODO: Log Out logic
                            },
                            child: const Text("Disconnect",
                              style: TextStyle(fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  letterSpacing: 0.4
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
          child: Icon(Icons.settings, size: 28, color: Colors.black.withOpacity(0.7),),
        ),
      ),
    );
  }
}