import 'package:binah_flutter_sdk/session/session_state.dart';
import 'package:binah_flutter_sdk/ui/camera_preview_view.dart';
import 'package:binah_poc/metric_panel.dart';
import 'package:binah_poc/models/binah_session.dart';
import 'package:binah_poc/models/image/image_validity.dart';
import 'package:binah_poc/models/measurement.dart';
import 'package:binah_poc/widget_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const ProviderScope(child: MaterialApp(home: MainApp())));
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  @override
  void initState() {
    super.initState();
    Permission.camera.request();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(binahSessionProvider, (_, value) {
      if (value == SessionState.stopping) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: const Text('Success'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              );
            });
        ref.read(measurementProvider.notifier).removeSession();
      }
    });
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => ref.read(measurementProvider.notifier).startOrStop(),
          child: Text(ref.watch(binahSessionProvider) == SessionState.processing
              ? 'Stop'
              : 'Start'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 300, child: _CameraPreview()),
              const SizedBox(height: 10),
              ref.watch(measurementProvider) != null
                  ? Text(
                      'Status: ${ref.watch(binahImageValidityProvider)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  : const Text(
                      'No Status',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
              const SizedBox(height: 10),
              MetricPanel(),
            ],
          ),
        ));
  }
}

class _CameraPreview extends ConsumerStatefulWidget {
  const _CameraPreview({Key? key}) : super(key: key);

  @override
  _CameraPreviewState createState() => _CameraPreviewState();
}

class _CameraPreviewState extends ConsumerState<_CameraPreview> {
  Size? size;

  @override
  Widget build(BuildContext context) {
    var sessionState = ref.watch(binahSessionProvider);
    if (sessionState == SessionState.initializing) {
      return Container();
    }

    return WidgetSize(
      onChange: (size) => setState(() {
        this.size = size;
      }),
      child: const SizedBox(
        width: double.infinity,
        child: AspectRatio(
          aspectRatio: 0.75,
          child: Stack(
            children: <Widget>[
              CameraPreviewView(),
              // Image.asset('assets/images/rppg_video_mask.png'),
              // _FaceDetectionView(size: size)
            ],
          ),
        ),
      ),
    );
  }
}
