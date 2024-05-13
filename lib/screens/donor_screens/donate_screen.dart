import 'package:flutter/material.dart';
// data model
import 'package:elbi_donation_system/data_models/organization.dart';
// custom widgets
import 'package:elbi_donation_system/custom_widgets/donor_views/donate_screen/org_image.dart';
import 'package:elbi_donation_system/custom_widgets/donor_views/donate_screen/org_details.dart';
import 'package:elbi_donation_system/custom_widgets/donor_views/donate_screen/donation_header.dart';
import 'package:elbi_donation_system/custom_widgets/donor_views/donate_screen/donation_detail_header.dart';
import 'package:elbi_donation_system/custom_widgets/donor_views/donate_screen/custom_elevated_button.dart';


class DonateScreen extends StatefulWidget {
  const DonateScreen({
    required this.org,
    super.key,
  });

  // property
  final Organization org;

  @override
  State<DonateScreen> createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  final double _optionsFontSize = 18;

  // states
  late String _chosenMethod = _donationMethod[0];
  late double _weight;
  late String _weightUnit = _weightUnits[0];
  late DateTime _date;
  late TimeOfDay _time;

  // controllers
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  // donation categories state
  final Map<String, bool> _donationCategories = {
    'Food': false,
    'Clothes': false,
    'Cash': false,
    'Necessities': false,
  };

  // pickup or drop-off
  final List<String> _donationMethod = ['Pickup', 'Drop-off'];

  // weight unit
  final List<String> _weightUnits = ['kg', 'lbs'];

  // method for showing the date picker
  Future<void> _selectDate() async {
    DateTime? _chosenDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 50),
    );

    if (_chosenDate != null) {
      setState(() {
        _date = _chosenDate;
        _dateController.text = _chosenDate.toString().split(" ")[0];
      });
    }
  }

  // method for showing the time picker
  Future<void> _selectTime() async {
    TimeOfDay? _chosenTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (_chosenTime != null) {
      setState(() {
        _time = _chosenTime;
        _timeController.text = _chosenTime.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Row(
          children: [
            Text('Donate'),
            SizedBox(width: 6),
            Icon(Icons.handshake),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Org Details
            // org image
            OrgImage(org: widget.org),
            // org details (displays name of org, addresses, and contact info)
            OrgDetails(org: widget.org),

            const SizedBox(height: 25),

            // Donation Input Fields
            Container(
              margin: const EdgeInsets.all(8),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // header
                    const DonationHeader(),

                    // categories checkboxes
                    const DonationDetailHeader(text: 'Category'),
                    ..._donationCategories.entries.map(
                      (entry) => CheckboxListTile(
                        title: Text(
                          entry.key,
                          style: TextStyle(
                            fontSize: _optionsFontSize,
                          ),
                        ),
                        value: _donationCategories[entry.key],
                        onChanged: (value) {
                          setState(() {
                            _donationCategories[entry.key] = value!;
                          });
                        },
                        activeColor: Colors.black,
                        selected: false,
                      ),
                    ),

                    // pickup or drop-off
                    const DonationDetailHeader(text: 'Method'),
                    Row(
                      children: [
                        ..._donationMethod.map(
                          (method) => Flexible(
                            child: ListTile(
                              horizontalTitleGap: 0,
                              contentPadding: const EdgeInsets.all(0),
                              title: Text(
                                method,
                                style: TextStyle(
                                  fontSize: _optionsFontSize,
                                ),
                              ),
                              leading: Radio<String>(
                                value: method,
                                groupValue: _chosenMethod,
                                onChanged: (value) {
                                  if (value == null) return;
                                  setState(() {
                                    _chosenMethod = value;
                                  });
                                },
                                activeColor: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // weight field
                    const DonationDetailHeader(text: 'Weight'),
                    Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Enter weight',
                              prefixIcon: Icon(Icons.scale),
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  int.tryParse(value) == null ||
                                  int.tryParse(value)! <= 0) {
                                return 'Must be a valid, positive number.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _weight = double.parse(value!);
                            },
                          ),
                        ),
                        const SizedBox(width: 30),
                        Flexible(
                          child: Row(
                            children: [
                              // kg or lbs radio button
                              ..._weightUnits.map(
                                (unit) => Flexible(
                                  child: ListTile(
                                    horizontalTitleGap: 0,
                                    contentPadding: const EdgeInsets.all(0),
                                    title: Text(
                                      unit,
                                      style: TextStyle(
                                        fontSize: _optionsFontSize,
                                      ),
                                    ),
                                    leading: Radio<String>(
                                      value: unit,
                                      groupValue: _weightUnit,
                                      onChanged: (value) {
                                        if (value == null) return;
                                        setState(() {
                                          _weightUnit = value;
                                        });
                                      },
                                      activeColor: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // Date input field
                    const DonationDetailHeader(text: 'Date'),
                    const SizedBox(height: 4),
                    TextFormField(
                      controller: _dateController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        hintText: 'Enter date',
                        prefixIcon: Icon(Icons.calendar_today),
                      ),
                      onTap: () {
                        _selectDate();
                      },
                    ),
                    const SizedBox(height: 15),

                    // Time input field
                    const DonationDetailHeader(text: 'Time'),
                    TextFormField(
                      controller: _timeController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        hintText: 'Enter Time',
                        prefixIcon: Icon(Icons.access_time),
                      ),
                      onTap: () {
                        _selectTime();
                      },
                    ),
                    const SizedBox(height: 15),

                    // If pickup is chosen then address/es
                    // and contact info will also be required

                    // Address input field
                    _chosenMethod == _donationMethod[0]
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const DonationDetailHeader(text: 'Address'),
                              TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Enter address',
                                  prefixIcon: Icon(Icons.home_outlined),
                                ),
                              ),
                              const SizedBox(height: 15),
                            ],
                          )
                        : const SizedBox(height: 10),

                    // Contact number input field
                    _chosenMethod == _donationMethod[0]
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const DonationDetailHeader(
                                  text: 'Contact Number'),
                              TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Enter contact number',
                                  prefixIcon: Icon(Icons.phone),
                                ),
                              ),
                              const SizedBox(height: 15),
                            ],
                          )
                        : const SizedBox(height: 20),

                    // Add and reset button 
                    Row(
                      children: [
                        const Spacer(),
                        CustomElevatedButton(
                          onButtonPress: () {},
                          bgColor: Colors.black,
                          buttonLabel: 'Donate',
                          textColor: Colors.white,
                        ),
                        CustomElevatedButton(
                          onButtonPress: () {},
                          bgColor: Colors.transparent,
                          buttonLabel: 'Reset',
                          textColor: Colors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
