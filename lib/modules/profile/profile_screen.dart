import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../../shared/network/cubit/cubit.dart';
import '../../shared/network/cubit/states.dart';
import '../../style/custom_icons.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> dataStream = FirebaseFirestore.instance.collection('users').snapshots();
    final userData = FirebaseAuth.instance.currentUser;
    var cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var height = MediaQuery.of(context).size.height;

        return StreamBuilder<QuerySnapshot> (
          stream: dataStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
          {
            if(snapshot.hasError)
            {
              return Text('Something Wrong! ${snapshot.error}');
            }else if(snapshot.hasData)
            {
              final List storeDocs = [];
              snapshot.data!.docs.map((DocumentSnapshot documentSnapshot)
              {
                Map users = documentSnapshot.data() as Map<String, dynamic>;
                storeDocs.add(users);
                users['uId'] = documentSnapshot.id;

              }).toList();
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.25,

                      // ******************** Stack of Cover Image ********************
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                SizedBox(
                                  height: height * 0.19,
                                  width: double.infinity,
                                  child: cubit.coverImageUrl == ''
                                      ? const Image(
                                    image: NetworkImage(
                                      'https://cdn.quotesgram.com/img/54/5/1828314355-ayat-kareema-islamic-fb-cover.png',
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                      : Image(
                                    image: NetworkImage(
                                      cubit.coverImageUrl,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    cubit.pickUploadCoverImage();
                                  },
                                  icon: const CircleAvatar(
                                    radius: 20.0,
                                    child: Icon(
                                      Icons.camera_alt,
                                      size: 18.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // ****************** Stack of Profile Image ********************
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 64.0,
                                backgroundColor: cubit.isDark ? Theme.of(context)
                                    .scaffoldBackgroundColor : const Color(0xffF4F2F2),
                                child: CircleAvatar(
                                  radius: 60.0,
                                  child: cubit.profileImageUrl == ''
                                      ? const CircleAvatar(
                                    radius: 60.0,
                                    backgroundImage: NetworkImage('https://icons-for-free.com/iconfiles/png/512/person-1324760545186718018.png'),
                                  )
                                      : CircleAvatar(
                                    radius: 60.0,
                                    backgroundImage: NetworkImage(cubit.profileImageUrl),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  cubit.pickUploadProfileImage();
                                },
                                icon: const CircleAvatar(
                                  radius: 20.0,
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 18.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: height * 0.015,
                    ),
                    Text(
                      'Name : ${userData?.displayName.toString()}',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 17),
                    ),
                    SizedBox(
                      height: height * 0.012,
                    ),
                    Text(
                      'Email : ${userData?.email.toString()}',
                      style: Theme.of(context).textTheme.caption?.copyWith(
                          fontSize: 14.0,
                        color: cubit.isDark ? Colors.black : Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Container(
                        padding: const EdgeInsets.only(left: 8.0),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'History',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemCount: 6,
                        itemBuilder: (context, index) => Container(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: customListTile(
                            onTapped: ()
                            {
                              //print(dataStream.toList());
                            },
                            leadingWidget: Icon(
                              Icons.history_outlined,
                              color:
                              AppCubit.get(context).isDark ? Colors.blue : Colors.deepOrange,
                            ),
                            title: '${userData?.displayName}',
                            trailingWidget: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(
                                CustomIcons.arrow_right,
                                color:
                                AppCubit.get(context).isDark ? Colors.blue : Colors.deepOrange,
                              ),
                            ),
                          ),
                        ), separatorBuilder: (BuildContext context, int index) => const Divider(),
                      ),
                    ),
                  ],
                ),
              );
            }else
            {
              return const Center(child: CircularProgressIndicator(),);
            }
          },
        );
      },
    );
  }

}
