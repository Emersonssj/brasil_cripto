abstract class CoinDetailsEvent {}

class GetCoinDetailsEvent extends CoinDetailsEvent {
  GetCoinDetailsEvent(this.id);

  final String id;
}
