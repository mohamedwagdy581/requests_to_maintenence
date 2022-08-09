import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../../shared/network/cubit/cubit.dart';
import 'requests_cubit/requests_cubit.dart';
import 'requests_cubit/requests_states.dart';

class RequestOrderScreen extends StatefulWidget {
  const RequestOrderScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RequestOrderScreenState createState() => _RequestOrderScreenState();
}

class _RequestOrderScreenState extends State<RequestOrderScreen> {
  int _cityValue = 0;
  String _city = '';
  var cities = <String>[
    'City?',
    'Jazan',
    'Sabia',
    'Jeddah',
    'Riyadh',
    'Makkah',
  ];

  int _schoolValue = 0;
  String _school = '';
  var schools = <String>[
    'School?',
    'Jazan School',
    'Sabia School',
    'Jeddah School',
    'Riyadh School',
    'Makkah School',
    'Emmarah',
  ];

  int _machineValue = 0;
  String _machine = '';
  var machines = <String>[
    'Machine?',
    'Printer',
    'Projector',
    'Laptop',
    'PC',
    'Accessories',
  ];

  int _machineTypeValue = 0;
  String _machineType = '';
  var machineTypes = <String>[
    'Machine Type?',
    'Lenovo',
    'Apple',
    'Samsung',
    'Redmi',
    'Dell',
    'Sony',
    'Toshiba',
    'Sharp',
  ];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var consultationController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (BuildContext context) => RequestCubit(),
      child: BlocConsumer<RequestCubit, RequestStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.03,
                    ),
                    // City ListTile with DropdownButton
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[300],
                      ),
                      child: ListTile(
                        title: const Text(
                          'Select your City',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        trailing: DropdownButton<String>(
                          hint: const Text('City'),
                          value: cities[_cityValue],
                          items: cities.map((String city) {
                            return DropdownMenuItem<String>(
                              value: city.toString(),
                              child: Text(city),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _cityValue = cities.indexOf(value!);
                              _city = value.toString();
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),

                    // School ListTile with DropdownButton
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[300],
                      ),
                      child: ListTile(
                        title: const Text(
                          'Select your School',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        trailing: DropdownButton<String>(
                          hint: const Text('School'),
                          value: schools[_schoolValue],
                          items: schools.map((String school) {
                            return DropdownMenuItem<String>(
                              value: school,
                              child: Text(school),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _schoolValue = schools.indexOf(value!);
                              _school = value.toString();
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),

                    // Machine ListTile with DropdownButton
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[300],
                      ),
                      child: ListTile(
                        title: const Text(
                          'Select your Machine',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        trailing: DropdownButton<String>(
                          hint: const Text('Machine'),
                          value: machines[_machineValue],
                          items: machines.map((String machine) {
                            return DropdownMenuItem<String>(
                              value: machine,
                              child: Text(machine),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _machineValue = machines.indexOf(value!);
                              _machine = value.toString();
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),

                    // Machine Type ListTile with DropdownButton
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[300],
                      ),
                      child: ListTile(
                        title: const Text(
                          'Select Machine Type',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        trailing: DropdownButton<String>(
                          hint: const Text('MachineType'),
                          value: machineTypes[_machineTypeValue],
                          items: machineTypes.map((String machineType) {
                            return DropdownMenuItem<String>(
                              value: machineType,
                              child: Text(machineType),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _machineTypeValue = machineTypes.indexOf(value!);
                              _machineType = value.toString();
                              //print(value.toString());
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),

                    // Consultation TextField
                    SizedBox(
                      width: width * 0.8, //height: 350,
                      child: TextField(
                        controller: consultationController,
                        textDirection: TextDirection.rtl,
                        maxLines: 5,
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          color:
                          AppCubit.get(context).isDark ? Colors.black : Colors.white,
                        ),
                        textAlign: TextAlign.end,
                        decoration: const InputDecoration(
                          hintText: ' !اكتب استفسارك',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 15,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                            color: Colors.red,
                          ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: height * 0.03,
                    ),

                    ConditionalBuilder(
                      condition: state is! RequestLoadingState,
                      builder: (context) => defaultButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final city = _city.toString();
                            final school = _school.toString();
                            final machine = _machine.toString();
                            final machineType = _machineType.toString();
                            final consultation = consultationController.text;

                            RequestCubit.get(context).userRequest(
                              city: city.toString(),
                              school: school.toString(),
                              machine: machine.toString(),
                              machineType: machineType.toString(),
                              consultation: consultation.toString(),
                            );
                            _cityValue = 0;
                            _schoolValue = 0;
                            _machineValue = 0;
                            _machineTypeValue = 0;
                            consultationController.text = '';
                            showToast(
                              message:
                                  'Request To Maintenance Sent Successfully',
                              state: ToastStates.SUCCESS,
                            );
                          }
                        },
                        text: 'Done',
                        backgroundColor: AppCubit.get(context).isDark ? Colors.blue : Colors.deepOrange,
                      ),
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
