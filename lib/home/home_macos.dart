import 'package:flutter/cupertino.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:mdedit/generated/l10n.dart';
import 'package:mdedit/home/home.dart';
import 'package:mdedit/home/home_view_model.dart';
import 'package:mdedit/text_editor/text_editor_macos.dart';
import 'package:split_view/split_view.dart';

class HomeMacos extends Home {
  HomeMacos({super.key, required this.title});

  final String title;
  final TextEditingController _controller = TextEditingController();

  @override
  onViewModelReady(BuildContext context, HomeViewModel viewModel) {
    super.onViewModelReady(context, viewModel);
    viewModel.onCreate();
  }

  @override
  Widget buildView(
      BuildContext context, HomeViewModel viewModel, Widget? child) {
    return MacosWindow(
      child: MacosScaffold(
        toolBar: _toolBar(viewModel),
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
                  Markdown(
                    data: viewModel.previewText,
                    selectable: true,
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }

  ToolBar _toolBar(HomeViewModel viewModel) {
    return ToolBar(
      actions: [
        ToolBarIconButton(
          icon: const MacosIcon(CupertinoIcons.add),
          onPressed: viewModel.onNewClicked,
          label: S.current.menu_file_new,
          showLabel: true,
        ),
        ToolBarIconButton(
          icon: const MacosIcon(CupertinoIcons.archivebox),
          onPressed: viewModel.onOpenClicked,
          label: S.current.menu_file_open,
          showLabel: true,
        ),
        ToolBarIconButton(
          icon: const MacosIcon(CupertinoIcons.floppy_disk),
          onPressed: viewModel.isSaveEnabled ? viewModel.onSaveAsClicked : null,
          label: S.current.menu_file_save,
          showLabel: true,
        ),
        ToolBarIconButton(
          icon: const MacosIcon(CupertinoIcons.floppy_disk),
          onPressed: viewModel.onSaveAsClicked,
          label: S.current.menu_file_save_as,
          showLabel: true,
        ),
      ],
    );
  }
}
