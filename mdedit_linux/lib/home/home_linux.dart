import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get_it/get_it.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:libadwaita_window_manager/libadwaita_window_manager.dart';
import 'package:mdedit_linux/text_editor/text_editor_linux.dart';
import 'package:mdedit_api/home/home_view_model.dart';
import 'package:split_view/split_view.dart';
import 'package:stacked/stacked.dart';
import 'package:window_manager/window_manager.dart';

class HomeLinux extends StatelessWidget {
  HomeLinux({super.key, required this.title});

  final String title;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => GetIt.I.get(),
      onViewModelReady: (viewModel) {
        windowManager.addListener(viewModel);
        viewModel.events.listen((event) async {
          switch (event) {
            case LoadContent():
              _controller.text = event.text;
            case ShowExitDialog():
            //TODO
            //final saveFile = await _showSaveFileDialog(context);
            //viewModel.onSaveFileDialogResult(saveFile);
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
    return AdwScaffold(
      actions: AdwActions().windowManager,
      start: [
        AdwHeaderButton(
          icon: const Icon(Icons.file_open),
          onPressed: () => viewModel.onNewClicked(),
        ),
        AdwHeaderButton(
          icon: const Icon(Icons.note_add),
          onPressed: () => viewModel.onOpenClicked(),
        ),
        AdwHeaderButton(
          icon: const Icon(Icons.save),
          onPressed: () =>
              viewModel.isSaveEnabled ? viewModel.onSaveClicked : null,
        ),
        AdwHeaderButton(
          icon: const Icon(Icons.save_as),
          onPressed: () => viewModel.onSaveAsClicked(),
        ),
      ],
      end: const [],
      title: const Text("Title"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SplitView(
              viewMode: SplitViewMode.Horizontal,
              children: [
                TextEditorLinux(
                  controller: _controller,
                  onTextChanged: viewModel.onTextChanged,
                ),
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
