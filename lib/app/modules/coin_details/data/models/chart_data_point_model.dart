class ChartDataPointModel {
  final DateTime date;
  final double value;

  ChartDataPointModel({required this.date, required this.value});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'date': date.millisecondsSinceEpoch, 'value': value};
  }

  factory ChartDataPointModel.fromMap(Map<String, dynamic> map) {
    return ChartDataPointModel(
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      value: map['value'] as double,
    );
  }
}
