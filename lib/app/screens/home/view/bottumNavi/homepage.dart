import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truff_majestic/app/screens/home/view/bottumNavi/widget/controller.dart';
import 'package:truff_majestic/app/screens/home/view/bottumNavi/widget/coustomScroll.dart';
import 'package:truff_majestic/app/screens/shared/themes.dart';
import 'package:truff_majestic/app/utils/constants/color_constants.dart';
import 'package:truff_majestic/app/utils/initsatate.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final contollerPro = Provider.of<CoustomScrollProvider>(context);

    return StatefulWrapper(
      onInit: () {
        contollerPro.initState();
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              CustomScrollviewAppBar(
                offset: contollerPro.offset,
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  controller: contollerPro.controller,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 135,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
                                  ),
                                  fit: BoxFit.fitHeight),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              "String",
                              overflow: TextOverflow.ellipsis,
                              style: TurffTheme.lightTextTheme.headline6,
                            ),
                          ),
                          const Text("place")
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class CustomScrollview extends StatefulWidget {
//   const CustomScrollview({Key? key}) : super(key: key);

//   @override
//   State<CustomScrollview> createState() => _CustomScrollviewState();
// }

// class _CustomScrollviewState extends State<CustomScrollview> {
//   final ScrollController _controller = ScrollController();

//   double _offset = 0.0;

//   @override
//   void initState() {
//     super.initState();
//     _controller.addListener(() {
//       setState(() {
//         _offset = _controller.offset;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CustomScrollviewAppBar(offset: _offset),
//         Expanded(
//           child: ListView(
//             padding: EdgeInsets.zero,
//             controller: _controller,
//             children: [
//               Container(
//                 height: 300,
//                 color: Colors.red,
//               ),
//               Container(
//                 height: 300,
//                 color: Colors.yellow,
//               ),
//               Container(
//                 height: 300,
//                 color: Colors.green,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
