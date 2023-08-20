import 'package:flutter/cupertino.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get_it/get_it.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:mdedit/home/home.dart';
import 'package:mdedit/home/home_view_model.dart';
import 'package:mdedit/text_editor/text_editor_macos.dart';
import 'package:mdedit/toolbar/toolbar_macos.dart';
import 'package:mdedit/toolbar/toolbar_view_model.dart';
import 'package:split_view/split_view.dart';

class HomeMacos extends Home {
  HomeMacos({super.key, required this.title});

  final String title;
  final TextEditingController _controller = TextEditingController();
  late ToolbarViewModel toolbarViewModel;

  @override
  onViewModelReady(BuildContext context, HomeViewModel viewModel) {
    super.onViewModelReady(context, viewModel);
    toolbarViewModel = GetIt.I.get();
  }

  @override
  Widget buildView(
      BuildContext context, HomeViewModel viewModel, Widget? child) {
    return MacosWindow(
      child: MacosScaffold(
        toolBar: ToolbarMacos(
          onNewClicked: toolbarViewModel.onNewClicked,
          onOpenClicked: toolbarViewModel.onOpenClicked,
          onSaveClicked: toolbarViewModel.onSaveClicked,
          onSaveAsClicked: toolbarViewModel.onSaveAsClicked,
          isSaveEnabled: toolbarViewModel.isSaveEnabled,
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
