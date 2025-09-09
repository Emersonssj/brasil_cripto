import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/dependency_injection/dependency_injection.dart';
import '../../../domain/repositories/coin_search_repository.dart';
import 'coin_values_preview_event.dart';
import 'coin_values_preview_state.dart';

class CoinValuesPreviewBloc extends Bloc<CoinValuesPreviewEvent, CoinValuesPreviewState> {
  CoinValuesPreviewBloc() : super(CoinValuesPreviewInitialState()) {
    on<GetValuesPreviewEvent>(_getValuesPreview);
  }

  final CoinSearchRepository _repository = getDependency<CoinSearchRepository>();

  Future<void> _getValuesPreview(GetValuesPreviewEvent event, Emitter emit) async {
    emit(CoinValuesPreviewLoadingState());

    final result = await _repository.getCoinsComplement(event.ids);

    emit(
      result.fold(
        (success) => GetValuesPreviewSuccessState(previewValues: success),
        (failure) => GetValuesPreviewErrorState(exception: failure),
      ),
    );
  }
}
