import 'package:ant_icons/ant_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:habito_de_ler/utils/space_utils.dart';

class RecordReadingPage extends StatefulWidget {
  @override
  _RecordReadingPageState createState() => _RecordReadingPageState();
}

class _RecordReadingPageState extends State<RecordReadingPage>
    with TickerProviderStateMixin {
  AnimationController controller;

  bool isPlaying = false;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    print('initState');
    controller = AnimationController(
      vsync: this,
      duration: Duration(minutes: 60, seconds: 00),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.only(left: 12, right: 12),
      child: Column(
        children: <Widget>[
          SpaceUtils.column(42),
          Container(
            decoration: new BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(18),
            height: height * 0.3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Positioned(
                      child: CachedNetworkImage(
                          imageUrl:
                              'https://a-static.mlcdn.com.br/618x463/livro-os-segredos-da-mente-milionaria/magazineluiza/088610900/b6ebc80978e5cae2c423dd0132a540a2.jpg'),
                    ),
                    Positioned.fill(
                      child: GestureDetector(
                        child: AnimatedBuilder(
                          animation: controller,
                          builder: (BuildContext context, Widget child) {
                            return Icon(
                              controller.isAnimating
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Colors.black45,
                              size: 68,
                            );
                          },
                        ),
                        onTap: () {
                          setState(() => isPlaying = !isPlaying);

                          if (controller.isAnimating) {
                            controller.stop(canceled: true);
                            String saveStopTime = timerString;
                            print(saveStopTime);
                          } else {
                            controller.repeat(reverse: false);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Tempo meta p/ dia",
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                    SpaceUtils.column(4),
                    AnimatedBuilder(
                      animation: controller,
                      builder: (BuildContext context, Widget child) {
                        return Text(
                          timerString,
                          style: TextStyle(fontSize: 18),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
