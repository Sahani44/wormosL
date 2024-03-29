import 'package:flutter/material.dart';

class CustomAnimatedAboveBar extends StatelessWidget {
  const CustomAnimatedAboveBar({
    Key? key,
    this.selectedIndex = 0,
    this.showElevation = true,
    this.iconSize = 24,
    this.backgroundColor,
    this.itemCornerRadius = 50,
    this.containerHeight = 80,
    this.containerWidth = double.infinity,
    this.containerColor = Colors.white,
    this.boxWidth = 10,
    this.animationDuration = const Duration(milliseconds: 0),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    required this.items,
    required this.onItemSelected,
    this.curve = Curves.linear,
  })  : assert(items.length >= 2 && items.length <= 7),
        super(key: key);

  final int selectedIndex;
  final double iconSize;
  final Color? backgroundColor;
  final bool showElevation;
  final Duration animationDuration;
  final List<AboveNavyBarItem> items;
  final ValueChanged<int> onItemSelected;
  final MainAxisAlignment mainAxisAlignment;
  final double itemCornerRadius;
  final double containerHeight;
  final double containerWidth;
  final double boxWidth;
  final Curve curve;
  final Color containerColor;

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? Theme.of(context).bottomAppBarColor;

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(40),
        ),
        border: Border.all(
          width: 3,
          color: containerColor,
          // style: BorderStyle.solid,
        ),
        color: containerColor,
        // boxShadow: [
        //   if (showElevation)
        //     const BoxShadow(
        //       color: Colors.black12,
        //       blurRadius: 2,
        //     ),
        // ],
      ),
      child: SafeArea(
        child: Container(
          width: containerWidth,
          height: containerHeight,
          padding: const EdgeInsets.only(top: 6, bottom: 6, left: 5,right: 5),
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: items.map((item) {
              var index = items.indexOf(item);
              return GestureDetector(
                onTap: () => onItemSelected(index),
                child: _ItemWidget(
                  item: item,
                  alphaSize: iconSize,
                  isSelected: index == selectedIndex,
                  backgroundColor: bgColor,
                  itemCornerRadius: itemCornerRadius,
                  animationDuration: animationDuration,
                  curve: curve,
                  boxWidth: boxWidth,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final double alphaSize;
  final bool isSelected;
  final AboveNavyBarItem item;
  final Color backgroundColor;
  final double itemCornerRadius;
  final Duration animationDuration;
  final Curve curve;
  final double boxWidth;

  const _ItemWidget({
    Key? key,
    required this.item,
    required this.isSelected,
    required this.backgroundColor,
    required this.animationDuration,
    required this.itemCornerRadius,
    required this.alphaSize,
    this.curve = Curves.linear,
    required this.boxWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      selected: isSelected,
      child: AnimatedContainer(
        width: boxWidth,
        height: double.maxFinite,
        duration: animationDuration,
        curve: curve,
        decoration: BoxDecoration(
          color:
              isSelected ? item.activeColor.withOpacity(0.2) : backgroundColor,
          borderRadius: BorderRadius.circular(itemCornerRadius),
        ),
        child: SizedBox(
          width: boxWidth,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconTheme(
                data: IconThemeData(
                  size: alphaSize,
                  color: isSelected
                      ? item.activeColor.withOpacity(1)
                      : item.inactiveColor ?? item.activeColor,
                ),
                child: Text(item.alpha),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AboveNavyBarItem {
  AboveNavyBarItem({
    required this.alpha,
    this.activeColor = Colors.white,
    this.inactiveColor,
  });

  final String alpha;
  final Color activeColor;
  final Color? inactiveColor;
}
