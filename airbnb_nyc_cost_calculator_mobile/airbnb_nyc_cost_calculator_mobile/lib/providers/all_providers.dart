import 'package:airbnb_cost_calculator/providers/controllers/cost_pred_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final costPredController = ChangeNotifierProvider<CostPredController>((ref) {
  final prefs = ref.read(sharedPreferencesProvider);
  return CostPredController(prefs);
});

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});
