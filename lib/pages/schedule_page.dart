import 'package:bus_seat_booking_user/pages/seat_plan_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../custom_widgets/schedule_item_view.dart';
import '../models/date_model.dart';
import '../providers/booking_provider.dart';


class SchedulePage extends StatefulWidget {
  static const String routeName = '/schedule';

  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  late String _startLocation;
  late String _endLocation;
  late DateModel _dateModel;

  @override
  void didChangeDependencies() {
    final argList = ModalRoute.of(context)!.settings.arguments as List;
    _startLocation = argList[0];
    _endLocation = argList[1];
    _dateModel = argList[2];
    context.read<BookingProvider>().getAllSchedulesByStartAndEndLocation(_startLocation, _endLocation);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Schedule List'),
        ),
        body: Consumer<BookingProvider>(
            builder: (context, provider, child) => provider.scheduleList.isEmpty
                ? const Center(
                    child: Text(
                    'Schedule not found',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                  ))
                : ListView.builder(
                    itemCount: provider.scheduleList.length,
                    itemBuilder: (context, index) {
                      final schedule = provider.scheduleList[index];
                      return ScheduleItemView(schedule: schedule, index: index, onClick: (){
                        Navigator.pushNamed(context, SeatPlanPage.routeName, arguments: [schedule, _dateModel]);
                      },);
                    },
                  )));
  }
}
