import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final Color? color;
  final Widget? child;
  final double paddingHorizontal;
  final void Function()? onPressed;

  const CustomButton(
      {Key? key,
      this.onPressed,
      this.child,
      this.color,
      this.height = 50,
      this.width = double.infinity,
      this.paddingHorizontal = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
      child: MaterialButton(
        elevation: 10,
        onPressed: onPressed,
        child: child,
        minWidth: width,
        height: height,
        color: Theme.of(context).splashColor,
      ),
    );
  }
}
