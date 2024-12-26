import 'package:flutter/material.dart';
import '../theme/theme_manager.dart';

@immutable
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.arrow_forward),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'Hello',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                onTap: () {},
                child: const ListTile(
                  title: Text('Tema'),
                  trailing: Icon(Icons.arrow_forward),
                ),
              ),
            ),
            const Divider(),
            AnimatedBuilder(
              animation: ThemeManager.of(context).store,
              builder: (context, child) => Column(
                children: [
                  ListTile(
                    title: const Text('Padrão do sistema'),
                    trailing: Radio<ThemeMode>(
                      groupValue: ThemeManager.of(context).store.themeMode,
                      value: ThemeMode.system,
                      onChanged: (_) {
                        ThemeManager.of(context).store.themeMode =
                            ThemeMode.system;
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Claro'),
                    trailing: Radio<ThemeMode>(
                      groupValue: ThemeManager.of(context).store.themeMode,
                      value: ThemeMode.light,
                      onChanged: (_) {
                        ThemeManager.of(context).store.themeMode =
                            ThemeMode.light;
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Escuro'),
                    trailing: Radio<ThemeMode>(
                      groupValue: ThemeManager.of(context).store.themeMode,
                      value: ThemeMode.dark,
                      onChanged: (_) {
                        ThemeManager.of(context).store.themeMode =
                            ThemeMode.dark;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
