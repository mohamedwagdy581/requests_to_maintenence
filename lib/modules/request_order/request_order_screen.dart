import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

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
  String? selectedCity;
  String? selectedCompany;

  int _machineValue = 0;
  String selectedMachine = '';
  var machines = <String>[
    'الآلة؟',
    'آلة تصوير',
    'بروجيكتور',
    'شاشة',
  ];
  var locationMessage = '';
  double latitude = 0.0;
  double longitude = 0.0;

  void getCurrentLocation() async
  {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator.getLastKnownPosition();
    //print(lastPosition);
    print('latitude : ${position.altitude}, Longtude: ${position.longitude}');
    setState(() {
      locationMessage = '${position.altitude}, ${position.longitude}';
      latitude = position.latitude;
      longitude = position.longitude;
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var consultationController = TextEditingController();

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

                    /*StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('machineTypes')
                          .snapshots(),
                      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        int i = 0;
                        if (!snapshot.hasData) {
                          return const Text('Loading');
                        } else {
                          final List<DropdownMenuItem<String>> cities = [];
                          String? selectedCity;
                          for (i = 0; i < snapshot.data!.docs.length; i++) {
                            DocumentSnapshot snap = snapshot.data!.docs[i];
                            Map city = snap.data() as Map<String, dynamic>;
                            cities.add(
                              DropdownMenuItem(
                                value: city['machineTypeName'],
                                child: Text(city['machineTypeName']),
                              ),
                            );
                          }
                          return DropdownButton(
                            value: selectedCity,
                            //isExpanded: false,
                            hint: const Text('المؤسسة؟'),
                            items: cities,
                            onChanged: (value) {
                              setState(() {
                                selectedCity = value;
                              });
                            },
                          );
                        }
                      },
                    ),*/
                    // City ListTile with DropdownButton
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[300],
                      ),
                      child: ListTile(
                        trailing: const Text(
                          'المدينة',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        leading: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('cities')
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            int i = 0;
                            if (!snapshot.hasData) {
                              return const Text('Loading');
                            } else {
                              final List<DropdownMenuItem<String>> cities = [];

                              for (i = 0; i < snapshot.data!.docs.length; i++) {
                                DocumentSnapshot snap = snapshot.data!.docs[i];
                                Map city = snap.data() as Map<String, dynamic>;
                                cities.add(
                                  DropdownMenuItem(
                                    value: city['city'],
                                    child: Text(city['city']),
                                  ),
                                );
                              }
                              return DropdownButton(
                                value: selectedCity,
                                //isExpanded: false,
                                hint: const Text('المدينة'),
                                items: cities,
                                onChanged: (value) {
                                  setState(() {
                                    selectedCity = value;
                                  });
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),

                    // School ListTile with DropdownButton
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[300],
                      ),
                      child: ListTile(
                        trailing: const Text(
                          'المدرسة',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        leading: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('companies')
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            int i = 0;
                            if (!snapshot.hasData) {
                              return const Text('Loading');
                            } else {
                              final List<DropdownMenuItem<String>> companies =
                                  [];

                              for (i = 0; i < snapshot.data!.docs.length; i++) {
                                DocumentSnapshot snap = snapshot.data!.docs[i];
                                Map company =
                                    snap.data() as Map<String, dynamic>;
                                companies.add(
                                  DropdownMenuItem(
                                    value: company['companyName'],
                                    child: Text(company['companyName']),
                                  ),
                                );
                              }
                              return DropdownButton(
                                value: selectedCompany,
                                //isExpanded: false,
                                hint: const Text('المؤسسة؟'),
                                items: companies,
                                onChanged: (value) {
                                  setState(() {
                                    selectedCompany = value;
                                  });
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    // Machine ListTile with DropdownButton
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[300],
                      ),
                      child: ListTile(
                        trailing: const Text(
                          'إختار الآلة',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        leading: DropdownButton<String>(
                          hint: const Text('الآلة'),
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
                              selectedMachine = value.toString();
                            });
                          },
                        ),
                      ),
                    ),

                    // Machine Type ListTile with DropdownButton
                    /*Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[300],
                      ),
                      child: ListTile(
                        trailing: const Text(
                          'نوع الآله',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        leading: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('machineTypes')
                              .snapshots(),
                          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            int i = 0;
                            if (!snapshot.hasData) {
                              return const Text('Loading');
                            } else {
                              final List<DropdownMenuItem<String>> machineTypes = [];

                              for (i = 0; i < snapshot.data!.docs.length; i++) {
                                DocumentSnapshot snap = snapshot.data!.docs[i];
                                Map machineType = snap.data() as Map<String, dynamic>;
                                machineTypes.add(
                                  DropdownMenuItem(
                                    value: machineType['machineTypeName'],
                                    child: Text(machineType['machineTypeName']),
                                  ),
                                );
                              }
                              return DropdownButton(
                                value: selectedMachineType,
                                //isExpanded: false,
                                hint: const Text('نوع الآلة؟'),
                                items: machineTypes,
                                onChanged: (value) {
                                  setState(() {
                                    selectedMachineType = value;
                                  });
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ),*/
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[300],
                      ),
                      child: ListTile(
                        trailing: const Text(
                          '<----   اضغط لتحديد الموقع',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        leading: IconButton(
                          onPressed: ()
                          {
                            getCurrentLocation();
                            print(locationMessage);
                          },
                          icon: const Icon(
                            Icons.location_on_outlined,
                            color: Colors.blue,
                            size: 30.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),

                    // Consultation TextField
                    SizedBox(
                      width: width * 0.8, //height: 350,
                      child: TextFormField(
                        controller: consultationController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'برجاء كتابة الإستفسار';
                          }
                          return null;
                        },
                        textDirection: TextDirection.rtl,
                        maxLines: 5,
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                              color: AppCubit.get(context).isDark
                                  ? Colors.black
                                  : Colors.white,
                            ),
                        textAlign: TextAlign.end,
                        decoration: const InputDecoration(
                          hintText: ' !اكتب استفسارك',
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 15,
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
                            var city = selectedCity.toString();
                            var company = selectedCompany.toString();
                            var machine = selectedMachine;
                            var consultation = consultationController.text;

                            if (machine.isEmpty &&
                                consultationController.text.isEmpty && latitude == 0.0 && longitude == 0.0) {
                              return showToast(
                                message:
                                    'تأكد من تحديد موقعك وإختيار الألة وكتابة الإستفسار!',
                                state: ToastStates.ERROR,
                              );
                            } else {
                              RequestCubit.get(context).userRequest(
                                city: city.toString(),
                                school: company.toString(),
                                machine: machine.toString(),
                                latitude: latitude,
                                longitude: longitude,
                                consultation: consultation.toString(),
                              );
                              consultationController.text = '';
                              showToast(
                                message: 'تم إرسال طلبك بنجاح',
                                state: ToastStates.SUCCESS,
                              );
                            }
                          }
                        },
                        text: 'إرسال',
                        backgroundColor: AppCubit.get(context).isDark
                            ? Colors.blue
                            : Colors.deepOrange,
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
