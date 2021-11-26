
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Icon? iconLeft;
  final Icon? iconRight;
  final bool? enabled;
  final Color? color;
  final Color? textColor;
  final Color? disabledColor;
  final Color? disabledTextColor;
  final Color? splashColor;
  final double? width;
  final bool? isOutline;
  Button({
    Key? key,
    required this.text,
    this.color,
    this.textColor,
    this.disabledColor,
    this.disabledTextColor,
    this.splashColor,
    required this.onPressed,
    this.iconLeft,
    this.iconRight,
    this.width,
    this.isOutline,
    this.enabled}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
        minWidth: width ?? MediaQuery.of(context).size.width,
        height: 50.0,
        child: !isOutline! ? RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: (enabled != null && enabled! ) ? Colors.deepPurple : Colors.transparent)),
            onPressed: enabled == true ? () { onPressed(); } : null,
            highlightColor: Colors.deepPurpleAccent,
            color: color ?? Colors.deepPurple,
            textColor: textColor ?? Colors.white,
            disabledColor: disabledColor ?? const Color.fromRGBO(255, 90, 94, 0.6),
            disabledTextColor: disabledTextColor ?? Colors.white,
            splashColor: splashColor ?? Colors.deepPurple,
            child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    iconLeft != null ? Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: iconLeft
                    ) : const SizedBox.shrink(),
                    Text(text),
                    iconRight != null ? Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: iconRight ?? const SizedBox.shrink(),
                    ) : const SizedBox.shrink(),

                  ],
                )
            )
        ) : OutlineButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: const BorderSide(color: Colors.deepPurple)),
            onPressed: enabled == true ? () { onPressed(); } : null,
            borderSide: const BorderSide(color: Colors.deepPurple, width: 1.5),
            color: color ?? Colors.deepPurple,
            textColor: textColor ?? Colors.deepPurple,
            disabledTextColor: disabledTextColor ?? Colors.white,
            child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    iconLeft != null ? Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: iconLeft
                    ) : const SizedBox.shrink(),
                    Text(text),
                    iconRight != null ? Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: iconRight ?? const SizedBox.shrink(),
                    ) : const SizedBox.shrink(),

                  ],
                )
            )
        )
    );
  }
}
