import 'package:flutter/material.dart';
import 'flutter_flow_theme.dart';
import 'flutter_flow_widgets.dart';

import 'package:roslibdart/roslibdart.dart';
import 'dart:async';
import 'dart:convert';

class FineControlWidget extends StatefulWidget {
  FineControlWidget({Key? key}) : super(key: key);

  @override
  _FineControlWidgetState createState() => _FineControlWidgetState();
}

class _FineControlWidgetState extends State<FineControlWidget> {
  // late FineControlModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  double sliderValue1 = 0.0;
  double sliderValue2 = 0.0;
  double sliderValue3 = 0.0;
  double sliderValue4 = 0.0;
  double sliderValue5 = 0.0;
  double sliderValue6 = 0.0;

  bool isLimitXReached = false;
  bool isLimitYReached = false;
  bool isLimitZReached = false;

  // @override
  // void initState() {
  //   super.initState();
  //   // _model = createModel(context, () => FineControlModel());

  //   // _model.textController1 = TextEditingController();
  //   // _model.textController2 = TextEditingController();
  //   // _model.textController3 = TextEditingController();
  // }
  late Ros ros;
  late Topic chatter;

  @override
  void initState() {
    super.initState();
    ros = Ros(url: 'ws://127.0.0.1:9090');
    // subscribe to the topic
    chatter = Topic(
        ros: ros,
        name: '/LIMIT_switch_pub',
        type: "std_msgs/Int32",
        reconnectOnClose: true,
        queueLength: 10,
        queueSize: 10);
    ros.connect();

    Timer(const Duration(seconds: 1), () async {
      await chatter.subscribe(subscribeHandler);
      // await chatter.subscribe();
    });
  }

  void destroyConnection() async {
    await chatter.unsubscribe();
    await ros.close();
    setState(() {});
  }

  String limitXState = '';
  Future<void> subscribeHandler(Map<String, dynamic> msg) async {
    limitXState = json.encode(msg['data']);
    setState(() {
      if (limitXState == '1') {
        isLimitXReached = true;
      } else {
        isLimitXReached = false;
      }
    });
  }

  // @override
  // void dispose() {
  //   _unfocusNode.dispose();
  //   super.dispose();
  // }

  @override
  void dispose() {
    // _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
            child: Text(
              'Front View Control',
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Poppins',
                    fontSize: 24,
                  ),
            ),
          ),
          Container(
            width: 600,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Color(0xFFD23793),
              ),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: Text(
                      'Adjust Scion Height',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                          ),
                    ),
                  ),
                  Slider(
                    activeColor: FlutterFlowTheme.of(context).primaryColor,
                    inactiveColor: Color(0xFF9E9E9E),
                    min: 0,
                    max: 10,
                    value: sliderValue1 ??= 0,
                    onChanged: (newValue) {
                      newValue = double.parse(newValue.toStringAsFixed(4));
                      setState(() => sliderValue1 = newValue);
                    },
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                    child: FFButtonWidget(
                      onPressed: () {
                        print('Button pressed ...');
                      },
                      text: 'Splice',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 40,
                        color: FlutterFlowTheme.of(context).tertiaryColor,
                        textStyle:
                            FlutterFlowTheme.of(context).subtitle2.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                ),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: 8,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-0.9, 0),
                        child: Text(
                          'Aligner',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                  ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Container(
                          width: 390,
                          child: Slider(
                            activeColor:
                                FlutterFlowTheme.of(context).primaryColor,
                            inactiveColor: Color(0xFF9E9E9E),
                            min: 0,
                            max: 10,
                            value: sliderValue2 ??= 0,
                            onChanged: (newValue) {
                              newValue =
                                  double.parse(newValue.toStringAsFixed(4));
                              setState(() => sliderValue2 = newValue);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Slider(
                        activeColor: FlutterFlowTheme.of(context).primaryColor,
                        inactiveColor: Color(0xFF9E9E9E),
                        min: 0,
                        max: 10,
                        value: sliderValue3 ??= 0,
                        onChanged: (newValue) {
                          newValue = double.parse(newValue.toStringAsFixed(4));
                          setState(() => sliderValue3 = newValue);
                        },
                      ),
                      Text(
                        'Bottom Aligner',
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                      Slider(
                        activeColor: FlutterFlowTheme.of(context).primaryColor,
                        inactiveColor: Color(0xFF9E9E9E),
                        min: 0,
                        max: 10,
                        value: sliderValue4 ??= 0,
                        onChanged: (newValue) {
                          newValue = double.parse(newValue.toStringAsFixed(4));
                          setState(() => sliderValue4 = newValue);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
            child: Text(
              'Rear Control',
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Poppins',
                    fontSize: 24,
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            child: Container(
              width: 600,
              height: 150.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: FlutterFlowTheme.of(context).tertiaryColor,
                ),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                      child: FFButtonWidget(
                        onPressed: () {
                          print('Button pressed ...');
                        },
                        text: 'Splice',
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 40,
                          color: FlutterFlowTheme.of(context).tertiaryColor,
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                  ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: 8,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Slider(
                          activeColor:
                              FlutterFlowTheme.of(context).primaryColor,
                          inactiveColor: Color(0xFF9E9E9E),
                          min: 0,
                          max: 10,
                          value: sliderValue5 ??= 0,
                          onChanged: (newValue) {
                            newValue =
                                double.parse(newValue.toStringAsFixed(4));
                            setState(() => sliderValue5 = newValue);
                          },
                        ),
                        Text(
                          'Bottom Aligner',
                          style: FlutterFlowTheme.of(context).bodyText1,
                        ),
                        Slider(
                          activeColor:
                              FlutterFlowTheme.of(context).primaryColor,
                          inactiveColor: Color(0xFF9E9E9E),
                          min: 0,
                          max: 10,
                          value: sliderValue6 ??= 0,
                          onChanged: (newValue) {
                            newValue =
                                double.parse(newValue.toStringAsFixed(4));
                            setState(() => sliderValue6 = newValue);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
            child: Text(
              'Sensor Feed',
              style: FlutterFlowTheme.of(context).bodyText1.override(
                    fontFamily: 'Poppins',
                    fontSize: 24,
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            child: Container(
              width: 600,
              height: 330,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: FlutterFlowTheme.of(context).tertiaryColor,
                ),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Generated code for this Row Widget...
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Limit X : ',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      fontSize: 24,
                                    ),
                          ),
                          Icon(
                            Icons.check_circle,
                            color: isLimitXReached
                                ? Color.fromARGB(255, 34, 214, 34)
                                : Color(0xFFD22F2F),
                            size: 40,
                          ),
                          Text(
                            'Limit Y : ',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      fontSize: 24,
                                    ),
                          ),
                          Icon(
                            Icons.check_circle,
                            color: isLimitYReached
                                ? Color(0xFF32CD32)
                                : Color(0xFFD22F2F),
                            size: 40,
                          ),
                          Text(
                            'Limit Z : ',
                            style:
                                FlutterFlowTheme.of(context).bodyText1.override(
                                      fontFamily: 'Poppins',
                                      fontSize: 24,
                                    ),
                          ),
                          Icon(
                            Icons.check_circle,
                            color: isLimitZReached
                                ? Color(0xFF32CD32)
                                : Color(0xFFD22F2F),
                            size: 40,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'ToF Front : ',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 22,
                                  ),
                        ),
                        Text(
                          '120',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                  ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'ToF Back : ',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 22,
                                  ),
                        ),
                        Text(
                          '120',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                  ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Encoder F1 : ',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 22,
                                  ),
                        ),
                        Text(
                          '120',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                  ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Encoder F2 : ',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 22,
                                  ),
                        ),
                        Text(
                          '120',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                  ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Encoder F3 : ',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 22,
                                  ),
                        ),
                        Text(
                          '120',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                  ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Encoder F4 : ',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 22,
                                  ),
                        ),
                        Text(
                          '120',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
