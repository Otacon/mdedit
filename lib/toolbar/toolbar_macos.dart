import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:mdedit/generated/l10n.dart';

class ToolbarMacos extends ToolBar {

  ToolbarMacos({super.key, 
    required onNewClicked,
    required onOpenClicked,
    required onSaveClicked,
    required onSaveAsClicked,
    required bool isSaveEnabled,
  }): super(actions: [
            ToolBarIconButton(
              icon: const MacosIcon(CupertinoIcons.add),
              onPressed: onNewClicked,
              label: S.current.menu_file_new,
              showLabel: true,
            ),
            ToolBarIconButton(
              icon: const MacosIcon(CupertinoIcons.archivebox),
              onPressed: onOpenClicked,
              label: S.current.menu_file_open,
              showLabel: true,
            ),
            ToolBarIconButton(
              icon: const MacosIcon(CupertinoIcons.floppy_disk),
              onPressed: isSaveEnabled ? onSaveAsClicked : null,
              label: S.current.menu_file_save,
              showLabel: true,
            ),
            ToolBarIconButton(
              icon: const MacosIcon(CupertinoIcons.floppy_disk),
              onPressed: onSaveAsClicked,
              label: S.current.menu_file_save_as,
              showLabel: true,
            ),
          ],
        );

}