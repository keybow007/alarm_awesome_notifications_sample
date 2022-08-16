import 'package:flutter/material.dart';

class AmPmChange extends StatefulWidget {
  final bool init;
  final Function(bool) value;

  AmPmChange(this.init, this.value);

  @override
  _AmPmChangeState createState() => _AmPmChangeState();
}

class _AmPmChangeState extends State<AmPmChange> {
  bool _isPM = true;

  @override
  void initState() {
    _isPM = widget.init;
    widget.value(_isPM);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isPM = !_isPM;
        });
        widget.value(_isPM);
      },
      child: Container(
        width: 42,
        height: 56,
        color: Colors.black54,
        padding: const EdgeInsets.symmetric(vertical: 4),
        // alignment: _isPM ? Alignment.bottomCenter : Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "AM",
              style: TextStyle(
                  fontSize: 18,
                  height: 1,
                  color: _isPM ? Colors.black26 : Colors.green[800]),
            ),
            Text(
              "PM",
              style: TextStyle(
                  fontSize: 18,
                  height: 1,
                  color: _isPM ? Colors.green[800] : Colors.black26),
            ),
          ],
        ),
      ),
    );
  }
}
