import 'package:flutter/material.dart';
import '../models/schedule_model.dart';
import '../utils/constants.dart';

class ScheduleItemView extends StatelessWidget {
  const ScheduleItemView({
    super.key,
    required this.schedule,
    required this.index,
    required this.onClick,

  });

  final ScheduleModel schedule;
  final VoidCallback onClick;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onClick,
      leading: Text(
        '${index + 1}.',
        style: const TextStyle(fontSize: 16.0),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(schedule.bus.busName,
            style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
          ),
          Text('Bus No: ${schedule.bus.busNumber}',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            schedule.route.routeName,
            style: const TextStyle(fontSize: 15),
          ),
          Text(schedule.departureTime, style: const TextStyle(fontSize: 15)),
        ],
      ),
      trailing: Column(
        children: [
          Text(schedule.bus.busType, style: const TextStyle(fontSize: 16.0)),
          Text('$currency ${schedule.ticketPrice.toString()}',
              style: const TextStyle(fontSize: 16.0)),
        ],
      ),
    );
  }
}
