import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

class OwnButton extends StatelessWidget{
  final String label;
  final void Function() onPressed;
  OwnButton({this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: TextButton.styleFrom(
          backgroundColor: primaryColor,
          padding: EdgeInsets.all(defaultPadding),
        ),
        onPressed: onPressed,
        child: Text(label, style: TextStyle(color: iconColor),),

    );
  }
}

class OwnButtonWithICon extends StatelessWidget{
  final String label;
  final IconData icon;
  final void Function() onPressed;
  OwnButtonWithICon({this.label, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(

        style: TextButton.styleFrom(
          backgroundColor: primaryColor,
          padding: EdgeInsets.all(defaultPadding),
        ),
        onPressed: onPressed,
        icon: Icon(icon, color: iconColor,),
        label: Text(label, style: TextStyle(color: iconColor),)

    );
  }
}

class OwnButtonICon extends StatelessWidget{
  final IconData icon;
  final void Function() onPressed;
  OwnButtonICon({this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        splashRadius: 25,
        color: iconColor,
        hoverColor: secondaryColor,
        onPressed: onPressed,
        icon: Icon(icon)
    );
  }
}

class OwnTextButton extends StatelessWidget{
  final String label;
  final void Function() onPressed;
  OwnTextButton({this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.all(10)),
          overlayColor: MaterialStateProperty.all(secondaryColor)
        ),
        child: Text(label, style: TextStyle(color: iconColor, fontSize: 16),),
    );
  }
}

class OwnChoiceChip extends StatelessWidget{
  final String label;
  final void Function(bool) onSelected;
  final bool selected;
  OwnChoiceChip({this.label, this.onSelected, this.selected});

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      backgroundColor: secondaryColor,
      selectedColor: Colors.indigo.withOpacity(0.5),
      disabledColor: Colors.indigo.withOpacity(0.6),
      labelStyle: TextStyle(color: Colors.black54),
      label: Text(label),
      // selected: _indexSelected.value == 3,
      selected: selected,
      onSelected: onSelected
    );
  }
}