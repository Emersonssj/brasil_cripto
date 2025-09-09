import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/dependency_injection/dependency_injection.dart';
import '../../../domain/repositories/coin_details_repository.dart';
import 'values_chart_event.dart';
import 'values_chart_state.dart';

class ValuesChartBloc extends Bloc<ValuesChartEvent, ValuesChartState> {
  ValuesChartBloc() : super(ValuesChartInitialState()) {
    on<GetChartInfoEvent>(_getChartInfo);
  }

  final CoinDetailsRepository _repository = getDependency<CoinDetailsRepository>();

  Future<void> _getChartInfo(GetChartInfoEvent event, Emitter emit) async {
    emit(ValuesChartLoadingState());

    final result = await _repository.getChartInfo(event.id, event.days);

    emit(
      result.fold((success) => GetChartInfoSuccessState(marketChart: success), (failure) => GetChartInfoErrorState()),
    );
  }
}
