import 'package:binah_flutter_sdk/session/session_state.dart';
import 'package:binah_flutter_sdk/ui/camera_preview_view.dart';
import 'package:binah_poc/metric_panel.dart';
import 'package:binah_poc/models/binah_session.dart';
import 'package:binah_poc/models/image/image_validity.dart';
import 'package:binah_poc/models/rppg_session.dart';
import 'package:binah_poc/models/session_info/error.dart';
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
      }
    });
    ref.listen(rPpgErrorProvider, (_, value) {
      if (value != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text('Error : ${value.code}'),
                content: Text(value.domain),
                actions: [
                  TextButton(
                    onPressed: () {
                      ref.read(rPpgErrorProvider.notifier).clear();
                      ref.read(rPpgSessionProvider.notifier).stop();
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            });
      }
    });
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final notifier = ref.read(rPpgSessionProvider.notifier);
            if (ref.read(binahSessionProvider) == SessionState.processing) {
              notifier.stop();
            } else {
              notifier.start();
            }
          },
          child: Text(ref.watch(binahSessionProvider) == SessionState.processing
              ? 'Stop'
              : 'Start'),
        ),
        body: SafeArea(
          minimum: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const _CameraPreview(),
              // const SizedBox(height: 300, child: _CameraPreview()),
              const SizedBox(height: 10),
              ref.watch(rPpgSessionProvider).hasValue
                  ? Text(
                      'Status: ${ref.watch(binahImageValidityProvider)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  : const Text(
                      'No Status',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
              const SizedBox(height: 10),
              const MetricPanel(),
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

    return WidgetSize(
      onChange: (size) => setState(() {
        this.size = size;
      }),
      child: SizedBox(
        width: double.infinity,
        child: AspectRatio(
          aspectRatio: 0.75,
          child: Stack(
            children: <Widget>[
              (sessionState == SessionState.ready ||
                      sessionState == SessionState.starting ||
                      sessionState == SessionState.processing)
                  ? const CameraPreviewView()
                  : const SizedBox.expand(),
              // Image.asset('assets/images/rppg_video_mask.png'),
              // _FaceDetectionView(size: size)
            ],
          ),
        ),
      ),
    );
  }
}
