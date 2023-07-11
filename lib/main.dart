import 'package:template_app/src/config/router/app_router.dart';
import 'package:template_app/src/config/themes/app_themes.dart';
import 'package:template_app/src/domain/repositories/api_repository.dart';
import 'package:template_app/src/domain/repositories/database_repository.dart';
import 'package:template_app/src/locator.dart';
import 'package:template_app/src/presentation/cubits/local_articles/local_articles_cubit.dart';
import 'package:template_app/src/presentation/cubits/remote_articles/remote_articles_cubit.dart';
import 'package:template_app/src/utils/constants/strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();

  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('fr')],
      path: 'assets/translations/',
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp()
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocalArticlesCubit(
          locator<DatabaseRepository>())..getAllSavedArticles(),
        ),
        BlocProvider(create: (context) => RemoteArticlesCubit(
          locator<ApiRepository>(),)..getBreakingNewsArticles(),
        )
      ],
      child: OKToast(child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter.config(),
        title: appTitle,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: AppTheme.light,
      )),
    );
  }
}
