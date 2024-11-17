import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'list_empty_model.dart';
export 'list_empty_model.dart';

class ListEmptyWidget extends StatefulWidget {
  const ListEmptyWidget({super.key});

  @override
  State<ListEmptyWidget> createState() => _ListEmptyWidgetState();
}

class _ListEmptyWidgetState extends State<ListEmptyWidget> {
  late ListEmptyModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ListEmptyModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 223.0,
      height: 50.0,
      decoration: BoxDecoration(),
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Text(
        'Список пуст :(',
        style: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: 'Readex Pro',
              letterSpacing: 0.0,
            ),
      ),
    );
  }
}
