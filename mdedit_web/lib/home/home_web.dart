import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get_it/get_it.dart';
import 'package:mdedit_api/home/home_view_model.dart';
import 'package:mdedit_web/text_editor/text_editor_web.dart';
import 'package:split_view/split_view.dart';
import 'package:stacked/stacked.dart';

class HomeWeb extends StatefulWidget {
  const HomeWeb({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomeWebState();
  }
}

class HomeWebState extends State<HomeWeb> {
  final TextEditingController _controller = TextEditingController();
  VoidCallback? textChanged;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final callback = textChanged;
      if (callback != null) {
        callback();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => GetIt.I.get(),
      onViewModelReady: (viewModel) {
        textChanged = () {
          viewModel.onTextChanged(_controller.text);
        };
        viewModel.events.listen((event) async {
          switch (event) {
            case LoadContent():
              _controller.text = event.text;
            case ShowExitDialog():
          }
        });
      },
      builder: _buildView,
    );
  }

  Widget _buildView(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.note_add),
            onPressed: viewModel.onNewClicked,
          ),
          IconButton(
            icon: const Icon(Icons.file_open),
            onPressed: viewModel.onOpenClicked,
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: viewModel.onSaveAsClicked,
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SplitView(
              viewMode: SplitViewMode.Horizontal,
              children: [
                TextEditorWeb(controller: _controller),
                Markdown(
                  data: viewModel.previewText,
                  selectable: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
