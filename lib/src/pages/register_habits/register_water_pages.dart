import 'package:app_vida_saludable/src/controllers/register_water_controller.dart';
import 'package:app_vida_saludable/src/pages/register_habits/alarm_water_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import '../../utils/custom_paint_water.dart';


class RegisterWaterPage extends StatelessWidget {

  final RegisterWaterController controller = Get.put(RegisterWaterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.indigo,
        child: Stack(
          children: [
            _iconBack(context),
            Column(
              children: [
                _textTitle(),
                _bgForm(context),
              ],
            ),
            _iconAlarm(context),
            _formWater(context)
          ],
        ),
      ),
    );
  }


  Widget _bgForm(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 18, bottom: 20),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.82,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.elliptical(25, 25),
            topRight: Radius.elliptical(25, 25),
            bottomLeft: Radius.elliptical(25, 25),
            bottomRight: Radius.elliptical(25, 25),
          )
      ),
    );
  }

  Widget _textTitle() {
    return Container(
      margin: EdgeInsets.only(top: 40),
      child: Text(
        'Agua',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _iconBack(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, top: 34),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _iconAlarm(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 34),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.alarm,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AlarmWaterPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _formWater(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _circleProgres(context),
            _myDatos(context),
            _registerWater(context)
          ],
        ),
      ),
    );
  }
  
  Widget _circleProgres(BuildContext context) {
    HomeController con = Get.find<HomeController>();
    double percentage = con.percentageWaterC.value;
    
    return Container(
      child: CircularProgress(percentage: percentage),
    );

  }

  Card _myDatos(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.06,
        left: 25,
        right: 25,
      ),
      elevation: 1,
      color: Colors.indigo[100],
      child: SizedBox(
        height: 110,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(15, 10, 25, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.local_drink, color: Colors.black),
                      SizedBox(width: 10),
                      Text('Meta diaria', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 15)),
                    ],
                  ),
                  Text('2000 ml', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 15)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 7, 25, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.local_drink_sharp, color: Colors.black),
                      SizedBox(width: 10),
                      Text('Última bebida', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 15)),
                    ],
                  ),
                  Text('250 ml', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 15)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 7, 25, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.local_drink_sharp, color: Colors.black),
                      SizedBox(width: 10),
                      Text('Cantidad', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 15)),
                    ],
                  ),
                  Obx(
                        () => Text(
                      '${controller.cantidadController.value} vasos',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _registerWater(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.18,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.do_disturb_on, color: Colors.red, size: 35),
            ],
          ),
          SizedBox(width: 20),
          Icon(Icons.local_drink_outlined, color: Colors.grey, size: 100),
          SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  controller.onTapIcon();
                  controller.createWater();
                  Navigator.pop(context);
                },
                child: Icon(Icons.add_circle_outlined, color: Colors.indigo, size: 35),
              ),
            ],
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }

}
