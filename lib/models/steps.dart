class StepsData {
  final DateTime date;
  int steps;

  StepsData({required this.date, required this.steps});

  String get status {
    if (steps < 4000) {
      return 'Bad';
    } else if (steps <= 8000) {
      return 'Average';
    } else {
      return 'Good';
    }
  }
}
