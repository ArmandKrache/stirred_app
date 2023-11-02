import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:stirred_app/src/config/router/app_router.dart';
import 'package:stirred_app/src/presentation/cubits/drink/drink_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stirred_app/src/presentation/cubits/profile/profile_edit_cubit.dart';
import 'package:stirred_app/src/presentation/widgets/rating_dialog_widget.dart';
import 'package:stirred_app/src/utils/constants/functions.dart';
import 'package:stirred_app/src/utils/constants/global_data.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


@RoutePage()
class ProfileEditView extends StatefulHookWidget {

  const ProfileEditView({Key? key}) : super (key: key);

  @override
  State<ProfileEditView> createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends State<ProfileEditView> {

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
    final profileEditCubit = BlocProvider.of<ProfileEditCubit>(context);

    useEffect(() {
      return ;
    }, const []);

    return Scaffold(
      appBar: AppBar(),
      body : SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: BlocBuilder<DrinkCubit, DrinkState>(
                    builder: (context, state) {
                      if (state.runtimeType == DrinkFailed) {
                        /// TODO: exit view and display toast
                        return const Center(
                          heightFactor: 50,
                          child: Text("Profile Edit couldn't be loaded"),
                        );
                      } else if (state.runtimeType == DrinkLoading && state.drink == null) {
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

    return const SizedBox();
  }

}