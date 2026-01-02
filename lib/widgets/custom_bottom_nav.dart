import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 343,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            icon: "assets/icons/setting.svg",
            index: 0,
            currentIndex: currentIndex,
            onTap: onTap,
          ),
          _NavItem(
            icon: "assets/icons/favourite.svg",
            index: 1,
            currentIndex: currentIndex,
            onTap: onTap,
          ),
          _NavItem(
            icon: "assets/icons/fluent_home-12-filled.svg",
            index: 2,
            isCenter: true,
            currentIndex: currentIndex,
            onTap: onTap,
          ),
          _NavItem(
            icon: "assets/icons/ai.svg",
            index: 3,
            currentIndex: currentIndex,
            onTap: onTap,
          ),
          _NavItem(
            icon: "assets/icons/person.svg",
            index: 4,
            currentIndex: currentIndex,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String icon;
  final int index;
  final int currentIndex;
  final bool isCenter;
  final Function(int) onTap;

  const _NavItem({
    required this.icon,
    required this.index,
    required this.currentIndex,
    required this.onTap,
    this.isCenter = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isActive = index == currentIndex;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        width: isCenter ? 52 : 40,
        height: isCenter ? 52 : 40,
        decoration: isCenter
            ? BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              )
            : null,
        child: Center(
          child: SvgPicture.asset(
            icon,
            width: isCenter ? 26 : 22,
            height: isCenter ? 26 : 22,
            colorFilter: ColorFilter.mode(
              isCenter
                  ? Colors.black
                  : isActive
                      ? Colors.white
                      : Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}