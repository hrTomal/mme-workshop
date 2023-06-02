// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class VideoPopup extends StatefulWidget {
//   final String videoUrl;

//   VideoPopup({required this.videoUrl});

//   @override
//   _VideoPopupState createState() => _VideoPopupState();
// }

// class _VideoPopupState extends State<VideoPopup> {
//   late VideoPlayerController _controller;
//   bool _isPlaying = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.videoUrl)
//       ..initialize().then((_) {
//         setState(() {});
//       });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Video'),
//       content: SingleChildScrollView(
//         child: Column(
//           children: [
//             _controller.value.isInitialized
//                 ? AspectRatio(
//                     aspectRatio: _controller.value.aspectRatio,
//                     child: GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           _isPlaying = !_isPlaying;
//                           if (_isPlaying) {
//                             _controller.play();
//                           } else {
//                             _controller.pause();
//                           }
//                         });
//                       },
//                       child: Stack(
//                         alignment: Alignment.center,
//                         children: [
//                           VideoPlayer(_controller),
//                           _isPlaying
//                               ? Container()
//                               : Icon(
//                                   Icons.play_circle_fill,
//                                   size: 50.0,
//                                   color: Colors.white,
//                                 ),
//                         ],
//                       ),
//                     ),
//                   )
//                 : Container(),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             _controller.pause();
//             Navigator.of(context).pop();
//           },
//           child: Text('Close'),
//         ),
//       ],
//     );
//   }
// }
