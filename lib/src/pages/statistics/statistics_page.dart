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
    List<Map<String, dynamic>> datosDescansoHorasU = con.datosDescansoHorasU;
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
          if (showStatisticsDream) _scrollStatisticsDream(context, datosDescansoHorasU),
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
        con.datosEjercicio(con.user.id.toString());
        con.datosEjercicioT(con.user.id.toString());
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
        con.datosEstadisticosAgua(con.user.id.toString());
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
        con.datosEstatisticosDescanso(con.user.id.toString());
        con.datosEstadisticosDescansoHoras(con.user.id.toString());
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
        con.datosSolTiempo(con.user.id.toString());
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
        con.datosAireTiempo(con.user.id.toString());
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
        con.datosEsperanza(con.user.id.toString());
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
          con.datosAlimentacionTipo(con.user.id.toString(), 'desayuno');
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
              fontSize: 16,
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
          con.datosAlimentacionTipo(con.user.id.toString(), 'almuerzo');
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
              fontSize: 16,
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
          con.datosAlimentacionTipo(con.user.id.toString(), 'cena');
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
              fontSize: 16,
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
          con.datosTipoEjercicio(con.user.id.toString(), 'trote');
          con.onPressed('trote');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: con.buttonColorTrote,
          padding: EdgeInsets.symmetric(vertical: 10), // padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // rounded corners
          ),
          minimumSize: Size(150, 0),
        ),
        child: Text(
          'Trote',
          style: TextStyle(
              fontSize: 16,
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
          con.datosTipoEjercicio(con.user.id.toString(), 'caminata rapida');
          con.onPressed('caminata rapida');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: con.buttonColorC_Rapida,
          padding: EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize: Size(150, 0),
        ),
        child: Text(
          'Caminata Rapida',
          style: TextStyle(
              fontSize: 16,
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
          con.datosTipoEjercicio(con.user.id.toString(), 'caminata lenta');
          con.onPressed('caminata lenta');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: con.buttonColorC_Lenta,
          padding: EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize: Size(150, 0),
        ),
        child: Text(
          'Caminata Lenta',
          style: TextStyle(
              fontSize: 16,
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
          con.datosTipoEjercicio(con.user.id.toString(), 'ejercicio guiado');
          con.onPressed('ejercicio guiado');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: con.buttonColorE_Guiado,
          padding: EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize: Size(150, 0),
        ),
        child: Text(
          'Ejercicio Guiado',
          style: TextStyle(
              fontSize: 16,
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
      String dia = data['dia_semana'];
      int minutos = data['tiempo_total'];
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
                // Aquí se establece el valor máximo de Y en 45
                maxY: 45,
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
                      } else if (value % 15 == 0) {
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
    // Lista de días de la semana
    List<String> diasDeLaSemana = ['Dom', 'Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb'];
    // Mapa para almacenar las cantidades de agua por día
    Map<String, int> cantidadPorDia = {
      'Dom': 0,
      'Lun': 0,
      'Mar': 0,
      'Mié': 0,
      'Jue': 0,
      'Vie': 0,
      'Sáb': 0,
    };

    // Rellenar el mapa con los datos existentes
    for (var data in datosAgua) {
      String dia = data['dia'] ?? 'Desconocido'; // Manejar día nulo
      int cantidad = (data['cantidad_agua'] ?? 0) as int; // Asegúrate de que cantidad sea un entero
      // Solo asignar si el día está en la lista
      if (cantidadPorDia.containsKey(dia)) {
        cantidadPorDia[dia] = cantidad;
      }
    }

    // Establecer maxY en 2000
    double maxY = 2000;

    // Convertir el mapa a una lista de WaterData
    List<WaterData> weeklyWater = diasDeLaSemana.map((dia) {
      return WaterData(dia, cantidadPorDia[dia] ?? 0);
    }).toList();

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
                maxY: maxY, // maxY fijado en 2000
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
                      return (index >= 0 && index < weeklyWater.length) ? weeklyWater[index].day : '';
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
                      } else if (value % 500 == 0) {
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



  Widget _scrollStatisticsDream(BuildContext context, List<Map<String, dynamic>> datosDescansoHorasU){
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.38, left: 20, right: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _titleHabitsDream(context),
            SizedBox(height: 25),
            _barChartDream(context, datosDescansoHorasU),
            SizedBox(height: 15),
            _chartsDream(context),
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

  Widget _barChartDream(BuildContext context, List<Map<String, dynamic>> datosDescansoHorasU) {
    // Utiliza la lista que ya tienes en el controlador
    final List<Map<String, dynamic>> weeklySleep = datosDescansoHorasU;

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
                maxY: 10, // Ajusta según el máximo de horas de sueño esperado
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      // Asegúrate de manejar el caso donde los datos pueden no estar disponibles
                      final data = weeklySleep[groupIndex];
                      return BarTooltipItem(
                        '${data['dia_semana']}\n',
                        TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '${data['total_horas'] ?? 0} hrs',
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
                      return index >= 0 && index < weeklySleep.length
                          ? weeklySleep[index]['dia_semana'] ?? ''
                          : '';
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
                  Map<String, dynamic> sleepData = entry.value;
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        y: sleepData['total_horas']?.toDouble() ?? 0.0, // Asegúrate de que no sea nulo
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

    // Asegúrate de que el total no sea cero para evitar divisiones por cero
    double total = bien + mal;

    if (total == 0) {
      return [
        PieChartSectionData(
          color: Colors.blue,
          value: 1, // Un valor mínimo para mostrar algo en el gráfico
          title: 'Bien 0%',
          radius: 120,
          titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        PieChartSectionData(
          color: Colors.red,
          value: 1, // Un valor mínimo para mostrar algo en el gráfico
          title: 'Mal 0%',
          radius: 120,
          titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ];
    }

    return [
      PieChartSectionData(
        color: Colors.blue,
        value: (bien / total) * 100, // Convertir a porcentaje
        title: 'Bien ${bien.toStringAsFixed(1)}%',
        radius: 120,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.red,
        value: (mal / total) * 100, // Convertir a porcentaje
        title: 'Mal ${mal.toStringAsFixed(1)}%',
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
    // Verifica si los datos están vacíos
    if (datosSol.isEmpty) {
      return Center(
        child: Text('No hay datos disponibles'),
      );
    }

    List<SunData> weeklySun = datosSol.map((data) {
      String dia = data['dia_semana'] ?? 'Desconocido';
      int minutos = data['tiempo_total'] ?? 0; // Asegúrate de que minutos sea siempre un número
      return SunData(dia, minutos);
    }).toList();

    // Filtra datos nulos o negativos
    weeklySun = weeklySun.where((data) => data.minutes >= 0).toList();

    // Si después de filtrar sigue vacío, muestra mensaje
    if (weeklySun.isEmpty) {
      return Center(
        child: Text('No hay datos válidos disponibles'),
      );
    }

    // Establece un máximo de 45 minutos
    double maxY = 45;

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
                maxY: maxY, // Usa el máximo fijo de 45
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
                      } else if (value % 15 == 0) { // Cambié a 15 para mejor visualización
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
      String dia = data['dia_semana'];
      int minutos = data['tiempo_total'];
      return AirData(dia, minutos);
    }).toList();

    if (weeklyAir.isEmpty) {
      return Center(
        child: Text('No hay datos disponibles'),
      );
    }

    // Definir el máximo en 45 minutos
    const int maxMinutes = 45;

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
                maxY: maxMinutes.toDouble(), // Establecer máximo en 45 minutos
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
                      } else if (value % 15 == 0) { // Cambiar a cada 15 minutos
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
                        y: airData.minutes.clamp(0, maxMinutes).toDouble(), // Limitar los minutos a un máximo de 45
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

    // Asegúrate de que los valores sean double
    double oracion = con.oracion.value.toDouble();
    double lectura = con.l_biblia.value.toDouble();

    // Calcula el total para evitar dividir por cero y normaliza los valores si es necesario
    double total = oracion + lectura;

    // En caso de que el total sea cero, previene NaN o Infinity
    if (total == 0) {
      return [
        PieChartSectionData(
          color: Colors.blue,
          value: 0,
          title: 'Oración 0%',
          radius: 120,
          titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        PieChartSectionData(
          color: Colors.green,
          value: 0,
          title: 'L. Biblia 0%',
          radius: 120,
          titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ];
    }

    return [
      PieChartSectionData(
        color: Colors.blue,
        value: oracion,
        title: 'Oración ${(oracion / total * 100).toStringAsFixed(1)}%', // Muestra el porcentaje
        radius: 120,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        color: Colors.green,
        value: lectura,
        title: 'L. Biblia ${(lectura / total * 100).toStringAsFixed(1)}%', // Muestra el porcentaje
        radius: 120,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ];
  }

}