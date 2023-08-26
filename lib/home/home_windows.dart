import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mdedit/generated/l10n.dart';
import 'package:mdedit/home/home.dart';
import 'package:mdedit/home/home_view_model.dart';
import 'package:mdedit/text_editor/text_editor_windows.dart';
import 'package:split_view/split_view.dart';
import 'package:window_manager/window_manager.dart';

class HomeWindows extends Home {
  HomeWindows({super.key, required this.title});

  final String title;

  final TextEditingController _controller = TextEditingController();

  @override
  onViewModelReady(BuildContext context, HomeViewModel viewModel) {
    super.onViewModelReady(context, viewModel);
    windowManager.addListener(viewModel);
    viewModel.events.listen((event) async {
      switch (event) {
        case LoadContent():
          _controller.text = event.text;
        case ShowExitDialog():
          final saveFile = await _showSaveFileDialog(context);
          viewModel.onSaveFileDialogResult(saveFile);
      }
    });
  }

  @override
  Widget buildView(
      BuildContext context, HomeViewModel viewModel, Widget? child) {
    return ScaffoldPage(
      header: _toolbar(viewModel),
      padding: EdgeInsets.zero,
      content: SplitView(
        gripSize: 5.0,
        viewMode: SplitViewMode.Horizontal,
        children: [
          Mica(
            child: TextEditorWindows(
              onTextChanged: viewModel.onTextChanged,
              controller: _controller,
            ),
          ),
          Markdown(
            data: viewModel.previewText,
            selectable: true,
          ),
        ],
      ),
    );
  }

  Widget _toolbar(HomeViewModel viewModel) {
    return Mica(
      child: CommandBarCard(
        child: CommandBar(
          mainAxisAlignment: MainAxisAlignment.start,
          overflowBehavior: CommandBarOverflowBehavior.noWrap,
          primaryItems: [
            CommandBarButton(
              label: Text(S.current.menu_file_new),
              icon: const Icon(FluentIcons.add),
              onPressed: viewModel.onNewClicked,
            ),
            CommandBarButton(
              label: Text(S.current.menu_file_open),
              icon: const Icon(FluentIcons.open_file),
              onPressed: viewModel.onOpenClicked,
            ),
            CommandBarButton(
              label: Text(S.current.menu_file_save),
              icon: const Icon(FluentIcons.save),
              onPressed:
                  viewModel.isSaveEnabled ? viewModel.onSaveClicked : null,
            ),
            CommandBarButton(
              label: Text(S.current.menu_file_save_as),
              icon: const Icon(FluentIcons.save_as),
              onPressed: viewModel.onSaveAsClicked,
            ),
          ],
        ),
      ),
    );
  }

  Future<bool?> _showSaveFileDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return ContentDialog(
          title: const Text('Save file'),
          content: const Text('Do you want to save the file?'),
          actions: <Widget>[
            Button(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FilledButton(
              child: const Text('Save'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
