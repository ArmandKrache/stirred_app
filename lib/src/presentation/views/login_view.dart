
import 'package:auto_route/auto_route.dart';
import 'package:stirred_app/src/presentation/cubits/login/login_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stirred_common_domain/stirred_common_domain.dart';

@RoutePage()
class LoginView extends HookWidget {

  LoginView({Key? key}) : super (key: key);

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final remoteLoginCubit = BlocProvider.of<LoginCubit>(context);

    useEffect(() {
      remoteLoginCubit.isAlreadyLoggedIn();
      return ;
    }, const []);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          if (state.runtimeType == LoginLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.runtimeType == LoginFailed) {
            return _buildLoginForm(context, remoteLoginCubit, error :state.exception);
          } else {
            return _buildLoginForm(context, remoteLoginCubit);
          }
        },
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context, LoginCubit remoteLoginCubit, {DioException? error}) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Expanded(flex: 2, child: SizedBox()),
            Column(
              children: [
                TextField(
                  controller: usernameController,
                  cursorColor: Colors.deepPurple,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple, style: BorderStyle.solid, width: 1.5)
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Username',
                  ),
                ),
                const SizedBox(height: 16,),
                TextField(
                  controller: passwordController,
                  cursorColor: Colors.deepPurple,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple, style: BorderStyle.solid, width: 1.5)
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Password',
                  ),
                ),
                Align(alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      logger.d("Forget password tapped");
                    },
                      child: const Text("forgot password ?", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold))
                  ),
                ),
                const SizedBox(height: 16,),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white)),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
                  ),
                  onPressed: () {
                    remoteLoginCubit.logIn(request : LoginRequest(
                        username: usernameController.text,
                        password: passwordController.text
                    ));
                  },
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      child: const Text("Log in",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),)
                  ),
                ),
                const SizedBox(height: 8,),
                const SizedBox(width: 64, child: Divider(thickness: 1.5,)),
                const SizedBox(height: 8,),
                GestureDetector(
                    onTap: () {
                      logger.d("Sign up tapped");
                    },
                    child: const Text("Sign up", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold))
                ),
              ],
            ),
          ],
        ),
      ),
    );
    return Column(
      children: [
        Container(
          width: 600,
          height: 300,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          decoration: BoxDecoration(
            color: Colors.deepPurpleAccent.withOpacity(0.4),
          ),
            child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Login", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                    TextField(
                      controller: usernameController,
                      cursorColor: Colors.deepPurple,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple, style: BorderStyle.solid, width: 1.5)
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Username',
                      ),
                    ),
                    TextField(
                      controller: passwordController,
                      cursorColor: Colors.deepPurple,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple, style: BorderStyle.solid, width: 1.5)
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Password',
                      ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white)),
                        padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
                      ),
                      onPressed: () {
                        remoteLoginCubit.logIn(request : LoginRequest(
                            username: usernameController.text,
                            password: passwordController.text
                        ));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                          child: const Text("Log in",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),)
                      ),
                    ),
                  ],
                ),
            ),
        ),
        Visibility(
          visible: error != null,
          child: Container(
            margin: const EdgeInsets.only(top: 8),
            child: Center(
                child: Text(error == null ? "" : error.response?.data.toString() ?? "",
                  style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
                ),
            ),
          ),
        ),
      ],
    );
  }
}
