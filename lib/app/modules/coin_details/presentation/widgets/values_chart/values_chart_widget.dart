import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/chart_data_point_entity.dart';
import 'values_chart_bloc.dart';
import 'values_chart_event.dart';
import 'values_chart_state.dart';

class ValuesChartWidget extends StatefulWidget {
  const ValuesChartWidget({super.key, required this.id});

  final String id;

  @override
  State<ValuesChartWidget> createState() => _ValuesChartWidgetState();
}

class _ValuesChartWidgetState extends State<ValuesChartWidget> {
  final ValuesChartBloc _coinDetailsBloc = ValuesChartBloc();
  final List<String> _timeRanges = ['1H', '24H', '7D', '1M', '3M', '1Y', 'MAX'];
  String _selectedDataType = 'Price';
  String _selectedTimeRange = '24H';

  @override
  void initState() {
    _coinDetailsBloc.add(GetChartInfoEvent(widget.id, _selectedTimeRange));
    super.initState();
  }

  Widget _buildToggleContainer({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
      child: Row(mainAxisSize: MainAxisSize.min, children: children),
    );
  }

  Widget _buildToggleButton({required String label, required bool isSelected, required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey.withOpacity(0.4) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[400],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  double _calculateInterval(List<ChartDataPointEntity> list) {
    if (list.isEmpty) return 1;
    final firstDate = list.first.date.millisecondsSinceEpoch;
    final lastDate = list.last.date.millisecondsSinceEpoch;
    final duration = lastDate - firstDate;
    // Tenta mostrar cerca de 4 a 5 labels no eixo X
    return duration / 4;
  }

  FlTitlesData _buildTitlesData(List<ChartDataPointEntity> list) {
    return FlTitlesData(
      leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)), // Oculta eixo Y (preços)
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)), // Oculta eixo superior
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)), // Oculta eixo direito
      // Configura os títulos do eixo X (datas)
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          interval: _calculateInterval(list), // Calcula o intervalo dinamicamente
          getTitlesWidget: (value, meta) {
            // Converte o timestamp (double) de volta para DateTime
            DateTime date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
            // Formata a data para "dd/MM"
            String text = DateFormat('dd/MM').format(date);

            return SideTitleWidget(
              axisSide: meta.axisSide,
              space: 4,
              child: Text(text, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            );
          },
        ),
      ),
    );
  }

  LineChartBarData _mainLine(List<ChartDataPointEntity> list) {
    // Transforma nossa lista de ChartDataPoint em uma lista de FlSpot
    final spots = list.map((point) {
      // O eixo X é o tempo (em milissegundos) e o eixo Y é o preço
      return FlSpot(point.date.millisecondsSinceEpoch.toDouble(), point.value);
    }).toList();

    return LineChartBarData(
      spots: spots,
      isCurved: true, // Deixa a linha com curvas suaves
      color: Colors.cyan, // Cor da linha
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false), // Oculta os pontos na linha
      belowBarData: BarAreaData(
        // Área preenchida abaixo da linha
        show: true,
        color: Colors.cyan.withOpacity(0.2),
      ),
    );
  }

  LineTouchData _buildLineTouchData(List<ChartDataPointEntity> list) {
    return LineTouchData(
      handleBuiltInTouches: true,
      getTouchedSpotIndicator: (barData, spotIndexes) {
        return spotIndexes.map((spotIndex) {
          return TouchedSpotIndicatorData(
            FlLine(color: Colors.white.withOpacity(0.5), strokeWidth: 2),
            FlDotData(
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(radius: 6, color: Colors.white, strokeWidth: 2, strokeColor: Colors.cyan);
              },
            ),
          );
        }).toList();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildToggleContainer(
              children: [
                _buildToggleButton(
                  label: 'Preço',
                  isSelected: _selectedDataType == 'Price',
                  onPressed: () {
                    if (_selectedDataType != 'Price') {
                      setState(() {
                        _selectedDataType = 'Price';
                      });
                    }
                  },
                ),
                _buildToggleButton(
                  label: 'Capitalização de mercado',
                  isSelected: _selectedDataType == 'Market Cap',
                  onPressed: () {
                    if (_selectedDataType != 'Market Cap') {
                      setState(() {
                        _selectedDataType = 'Market Cap';
                      });
                    }
                  },
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 12),
        SizedBox(
          height: 250,
          width: double.infinity,
          child: BlocBuilder<ValuesChartBloc, ValuesChartState>(
            bloc: _coinDetailsBloc,
            builder: (context, state) {
              if (state is ValuesChartLoadingState) {
                return Center(child: CircularProgressIndicator());
              }

              if (state is GetChartInfoSuccessState) {
                return Visibility(
                  visible: _selectedDataType == 'Price',
                  replacement: LineChart(
                    LineChartData(
                      lineBarsData: [_mainLine(state.marketChart.marketCaps)],
                      lineTouchData: _buildLineTouchData(state.marketChart.marketCaps),
                      titlesData: _buildTitlesData(state.marketChart.marketCaps),
                      gridData: FlGridData(drawHorizontalLine: true, drawVerticalLine: false),
                      borderData: FlBorderData(show: false),
                    ),
                  ),
                  child: LineChart(
                    LineChartData(
                      lineBarsData: [_mainLine(state.marketChart.prices)],
                      lineTouchData: _buildLineTouchData(state.marketChart.prices),
                      titlesData: _buildTitlesData(state.marketChart.prices),
                      gridData: FlGridData(drawHorizontalLine: true, drawVerticalLine: false),
                      borderData: FlBorderData(show: false),
                    ),
                  ),
                );
              }

              if (state is GetChartInfoErrorState) {
                return Center(child: Text('Erro, tentar novamente'));
              }

              return SizedBox();
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _timeRanges.map((range) {
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  if (_selectedTimeRange != range) {
                    setState(() {
                      _selectedTimeRange = range;
                      _coinDetailsBloc.add(GetChartInfoEvent(widget.id, range));
                    });
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2.0),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: _selectedTimeRange == range ? const Color(0xFF3C3C3E) : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    range,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _selectedTimeRange == range ? Colors.white : Colors.grey[400],
                      fontWeight: _selectedTimeRange == range ? FontWeight.bold : FontWeight.normal,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
