import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components/order_discription_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/instant_timer.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/permissions_util.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'order_page_model.dart';
export 'order_page_model.dart';

class OrderPageWidget extends StatefulWidget {
  const OrderPageWidget({
    super.key,
    required this.orderRef,
    required this.numberCall,
  });

  final DocumentReference? orderRef;
  final String? numberCall;

  @override
  State<OrderPageWidget> createState() => _OrderPageWidgetState();
}

class _OrderPageWidgetState extends State<OrderPageWidget> {
  late OrderPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OrderPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await requestPermission(locationPermission);
    });

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
        appBar: AppBar(
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
              context.pop();
            },
          ),
          actions: [
            FlutterFlowIconButton(
              borderRadius: 8.0,
              buttonSize: 50.0,
              fillColor: FlutterFlowTheme.of(context).primary,
              icon: Icon(
                Icons.call,
                color: FlutterFlowTheme.of(context).info,
                size: 24.0,
              ),
              onPressed: () async {
                await launchUrl(Uri(
                  scheme: 'tel',
                  path: widget!.numberCall!,
                ));
              },
            ),
            FlutterFlowIconButton(
              borderRadius: 8.0,
              buttonSize: 50.0,
              fillColor: FlutterFlowTheme.of(context).primary,
              icon: Icon(
                Icons.wechat_outlined,
                color: FlutterFlowTheme.of(context).info,
                size: 24.0,
              ),
              showLoadingIndicator: true,
              onPressed: () async {
                _model.chatDriverFromOfer = await queryOffersRecordOnce(
                  parent: widget!.orderRef,
                  queryBuilder: (offersRecord) => offersRecord.where(
                    'driver_ref',
                    isEqualTo: currentUserReference,
                  ),
                  singleRecord: true,
                ).then((s) => s.firstOrNull);

                context.pushNamed(
                  'ChatPage',
                  queryParameters: {
                    'chatRef': serializeParam(
                      _model.chatDriverFromOfer?.chatRef,
                      ParamType.DocumentReference,
                    ),
                  }.withoutNulls,
                );

                safeSetState(() {});
              },
            ),
          ],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
            child: StreamBuilder<OrdersRecord>(
              stream: OrdersRecord.getDocument(widget!.orderRef!),
              builder: (context, snapshot) {
                // Customize what your widget looks like when it's loading.
                if (!snapshot.hasData) {
                  return Center(
                    child: SizedBox(
                      width: 30.0,
                      height: 30.0,
                      child: SpinKitCircle(
                        color: FlutterFlowTheme.of(context).primary,
                        size: 30.0,
                      ),
                    ),
                  );
                }

                final columnOrdersRecord = snapshot.data!;

                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            12.0, 16.0, 12.0, 16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Заказ № ${columnOrdersRecord.orderNumber.toString()}',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                Text(
                                  'Локация обновлена  ${dateTimeFormat(
                                    "relative",
                                    columnOrdersRecord.lastEdited,
                                    locale: FFLocalizations.of(context)
                                        .languageCode,
                                  )}',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        fontSize: 10.0,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (columnOrdersRecord.workFlow > 0)
                                  FlutterFlowTimer(
                                    initialTime: _model.timerInitialTimeMs,
                                    getDisplayTime: (value) =>
                                        StopWatchTimer.getDisplayTime(value,
                                            milliSecond: false),
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
                                        .headlineSmall
                                        .override(
                                          fontFamily: 'Outfit',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                Stack(
                                  alignment: AlignmentDirectional(1.0, 0.0),
                                  children: [
                                    if (columnOrdersRecord.workFlow == 2)
                                      Card(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        color: FlutterFlowTheme.of(context)
                                            .success,
                                        elevation: 0.1,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8.0, 8.0, 8.0, 8.0),
                                          child: Text(
                                            'Завершён',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ),
                                      ),
                                    if (columnOrdersRecord.workFlow == 1)
                                      Container(
                                        height: 34.0,
                                        child: Stack(
                                          children: [
                                            if (columnOrdersRecord.workpPause ==
                                                false)
                                              FFButtonWidget(
                                                onPressed: () async {
                                                  _model.timerController
                                                      .onStopTimer();

                                                  await columnOrdersRecord
                                                      .reference
                                                      .update(
                                                          createOrdersRecordData(
                                                    workpPause: true,
                                                  ));
                                                  triggerPushNotification(
                                                    notificationTitle:
                                                        'Заказ на паузе!',
                                                    notificationText:
                                                        'Сотрудник поставил заказ на паузу. Вы можете отследить его местоположение на карте!',
                                                    notificationSound:
                                                        'default',
                                                    userRefs: [
                                                      columnOrdersRecord
                                                          .companyRef!
                                                    ],
                                                    initialPageName:
                                                        'SplashPage',
                                                    parameterData: {},
                                                  );
                                                },
                                                text: 'Перерыв',
                                                icon: Icon(
                                                  Icons.pause,
                                                  size: 15.0,
                                                ),
                                                options: FFButtonOptions(
                                                  height: 44.0,
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          12.0, 0.0, 12.0, 0.0),
                                                  iconPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(0.0, 0.0,
                                                              0.0, 0.0),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  textStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .override(
                                                            fontFamily:
                                                                'Readex Pro',
                                                            color: Colors.white,
                                                            letterSpacing: 0.0,
                                                          ),
                                                  elevation: 3.0,
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.0),
                                                ),
                                              ),
                                            if (columnOrdersRecord.workpPause ==
                                                true)
                                              FFButtonWidget(
                                                onPressed: () async {
                                                  _model.timerController
                                                      .onStartTimer();

                                                  await columnOrdersRecord
                                                      .reference
                                                      .update(
                                                          createOrdersRecordData(
                                                    workpPause: false,
                                                  ));
                                                  triggerPushNotification(
                                                    notificationTitle:
                                                        'Заказ на снова в работе!',
                                                    notificationText:
                                                        'Сотрудник продолжил работать. Вы можете отследить его местоположение на карте!',
                                                    notificationSound:
                                                        'default',
                                                    userRefs: [
                                                      columnOrdersRecord
                                                          .companyRef!
                                                    ],
                                                    initialPageName:
                                                        'SplashPage',
                                                    parameterData: {},
                                                  );
                                                },
                                                text: 'Продолжить',
                                                icon: Icon(
                                                  Icons.play_arrow,
                                                  size: 15.0,
                                                ),
                                                options: FFButtonOptions(
                                                  height: 44.0,
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          12.0, 0.0, 12.0, 0.0),
                                                  iconPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(0.0, 0.0,
                                                              0.0, 0.0),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .success,
                                                  textStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .override(
                                                            fontFamily:
                                                                'Readex Pro',
                                                            color: Colors.white,
                                                            letterSpacing: 0.0,
                                                          ),
                                                  elevation: 3.0,
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.0),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                      ),
                      Stack(
                        alignment: AlignmentDirectional(0.0, 1.0),
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: 400.0,
                              child: custom_widgets.EmptyMap(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                height: 400.0,
                                orderGeo: columnOrdersRecord.orderGeo,
                                zoom: 12.0,
                                driverGeo: columnOrdersRecord.draverGeo,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Material(
                              color: Colors.transparent,
                              elevation: 1.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border.all(
                                    color:
                                        FlutterFlowTheme.of(context).lineColor,
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12.0, 8.0, 12.0, 8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 0.0),
                                          child: Text(
                                            'Адрес: ${columnOrdersRecord.location}',
                                            maxLines: 2,
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .override(
                                                  fontFamily: 'Readex Pro',
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ),
                                      ),
                                      FlutterFlowIconButton(
                                        borderRadius: 8.0,
                                        buttonSize: 40.0,
                                        fillColor: FlutterFlowTheme.of(context)
                                            .primary,
                                        icon: Icon(
                                          Icons.content_copy,
                                          color:
                                              FlutterFlowTheme.of(context).info,
                                          size: 24.0,
                                        ),
                                        onPressed: () async {
                                          await Clipboard.setData(ClipboardData(
                                              text:
                                                  columnOrdersRecord.location));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Адрес скопирован!',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                ),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 2000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .success,
                                            ),
                                          );
                                        },
                                      ),
                                    ].divide(SizedBox(width: 12.0)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            12.0, 16.0, 12.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Stack(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                children: [
                                  if (columnOrdersRecord.workFlow == -1)
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: FFButtonWidget(
                                        onPressed: () async {
                                          currentUserLocationValue =
                                              await getCurrentUserLocation(
                                                  defaultLocation:
                                                      LatLng(0.0, 0.0));
                                          var _shouldSetState = false;
                                          if (functions
                                                  .checkDatePermitionForDriver(
                                                      columnOrdersRecord
                                                          .startTime)
                                                  .toString() ==
                                              '2') {
                                            await showDialog(
                                              context: context,
                                              builder: (alertDialogContext) {
                                                return AlertDialog(
                                                  title: Text('Ошибка!'),
                                                  content: Text(
                                                      'Вы не можете приступить к работе, заказ просрочен!'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext),
                                                      child: Text('Понял!'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          } else {
                                            _model.chekLocation = await actions
                                                .chekLocationPermission(
                                              context,
                                            );
                                            _shouldSetState = true;
                                            if (_model.chekLocation!) {
                                              await columnOrdersRecord.reference
                                                  .update({
                                                ...createOrdersRecordData(
                                                  lastEdited:
                                                      getCurrentTimestamp,
                                                  draverGeo:
                                                      currentUserLocationValue ==
                                                              FFAppState()
                                                                  .NullGeo
                                                          ? FFAppState()
                                                              .driverGeoStart
                                                          : currentUserLocationValue,
                                                ),
                                                ...mapToFirestore(
                                                  {
                                                    'work_flow':
                                                        FieldValue.increment(1),
                                                  },
                                                ),
                                              });
                                              triggerPushNotification(
                                                notificationTitle:
                                                    'Заказ в работе!',
                                                notificationText:
                                                    'Компания приступила к заказу. Водитель выбыл из гаража на место проведения работ!',
                                                notificationSound: 'default',
                                                userRefs: [
                                                  columnOrdersRecord.companyRef!
                                                ],
                                                initialPageName: 'SplashPage',
                                                parameterData: {},
                                              );
                                              _model.instantTimer =
                                                  InstantTimer.periodic(
                                                duration: Duration(
                                                    milliseconds: 100000),
                                                callback: (timer) async {
                                                  currentUserLocationValue =
                                                      await getCurrentUserLocation(
                                                          defaultLocation:
                                                              LatLng(0.0, 0.0));
                                                  if (columnOrdersRecord
                                                          .workFlow <
                                                      2) {
                                                    await columnOrdersRecord
                                                        .reference
                                                        .update(
                                                            createOrdersRecordData(
                                                      lastEdited:
                                                          getCurrentTimestamp,
                                                      draverGeo:
                                                          currentUserLocationValue,
                                                    ));
                                                  } else {
                                                    _model.instantTimer
                                                        ?.cancel();
                                                  }
                                                },
                                                startImmediately: true,
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Местоположение не определено!',
                                                    style: TextStyle(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 2000),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
                                                ),
                                              );
                                              if (_shouldSetState)
                                                safeSetState(() {});
                                              return;
                                            }
                                          }

                                          if (_shouldSetState)
                                            safeSetState(() {});
                                        },
                                        text: 'Выехал из гаража',
                                        options: FFButtonOptions(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  1.0,
                                          height: 44.0,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 0.0, 24.0, 0.0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          textStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    color: Colors.white,
                                                    letterSpacing: 0.0,
                                                  ),
                                          elevation: 3.0,
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                        ),
                                      ),
                                    ),
                                  if (columnOrdersRecord.workFlow == 0)
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: FFButtonWidget(
                                        onPressed: () async {
                                          if (functions.chekGeoDriverForJob(
                                                  columnOrdersRecord.draverGeo,
                                                  columnOrdersRecord
                                                      .orderGeo) ==
                                              true) {
                                            _model.timerController
                                                .onStartTimer();

                                            await columnOrdersRecord.reference
                                                .update({
                                              ...createOrdersRecordData(
                                                lastEdited: getCurrentTimestamp,
                                              ),
                                              ...mapToFirestore(
                                                {
                                                  'work_flow':
                                                      FieldValue.increment(1),
                                                },
                                              ),
                                            });
                                            triggerPushNotification(
                                              notificationTitle:
                                                  'Заказ в работе!',
                                              notificationText:
                                                  'Компания приступила к заказу. Водитель выбыл на место проведения работ!',
                                              notificationSound: 'default',
                                              userRefs: [
                                                columnOrdersRecord.companyRef!
                                              ],
                                              initialPageName: 'SplashPage',
                                              parameterData: {},
                                            );
                                          } else {
                                            await showDialog(
                                              context: context,
                                              builder: (alertDialogContext) {
                                                return AlertDialog(
                                                  title: Text('Ошибка!'),
                                                  content: Text(
                                                      'Вы можете приступить к работе только в радиусе 200 метров от точки выполнения заказа!'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              alertDialogContext),
                                                      child: Text('Понял.'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                        },
                                        text: 'Приступить к работе',
                                        options: FFButtonOptions(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  1.0,
                                          height: 44.0,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24.0, 0.0, 24.0, 0.0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          textStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .override(
                                                    fontFamily: 'Readex Pro',
                                                    color: Colors.white,
                                                    letterSpacing: 0.0,
                                                  ),
                                          elevation: 3.0,
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                        ),
                                      ),
                                    ),
                                  if (columnOrdersRecord.workFlow == 1)
                                    FFButtonWidget(
                                      onPressed: () async {
                                        _model.timerController.onStopTimer();

                                        await columnOrdersRecord.reference
                                            .update({
                                          ...createOrdersRecordData(
                                            lastEdited: getCurrentTimestamp,
                                            draverGeo:
                                                FFAppState().driverGeoStart,
                                          ),
                                          ...mapToFirestore(
                                            {
                                              'work_flow':
                                                  FieldValue.increment(1),
                                              'work_time':
                                                  FieldValue.arrayUnion([
                                                _model.timerMilliseconds
                                              ]),
                                            },
                                          ),
                                        });
                                        _model.timerController.onResetTimer();

                                        triggerPushNotification(
                                          notificationTitle: 'Заказ выполнен!',
                                          notificationText:
                                              'Сотрудник компании отметил заказ как выполненный!',
                                          notificationSound: 'default',
                                          userRefs: [
                                            columnOrdersRecord.companyRef!
                                          ],
                                          initialPageName: 'SplashPage',
                                          parameterData: {},
                                        );
                                      },
                                      text: 'Закончить работу ',
                                      options: FFButtonOptions(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        height: 44.0,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            24.0, 0.0, 24.0, 0.0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .success,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              color: Colors.white,
                                              letterSpacing: 0.0,
                                            ),
                                        elevation: 3.0,
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            FFButtonWidget(
                              onPressed: () async {
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  enableDrag: false,
                                  context: context,
                                  builder: (context) {
                                    return GestureDetector(
                                      onTap: () =>
                                          FocusScope.of(context).unfocus(),
                                      child: Padding(
                                        padding:
                                            MediaQuery.viewInsetsOf(context),
                                        child: OrderDiscriptionWidget(
                                          description:
                                              columnOrdersRecord.description,
                                        ),
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));
                              },
                              text: 'Описание заказа',
                              options: FFButtonOptions(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                height: 44.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: Color(0x19EC9832),
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
