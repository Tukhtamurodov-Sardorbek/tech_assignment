part of '../home_page.dart';

class _Footer extends StatelessWidget {
  const _Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final refrence = HomePage.of(context);
    var selectedType = NoteType.observation;
    final inputController = refrence.inputController;
    final summaryController = refrence.summaryController;

    return BlocBuilder<ShiftHandoverBloc, ShiftHandoverState>(
      buildWhen: (prev, cur) {
        return cur.maybeWhen(
          loading: (isSubmission) => !isSubmission,
          orElse: () => true,
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          loaded: (_) {
            return Material(
              elevation: 8.0,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    StatefulBuilder(builder: (context, setState) {
                      return Column(
                        children: [
                          TextField(
                            controller: inputController,
                            decoration: const InputDecoration(
                              hintText: 'Add a new note for the next shift...',
                            ),
                            onSubmitted: (value) {
                              if (value.isNotEmpty) {
                                context.read<ShiftHandoverBloc>().add(
                                    ShiftHandoverEvent.addNote(
                                        text: value, type: selectedType));
                                inputController.clear();
                              }
                            },
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.0),
                              border:
                                  Border.all(color: const Color(0xFFBDBDBD)),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<NoteType>(
                                value: selectedType,
                                isExpanded: true,
                                icon: const Icon(Icons.category_outlined),
                                onChanged: (NoteType? newValue) {
                                  if (newValue != null) {
                                    setState(() {
                                      selectedType = newValue;
                                    });
                                  }
                                },
                                items: NoteType.values.map((NoteType type) {
                                  return DropdownMenuItem<NoteType>(
                                    value: type,
                                    child: Text(type.name.toUpperCase()),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                    const SizedBox(height: 16),
                    BlocBuilder<ShiftHandoverBloc, ShiftHandoverState>(
                        builder: (context, state) {
                      final hide = state.maybeWhen(
                          loading: (isSubmission) => isSubmission,
                          orElse: () => false);

                      return ElevatedButton.icon(
                        icon: hide
                            ? const SizedBox.shrink()
                            : const Icon(Icons.send),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 52),
                        ),
                        onPressed: hide
                            ? null
                            : () {
                                _showSubmitDialog(
                                  context,
                                  selectedType,
                                  inputController,
                                  summaryController,
                                );
                              },
                        label: hide
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  color: Colors.white,
                                ))
                            : const Text('Submit Final Report'),
                      );
                    }),
                  ],
                ),
              ),
            );
          },
          orElse: () => const SizedBox.shrink(),
        );
      },
    );
  }

  void _showSubmitDialog(
    BuildContext context,
    NoteType selectedType,
    TextEditingController inputController,
    TextEditingController summaryController,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Finalize and Submit Report'),
        content: TextField(
          controller: summaryController,
          maxLines: 3,
          decoration:
              const InputDecoration(hintText: "Enter a brief shift summary..."),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final input = inputController.text;
              if (input.isNotEmpty && input.trim().isNotEmpty) {
                context.read<ShiftHandoverBloc>().add(
                      ShiftHandoverEvent.addNote(
                          text: input, type: selectedType),
                    );
                inputController.clear();
              }
              context.read<ShiftHandoverBloc>().add(
                  ShiftHandoverEvent.submit(summaryController.text.trim()));
              Navigator.pop(dialogContext);
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
