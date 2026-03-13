import 'package:congo_chalenge/core/app/app_colors.dart';
import 'package:congo_chalenge/feature/home/home_view.dart';
import 'package:flutter/material.dart';

class BottomNavBarPage extends StatefulWidget {
  final int index;
  const BottomNavBarPage({super.key, required this.index});

  @override
  State<BottomNavBarPage> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBarPage> {
  late int selectIndex = widget.index;

  // ignore: constant_identifier_names, non_constant_identifier_names
  final List MesPages = [
    HomeView(),
    Center(child: Text('page d\'artiste')),
    // null,
    Center(child: Text('page de la competition')),
    Center(child: Text('profile')),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: MesPages.elementAt(selectIndex),
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        //fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          BottomNavigationBar(
            currentIndex: selectIndex,
            selectedItemColor: AppColor.secondary,
            type: BottomNavigationBarType.fixed,
            unselectedLabelStyle: TextStyle(color: Colors.grey[800]),
            showUnselectedLabels: true,
            backgroundColor: AppColor.primary,
            onTap: (valeur) {
              setState(() {
                selectIndex = valeur;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home), // Changé de category_rounded à category
                label: 'Acuueil',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category_rounded),
                label: 'Artiste',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.analytics_rounded),
                label: 'competition',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_rounded,
                ), // person_rounded au lieu de person_3_rounded
                label: 'mon profil',
              ),
            ],
          ),
          // Positioned(
          //   top: -18,
          //   left: 0,
          //   right: 0,
          //   child: Center(
          //       child: GestureDetector(
          //         onTap:()=> Get.to(()=>AnalyseView()),
          //         child: Container(
          //           height: 65,
          //           width:66,
          //           decoration: BoxDecoration(
          //             color:Colors.white,
          //             gradient: LinearGradient(colors: [
          //               Colors.green.shade300,
          //               AppColors.primarydark
          //             ],
          //             tileMode: TileMode.mirror,
          //             begin: Alignment.topCenter
          //             ),
          //           //  image: DecorationImage(fit: BoxFit.cover,
          //           //  filterQuality: FilterQuality.low,
          //           // opacity:0.3,
          //           // image: AssetImage(AppName.fondAssetPath)
          //           //  ),
          //            shape: BoxShape.circle,
          //            border: Border.all(color: couleurP),
          //            boxShadow:[
          //             BoxShadow(blurRadius: 2,color:Colors.grey.shade600)
          //            ]
          //           ),
          //           child: Icon(Icons.photo_camera,size: 31,color: AppColors.background),
          //          ),
          //       )
          //     ),
          //   ),
        ],
      ),
    );
  }
}
