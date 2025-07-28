import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:shift_handover_challenge/src/app/app_bloc/app_bloc.dart';
import 'package:shift_handover_challenge/src/app/feature/home_feature/home_page/components/note_card.dart';
import 'package:shift_handover_challenge/src/domain/model/model.dart';

part 'components/app_bar.dart';

part 'components/footer.dart';

part 'components/loaded_view.dart';

part 'components/state_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  static _HomePageState of(BuildContext context) {
    final state = context.findAncestorStateOfType<_HomePageState>();
    assert(
        state != null, 'No _HomePageState ancestor found in the widget tree');
    return state!;
  }
}

class _HomePageState extends State<HomePage> with _StateHelper {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ShiftHandoverBloc, ShiftHandoverState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('An error occurred: $message'),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          },
          loaded: (report) {
            if (report.isSubmitted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Report submitted successfully!'),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
              );
            }
          },
        );
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    _AppBar(),
                    BlocBuilder<ShiftHandoverBloc, ShiftHandoverState>(
                      buildWhen: (prev, cur) {
                        return cur.maybeWhen(
                          loading: (isSubmission) => !isSubmission,
                          orElse: () => true,
                        );
                      },
                      builder: (context, state) {
                        return state.maybeWhen(
                          loaded: (report) => _LoadedView(report: report),
                          loading: (_) {
                            return const SliverFillRemaining(
                              hasScrollBody: false,
                              child: Center(
                                child: CircularProgressIndicator.adaptive(),
                              ),
                            );
                          },
                          orElse: () {
                            return SliverFillRemaining(
                              hasScrollBody: false,
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Failed to load shift report.',
                                        style: TextStyle(fontSize: 16)),
                                    const SizedBox(height: 16),
                                    ElevatedButton.icon(
                                      icon: const Icon(Icons.refresh),
                                      label: const Text('Try Again'),
                                      onPressed: () => context
                                          .read<ShiftHandoverBloc>()
                                          .add(ShiftHandoverEvent.load(
                                              'current-user-id')),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              _Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
