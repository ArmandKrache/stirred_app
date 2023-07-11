import 'package:auto_route/auto_route.dart';
import 'package:template_app/src/config/router/app_router.dart';
import 'package:template_app/src/domain/models/article.dart';
import 'package:template_app/src/presentation/cubits/local_articles/local_articles_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
import 'package:oktoast/oktoast.dart';

@RoutePage()
class ArticleDetailsView extends HookWidget {
  final Article article;

  const ArticleDetailsView({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localArticlesCubit = BlocProvider.of<LocalArticlesCubit>(context);

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => appRouter.pop(),
          child: const Icon(Ionicons.chevron_back, color: Colors.black,),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildArticleTitleAndDate(),
            _buildArticleImage(),
            _buildArticleDescription(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          localArticlesCubit.saveArticle(article: article);
          showToast(tr("article_details.article_saved_confirm"));
        },
        child: const Icon(Ionicons.bookmark, color: Colors.white,),
      ),
    );
  }

  Widget _buildArticleTitleAndDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article.title ?? "",
            style: const TextStyle(
              fontFamily: "Butler",
              fontSize: 20,
              fontWeight: FontWeight.w900
            ),
          ),
          const SizedBox(height: 12,),
          Row(
            children: [
              const Icon(Ionicons.time_outline, size: 16,),
              const SizedBox(width: 4,),
              Text(
                article.publishedAt ?? '',
                style: const TextStyle(fontSize: 12),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildArticleImage() {
    return Container(
      width: double.maxFinite,
      height: 256,
      margin: const EdgeInsets.only(top: 12),
      child: Image.network(
        article.urlToImage ?? '',
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
      ),
    );
  }

  Widget _buildArticleDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Text('${article.description}\n\n${article.content}',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}