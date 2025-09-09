import '../../../domain/entities/coin_complement_entity.dart';

abstract class CoinValuesPreviewState {}

class CoinValuesPreviewInitialState extends CoinValuesPreviewState {}

class CoinValuesPreviewLoadingState extends CoinValuesPreviewState {}

class GetValuesPreviewSuccessState extends CoinValuesPreviewState {
  GetValuesPreviewSuccessState({required this.previewValues});

  final CoinComplementEntity previewValues;
}

class GetValuesPreviewErrorState extends CoinValuesPreviewState {
  GetValuesPreviewErrorState();
}
