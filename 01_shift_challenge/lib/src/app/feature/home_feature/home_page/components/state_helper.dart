part of '../home_page.dart';

mixin _StateHelper<HomePage extends StatefulWidget> on State<HomePage> {
  late final TextEditingController inputController;
  late final TextEditingController summaryController;

  @override
  void initState() {
    super.initState();
    inputController = TextEditingController();
    summaryController = TextEditingController();
  }


  @override
  void dispose() {
    inputController.dispose();
    summaryController.dispose();
    super.dispose();
  }
}
