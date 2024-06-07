import 'package:etag/cors/shared/styles/styles.dart';
import 'package:etag/ui/controller/sync_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SyncPage extends StatelessWidget {
  const SyncPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sync = Modular.get<SyncController>();
    return Scaffold(
      backgroundColor: Styles.black,
      body: Center(
        child: FutureBuilder(
          future: sync.awaitCall(),
          builder: (context, snapshot) {
            return CircularProgressIndicator(
              color: Styles.ice,
            );
          },
        ),
      ),
    );
  }
}
