
import 'package:flutter/widgets.dart';
import 'package:mdedit/home/home_view_model.dart';
import 'package:mdedit/screen.dart';

abstract class Home extends Screen<HomeViewModel> {
  const Home({super.key});

  static const path = "/";

  @override
  onViewModelReady(BuildContext context, HomeViewModel viewModel) {
    viewModel.onCreate();
  }

}