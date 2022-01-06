import 'package:admin/constants/colors.dart';
import 'package:admin/constants/measurements.dart';
import 'package:flutter/material.dart';

class OwnButton extends StatelessWidget{
  final String? label;
  final void Function()? onPressed;
  OwnButton({this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: TextButton.styleFrom(
          backgroundColor: secondaryColor,
          padding: EdgeInsets.all(5),
        ),
        onPressed: onPressed,
        child: Text(label!, style: TextStyle(color: primaryColor),),

    );
  }
}

class OwnButtonWithICon extends StatelessWidget{
  final String? label;
  final IconData? icon;
  final void Function()? onPressed;
  OwnButtonWithICon({this.label, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(

        style: TextButton.styleFrom(
          backgroundColor: secondaryColor,
          padding: EdgeInsets.all(5),
        ),
        onPressed: onPressed,
        icon: Icon(icon, color: primaryColor,),
        label: Text(label!, style: TextStyle(color: primaryColor),)

    );
  }
}

class OwnButtonICon extends StatelessWidget{
  final IconData? icon;
  final void Function()? onPressed;
  OwnButtonICon({this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: IconButton(
        splashRadius: 20,
        color: iconColor,
        hoverColor: secondaryColor,
        onPressed: onPressed,
        icon: Icon(icon)
    ),
    );
  }
}

class OwnTextButton extends StatelessWidget{
  final String? label;
  final void Function()? onPressed;
  OwnTextButton({this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.all(10)),
          overlayColor: MaterialStateProperty.all(secondaryColor)
        ),
        child: Text(label!, style: TextStyle(color: primaryColor, fontSize: 16),),
    );
  }
}

class OwnChoiceChip extends StatelessWidget{
  final String? label;
  final void Function(bool)? onSelected;
  final bool? selected;
  OwnChoiceChip({this.label, this.onSelected, this.selected});

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      backgroundColor: secondaryColor,
      selectedColor: Colors.indigo.withOpacity(0.5),
      disabledColor: Colors.indigo.withOpacity(0.6),
      labelStyle: TextStyle(color: Colors.black54),
      label: Text(label!),
      // selected: _indexSelected.value == 3,
      selected: selected!,
      onSelected: onSelected
    );
  }
}

class OwnAnimatedButton extends StatefulWidget{
  @override
  State<OwnAnimatedButton> createState() => _OwnAnimatedButtonState();

  final Widget? child;
  final void Function()? onTap;
  final double width;

  OwnAnimatedButton({this.child, this.onTap, this.width = 50});

}

class _OwnAnimatedButtonState extends State<OwnAnimatedButton> {
  Color _color = Colors.transparent;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        alignment: Alignment.center,
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: _color,
          borderRadius: BorderRadius.circular(5),
        ),
        width: widget.width,
        height: 30,
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            padding: EdgeInsets.all(5),
            child: InkWell(
              focusColor: secondaryColor,
              hoverColor: Colors.transparent,
              onHover: (isHover) {
                setState(() {
                  _color = _color == Colors.transparent ? secondaryColor : Colors.transparent;
                });
              },
              onTap: widget.onTap,
              child: widget.child,
            ),
          ) 
        )
    );
  }
}

class OwnAnimatedTextButton extends StatefulWidget{
  @override
  State<OwnAnimatedTextButton> createState() => _OwnAnimatedTextButton();

  final void Function()? onPressed;
  final String? childText;
  final double fontSize;

  OwnAnimatedTextButton({this.childText, this.onPressed, this.fontSize = 25});

}

class _OwnAnimatedTextButton extends State<OwnAnimatedTextButton> {
  Color _color = primaryColor;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 200),
        child: Material(
            type: MaterialType.transparency,
            child: Container(
              padding: EdgeInsets.all(5),
              child: InkWell(
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onHover: (isHover) {
                  setState(() {
                    _color = _color == primaryColor ? secondaryColor : primaryColor;
                  });
                },
                onTap: widget.onPressed,
                child: Text(widget.childText!,  style: TextStyle(color: _color, fontSize: widget.fontSize)),
              ),
            )
        )
    );
  }
}



