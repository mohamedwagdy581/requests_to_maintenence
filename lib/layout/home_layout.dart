import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../modules/about_us/about_us_screen.dart';
import '../modules/login/login_screen.dart';
import '../shared/components/components.dart';
import '../shared/components/constants.dart';
import '../shared/network/cubit/cubit.dart';
import '../shared/network/cubit/states.dart';
import '../shared/network/local/cash_helper.dart';
import '../style/custom_icons.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {

        var cubit = AppCubit.get(context);
        var user = FirebaseAuth.instance.currentUser;
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        uId = CashHelper.getData(key: 'uId');

        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.appBarTitle[cubit.currentIndex]),
            centerTitle: true,
          ),
          // **************************  The Drawer  ***************************
          /*drawer: Drawer(
            child: ListView(
              children: <Widget>[
                // Header
                UserAccountsDrawerHeader(
                  accountName: uId != null ?  Text('${user?.displayName}') : const Text(''),
                  accountEmail: uId != null ?  Text('${user?.email}') : Container(
                    width: width * 0.5,
                    padding: const EdgeInsets.only(bottom: 15,left: 5,right: 60),
                    child: defaultButton(
                      onPressed: ()
                      {
                        navigateAndFinish(context, LoginScreen());
                      },
                      text: 'سجل الآن',
                      backgroundColor: Colors.deepOrange,
                    ),
                  ),
                  currentAccountPicture: cubit.profileImageUrl == ''
                      ? Image.network('https://icons-for-free.com/iconfiles/png/512/person-1324760545186718018.png')
                      : CircleAvatar(
                      backgroundImage: NetworkImage(
                          cubit.profileImageUrl,
                      ),
                  ),
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                  ),
                ),

                // Body
                 SizedBox(
                  height: height * 0.03,
                ),

                InkWell(
                  onTap: () {
                    navigateAndFinish(context, const HomeLayout());
                  },
                  child: const ListTile(
                    title: Text(
                        'الرئيسية',
                    ),
                    leading: Icon(
                      Icons.home,
                      color: Colors.green,
                    ),
                  ),
                ),

                SizedBox(
                  height: height * 0.03,
                ),
                const Divider(),

                InkWell(
                  onTap: ()
                  {
                    navigateTo(context, const AboutUsScreen());
                  },
                  child: const ListTile(
                    title: Text('للتواصل'),
                    leading: Icon(
                      Icons.help,
                      color: Colors.blue,
                    ),
                  ),
                ),

                InkWell(
                  onTap: () {
                    signOut(context);
                  },
                  child: const ListTile(
                    title: Text('تسجيل خروج'),
                    leading: Icon(
                      Icons.logout_outlined,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),*/
          endDrawer: Drawer(
            child: ListView(
              children: <Widget>[
                // Header
                UserAccountsDrawerHeader(
                  accountName: uId != null ?  Text('${user?.displayName}') : const Text(''),
                  accountEmail: uId != null ?  Text('${user?.email}') : Container(
                    width: width * 0.5,
                    padding: const EdgeInsets.only(bottom: 15,left: 5,right: 60),
                    child: defaultButton(
                      onPressed: ()
                      {
                        navigateAndFinish(context, LoginScreen());
                      },
                      text: 'سجل الآن',
                      backgroundColor: Colors.deepOrange,
                    ),
                  ),
                  currentAccountPicture: cubit.profileImageUrl == ''
                      ? Image.network('https://icons-for-free.com/iconfiles/png/512/person-1324760545186718018.png')
                      : CircleAvatar(
                    backgroundImage: NetworkImage(
                      cubit.profileImageUrl,
                    ),
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                ),

                // Body
                SizedBox(
                  height: height * 0.03,
                ),

                InkWell(
                  onTap: () {
                    navigateAndFinish(context, const HomeLayout());
                  },
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:
                      [
                        const Text('الرئيسية'),
                        SizedBox(width: width * 0.1,),
                        const Icon(
                          Icons.home,
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: height * 0.03,
                ),
                const Divider(thickness: 2),

                InkWell(
                  onTap: ()
                  {
                    navigateTo(context, const AboutUsScreen());
                  },
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:
                      [
                        const Text('للتواصل'),
                        SizedBox(width: width * 0.1,),
                        const Icon(
                          Icons.help,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                ),

                InkWell(
                  onTap: () {
                    signOut(context);
                  },
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:
                      [
                        const Text('تسجيل الخروج'),
                        SizedBox(width: width * 0.1,),
                        const Icon(
                          Icons.logout_outlined,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ***********************  The Scaffold Body  ***********************
          body: cubit.screens[cubit.currentIndex],

          // Bottom Navigation Bar
          /*bottomNavigationBar: BottomNavigationBar(
            onTap: (int index)
            {
              cubit.changeBottomNavBar(index);
            },
            items:
            const [
              BottomNavigationBarItem(
                icon: Icon(
                  CustomIcons.home,
                ),
                label: 'Home',
              ),
              *//*BottomNavigationBarItem(
                icon: Icon(
                  CustomIcons.settings,
                ),
                label: 'Settings',
              ),*//*
            ],
            currentIndex: cubit.currentIndex,
          ),*/
        );
      },
    );
  }
}
