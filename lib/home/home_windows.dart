import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:mdedit/generated/l10n.dart';
import 'package:mdedit/home/home.dart';
import 'package:mdedit/home/home_view_model.dart';

class HomeWindows extends Home {
  const HomeWindows({super.key, required this.title});

  final String title;

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
            CommandBar(
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
                ]),
          ],
        ),
      ),
    );
  }
}
