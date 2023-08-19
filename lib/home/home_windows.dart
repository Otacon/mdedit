import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mdedit/generated/l10n.dart';
import 'package:mdedit/home/home.dart';
import 'package:mdedit/home/home_view_model.dart';
import 'package:mdedit/text_editor/text_editor_windows.dart';
import 'package:split_view/split_view.dart';

class HomeWindows extends Home {
  HomeWindows({super.key, required this.title});

  final String title;

  final TextEditingController _controller = TextEditingController();

  @override
  onViewModelReady(HomeViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.events.listen((event) {
      switch (event) {
        case LoadContent():
          _controller.text = event.text;
      }
    });
  }

  @override
  Widget buildView(
      BuildContext context, HomeViewModel viewModel, Widget? child) {
    return ScaffoldPage(
      padding: EdgeInsets.zero,
      content: Acrylic(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CommandBar(
                overflowBehavior: CommandBarOverflowBehavior.noWrap,
                primaryItems: [
                  CommandBarButton(
                    label: Text(S.current.menu_file_new),
                    icon: const Icon(FluentIcons.add),
                    onPressed: viewModel.onNewClicked,
                  ),
                  const CommandBarSeparator(),
                  CommandBarButton(
                    label: Text(S.current.menu_file_open),
                    icon: const Icon(FluentIcons.open_file),
                    onPressed: viewModel.onOpenClicked,
                  ),
                  CommandBarButton(
                      label: Text(S.current.menu_file_save),
                      icon: const Icon(FluentIcons.save),
                      onPressed: viewModel.onSaveClicked),
                  CommandBarButton(
                    label: Text(S.current.menu_file_save_as),
                    icon: const Icon(FluentIcons.save_as),
                    onPressed: viewModel.onSaveAsClicked,
                  ),
                ],
              ),
            ),
            Expanded(
              child: SplitView(
                gripSize: 5.0,
                viewMode: SplitViewMode.Horizontal,
                children: [
                  TextEditorWindows(
                    onTextChanged: viewModel.onTextChanged,
                    controller: _controller,
                  ),
                  Markdown(data: viewModel.previewText),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
