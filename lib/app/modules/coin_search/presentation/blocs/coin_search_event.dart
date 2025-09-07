abstract class CoinSearchEvent {}

class GetCoinsEvent extends CoinSearchEvent {
  GetCoinsEvent(this.query);

  final String query;
}
