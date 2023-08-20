
import 'package:flutter/material.dart';
import 'package:mdedit/generated/l10n.dart';
import 'package:mdedit/screen.dart';
import 'package:mdedit/toolbar/toolbar_view_model.dart';

class ToolbarLinux extends Screen<ToolbarViewModel> {
  
  const ToolbarLinux({super.key});
  
  @override
  Widget buildView(BuildContext context, ToolbarViewModel viewModel, Widget? child) {
    return MenuBar(
      children: [
        SubmenuButton(menuChildren: [
          _MenuItem(
            label: S.current.menu_file_new,
            icon: const Icon(Icons.note_add),
            onPressed: viewModel.onNewClicked,
          ),
          const Divider(),
          _MenuItem(
            label: S.current.menu_file_open,
            icon: const Icon(Icons.file_open),
            onPressed: viewModel.onOpenClicked,
          ),
          _MenuItem(
            label: S.current.menu_file_save,
            icon: const Icon(Icons.save),
            onPressed: viewModel.isSaveEnabled ? viewModel.onSaveClicked : null,
          ),
          _MenuItem(
            label: S.current.menu_file_save_as,
            icon: const Icon(Icons.save_as),
            onPressed: viewModel.onSaveAsClicked,
          ),
          const Divider(),
          _MenuItem(
            label: S.current.menu_file_exit,
            icon: const Icon(Icons.exit_to_app),
            onPressed: viewModel.onExitClicked,
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