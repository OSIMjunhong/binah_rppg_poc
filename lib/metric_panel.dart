import 'package:binah_poc/models/vital_sign/heart_rate.dart';
import 'package:binah_poc/models/vital_sign/respiration_rate.dart';
import 'package:binah_poc/models/vital_sign/spo2.dart';
import 'package:binah_poc/models/vital_sign/stress_index.dart';
import 'package:binah_poc/models/vital_sign/stress_level.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MetricPanel extends StatelessWidget {
  const MetricPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 70,
          child: Row(
            children: [
              Expanded(child: _RespirationRateInfo()),
              const VerticalDivider(color: Colors.black),
              Expanded(child: _HeartRateInfo()),
              const VerticalDivider(color: Colors.black),
              Expanded(child: _Spo2Info()),
            ],
          ),
        ),
        const Divider(color: Colors.black),
        SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _StressLevelInfo(),
              const VerticalDivider(color: Colors.black),
              _StressIndexInfo(),
            ],
          ),
        ),
      ],
    );
  }
}

class _HeartRateInfo extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      _Info(title: 'HR', value: ref.watch(heartRateProvider).toString());
}

class _RespirationRateInfo extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      _Info(title: 'RR', value: ref.watch(respirationRateProvider).toString());
}

class _Spo2Info extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      _Info(title: 'SPO2', value: ref.watch(spo2Provider).toString());
}

class _StressLevelInfo extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) =>
      _Info(title: 'Stress Level', value: ref.watch(stressProvider).toString());
}

class _StressIndexInfo extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) => _Info(
      title: 'Stress Index', value: ref.watch(stressIndexProvider).toString());
}

class _Info extends StatelessWidget {
  final String title;
  final String value;

  const _Info({required this.title, required this.value});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      child: Center(
        child: Column(children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ]),
      ),
    );
  }
}
