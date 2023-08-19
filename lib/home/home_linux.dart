import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mdedit/home/home.dart';
import 'package:mdedit/home/home_view_model.dart';
import 'package:mdedit/generated/l10n.dart';
import 'package:mdedit/text_editor/text_editor_linux.dart';
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
          _Menubar(
            onNewClicked: viewModel.onNewClicked,
            onOpenClicked: viewModel.onOpenClicked,
            onSaveClicked: viewModel.onSaveClicked,
            onSaveAsClicked: viewModel.onSaveAsClicked,
            onExitClicked: viewModel.onExitClicked,
          ),
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

class _Menubar extends StatelessWidget {
  final VoidCallback onNewClicked;
  final VoidCallback onOpenClicked;
  final VoidCallback onSaveClicked;
  final VoidCallback onSaveAsClicked;
  final VoidCallback onExitClicked;

  const _Menubar({
    required this.onNewClicked,
    required this.onOpenClicked,
    required this.onSaveClicked,
    required this.onSaveAsClicked,
    required this.onExitClicked,
  });

  @override
  Widget build(BuildContext context) {
    return MenuBar(
      children: [
        SubmenuButton(menuChildren: [
          _MenuItem(
            label: S.current.menu_file_new,
            icon: const Icon(Icons.note_add),
            onPressed: onNewClicked,
          ),
          const Divider(),
          _MenuItem(
            label: S.current.menu_file_open,
            icon: const Icon(Icons.file_open),
            onPressed: onOpenClicked,
          ),
          _MenuItem(
            label: S.current.menu_file_save,
            icon: const Icon(Icons.save),
            onPressed: onSaveClicked,
          ),
          _MenuItem(
            label: S.current.menu_file_save_as,
            icon: const Icon(Icons.save_as),
            onPressed: onSaveAsClicked,
          ),
          const Divider(),
          _MenuItem(
            label: S.current.menu_file_exit,
            icon: const Icon(Icons.exit_to_app),
            onPressed: onExitClicked,
          ),
        ], child: Text(S.current.menu_file)),
      ],
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Icon? icon;

  const _MenuItem({required this.label, this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return MenuItemButton(
      onPressed: onPressed,
      child: Row(
        children: [
          icon ?? const SizedBox(width: 24, height: 16),
          const SizedBox(width: 10),
          Text(label)
        ],
      ),
    );
  }
}
