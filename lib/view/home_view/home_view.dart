import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kickstart/view_model/home_view_model/home_view_model.dart';
import 'package:stacked/stacked.dart';

class HomeView extends ViewModelBuilderWidget<HomeViewModel> {
  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel model) => null;

  @override
  Widget builder(BuildContext context, HomeViewModel model, Widget child) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr("app-name")),
      ),
    );
  }
}
