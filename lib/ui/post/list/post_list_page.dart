import 'package:flutter/material.dart';
import 'package:halo/app/base/base_widget.dart';
import 'package:halo/app/config.dart' as cf;
import 'package:halo/app/provide.dart';
import 'package:halo/module/category_list.dart';
import 'package:halo/ui/post/edit/edit_page.dart';
import 'package:halo/ui/post/list/list_item.dart';
import 'package:halo/ui/post/list/search_post_list_page.dart';
import 'package:halo/ui/post/post_manager_module.dart';
import 'package:halo/util/jump_page.dart';
import 'package:halo/widget/loading_dialog.dart';
import 'package:halo/widget/refresh_list.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PostListPage extends StatefulWidget {
  Category category;
  String keyWord, postStatus;

  PostListPage({this.category, this.keyWord, this.postStatus});

  @override
  State<StatefulWidget> createState() {
    return _ArticleListPageView();
  }
}

class _ArticleListPageView extends BaseState<PostListPage> with PullRefreshMixIn {
  RefreshController controller;

  @override
  void initState() {
    super.initState();
    controller = RefreshController();
  }

  @override
  void onFirstInit() {
    refresh(true);
  }

  void refresh(bool refresh) {
    Provide.value<PostListModule>(context).refresh(refresh,
        cate: widget.category, key: widget.keyWord, postStatus: widget.postStatus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cf.Config.background,
      appBar: AppBar(
        title: Text(widget.category == null ? "博客文章" : "${widget.category.name}下的文章"),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () {
                pushToNewPage(context, SearchPostListPage());
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Image.asset(
          "assest/images/push_article.png",
          width: 24,
          height: 24,
          color: Colors.white,
        ),
        tooltip: "发布新文章",
        onPressed: () {
          pushToNewPage(context, EditPostPage(false, null));
        },
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 0, 135, 190),
        elevation: 5.0,
        highlightElevation: 10.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Provide<PostListModule>(builder: (context, child, mode) {
        return _buildList(context, mode);
      }),
    );
  }

  Widget _buildList(
    BuildContext context,
    PostListModule mode,
  ) {
    finishRefresh(controller);
    IndexedWidgetBuilder builder;
    if (mode.articleList.isEmpty) {
      builder = (BuildContext context, int index) {
        return loadWithStatus(mode.status);
      };
    } else {
      builder = (BuildContext context, int index) {
        return ListItemPage(mode.articleList[index]);
      };
    }
    return buildRefresh(builderList(mode.articleList.length, builder), (up) {
      refresh(up);
    }, controller);
  }
}
