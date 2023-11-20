
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rugst_alliance_academia/theme/app_colors.dart';
import 'package:rugst_alliance_academia/util/image_path.dart';




class _Badge extends StatelessWidget {
  const _Badge(
    this.lottieAsset, {
    required this.size,
    required this.borderColor,
  });
  final String lottieAsset;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
     
      child: Lottie.asset(
        lottieAsset,
      ),
    );
  }
}

class PieChartScreen extends StatefulWidget {
    final Color donutColor1;
final Color donutColor2;
  const PieChartScreen({super.key , required this.donutColor1, required this.donutColor2});

  @override
  State<PieChartScreen> createState() => _CustomPieChartState();
}

class _CustomPieChartState extends State<PieChartScreen> {
  int touchedIndex = 0;
  @override
  Widget build(BuildContext context) {
    
return PieChart(
      PieChartData(
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {
            setState(() {
              if (!event.isInterestedForInteractions ||
                  pieTouchResponse == null ||
                  pieTouchResponse.touchedSection == null) {
                touchedIndex = -1;
                return;
              }
              touchedIndex =
                  pieTouchResponse.touchedSection!.touchedSectionIndex;
            });
          },
        ),
        borderData: FlBorderData(
          show: false,
        ),
        sectionsSpace: 0,
        centerSpaceRadius: 0,
        sections: showingSections(
        widget.donutColor1, widget.donutColor2
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections( Color donutColor1,
 Color donutColor2) {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 35.0 : 30.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: donutColor1,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(LottiePath.genderMLottie,
              size: widgetSize,
              borderColor: AppColors.colorBlack,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: donutColor2,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              LottiePath.genderFLottie,
              size: widgetSize,
              borderColor: AppColors.colorBlack,
            ),
            badgePositionPercentageOffset: .98,
          );
       
         default:
          throw Exception('Oh no');
         
      }
    });
  }
  }
