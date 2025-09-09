abstract class CoinValuesPreviewEvent {}

class GetValuesPreviewEvent extends CoinValuesPreviewEvent {
  GetValuesPreviewEvent(this.ids);

  final String ids;
}
