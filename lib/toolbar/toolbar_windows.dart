import 'package:fluent_ui/fluent_ui.dart';
import 'package:mdedit/generated/l10n.dart';
import 'package:mdedit/screen.dart';
import 'package:mdedit/toolbar/toolbar_view_model.dart';

class ToolbarWindows extends Screen<ToolbarViewModel> {
  const ToolbarWindows({super.key});

  @override
  Widget buildView(
      BuildContext context, ToolbarViewModel viewModel, Widget? child) {
    return Padding(
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
            onPressed: viewModel.isSaveEnabled ? viewModel.onSaveClicked : null,
          ),
          CommandBarButton(
            label: Text(S.current.menu_file_save_as),
            icon: const Icon(FluentIcons.save_as),
            onPressed: viewModel.onSaveAsClicked,
          ),
        ],
      ),
    );
  }
}
