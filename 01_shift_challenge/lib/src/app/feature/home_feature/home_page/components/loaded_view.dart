part of '../home_page.dart';

class _LoadedView extends StatelessWidget {
  final ShiftReport report;

  const _LoadedView({required this.report});

  @override
  Widget build(BuildContext context) {
    return report.notes.isEmpty
        ? SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Text(
                'No notes added yet.\nUse the form below to add the first note.',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey[600]),
              ),
            ),
          )
        : SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList.separated(
              itemCount: report.notes.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return NoteCard(note: report.notes[index]);
              },
            ),
          );
  }
}
