import 'package:flutter/material.dart';

import '../../../models/room_info.dart';
import '../../../widgets/constant_widgets.dart';

class RoomsWidget extends StatelessWidget {
  const RoomsWidget({
    Key? key,
    required this.width,
    required Future<RoomInfo> rooms,
    required this.height,
    required this.topSectionHeight,
  })  : _rooms = rooms,
        super(key: key);

  final double width;
  final Future<RoomInfo> _rooms;
  final double height;
  final double topSectionHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width - (width * .050),
      height: (height - topSectionHeight) * 0.07,
      //color: const Color.fromARGB(255, 232, 242, 255),
      child: FutureBuilder(
        future: _rooms,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            var _roomList = snapshot.data!.results;
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _roomList!.length,
                itemBuilder: (context, index) {
                  return Container(
                      width: (width - (width * .050)) * .23,
                      margin: EdgeInsets.symmetric(
                        horizontal: (height - topSectionHeight) * .015,
                        vertical: (height - topSectionHeight) * .01,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 232, 242, 255),
                        borderRadius: BorderRadius.all(
                          Radius.circular(width * .03),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: const Color.fromARGB(255, 232, 242, 255),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(3, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FittedBox(
                              child: Text(
                                _roomList[index].subject?.title ?? '',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                            // WhiteDivider(),
                            // Text(
                            //   _roomList[index].subject?.description ?? '',
                            //   style: const TextStyle(color: Colors.white),
                            // ),
                          ],
                        ),
                      ));
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}
