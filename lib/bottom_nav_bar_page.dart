// import 'dart:io';

// import 'package:congo_chalenge/core/app/app_name.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter_android/webview_flutter_android.dart';
// import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

// class BottomNavBarPage extends StatefulWidget {
//   const BottomNavBarPage({super.key, this.initialIndex = 0});

//   final int initialIndex;

//   /// A appeler depuis SplashView juste apres le delai:
//   /// `BottomNavBarPage.openAfterSplash();`
//   static Future<T?> openAfterSplash<T>() async {
//     return Get.to<T>(
//       () => const BottomNavBarPage(),
//       preventDuplicates: true,
//       transition: Transition.fadeIn,
//     );
//   }

//   @override
//   State<BottomNavBarPage> createState() => _BottomNavBarPageState();
// }

// class _BottomNavBarPageState extends State<BottomNavBarPage> {
//   late int _currentIndex;
//   late final List<_TabConfig> _tabs;
//   final Map<int, _TabState> _tabStates = <int, _TabState>{};

//   @override
//   void initState() {
//     super.initState();
//     _tabs = <_TabConfig>[
//       _TabConfig(label: 'Accueil', icon: Icons.home_outlined, url: AppName.url),
//       _TabConfig(
//         label: 'Artiste',
//         icon: Icons.mic_external_on_outlined,
//         url: AppName.urlArtiste,
//       ),
//       _TabConfig(
//         label: 'Competition',
//         icon: Icons.emoji_events_outlined,
//         url: AppName.urlCompetition,
//       ),
//       _TabConfig(
//         label: 'Profil',
//         icon: Icons.person_outline,
//         url: _profileUrl(),
//       ),
//     ];

//     _currentIndex = widget.initialIndex.clamp(0, _tabs.length - 1);
//     _ensureTabReady(_currentIndex);
//   }

//   String _profileUrl() {
//     // Compatibilite: si AppName.profil existe dans votre base, il sera utilise.
//     try {
//       final dynamic appName = AppName;
//       final dynamic profil = appName.profil;
//       if (profil is String && profil.isNotEmpty) {
//         return profil;
//       }
//     } catch (_) {
//       // Fallback sur la constante actuelle du projet.
//     }
//     return AppName.urlProfile;
//   }

//   void _ensureTabReady(int index) {
//     if (_tabStates.containsKey(index)) {
//       return;
//     }

//     final _TabConfig tab = _tabs[index];
//     final _TabState tabState = _TabState();
//     final WebViewController controller = _buildController(
//       url: tab.url,
//       onLoading: () {
//         if (!mounted) return;
//         setState(() {
//           tabState.isLoading = true;
//         });
//       },
//       onLoaded: () {
//         if (!mounted) return;
//         setState(() {
//           tabState.isLoading = false;
//           tabState.hasLoadedOnce = true;
//         });
//       },
//       onError: () {
//         if (!mounted) return;
//         setState(() {
//           tabState.isLoading = false;
//         });
//       },
//     );

//     tabState.controller = controller;
//     _tabStates[index] = tabState;
//   }

//   WebViewController _buildController({
//     required String url,
//     required VoidCallback onLoading,
//     required VoidCallback onLoaded,
//     required VoidCallback onError,
//   }) {
//     if (WebViewPlatform.instance == null) {
//       if (Platform.isIOS || Platform.isMacOS) {
//         WebViewPlatform.instance = WebKitWebViewPlatform();
//       } else {
//         WebViewPlatform.instance = AndroidWebViewPlatform();
//       }
//     }

//     late final PlatformWebViewControllerCreationParams params;
//     if (WebViewPlatform.instance is WebKitWebViewPlatform) {
//       params = WebKitWebViewControllerCreationParams(
//         allowsInlineMediaPlayback: true,
//         mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
//       );
//     } else {
//       params = const PlatformWebViewControllerCreationParams();
//     }

//     final WebViewController controller =
//         WebViewController.fromPlatformCreationParams(params);

//     if (controller.platform is AndroidWebViewController) {
//       AndroidWebViewController.enableDebugging(true);
//       (controller.platform as AndroidWebViewController)
//           .setMediaPlaybackRequiresUserGesture(false);
//     }

//     controller
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onPageStarted: (_) => onLoading(),
//           onPageFinished: (_) => onLoaded(),
//           onWebResourceError: (WebResourceError error) {
//             if (error.isForMainFrame == true) {
//               onError();
//             }
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse(url));

//     return controller;
//   }

//   void _onTabTapped(int index) {
//     if (index == _currentIndex) return;
//     _ensureTabReady(index);
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final List<Widget> pages = List<Widget>.generate(_tabs.length, (int index) {
//       final _TabState? tabState = _tabStates[index];
//       if (tabState == null || tabState.controller == null) {
//         return const SizedBox.shrink();
//       }

//       final bool showLoader = index == _currentIndex &&
//           tabState.isLoading &&
//           !tabState.hasLoadedOnce;

//       return Stack(
//         children: <Widget>[
//           WebViewWidget(controller: tabState.controller!),
//           if (showLoader)
//             const Center(
//               child: CircularProgressIndicator(),
//             ),
//         ],
//       );
//     });

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(_tabs[_currentIndex].label),
//         centerTitle: true,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//             bottom: Radius.circular(25),
//           ),
//         ),
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
//         ),
//         child: ClipRRect(
//           borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
//           child: IndexedStack(
//             index: _currentIndex,
//             children: pages,
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: _onTabTapped,
//         type: BottomNavigationBarType.fixed,
//         items: _tabs
//             .map(
//               (_TabConfig tab) => BottomNavigationBarItem(
//                 icon: Icon(tab.icon),
//                 label: tab.label,
//               ),
//             )
//             .toList(growable: false),
//       ),
//     );
//   }
// }

// class _TabConfig {
//   const _TabConfig({
//     required this.label,
//     required this.icon,
//     required this.url,
//   });

//   final String label;
//   final IconData icon;
//   final String url;
// }

// class _TabState {
//   WebViewController? controller;
//   bool isLoading = true;
//   bool hasLoadedOnce = false;
// }
