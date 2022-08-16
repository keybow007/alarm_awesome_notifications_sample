import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flip_board/flip_widget.dart';
import 'package:flutter/material.dart';

class Digit extends StatefulWidget {
  final double width;
  final double? height;
  final List<String>? digits;
  final String? target;
  final String? font;
  final int times;
  final String? init;
  final bool isZero;
  final bool isPlay;
  final Function(int)? value;
  final Function(int)? isDone;

  final VoidCallback? isFin;

  Digit(this.width, this.times,
      {this.init,
      this.height = 64,
      this.digits,
      this.target,
      this.font,
      this.isZero = true,
      this.isPlay = false,
      this.value,
      this.isDone,
      this.isFin,

      ///20220609: Keyの追加（GlobalKeyを使えるように）
      Key? key})
      : super(key: key);

  @override
  DigitState createState() => DigitState();
}

///20220609: GlobalKey使うためにpublic化
class DigitState extends State<Digit> {
  final _flipController = StreamController<String>.broadcast();
  Timer? _timer;
  List<String> _digits = <String>[];
  bool _isFw = true;
  int _index = 0;
  int _times = 10;


  @override
  void initState() {
    ///20220609: 再度★を押したときにinitStateを通らない
    //  => Digitウィジェットはすでに生成されているので
    //  => この初期化処理を別メソッドで外出しにしてGlobalKey経由で呼べばよい？
    //  => _DigitStateは「_」を抜いてpublicに

    startDigitMove();
    super.initState();
  }

  ///20220609: この初期化処理を別メソッドで外出しにしてGlobalKey経由で呼べるように
  void startDigitMove() {
    _times = widget.digits != null ? widget.digits!.length : widget.times;

    if (widget.target == null) {
      _index = int.parse(widget.init!);
      if (widget.value != null) {
        widget.value!(_index);
      }
    } else if (widget.init != null && widget.target != widget.init) {
      if (widget.digits != null) {
        _digits = widget.digits!;
      } else {
        _digits.add("");
        for (int i = 0; i < _times; i++) {
          _digits.add("$i");
        }
      }
      _play();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isPlay) {
      _play();
    }

    return widget.target == null
        ? GestureDetector(
            onTap: () {
              setState(() {
                _isFw = true;
              });
              _once(1);
            },
            onVerticalDragEnd: (details) {
              double v = details.primaryVelocity ?? 0.0;
              if (v < 0) {
                setState(() {
                  _isFw = false;
                });
                _once(-(v / 1000));
              } else {
                setState(() {
                  _isFw = true;
                });
                _once(v / 1000);
              }
            },
            child: FlipWidget(
              initialValue: "$_index",
              flipType: FlipType.middleFlip,
              flipDirection: _isFw ? AxisDirection.down : AxisDirection.up,
              itemStream: _flipController.stream,
              flipDuration: Duration(milliseconds: 120),
              hingeLength: 1.2,
              hingeWidth: 1.2,
              flipCurve:
                  _isFw ? FlipWidget.bounceFastFlip : FlipWidget.defaultFlip,
              itemBuilder: (context, item) => Container(
                width: widget.width,
                height: widget.height,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                ),
                child: AutoSizeText(
                  (item ?? "").toString(),
                  maxLines: 1,
                  style: TextStyle(
                    height: 1,
                    fontFamily: "DinR",
                    fontSize: 54.0,
                  ),
                ),
              ),
            ),
          )
        : FlipWidget(
            // initialValue: "$_index",
            flipType: FlipType.middleFlip,
            flipDirection: AxisDirection.down,
            itemStream: _flipController.stream,
            flipDuration: Duration(milliseconds: 120),
            hingeLength: 0.4,
            hingeWidth: 0.4,
            flipCurve: FlipWidget.bounceFastFlip,
            itemBuilder: (context, item) {
              final String s = (item ?? "").toString();
              final List<String> l = s.contains("\n") ? s.split("\n") : [];

              return Container(
                width: widget.width,
                height: widget.height!,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  // border: Border.all(color: Colors.white60),
                ),

                ///2段の時
                child: l.length > 1
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            l[0],
                            maxLines: 1,
                            style: TextStyle(
                              height: 1,
                              fontFamily: widget.font,
                              fontSize: widget.height! * 0.4,
                            ),
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(width: 2, color: Colors.white),
                              ),
                            ),
                            child: Text(
                              l[1],
                              style: TextStyle(
                                height: 1,
                                fontFamily: widget.font,
                                fontSize: widget.height! * 0.4,
                              ),
                            ),
                          ),
                        ],
                      )

                    ///1段の時
                    : AutoSizeText(
                        s,
                        maxLines: 1,
                        style: TextStyle(
                          height: 1,
                          fontFamily: widget.font,
                          fontSize: widget.height! * 0.8,
                        ),
                      ),
              );
            },
          );
  }

  _once(double time) async {
    int t = time.ceil();
    int def = widget.isZero ? 0 : 1;

    if (_isFw) {
      for (int i = 0; i < t; i++) {
        _index = _index < _times - 1 ? _index + 1 : def;

        _flipController.add("$_index");
        await Future.delayed(Duration(milliseconds: 120));
      }
    } else {
      for (int i = 0; i < t; i++) {
        _index = _index > def ? _index - 1 : _times - 1;
        _flipController.add("$_index");
        await Future.delayed(Duration(milliseconds: 100));
      }
    }
    widget.value!(_index);
  }

  _play() {
    if (widget.isDone != null) {
      widget.isDone!(1);
    }
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (_index >= _digits.length) {
        _index = 0;
      }
      _flipController.add(_digits[_index]);
      if (widget.target != null && _digits[_index] == widget.target) {
        _stop();
        if (widget.isFin != null) widget.isFin!();
        if (widget.isDone != null) {
          widget.isDone!(2);
        }
      }
      _index++;
    });
  }

  _stop() {
    _timer?.cancel();
  }
}
