import 'package:app_vida_saludable/src/controllers/statistics_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExerciseData {
  final String day;
  final int minutes;

  ExerciseData(this.day, this.minutes);
}
class SunData {
  final String day;
  final int minutes;

  SunData(this.day, this.minutes);
}

class AirData {
  final String day;
  final int minutes;

  AirData(this.day, this.minutes);
}

class WaterData {
  final String day;
  final int quantity;

  WaterData(this.day, this.quantity);
}
class StatisticsPage extends StatefulWidget {

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class SleepData {
  final String day;
  final double hours;

  SleepData(this.day, this.hours);
}


class _StatisticsPageState extends State<StatisticsPage> {
  bool showStatisticsFeeding = true;
  bool showStatisticsExercise = false;
  bool showStatisticsWater = false;
  bool showStatisticsDream = false;
  bool showStatisticsSun = false;
  bool showStatisticsWake_up = false;
  bool showStatisticsHope = false;

  @override
  Widget build(BuildContext context) {
    StatisticsController con = Get.put(StatisticsController());
    List<Map<String, dynamic>> datosEjercicioTiempo = con.datosEjercicioTiempo;
    List<Map<String, dynamic>> datosAgua = con.datosAgua;
    List<Map<String, dynamic>> datosSol = con.datosSol;
    List<Map<String, dynamic>> datosAire = con.datosAire;
    return Scaffold(
      body: Stack(
        children: [
          _bgStatistics(),
          _title(context),
          _text(context),
          _scrollHabits(context),
          if (showStatisticsFeeding) _scrollStatisticsFeeding(context),
          if (showStatisticsExercise) _scrollStatisticsExercise(context, datosEjercicioTiempo),
          if (showStatisticsWater) _scrollStatisticsWater(context, datosAgua),
          if (showStatisticsDream) _scrollStatisticsDream(context),
          if (showStatisticsSun) _scrollStatisticsSun(context, datosSol),
          if (showStatisticsWake_up) _scrollStatisticsAir(context, datosAire),
          if (showStatisticsHope) _scrollStatisticsHope(context),
        ],
      ),
    );
  }

  Widget _bgStatistics() {
    return Container(
      height: 190,
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(90),
        ),
      ),
    );
  }

  Widget _title(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05, left: 20),
      child: Text(
        'Mi Progreso',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _text(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.12, left: 20, right: 30),
      child: Text(
        'Encuentra alegría en cada paso del camino. Los hábitos saludables no son una meta, sino un estilo de vida.',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _scrollHabits(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.28, left: 20, right: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _feeding(),
            SizedBox(width: 10),
            _exercise(),
            SizedBox(width: 10),
            _water(),
            SizedBox(width: 10),
            _dream(),
            SizedBox(width: 10),
            _sun(),
            SizedBox(width: 10),
            _wake_up(),
            SizedBox(width: 10),
            _hope(),
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }

  Widget _feeding() {
    return GestureDetector(
      onTap: () {
        setState(() {
          showStatisticsFeeding = true;
          showStatisticsExercise = false;
          showStatisticsWater = false;
          showStatisticsDream = false;
          showStatisticsSun = false;
          showStatisticsWake_up = false;
          showStatisticsHope = false;
        });
      },
      child: Container(
        width: 70.0,
        height: 70.0,
        decoration: BoxDecoration(
          color: Colors.indigo.shade100,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            'assets/img/feeding.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _exercise() {
    StatisticsController con = Get.put(StatisticsController());
    return GestureDetector(
      onTap: () {
        con.datosEjercicio(con.user.id);
        con.datosEjercicioT(con.user.id);
        setState(() {
          showStatisticsExercise = true;
          showStatisticsFeeding = false;
          showStatisticsWater = false;
          showStatisticsDream = false;
          showStatisticsSun = false;
          showStatisticsWake_up = false;
          showStatisticsHope = false;
        });
      },
      child: Container(
        width: 70.0,
        height: 70.0,
        decoration: BoxDecoration(
          color: Colors.indigo.shade100,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            'assets/img/exercise.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _water() {
    StatisticsController con = Get.put(StatisticsController());
    return GestureDetector(
      onTap: () {
        con.datosEstadisticosAgua(con.user.id);
        setState(() {
          showStatisticsExercise = false;
          showStatisticsFeeding = false;
          showStatisticsWater = true;
          showStatisticsSun = false;
          showStatisticsDream = false;
          showStatisticsWake_up = false;
          showStatisticsHope = false;
        });
      },
      child: Container(
        width: 70.0,
        height: 70.0,
        decoration: BoxDecoration(
          color: Colors.indigo.shade100,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            'assets/img/water.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _dream() {
    StatisticsController con = Get.put(StatisticsController());
    return GestureDetector(
      onTap: () {
        con.datosEstatisticosDescanso(con.user.id);
        setState(() {
          showStatisticsExercise = false;
          showStatisticsFeeding = false;
          showStatisticsWater = false;
          showStatisticsSun = false;
          showStatisticsDream = true;
          showStatisticsWake_up = false;
          showStatisticsHope = false;
        });
      },
      child: Container(
        width: 70.0,
        height: 70.0,
        decoration: BoxDecoration(
          color: Colors.indigo.shade100,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            'assets/img/dream.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _sun() {
    StatisticsController con = Get.put(StatisticsController());
    return GestureDetector(
      onTap: () {
        // con.datosEstatisticosDescanso(con.user.id);
        con.datosSolTiempo(con.user.id);
        setState(() {
          showStatisticsExercise = false;
          showStatisticsFeeding = false;
          showStatisticsWater = false;
          showStatisticsSun = true;
          showStatisticsDream = false;
          showStatisticsWake_up = false;
          showStatisticsHope = false;
        });
      },
      child: Container(
        width: 70.0,
        height: 70.0,
        decoration: BoxDecoration(
          color: Colors.indigo.shade100,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            'assets/img/sun.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _wake_up() {
    StatisticsController con = Get.put(StatisticsController());
    return GestureDetector(
      onTap: () {
        // con.datosEstatisticosDescanso(con.user.id);
        con.datosAireTiempo(con.user.id);
        setState(() {
          showStatisticsExercise = false;
          showStatisticsFeeding = false;
          showStatisticsWater = false;
          showStatisticsSun = false;
          showStatisticsDream = false;
          showStatisticsWake_up = true;
          showStatisticsHope = false;
        });
      },
      child: Container(
        width: 70.0,
        height: 70.0,
        decoration: BoxDecoration(
          color: Colors.indigo.shade100,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            'assets/img/wake_up.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _hope() {
    StatisticsController con = Get.put(StatisticsController());
    return GestureDetector(
      onTap: () {
        // con.datosEstatisticosDescanso(con.user.id);
        con.datosEsperanza(con.user.id);
        setState(() {
          showStatisticsExercise = false;
          showStatisticsFeeding = false;
          showStatisticsWater = false;
          showStatisticsSun = false;
          showStatisticsDream = false;
          showStatisticsWake_up = false;
          showStatisticsHope = true;
        });
      },
      child: Container(
        width: 70.0,
        height: 70.0,
        decoration: BoxDecoration(
          color: Colors.indigo.shade100,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            'assets/img/hope.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _scrollStatisticsFeeding(BuildContext context){
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.38, left: 20, right: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _titleHabits(context),
            SizedBox(height: 10),
            _buttoms(context),
            SizedBox(height: 25),
            _charts(context),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  Widget _titleHabits(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        'Alimentacion',
        style: TextStyle(
          fontSize: 27,
          fontWeight: FontWeight.w800,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buttoms(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buttonDesayuno(),
          _buttonAlmuerzo(),
          _buttonCena(),
        ],
      ),
    );
  }

  Widget _buttonDesayuno() {
    StatisticsController con = Get.put(StatisticsController());
    return Container(
      child: ElevatedButton(
        onPressed: () {
          con.datosAlimentacionTipo(con.user.id, 'desayuno');
          con.onPressed('desayuno');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: con.buttonColorDesayuno,
          padding: EdgeInsets.symmetric(horizontal: 13, vertical: 10), // padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // rounded corners
          ),
        ),
        child: Text(
          'Desayuno',
          style: TextStyle(
              fontSize: 20,
              color: con.textColorDesayuno
          ),
        ),
      ),
    );
  }

  Widget _buttonAlmuerzo() {
    StatisticsController con = Get.put(StatisticsController());
    return Container(
      child: ElevatedButton(
        onPressed: () {
          con.datosAlimentacionTipo(con.user.id, 'almuerzo');
          con.onPressed('almuerzo');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: con.buttonColorAlmuerzo,
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'Almuerzo',
          style: TextStyle(
              fontSize: 20,
              color: con.textColorAlmuerzo
          ),
        ),
      ),
    );
  }

  Widget _buttonCena() {
    StatisticsController con = Get.put(StatisticsController());
    return Container(
      child: ElevatedButton(
        onPressed: () {
          con.datosAlimentacionTipo(con.user.id, 'cena');
          con.onPressed('cena');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: con.buttonColorCena,
          padding: EdgeInsets.symmetric(horizontal: 33, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'Cena',
          style: TextStyle(
              fontSize: 20,
              color: con.textColorCena
          ),
        ),
      ),
    );
  }

  Widget _charts(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: MediaQuery.of(context).size.width - 40,
      decoration: BoxDecoration(
        color: Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '¿Comió Saludable?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: _getSections(),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 3,
                  centerSpaceRadius: 5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _getSections() {
    StatisticsController con = Get.put(StatisticsController());
    double siValue = con.si.value.toDouble();
    double noValue = con.no.value.toDouble();
    return [
      PieChartSectionData(
        color: Colors.blue,
        value: siValue,
        title: 'Si ${con.si.value}%',
        radius: 120,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.red,
        value: noValue,
        title: 'No ${con.no.value}%',
        radius: 120,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ];
  }

  Widget _scrollStatisticsExercise(BuildContext context, List<Map<String, dynamic>> datosEjercicioTiempo){
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.38, left: 20, right: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _titleHabitsE(context),
            SizedBox(height: 10),
            _buttomsE(context),
            SizedBox(height: 25),
            _barChartExercise(context, datosEjercicioTiempo),
            SizedBox(height: 25),
            _chartsExercise(context),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
  Widget _titleHabitsE(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        'Ejercicio',
        style: TextStyle(
          fontSize: 27,
          fontWeight: FontWeight.w800,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buttomsE(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buttonCaminataLenta(),
            _buttonCaminataRapida(),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buttonTrote(),
              _buttonEjercicioGuiado()
            ],
          ),
        ],
      ),
    );
  }

  Widget _buttonTrote() {
    StatisticsController con = Get.put(StatisticsController());
    return Container(
      child: ElevatedButton(
        onPressed: () {
          con.datosTipoEjercicio(con.user.id, 'trote');
          con.onPressed('trote');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: con.buttonColorTrote,
          padding: EdgeInsets.symmetric(horizontal: 62, vertical: 10), // padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // rounded corners
          ),
        ),
        child: Text(
          'Trote',
          style: TextStyle(
              fontSize: 20,
              color: con.textColorTrote,
          ),
        ),
      ),
    );
  }

  Widget _buttonCaminataRapida() {
    StatisticsController con = Get.put(StatisticsController());
    return Container(
      child: ElevatedButton(
        onPressed: () {
          con.datosTipoEjercicio(con.user.id, 'caminata rapida');
          con.onPressed('caminata rapida');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: con.buttonColorC_Rapida,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'Caminata Rapida',
          style: TextStyle(
              fontSize: 20,
              color: con.textColorC_Rapida
          ),
        ),
      ),
    );
  }

  Widget _buttonCaminataLenta() {
    StatisticsController con = Get.put(StatisticsController());
    return Container(
      child: ElevatedButton(
        onPressed: () {
          con.datosTipoEjercicio(con.user.id, 'caminata lenta');
          con.onPressed('caminata lenta');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: con.buttonColorC_Lenta,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'Caminata Lenta',
          style: TextStyle(
              fontSize: 20,
              color: con.textColorC_Lenta
          ),
        ),
      ),
    );
  }
  Widget _buttonEjercicioGuiado() {
    StatisticsController con = Get.put(StatisticsController());
    return Container(
      child: ElevatedButton(
        onPressed: () {
          con.datosTipoEjercicio(con.user.id, 'ejercicio guiado');
          con.onPressed('ejercicio guiado');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: con.buttonColorE_Guiado,
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'Ejercicio Guiado',
          style: TextStyle(
              fontSize: 20,
              color: con.textColorE_Guiado
          ),
        ),
      ),
    );
  }

  Widget _chartsExercise(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: MediaQuery.of(context).size.width - 40,
      decoration: BoxDecoration(
        color: Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Ejercicios que realizo',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: _getSectionsE(),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 3,
                  centerSpaceRadius: 5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _getSectionsE() {
    StatisticsController con = Get.put(StatisticsController());
    return [
      PieChartSectionData(
        color: Colors.blue,
        value: con.c_lenta.value.toDouble(),
        title: 'C. Lenta ${con.c_lenta.value}%',
        radius: 120,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.amber,
        value: con.c_rapida.value.toDouble(),
        title: 'C. Rápida ${con.c_rapida.value}%',
        radius: 120,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.green,
        value: con.trote.value.toDouble(),
        title: 'Trote ${con.trote.value}%',
        radius: 120,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.red,
        value: con.e_guiado.value.toDouble(),
        title: 'E. Guiado ${con.e_guiado.value}%',
        radius: 120,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ];
  }

  Widget _barChartExercise(BuildContext context, List<Map<String, dynamic>> datosEjercicioTiempo) {
    List<ExerciseData> weeklyExercise = datosEjercicioTiempo.map((data) {
      String dia = data['dia'];
      int minutos = data['minutos'];
      return ExerciseData(dia, minutos);
    }).toList();

    if (weeklyExercise.isEmpty) {
      return Center(
        child: Text('No hay datos disponibles'),
      );
    }

    return Container(
      height: 300,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Minutos de Ejercicio',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Expanded(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: weeklyExercise.map((e) => e.minutes.toDouble()).reduce((a, b) => a > b ? a : b) * 1.2,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        '${weeklyExercise[groupIndex].day}\n',
                        TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '${weeklyExercise[groupIndex].minutes} min',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (context, value) {
                      return const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      );
                    },
                    margin: 10,
                    getTitles: (double value) {
                      int index = value.toInt();
                      return index >= 0 && index < weeklyExercise.length ? weeklyExercise[index].day : '';
                    },
                  ),
                  leftTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (context, value) {
                      return const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      );
                    },
                    margin: 10,
                    reservedSize: 28,
                    getTitles: (value) {
                      if (value == 0) {
                        return '0';
                      } else if (value % 30 == 0) {
                        return '${value.toInt()} min';
                      }
                      return '';
                    },
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey[300],
                      strokeWidth: 1,
                    );
                  },
                ),
                borderData: FlBorderData(show: false),
                barGroups: weeklyExercise.asMap().entries.map((entry) {
                  int index = entry.key;
                  ExerciseData exerciseData = entry.value;
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        y: exerciseData.minutes.toDouble(),
                        colors: [Colors.blue[400]!],
                        borderRadius: BorderRadius.circular(5),
                        width: 20,
                      )
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _scrollStatisticsWater(BuildContext context, List<Map<String, dynamic>> datosAgua){
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.38, left: 20, right: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _titleHabitsWater(context),
            SizedBox(height: 25),
            _barChartWater(context, datosAgua),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _titleHabitsWater(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        'Agua',
        style: TextStyle(
          fontSize: 27,
          fontWeight: FontWeight.w800,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _barChartWater(BuildContext context, List<Map<String, dynamic>> datosAgua) {
    List<WaterData> weeklyWater = datosAgua.map((data) {
      String dia = data['dia'];
      int cantidad = data['cantidad_ml']; // Ajustado para reflejar la clave correcta
      return WaterData(dia, cantidad);
    }).toList();

    if (weeklyWater.isEmpty) {
      return Center(
        child: Text('No hay datos disponibles'),
      );
    }

    return Container(
      height: 300,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Cantidad de Agua Ingerida (ml)',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Expanded(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 2000,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        '${weeklyWater[groupIndex].day}\n',
                        TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '${weeklyWater[groupIndex].quantity} ml',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (context, value) {
                      return const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      );
                    },
                    margin: 10,
                    getTitles: (double value) {
                      int index = value.toInt();
                      return index >= 0 && index < weeklyWater.length ? weeklyWater[index].day : '';
                    },
                  ),
                  leftTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (context, value) {
                      return const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      );
                    },
                    margin: 10,
                    reservedSize: 28,
                    getTitles: (value) {
                      if (value == 0) {
                        return '0';
                      } else if (value % 500 == 0) { // Mostrar etiquetas cada 500 ml
                        return '${value.toInt()} ml';
                      }
                      return '';
                    },
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey[300],
                      strokeWidth: 1,
                    );
                  },
                ),
                borderData: FlBorderData(show: false),
                barGroups: weeklyWater.asMap().entries.map((entry) {
                  int index = entry.key;
                  WaterData waterData = entry.value;
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        y: waterData.quantity.toDouble(),
                        colors: [Colors.blue[400]!],
                        borderRadius: BorderRadius.circular(5),
                        width: 20,
                      )
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _scrollStatisticsDream(BuildContext context){
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.38, left: 20, right: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _titleHabitsDream(context),
            SizedBox(height: 25),
            _chartsDream(context),
            SizedBox(height: 15),
            _barChartDream(context),
            SizedBox(height: 10,)
          ],
        ),
      ),
    );
  }

  Widget _titleHabitsDream(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        'Descanso',
        style: TextStyle(
          fontSize: 27,
          fontWeight: FontWeight.w800,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _barChartDream(BuildContext context) {
    final List<SleepData> weeklySleep = [
      SleepData("Lun", 7.0),
      SleepData("Mar", 6.5),
      SleepData("Mie", 8.0),
      SleepData("Jue", 5.5),
      SleepData("Vie", 7.0),
      SleepData("Sab", 6.0),
      SleepData("Dom", 7.5),
    ];

    return Container(
      height: 300,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Horas de Sueño (hrs)',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Expanded(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 10, // Ajusta esto según el máximo de horas de sueño esperado
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        '${weeklySleep[groupIndex].day}\n',
                        TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '${weeklySleep[groupIndex].hours} hrs',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (context, value) {
                      return const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      );
                    },
                    margin: 10,
                    getTitles: (double value) {
                      int index = value.toInt();
                      return index >= 0 && index < weeklySleep.length ? weeklySleep[index].day : '';
                    },
                  ),
                  leftTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (context, value) {
                      return const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      );
                    },
                    margin: 10,
                    reservedSize: 28,
                    getTitles: (value) {
                      if (value == 0) {
                        return '0';
                      } else if (value % 2 == 0) {
                        return '${value.toInt()} hrs';
                      }
                      return '';
                    },
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey[300],
                      strokeWidth: 1,
                    );
                  },
                ),
                borderData: FlBorderData(show: false),
                barGroups: weeklySleep.asMap().entries.map((entry) {
                  int index = entry.key;
                  SleepData sleepData = entry.value;
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        y: sleepData.hours,
                        colors: [Colors.blue[400]!],
                        borderRadius: BorderRadius.circular(5),
                        width: 20,
                      )
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _chartsDream(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: MediaQuery.of(context).size.width - 40,
      decoration: BoxDecoration(
        color: Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          SizedBox(height: 15),
          Text(
            '¿Cómo descanso?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: PieChart(
                PieChartData(
                  sections: _getSectionsD(),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 3,
                  centerSpaceRadius: 5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  List<PieChartSectionData> _getSectionsD() {
    StatisticsController con = Get.put(StatisticsController());
    double bien = con.bien.value.toDouble();
    double mal = con.mal.value.toDouble();
    return [
      PieChartSectionData(
        color: Colors.blue,
        value: bien,
        title: 'Bien ${bien}%',
        radius: 120,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.red,
        value: mal,
        title: 'Mal ${mal}%',
        radius: 120,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ];
  }

  Widget _scrollStatisticsSun(BuildContext context, List<Map<String, dynamic>> datosSol){
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.38, left: 20, right: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _titleHabitsSun(context),
            SizedBox(height: 10),
            _barChartSun(context, datosSol),
          ],
        ),
      ),
    );
  }

  Widget _titleHabitsSun(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        'Luz Solar',
        style: TextStyle(
          fontSize: 27,
          fontWeight: FontWeight.w800,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _barChartSun(BuildContext context, List<Map<String, dynamic>> datosSol) {
    List<SunData> weeklySun = datosSol.map((data) {
      String dia = data['dia'];
      int minutos = data['minutos'];
      return SunData(dia, minutos);
    }).toList();

    if (weeklySun.isEmpty) {
      return Center(
        child: Text('No hay datos disponibles'),
      );
    }

    return Container(
      height: 300,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Minutos de Luz Solar',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Expanded(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: weeklySun.map((e) => e.minutes.toDouble()).reduce((a, b) => a > b ? a : b) * 1.2,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        '${weeklySun[groupIndex].day}\n',
                        TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '${weeklySun[groupIndex].minutes} min',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (context, value) {
                      return const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      );
                    },
                    margin: 10,
                    getTitles: (double value) {
                      int index = value.toInt();
                      return index >= 0 && index < weeklySun.length ? weeklySun[index].day : '';
                    },
                  ),
                  leftTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (context, value) {
                      return const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      );
                    },
                    margin: 10,
                    reservedSize: 28,
                    getTitles: (value) {
                      if (value == 0) {
                        return '0';
                      } else if (value % 30 == 0) {
                        return '${value.toInt()} min';
                      }
                      return '';
                    },
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey[300],
                      strokeWidth: 1,
                    );
                  },
                ),
                borderData: FlBorderData(show: false),
                barGroups: weeklySun.asMap().entries.map((entry) {
                  int index = entry.key;
                  SunData sunData = entry.value;
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        y: sunData.minutes.toDouble(),
                        colors: [Colors.blue[400]!],
                        borderRadius: BorderRadius.circular(5),
                        width: 20,
                      )
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _scrollStatisticsAir(BuildContext context, List<Map<String, dynamic>> datosSol){
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.38, left: 20, right: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _titleHabitsAir(context),
            SizedBox(height: 10),
            _barChartAir(context, datosSol),
          ],
        ),
      ),
    );
  }

  Widget _titleHabitsAir(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        'Aire Puro',
        style: TextStyle(
          fontSize: 27,
          fontWeight: FontWeight.w800,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _barChartAir(BuildContext context, List<Map<String, dynamic>> datosAire) {
    List<AirData> weeklyAir = datosAire.map((data) {
      String dia = data['dia'];
      int minutos = data['minutos'];
      return AirData(dia, minutos);
    }).toList();

    if (weeklyAir.isEmpty) {
      return Center(
        child: Text('No hay datos disponibles'),
      );
    }

    return Container(
      height: 300,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Minutos de Aire Puro',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Expanded(
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: weeklyAir.map((e) => e.minutes.toDouble()).reduce((a, b) => a > b ? a : b) * 1.2,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        '${weeklyAir[groupIndex].day}\n',
                        TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '${weeklyAir[groupIndex].minutes} min',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (context, value) {
                      return const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      );
                    },
                    margin: 10,
                    getTitles: (double value) {
                      int index = value.toInt();
                      return index >= 0 && index < weeklyAir.length ? weeklyAir[index].day : '';
                    },
                  ),
                  leftTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (context, value) {
                      return const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      );
                    },
                    margin: 10,
                    reservedSize: 28,
                    getTitles: (value) {
                      if (value == 0) {
                        return '0';
                      } else if (value % 30 == 0) {
                        return '${value.toInt()} min';
                      }
                      return '';
                    },
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey[300],
                      strokeWidth: 1,
                    );
                  },
                ),
                borderData: FlBorderData(show: false),
                barGroups: weeklyAir.asMap().entries.map((entry) {
                  int index = entry.key;
                  AirData airData = entry.value;
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        y: airData.minutes.toDouble(),
                        colors: [Colors.blue[400]!],
                        borderRadius: BorderRadius.circular(5),
                        width: 20,
                      )
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _scrollStatisticsHope(BuildContext context){
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.38, left: 20, right: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _titleHabitsH(context),
            SizedBox(height: 25),
            _chartsH(context),
          ],
        ),
      ),
    );
  }

  Widget _titleHabitsH(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        'Esperanza',
        style: TextStyle(
          fontSize: 27,
          fontWeight: FontWeight.w800,
          color: Colors.black87,
        ),
      ),
    );
  }


  Widget _chartsH(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: MediaQuery.of(context).size.width - 40,
      decoration: BoxDecoration(
        color: Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Actividad que realiza',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: _getSectionsH(),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 3,
                  centerSpaceRadius: 5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _getSectionsH() {
    StatisticsController con = Get.put(StatisticsController());
    double oracion = con.oracion.value.toDouble();
    double lectura = con.l_biblia.value.toDouble();
    return [
      PieChartSectionData(
        color: Colors.blue,
        value: oracion,
        title: 'Oración ${con.oracion.value}%',
        radius: 120,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.green,
        value: lectura,
        title: 'L. Biblia ${con.l_biblia.value}%',
        radius: 120,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ];
  }
}