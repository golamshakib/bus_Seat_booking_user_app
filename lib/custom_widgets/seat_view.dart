import 'package:flutter/material.dart';

class SeatView extends StatelessWidget {
  const SeatView({
    super.key,
    required this.label,
    required this.isSelected,
    required this.isBooked,
    required this.onSelect,
    required this.onDeselect,
  });

  final String label;
  final bool isSelected;
  final bool isBooked;
  final Function(String) onSelect;
  final Function(String) onDeselect;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: isBooked
          ? null
          : () {
              if (isSelected) {
                onDeselect(label);
              } else {
                onSelect(label);
              }
            },
      icon: Stack(
        children: [
          Center(
            child: Image.asset('assets/images/seat.png',
                color: isBooked
                    ? Colors.red
                    : isSelected
                        ? Colors.green
                        : null),
          ),
          Center(
              child: Container(
                  height: 22.0,
                  width: 22.0,
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
                  child: Center(
                    child: Text(
                      label,
                      style: TextStyle(
                        color: isBooked
                            ? Colors.red
                            : isSelected
                                ? Colors.green
                                : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ))),
        ],
      ),
    );
  }
}
