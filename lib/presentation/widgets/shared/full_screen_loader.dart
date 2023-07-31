import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  Stream<String> getLoadingMessages() {
    final messages = <String>[
      'Llamando a mi novia',
      'Caray esto tarda mucho',
      'Que esperas has palomitas de maíz',
      'Prepara el sillon esto esta cool...',
      'Espera ya casi terminamos!'
    ];

    return Stream.periodic(const Duration(milliseconds: 2000), (step) {
      return messages[step];
    }).take(messages.length);
  }

  const FullScreenLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(strokeWidth: 4, color: color.primary),
          const SizedBox(height: 20),
          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text(
                  'Cargando...',
                  style: textStyle.titleLarge,
                );
              }

              return Text(
                snapshot.data!,
                style: textStyle.titleLarge!.copyWith(color: color.secondary),
              );
            },
          ),
        ],
      ),
    );
  }
}
