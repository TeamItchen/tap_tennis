import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'pause_menu.dart';
export 'pause_menu.dart';

class PausedModel extends FlutterFlowModel {
  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {}

/// Additional helper methods are added here.

}

class PausedWidget extends StatefulWidget {
  const PausedWidget({Key? key}) : super(key: key);

  @override
  _PausedWidgetState createState() => _PausedWidgetState();
}

class _PausedWidgetState extends State<PausedWidget> {
  late PausedModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PausedModel());
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tap Tennis',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Poppins',
                      fontSize: 60.0,
                    ),
                  ),
                ],
              ),
              Text(
                'Paused',
                style: FlutterFlowTheme.of(context).headlineLarge.override(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30.0,
                    borderWidth: 10.0,
                    buttonSize: 200.0,
                    fillColor: Color(0xFF23C400),
                    icon: Icon(
                      Icons.subdirectory_arrow_right_rounded,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 50.0,
                    ),
                    onPressed: () async {
                      context.safePop();
                    },
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30.0,
                    borderWidth: 1.0,
                    buttonSize: 100.0,
                    fillColor: Color(0xFF595959),
                    icon: Icon(
                      Icons.settings,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 30.0,
                    ),
                    onPressed: () async {
                      context.pushNamed('options');
                    },
                  ),
                  FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30.0,
                    borderWidth: 1.0,
                    buttonSize: 100.0,
                    fillColor: Color(0xFFC60000),
                    icon: Icon(
                      Icons.leaderboard,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 30.0,
                    ),
                    onPressed: () async {
                      context.pushNamed('leaderboard');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
