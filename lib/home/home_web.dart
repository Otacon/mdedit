import 'package:flutter/material.dart';
import 'package:mdedit/home/home.dart';
import 'package:mdedit/home/home_view_model.dart';

class HomeWeb extends Home {
  const HomeWeb({super.key, required this.title});

  final String title;

  @override
  onViewModelReady(HomeViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.events.listen((event) {});
  }

  @override
  Widget buildView(
      BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Hello world"),
        ],
      ),
    );
  }
}
