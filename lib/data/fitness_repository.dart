import '../models/steps.dart';
import '../models/water.dart';

class FitnessRepository {
  static final List<StepsData> _stepsList = [];
  static final List<WaterData> _waterList = [];

  static bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  // READ
  static StepsData? getStepsByDate(DateTime date) {
    try {
      return _stepsList.firstWhere((item) => _isSameDate(item.date, date));
    } catch (_) {
      return null;
    }
  }

  static WaterData? getWaterByDate(DateTime date) {
    try {
      return _waterList.firstWhere((item) => _isSameDate(item.date, date));
    } catch (_) {
      return null;
    }
  }

  static List<StepsData> getStepsList() {
    return _stepsList;
  }

  static List<WaterData> getWaterList() {
    return _waterList;
  }

  // CREATE
  static bool addSteps(StepsData data) {
    if (hasStepsOnDate(data.date)) return false;
    _stepsList.add(data);
    return true;
  }

  static bool addWater(WaterData data) {
    if (hasWaterOnDate(data.date)) return false;
    _waterList.add(data);
    return true;
  }

  // UPDATE
  static bool updateSteps(DateTime date, int newSteps) {
    for (var item in _stepsList) {
      if (_isSameDate(item.date, date)) {
        item.steps = newSteps;
        return true;
      }
    }
    return false;
  }

  static bool updateWater(DateTime date, double newAmount) {
    for (var item in _waterList) {
      if (_isSameDate(item.date, date)) {
        item.amount = newAmount;
        return true;
      }
    }
    return false;
  }

  // DELETE
  static bool deleteSteps(DateTime date) {
    final before = _stepsList.length;
    _stepsList.removeWhere((item) => _isSameDate(item.date, date));
    return _stepsList.length < before;
  }

  static bool deleteWater(DateTime date) {
    final before = _waterList.length;
    _waterList.removeWhere((item) => _isSameDate(item.date, date));
    return _waterList.length < before;
  }

  // VALIDATION
  static bool hasStepsOnDate(DateTime date) {
    return _stepsList.any((item) => _isSameDate(item.date, date));
  }

  static bool hasWaterOnDate(DateTime date) {
    return _waterList.any((item) => _isSameDate(item.date, date));
  }

  // STATUS
  static String getStepsStatus(int steps) {
    if (steps < 4000) return 'Bad';
    if (steps <= 8000) return 'Average';
    return 'Good';
  }

  static String getWaterStatus(double liter) {
    if (liter < 1.5) return 'Bad';
    if (liter <= 2.0) return 'Average';
    return 'Good';
  }
}
