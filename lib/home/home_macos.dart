import 'package:flutter/cupertino.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:mdedit/home/home.dart';
import 'package:mdedit/home/home_view_model.dart';
import 'package:mdedit/text_editor/text_editor_macos.dart';
import 'package:split_view/split_view.dart';

class HomeMacos extends Home {
  HomeMacos({super.key, required this.title});

  final String title;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget buildView(
      BuildContext context, HomeViewModel viewModel, Widget? child) {
    return MacosWindow(
      child: MacosScaffold(
        toolBar: ToolBar(
          actions: [
            ToolBarIconButton(
              icon: const MacosIcon(CupertinoIcons.add),
              onPressed: viewModel.onNewClicked,
              label: 'New',
              showLabel: true,
            ),
            ToolBarIconButton(
              icon: const MacosIcon(CupertinoIcons.archivebox),
              onPressed: viewModel.onOpenClicked,
              label: 'Open',
              showLabel: true,
            ),
            ToolBarIconButton(
              icon: const MacosIcon(CupertinoIcons.floppy_disk),
              onPressed: viewModel.onSaveAsClicked,
              label: 'Save',
              showLabel: true,
            ),
            ToolBarIconButton(
              icon: const MacosIcon(CupertinoIcons.floppy_disk),
              onPressed: viewModel.onSaveAsClicked,
              label: 'Save as...',
              showLabel: true,
            ),
          ],
        ),
        children: [
          ContentArea(
            builder: (_, __) {
              return SplitView(
                  gripSize: 5.0,
                  viewMode: SplitViewMode.Horizontal,
                  children: [
                    TextEditorMacos(
                      controller: _controller,
                      onTextChanged: viewModel.onTextChanged,
                    ),
                    Markdown(data: viewModel.previewText),
                  ],
                );
            },
          )
        ],
      ),
    );
  }
}
