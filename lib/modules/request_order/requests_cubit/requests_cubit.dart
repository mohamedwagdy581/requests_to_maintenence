import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/request_model.dart';
import 'requests_states.dart';

class RequestCubit extends Cubit<RequestStates>
{
  RequestCubit() : super(RequestInitialState());

  static RequestCubit get(context) => BlocProvider.of(context);

  void userRequest(
      {
        required String city,
        required String school,
        required String machine,
        required String machineType,
        required String consultation,
      })
  {
    emit(RequestLoadingState());
    var companyName = FirebaseAuth.instance.currentUser?.displayName;

    FirebaseFirestore.instance.collection('requests').doc(companyName).get().then((value)
    {

      createUser(
        city: city,
        companyName: companyName.toString(),
        school: school,
        machine: machine,
        uId: value.id.toString(),
        machineType: machineType.toString(),
        consultation: consultation.toString(),
        //isEmailVerified: value.user!.emailVerified.toString(),
      );
    }).catchError((error)
    {
      emit(RequestErrorState(error.toString()));
    });
  }

  void createUser(
      {
        required String city,
        required String companyName,
        required String school,
        required String machine,
        required String uId,
        required String machineType,
        required String consultation,
      })
  {

    RequestModel model = RequestModel(
      city: city,
      companyName: companyName,
      school: school,
      machine: machine,
      uId: uId,
      machineType: machineType, 
      consultation: consultation,
    );

    FirebaseFirestore.instance
        .collection('requests')
        .doc(uId)
        .set(model.toJson())
        .then((value)
    {
      emit(CreateRequestSuccessState());
    }).catchError((error)
    {
      emit(CreateRequestErrorState(error.toString()));
    });
  }
  

}