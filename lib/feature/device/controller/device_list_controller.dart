import 'package:flutter_riverpod/flutter_riverpod.dart';



final selectModeProvider = StateProvider<bool>((ref) => false);
final selectAllProvider = StateProvider<bool>((ref) => false);
final selectDevicesProvider = StateProvider<List<int>>((ref) => List.empty());
