import 'package:flutter/cupertino.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get_it/get_it.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:mdedit_api/generated/l10n.dart';
import 'package:mdedit_api/home/home_view_model.dart';
import 'package:mdedit_macos/text_editor/text_editor_macos.dart';
import 'package:split_view/split_view.dart';
import 'package:stacked/stacked.dart';

class HomeMacos extends StatelessWidget {
  HomeMacos({super.key, required this.title});

  final String title;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => GetIt.I.get(),
      onViewModelReady: (viewModel) {
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
