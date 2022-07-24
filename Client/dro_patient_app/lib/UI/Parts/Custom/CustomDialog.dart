import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCustomDialog extends StatefulWidget {

  final Widget title,content;
  final List<Widget> actions;

  MyCustomDialog({this.title,this.content,this.actions});

  @override
  State<StatefulWidget> createState() => MyCustomDialogState();
}

class MyCustomDialogState extends State<MyCustomDialog>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeInOutCirc);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Container(
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width/1.3,
                  child: NotificationListener(
                    // ignore: missing_return
                    onNotification: (OverscrollIndicatorNotification overScrollIndicatorNotification){
                      overScrollIndicatorNotification.disallowGlow();
                    },
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        widget.title != null ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: widget.title,
                        ) : Container(),
                        widget.content != null ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: widget.content,
                        ) : Container(),
                        widget.actions != null ? Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: widget.actions
                        ) : Container()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}