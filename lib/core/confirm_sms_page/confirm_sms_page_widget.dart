import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'confirm_sms_page_model.dart';
export 'confirm_sms_page_model.dart';

class ConfirmSmsPageWidget extends StatefulWidget {
  const ConfirmSmsPageWidget({
    super.key,
    required this.number,
  });

  final String? number;

  @override
  State<ConfirmSmsPageWidget> createState() => _ConfirmSmsPageWidgetState();
}

class _ConfirmSmsPageWidgetState extends State<ConfirmSmsPageWidget> {
  late ConfirmSmsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ConfirmSmsPageModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: !isWeb
            ? AppBar(
                backgroundColor: FlutterFlowTheme.of(context).primary,
                automaticallyImplyLeading: false,
                leading: FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30.0,
                  borderWidth: 1.0,
                  buttonSize: 60.0,
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  onPressed: () async {
                    context.goNamed(
                      'LoginsmsPage',
                      extra: <String, dynamic>{
                        kTransitionInfoKey: TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.leftToRight,
                        ),
                      },
                    );
                  },
                ),
                title: Text(
                  'Ожидаем SMS',
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily: 'Outfit',
                        color: Colors.white,
                        fontSize: 20.0,
                        letterSpacing: 0.0,
                      ),
                ),
                actions: [],
                centerTitle: true,
                elevation: 2.0,
              )
            : null,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: 220.0,
                decoration: BoxDecoration(),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                  child: Lottie.asset(
                    'assets/jsons/Animation_-_1707039939741.json',
                    width: 50.0,
                    height: 114.0,
                    fit: BoxFit.contain,
                    repeat: false,
                    animate: true,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'На номер ',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Nunito',
                                    color: Color(0xFF393939),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                            Text(
                              '+7${widget!.number}',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Nunito',
                                    color: FlutterFlowTheme.of(context).primary,
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 16.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'был отправлен код..',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Nunito',
                                    color: Color(0xFF393939),
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 20.0, 20.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                maxWidth: 400.0,
                              ),
                              decoration: BoxDecoration(),
                              child: PinCodeTextField(
                                autoDisposeControllers: false,
                                appContext: context,
                                length: 4,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyLarge
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      letterSpacing: 0.0,
                                    ),
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                enableActiveFill: false,
                                autoFocus: true,
                                enablePinAutofill: false,
                                errorTextSpace: 16.0,
                                showCursor: false,
                                cursorColor:
                                    FlutterFlowTheme.of(context).primary,
                                obscureText: false,
                                keyboardType: TextInputType.number,
                                pinTheme: PinTheme(
                                  fieldHeight: 90.0,
                                  fieldWidth: 50.0,
                                  borderWidth: 1.0,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(4.0),
                                    bottomRight: Radius.circular(4.0),
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                  shape: PinCodeFieldShape.box,
                                  activeColor:
                                      FlutterFlowTheme.of(context).success,
                                  inactiveColor:
                                      FlutterFlowTheme.of(context).alternate,
                                  selectedColor:
                                      FlutterFlowTheme.of(context).primary,
                                ),
                                controller: _model.pinCodeController,
                                onChanged: (_) {},
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: _model.pinCodeControllerValidator
                                    .asValidator(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          if (_model.timerMilliseconds > 0)
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 10.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 2.0, 0.0),
                                    child: Text(
                                      'Выслать код повторно можно через ',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Nunito',
                                            color: Color(0xFF848488),
                                            fontSize: 12.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 2.0, 0.0),
                                    child: FlutterFlowTimer(
                                      initialTime: _model.timerInitialTimeMs,
                                      getDisplayTime: (value) =>
                                          StopWatchTimer.getDisplayTime(
                                        value,
                                        hours: false,
                                        minute: false,
                                        milliSecond: false,
                                      ),
                                      controller: _model.timerController,
                                      updateStateInterval:
                                          Duration(milliseconds: 1000),
                                      onChanged:
                                          (value, displayTime, shouldUpdate) {
                                        _model.timerMilliseconds = value;
                                        _model.timerValue = displayTime;
                                        if (shouldUpdate) safeSetState(() {});
                                      },
                                      textAlign: TextAlign.start,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            color: Color(0xFF949494),
                                            fontSize: 12.0,
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(-0.7, 0.0),
                                    child: Text(
                                      'сек.',
                                      textAlign: TextAlign.center,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Nunito',
                                            color: Color(0xFF848488),
                                            fontSize: 12.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 40.0, 16.0, 0.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    var _shouldSetState = false;
                    if (FFAppState().smsCode ==
                        _model.pinCodeController!.text) {
                      _model.driverExist = await queryUsersRecordOnce(
                        queryBuilder: (usersRecord) => usersRecord.where(
                          'phone_number',
                          isEqualTo: '7${functions.onlyNumber(widget!.number)}',
                        ),
                        singleRecord: true,
                      ).then((s) => s.firstOrNull);
                      _shouldSetState = true;
                      if (_model.driverExist != null) {
                        GoRouter.of(context).prepareAuthEvent();

                        final user = await authManager.signInWithEmail(
                          context,
                          '7${functions.onlyNumber(widget!.number)}@track-app.ru',
                          FFAppConstants.pass,
                        );
                        if (user == null) {
                          return;
                        }

                        context.goNamedAuth('HomePage', context.mounted);
                      } else {
                        _model.driverDoc = await queryDriverListRecordOnce(
                          queryBuilder: (driverListRecord) =>
                              driverListRecord.where(
                            'phone_number',
                            isEqualTo:
                                '7${functions.onlyNumber(widget!.number)}',
                          ),
                          singleRecord: true,
                        ).then((s) => s.firstOrNull);
                        _shouldSetState = true;
                        if (_model.driverDoc != null) {
                          context.goNamedAuth(
                            'CreateNewDriverProfile',
                            context.mounted,
                            queryParameters: {
                              'number': serializeParam(
                                _model.driverDoc?.phoneNumber,
                                ParamType.String,
                              ),
                              'displayName': serializeParam(
                                _model.driverDoc?.displayName,
                                ParamType.String,
                              ),
                              'assainedIsp': serializeParam(
                                _model.driverDoc?.assignedIspolnitel,
                                ParamType.DocumentReference,
                              ),
                              'lastName': serializeParam(
                                _model.driverDoc?.lastName,
                                ParamType.String,
                              ),
                              'companyRef': serializeParam(
                                _model.driverDoc?.companyRef,
                                ParamType.DocumentReference,
                              ),
                              'driverListRef': serializeParam(
                                _model.driverDoc?.reference,
                                ParamType.DocumentReference,
                              ),
                            }.withoutNulls,
                          );
                        } else {
                          await showDialog(
                            context: context,
                            builder: (alertDialogContext) {
                              return AlertDialog(
                                title: Text(
                                    'Нет приглашений для указаного номера!'),
                                content: Text(
                                    'Обратитесь к руководителю, что бы создал для Вас приглашение и попробуйти зайти снова!'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(alertDialogContext),
                                    child: Text('Понял'),
                                  ),
                                ],
                              );
                            },
                          );
                          context.pop();
                          if (_shouldSetState) safeSetState(() {});
                          return;
                        }
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Код введен неверно!',
                            style: TextStyle(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                          ),
                          duration: Duration(milliseconds: 2000),
                          backgroundColor: FlutterFlowTheme.of(context).error,
                        ),
                      );
                    }

                    if (_shouldSetState) safeSetState(() {});
                  },
                  text: 'Войти',
                  options: FFButtonOptions(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: 44.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Readex Pro',
                          color: Colors.white,
                          letterSpacing: 0.0,
                        ),
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
