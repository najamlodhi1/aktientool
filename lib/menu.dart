import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final titleProvider = StateProvider((ref) {
  return 5;
});

class Menu extends ConsumerWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchTitleprovider = ref.watch(titleProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Wrap(
            children: [
              ElevatedButton(
                  onPressed: () {
                    ref
                        .read(titleProvider.state)
                        .state++; // stateProvider wird geupdatet
                  },
                  child: Text(watchTitleprovider
                      .toString())) // stateProvider wird geladen
            ],
          ),
        ),
      ),
    );
  }
}
