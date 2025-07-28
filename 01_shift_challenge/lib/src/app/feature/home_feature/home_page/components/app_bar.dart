part of '../home_page.dart';

class _AppBar extends StatelessWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      title: const FittedBox(child: Text('Shift Handover Report')),
      actions: [
        BlocBuilder<ShiftHandoverBloc, ShiftHandoverState>(
          builder: (context, state) {
            final isLoading = state.maybeWhen(
                loading: (isSubmission) => !isSubmission, orElse: () => false);
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: isLoading
                  ? const SizedBox.shrink()
                  : IconButton(
                      icon: const Icon(Icons.refresh),
                      tooltip: 'Refresh Report',
                      onPressed: () {
                        context
                            .read<ShiftHandoverBloc>()
                            .add(ShiftHandoverEvent.load('current-user-id'));
                      },
                    ),
            );
          },
        ),
      ],
    );
  }
}
