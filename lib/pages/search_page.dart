import 'package:bus_seat_booking_user/models/date_model.dart';
import 'package:bus_seat_booking_user/pages/schedule_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/constants.dart';

class SearchPage extends StatefulWidget {
  static const String routeName = '/search';

  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _formKey = GlobalKey<FormState>();
  final _datePickerController = TextEditingController();
  String? _startLocation;
  String? _endLocation;
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 8.0),
              child: DropdownButtonFormField<String>(
                value: _startLocation,
                hint: const Text('From'),
                items: routeTypeList
                    .map((type) => DropdownMenuItem<String>(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _startLocation = value;
                  });
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Provide start location';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 8.0),
              child: DropdownButtonFormField<String>(
                value: _endLocation,
                hint: const Text('To'),
                items: routeTypeList
                    .map((type) => DropdownMenuItem<String>(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _endLocation = value;
                  });
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Provide final destination';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
              child: TextFormField(
                controller: _datePickerController,
                onTap: _datePicker,
                readOnly: true,
                decoration: InputDecoration(
                  label: const Text('Pick departure date'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  suffixIcon: IconButton(
                    onPressed: _datePicker,
                    icon: const Icon(Icons.date_range_outlined),
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (_selectedDate == null) {
                    return 'Select departure date';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 30.0),
            Center(
              child: ElevatedButton(
                onPressed: _search,
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    )),
                child: const Text(
                  'Search',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _search() {
    if (_formKey.currentState!.validate()) {
      final dateModel = DateModel(
        year: _selectedDate!.year,
        month: _selectedDate!.month,
        day: _selectedDate!.day,
        timestamp: _selectedDate!.millisecondsSinceEpoch,
      );
      Navigator.pushNamed(context, SchedulePage.routeName, arguments: [_startLocation, _endLocation, dateModel]);
    }
  }

  @override
  void dispose() {
    _datePickerController.dispose();
    super.dispose();
  }

  void _datePicker() async {
    final dt = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 7)),
    );
    if (dt != null) {
      setState(() {
        _selectedDate = dt;
        _datePickerController.text = DateFormat.yMMMMd().format(_selectedDate!);
      });
    }
  }
}
