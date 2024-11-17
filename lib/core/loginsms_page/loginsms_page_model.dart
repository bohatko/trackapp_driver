import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'loginsms_page_widget.dart' show LoginsmsPageWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class LoginsmsPageModel extends FlutterFlowModel<LoginsmsPageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for number widget.
  FocusNode? numberFocusNode;
  TextEditingController? numberTextController;
  final numberMask = MaskTextInputFormatter(mask: '(###)-###-##-##');
  String? Function(BuildContext, String?)? numberTextControllerValidator;
  // Stores action output result for [Backend Call - API (smsAuth)] action in Button widget.
  ApiCallResponse? apiResultm0g;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    numberFocusNode?.dispose();
    numberTextController?.dispose();
  }
}
