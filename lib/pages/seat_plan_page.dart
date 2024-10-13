import 'package:bus_seat_booking_user/models/schedule_model.dart';
import 'package:bus_seat_booking_user/pages/confirm_booking_page.dart';
import 'package:bus_seat_booking_user/providers/seat_plan_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../custom_widgets/small_box.dart';
import '../custom_widgets/seat_view.dart';
import '../models/date_model.dart';

class SeatPlanPage extends StatefulWidget {
  static const String routeName = '/seat_plan';

  const SeatPlanPage({super.key});

  @override
  State<SeatPlanPage> createState() => _SeatPlanPageState();
}

class _SeatPlanPageState extends State<SeatPlanPage> {
  late ScheduleModel _scheduleModel;
  late DateModel _dateModel;

  @override
  void didChangeDependencies() {
    final argList = ModalRoute.of(context)!.settings.arguments as List;
    _scheduleModel = argList[0];
    _dateModel = argList[1];
    context
        .read<SeatPlanProvider>()
        .init(_scheduleModel, _dateModel);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seat Plan'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SmallBox(label: 'Available', color: Colors.grey.shade700),
                  const SizedBox(width: 10.0),
                  const SmallBox(
                      label: 'Selected', color: Colors.green),
                  const SizedBox(width: 10.0),
                  const SmallBox(label: 'Booked', color: Colors.red),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 40.0, right: 40.0, bottom: 10.0),
              child: Consumer<SeatPlanProvider>(
                  builder: (context, provider, child) => Text(
                        'Selected seats: ${provider.getAllSelectedSeat}',
                        style: const TextStyle(fontSize: 16.0),
                      )),
            ),
            SizedBox(
              width: double.infinity,
              height: 600,
              child: Consumer<SeatPlanProvider>(
                builder: (context, provider, child) => GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: provider.crossAxisCount.toInt(),
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: provider.seatList.length,
                  itemBuilder: (context, index) {
                    final number = provider.seatList[index];
                    return number.isEmpty
                        ? const SizedBox()
                        : SeatView(
                            label: number,
                            isSelected:
                                provider.selectedSeatNumber.contains(number),
                            isBooked: false,
                            onSelect: (value) {
                              provider.selectSeat(value);
                            },
                            onDeselect: (value) {
                              provider.deSelectSeat(value);
                            },
                          );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0, right: 40.0,),
              child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushNamed(context, ConfirmBookingPage.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      )),
                  child: const Text(
                    'NEXT',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
