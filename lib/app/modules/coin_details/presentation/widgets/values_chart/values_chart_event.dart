abstract class ValuesChartEvent {}

class GetChartInfoEvent extends ValuesChartEvent {
  GetChartInfoEvent(this.id, this.days);

  final String id;
  final String days;
}
