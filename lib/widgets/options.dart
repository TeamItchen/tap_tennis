import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'options.dart';
export 'options.dart';

class OptionsModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue1;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue2;
  // State field(s) for SwitchListTile widget.
  bool? switchListTileValue3;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {}

/// Additional helper methods are added here.

}

class OptionsWidget extends StatefulWidget {
  const OptionsWidget({Key? key}) : super(key: key);

  @override
  _OptionsWidgetState createState() => _OptionsWidgetState();
}

class _OptionsWidgetState extends State<OptionsWidget> {
  late OptionsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OptionsModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30.0,
          borderWidth: 1.0,
          buttonSize: 60.0,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Color(0xFF090F13),
            size: 30.0,
          ),
          onPressed: () async {
            context.safePop();
          },
        ),
        title: Text(
          'Options',
          style: FlutterFlowTheme.of(context).headlineMedium.override(
            fontFamily: 'Lexend Deca',
            color: Color(0xFF090F13),
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0.0,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Text(
                    'Change options to make the game more or less difficult.',
                    style: FlutterFlowTheme.of(context).bodySmall.override(
                      fontFamily: 'Lexend Deca',
                      color: Color(0xFF95A1AC),
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
            child: SwitchListTile.adaptive(
              value: _model.switchListTileValue1 ??= false,
              onChanged: (newValue) async {
                setState(() => _model.switchListTileValue1 = newValue!);
              },
              title: Text(
                'Power-Ups',
                style: FlutterFlowTheme.of(context).headlineSmall.override(
                  fontFamily: 'Lexend Deca',
                  color: Color(0xFF090F13),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'If turned on, power-ups will appear in-game.',
                style: FlutterFlowTheme.of(context).bodySmall.override(
                  fontFamily: 'Lexend Deca',
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              tileColor: Color(0xFF77A6FF),
              activeColor: Color(0xFF23C400),
              activeTrackColor: Color(0x8A4B39EF),
              dense: false,
              controlAffinity: ListTileControlAffinity.trailing,
              contentPadding:
              EdgeInsetsDirectional.fromSTEB(24.0, 12.0, 24.0, 12.0),
            ),
          ),
          SwitchListTile.adaptive(
            value: _model.switchListTileValue2 ??= false,
            onChanged: (newValue) async {
              setState(() => _model.switchListTileValue2 = newValue!);
            },
            title: Text(
              'Obstacles',
              style: FlutterFlowTheme.of(context).headlineSmall.override(
                fontFamily: 'Lexend Deca',
                color: Color(0xFF090F13),
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'If turned on, obstacles will appear in-game.',
              style: FlutterFlowTheme.of(context).bodySmall.override(
                fontFamily: 'Lexend Deca',
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
              ),
            ),
            tileColor: Color(0xFF77A6FF),
            activeColor: Color(0xFF23C400),
            activeTrackColor: Color(0xFF3B2DB6),
            dense: false,
            controlAffinity: ListTileControlAffinity.trailing,
            contentPadding:
            EdgeInsetsDirectional.fromSTEB(24.0, 12.0, 24.0, 12.0),
          ),
          SwitchListTile.adaptive(
            value: _model.switchListTileValue3 ??= false,
            onChanged: (newValue) async {
              setState(() => _model.switchListTileValue3 = newValue!);
            },
            title: Text(
              'Speed',
              style: FlutterFlowTheme.of(context).headlineSmall.override(
                fontFamily: 'Lexend Deca',
                color: Color(0xFF090F13),
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'If turned on, the ball will move at a faster speed.',
              style: FlutterFlowTheme.of(context).bodySmall.override(
                fontFamily: 'Lexend Deca',
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
              ),
            ),
            tileColor: Color(0xFF77A6FF),
            activeColor: Color(0xFF23C400),
            activeTrackColor: Color(0xFF3B2DB6),
            dense: false,
            controlAffinity: ListTileControlAffinity.trailing,
            contentPadding:
            EdgeInsetsDirectional.fromSTEB(24.0, 12.0, 24.0, 12.0),
          ),
        ],
      ),
    );
  }
}
