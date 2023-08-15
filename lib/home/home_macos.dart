import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:mdedit/home/home.dart';
import 'package:mdedit/home/home_view_model.dart';

class HomeMacos extends Home {
  const HomeMacos({super.key, required this.title});

  final String title;

  @override
  Widget buildView(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return MacosScaffold(
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
            label: 'Save as',
            showLabel: true,
          ),
        ],
      ),
    );
  }

}