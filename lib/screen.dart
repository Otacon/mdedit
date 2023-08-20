import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';

abstract class Screen<VIEWMODEL extends ChangeNotifier>
    extends StatelessWidget {
  const Screen({super.key});

  VIEWMODEL createViewModel() {
    return GetIt.I.get();
  }

  onViewModelReady(BuildContext context, VIEWMODEL viewModel) {}

  Widget buildView(
    BuildContext context,
    VIEWMODEL viewModel,
    Widget? child,
  );

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VIEWMODEL>.reactive(
      viewModelBuilder: createViewModel,
      onViewModelReady: (viewModel) { onViewModelReady(context, viewModel); },
      builder: buildView,
    );
  }
}
