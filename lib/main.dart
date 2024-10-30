import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_01/bloc/main_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MainBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Image Picker Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _imageWidth = 175.0;
  double _imageHeight = 118.0;
  double _scaleFactor = 1.0;
  double _frameWidth = 200;
  double _frameHeight = 200.0;
  Offset _position = Offset(0, 0);
  double _imageTop = 43;
  double _imageLeft = 12;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black54,
        onPressed: () {
          context.read<MainBloc>().add(PickBackgroundImageEvent());
        },
        tooltip: 'Add Your Background',
        shape: const CircleBorder(),
        child: Icon(
          Icons.edit_outlined,
          color: Colors.white,
          size: 27.r,
        ),
      ),
      body: BlocBuilder<MainBloc, MainState>(builder: (context, state) {
        return Container(
          // width: 1.sw,
          // height: 1.sh,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: state.backgroundFile != null
                    ? FileImage(
                        state.backgroundFile!,
                      )
                    : const AssetImage('assets/images/wall.jpg'),
                fit: BoxFit.cover),
          ),
          child: GestureDetector(
            onScaleStart: (details) {
              _scaleFactor = 1.0; // Reset scale factor for new gesture
            },
            // onScaleUpdate to adjust width and height based on scale
            onScaleUpdate: (details) {
              setState(() {
                // Update size by accumulating scale
                _imageWidth *= details.scale / _scaleFactor;
                _imageHeight *= details.scale / _scaleFactor;

                _frameWidth *= details.scale / _scaleFactor;
                _frameHeight *= details.scale / _scaleFactor;
                _scaleFactor = details.scale;
                _position += details.focalPointDelta;
                _imageTop = details.verticalScale.sp;
              });
            },

            child: Stack(
              children: [
                Positioned(
                  left: _position.dx,
                  top: _position.dy,
                  child: Container(
                    // margin: EdgeInsets.only(top: 25.r, left: 69.r),
                    width: _frameWidth,
                    height: _frameHeight,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/frame.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: BlocBuilder<MainBloc, MainState>(
                      builder: (context, state) {
                        return Stack(children: [
                          Container(
                            height: _frameHeight / 1.23,
                            width: _frameWidth,
                            padding: EdgeInsets.only(
                              left: _frameWidth / 16,
                              top: _frameHeight / 4.6,
                              right: _frameWidth / 15,
                            ),
                            child: Image(
                              image: state.frameFile != null
                                  ? FileImage(state.frameFile!)
                                  : const AssetImage(
                                      'assets/images/sample02.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                              bottom: 56.r,
                              left: _imageLeft + (_frameWidth - 300) / 17,
                              child: InkWell(
                                  onTap: () {
                                    context
                                        .read<MainBloc>()
                                        .add(PickFrameImageEvent());
                                  },
                                  child: Container(
                                    width: 44.r,
                                    height: 44.r,
                                    decoration: BoxDecoration(
                                        color: Colors.white70,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                      size: 36.r,
                                    ),
                                  ))),
                        ]);
                        // Container(
                        //   // width: _imageWidth / 2,
                        //   // height: _imageHeight / 2,
                        //   decoration: BoxDecoration(
                        //     image: DecorationImage(
                        //       image: state.frameFile != null
                        //           ? FileImage(state.frameFile!)
                        //           : const AssetImage(
                        //               'assets/images/sample02.jpg'),
                        //       fit: BoxFit.fill,
                        //     ),
                        //   ),
                        // );

                        // Stack(
                        //   children: [
                        //     Positioned(
                        //       top: _imageTop + (_frameHeight - 175) / 1.8,
                        //       left: _imageLeft + (_frameWidth - 175) / 17,
                        //       child:
                        //   ),
                        // Positioned(
                        //     bottom: 56.r,
                        //     left: _imageLeft + (_frameWidth - 300) / 17,
                        //     child: InkWell(
                        //         onTap: () {
                        //           context
                        //               .read<MainBloc>()
                        //               .add(PickFrameImageEvent());
                        //         },
                        //         child: Container(
                        //           width: 44.r,
                        //           height: 44.r,
                        //           decoration: BoxDecoration(
                        //               color: Colors.white70,
                        //               borderRadius:
                        //                   BorderRadius.circular(20)),
                        //           child: Icon(
                        //             Icons.edit,
                        //             color: Colors.black,
                        //             size: 36.r,
                        //           ),
                        //         ))),
                        //   ],
                        // );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
