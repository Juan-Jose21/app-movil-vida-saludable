import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/alarm_water_controller.dart';


class NotificationsPage extends StatelessWidget {
  final AlarmController _alarmController = Get.put(AlarmController());
  final AudioPlayer _audioPlayer = AudioPlayer();

  void _playSound(String sound) async {
    await _audioPlayer.play(AssetSource(sound));
  }

  // void _selectSound(String sound) async {
  //   _playSound('sound/$sound.mp3');
  //   await _alarmController.setSelectedSound(sound);
  // }

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
            _textSubTitle(context),
            // _SoundStarWars(context),
            // _SoundMarimba(context),
            // _SoundMozart(context),
            // _SoundNokia(context),
            // _SoundOnePiece(context)
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
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(top: 40),
      child: Text(
        'Notificación',
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

  Widget _textSubTitle(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.only(top: screenHeight * 0.14),
      child: Column(
        children: [
          Text(
            'Efectos de sonidos',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            height: 1.0,
            width: double.infinity,
            color: Colors.black, // Color de la línea
          ),
        ],
      ),
    );
  }

  // Widget _SoundStarWars(BuildContext context) {
  //   double screenHeight = MediaQuery.of(context).size.height;
  //   return GestureDetector(
  //     onTap: () {
  //       _selectSound('star_wars');
  //     },
  //     child: Container(
  //       margin: EdgeInsets.only(top: screenHeight * 0.42, left: 14, right: 14),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             'Star Wars',
  //             style: TextStyle(
  //               fontSize: 16,
  //               fontWeight: FontWeight.bold,
  //               color: Colors.black,
  //             ),
  //           ),
  //           SizedBox(height: 8.0),
  //           Container(
  //             height: 1.0,
  //             color: Colors.black,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _SoundNokia(BuildContext context) {
  //   double screenHeight = MediaQuery.of(context).size.height;
  //   return GestureDetector(
  //     onTap: () {
  //       _selectSound('nokia');
  //     },
  //     child: Container(
  //       margin: EdgeInsets.only(top: screenHeight * 0.24, left: 14, right: 14),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             'Nokia',
  //             style: TextStyle(
  //               fontSize: 16,
  //               fontWeight: FontWeight.bold,
  //               color: Colors.black,
  //             ),
  //           ),
  //           SizedBox(height: 8.0),
  //           Container(
  //             height: 1.0,
  //             color: Colors.black,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _SoundMozart(BuildContext context) {
  //   double screenHeight = MediaQuery.of(context).size.height;
  //   return GestureDetector(
  //     onTap: () {
  //       _selectSound('mozart');
  //     },
  //     child: Container(
  //       margin: EdgeInsets.only(top: screenHeight * 0.36, left: 14, right: 14),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             'Mozart',
  //             style: TextStyle(
  //               fontSize: 16,
  //               fontWeight: FontWeight.bold,
  //               color: Colors.black,
  //             ),
  //           ),
  //           SizedBox(height: 8.0),
  //           Container(
  //             height: 1.0,
  //             color: Colors.black,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _SoundMarimba(BuildContext context) {
  //   double screenHeight = MediaQuery.of(context).size.height;
  //   return GestureDetector(
  //     onTap: () {
  //       _selectSound('marimba');
  //     },
  //     child: Container(
  //       margin: EdgeInsets.only(top: screenHeight * 0.3, left: 14, right: 14),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             'Marimba',
  //             style: TextStyle(
  //               fontSize: 16,
  //               fontWeight: FontWeight.bold,
  //               color: Colors.black,
  //             ),
  //           ),
  //           SizedBox(height: 8.0),
  //           Container(
  //             height: 1.0,
  //             color: Colors.black,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _SoundOnePiece(BuildContext context) {
  //   double screenHeight = MediaQuery.of(context).size.height;
  //   return GestureDetector(
  //     onTap: () {
  //       _selectSound('one_piece');
  //     },
  //     child: Container(
  //       margin: EdgeInsets.only(top: screenHeight * 0.48, left: 14, right: 14),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             'One Piece',
  //             style: TextStyle(
  //               fontSize: 16,
  //               fontWeight: FontWeight.bold,
  //               color: Colors.black,
  //             ),
  //           ),
  //           SizedBox(height: 8.0),
  //           Container(
  //             height: 1.0,
  //             color: Colors.black,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

}
