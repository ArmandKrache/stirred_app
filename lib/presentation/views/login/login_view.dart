import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stirred_app/core/extensions/widget_ref.dart';
import 'package:stirred_app/presentation/widgets/design_system/stir_button.dart';
import 'package:stirred_app/presentation/widgets/design_system/stir_text.dart';
import 'package:stirred_app/presentation/widgets/design_system/stir_text_field.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.colors;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 64),
              Text('Stirred', style: Theme.of(context).textTheme.headlineLarge),
              Spacer(),
              StirTextField(
                hint: 'Email',
              ),
              SizedBox(height: 16),
              StirTextField(
                hint: 'Password',
              ),
              SizedBox(height: 4),
              Align(
                alignment: Alignment.centerRight,
                child: StirText.bodyMedium('Forgot password?', color: colors.onPrimary),
              ),
              SizedBox(height: 24),
              StirButton.primary(
                onPressed: () {},
                label: 'Login',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
