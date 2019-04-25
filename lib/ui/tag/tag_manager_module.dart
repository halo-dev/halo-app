import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:halo/module/tag_list.dart';
import 'package:halo/net/api.dart';
import 'package:halo/net/api_request.dart';
import 'package:halo/util/Utils.dart';
import 'package:halo/util/toast.dart';

class TagListModule extends ChangeNotifier {
  TagList tagList;
  int status;

  void updateList(BuildContext context) {
    Map params = HashMap<String, dynamic>();
    params["more"] = true;
    ApiWithQuery<TagList>(Api.listTags, GET, params, (data) {
      tagList = data;
      notifyListeners();
    }, (code, msg) {
      status = code;
      ToastUtil.showToast(msg);
      notifyListeners();
    }, () {});
  }

  void delete(Tag tag) {
    ApiRequest<TagList>(Api.deleteTags(tag.id), DELETE, (data) {
      tagList.list.remove(tag);
      notifyListeners();
    }, (code, msg) {
      ToastUtil.showToast(msg);
      notifyListeners();
    }, () {});
  }

  void update(Tag tag) {
    Map params = HashMap<String, dynamic>();
    params["tagId"] = tag.id;
    ApiWithQuery<TagList>(Api.listTags, DELETE, params, (data) {
      tagList.list.remove(tag);
      notifyListeners();
    }, (code, msg) {
      ToastUtil.showToast(msg);
      notifyListeners();
    }, () {});
  }

  void create(String name, String slug) {
    /// {
    //  "name": "string",
    //  "slugName": "string"
    //}
    Map params = HashMap<String, dynamic>();
    params["name"] = name;
    params["slugName"] = slug;
    ApiWithQuery<Tag>(Api.listTags, POST, params, (data) {
      tagList.list.add(data);
      notifyListeners();
    }, (code, msg) {
      ToastUtil.showToast(msg);
      notifyListeners();
    }, () {});
  }
}