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
  String _selectedTimeRange = '7D';

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
    return duration / 4;
  }

  FlTitlesData _buildTitlesData(List<ChartDataPointEntity> list) {
    return FlTitlesData(
      leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          interval: _calculateInterval(list),
          getTitlesWidget: (value, meta) {
            DateTime date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
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
    final spots = list.map((point) {
      return FlSpot(point.date.millisecondsSinceEpoch.toDouble(), point.value);
    }).toList();

    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: Colors.orange,
      barWidth: 2,
      isStrokeCapRound: false,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(show: true, color: const Color.fromARGB(33, 255, 153, 0)),
    );
  }

  LineTouchData _buildLineTouchData(List<ChartDataPointEntity> list) {
    return LineTouchData(
      handleBuiltInTouches: true,
      getTouchedSpotIndicator: (barData, spotIndexes) {
        return spotIndexes.map((spotIndex) {
          return TouchedSpotIndicatorData(
            FlLine(color: Colors.orange, strokeWidth: 1),
            FlDotData(
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(radius: 5, color: Colors.white, strokeWidth: 1, strokeColor: Colors.orange);
              },
            ),
          );
        }).toList();
      },
      touchTooltipData: LineTouchTooltipData(
        getTooltipItems: (touchedSpots) {
          return touchedSpots.map((touchedSpot) {
            final textStyle = TextStyle(
              color: touchedSpot.bar.gradient?.colors.first ?? Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            );
            final double priceValue = touchedSpot.y;
            final NumberFormat currencyFormatter = NumberFormat.currency(
              locale: 'en_US',
              symbol: '\$',
              decimalDigits: 2,
            );
            final String formattedPrice = currencyFormatter.format(priceValue);
            return LineTooltipItem(formattedPrice, textStyle);
          }).toList();
        },
      ),
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
                var marketChart = LineChart(
                  LineChartData(
                    lineBarsData: [_mainLine(state.marketChart.marketCaps)],
                    lineTouchData: _buildLineTouchData(state.marketChart.marketCaps),
                    titlesData: _buildTitlesData(state.marketChart.marketCaps),
                    gridData: FlGridData(drawHorizontalLine: true, drawVerticalLine: false),
                    borderData: FlBorderData(show: false),
                  ),
                );

                var priceChart = LineChart(
                  LineChartData(
                    lineBarsData: [_mainLine(state.marketChart.prices)],
                    lineTouchData: _buildLineTouchData(state.marketChart.prices),
                    titlesData: _buildTitlesData(state.marketChart.prices),
                    gridData: FlGridData(drawHorizontalLine: true, drawVerticalLine: false),
                    borderData: FlBorderData(show: false),
                  ),
                );

                return Visibility(visible: _selectedDataType == 'Price', replacement: marketChart, child: priceChart);
              }

              if (state is GetChartInfoErrorState) {
                return Center(
                  child: ElevatedButton(
                    onPressed: () => _coinDetailsBloc.add(GetChartInfoEvent(widget.id, _selectedTimeRange)),
                    child: Text('reload'),
                  ),
                );
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
