import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mdedit/home/home.dart';
import 'package:mdedit/home/home_view_model.dart';
import 'package:mdedit/text_editor/text_editor_linux.dart';
import 'package:mdedit/toolbar/toolbar_linux.dart';
import 'package:split_view/split_view.dart';

class HomeLinux extends Home {
  HomeLinux({super.key, required this.title});

  final String title;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget buildView(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const ToolbarLinux(),
          Expanded(
            child: SplitView(
              viewMode: SplitViewMode.Horizontal,
              children: [
                TextEditorLinux(
                  controller: _controller, 
                  onTextChanged: viewModel.onTextChanged,
                ),
                Markdown(data: viewModel.previewText),
              ],
            ),
          ),
        ],
      ),
    );
  }
}