import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  bool hasCategory() => _category != null;

  // "city" field.
  String? _city;
  String get city => _city ?? '';
  bool hasCity() => _city != null;

  // "rating" field.
  double? _rating;
  double get rating => _rating ?? 0.0;
  bool hasRating() => _rating != null;

  // "stage_driver" field.
  int? _stageDriver;
  int get stageDriver => _stageDriver ?? 0;
  bool hasStageDriver() => _stageDriver != null;

  // "otkliki_ispolnitel" field.
  int? _otklikiIspolnitel;
  int get otklikiIspolnitel => _otklikiIspolnitel ?? 0;
  bool hasOtklikiIspolnitel() => _otklikiIspolnitel != null;

  // "assigned_ispolnitel" field.
  DocumentReference? _assignedIspolnitel;
  DocumentReference? get assignedIspolnitel => _assignedIspolnitel;
  bool hasAssignedIspolnitel() => _assignedIspolnitel != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "curent_lokation" field.
  List<LatLng>? _curentLokation;
  List<LatLng> get curentLokation => _curentLokation ?? const [];
  bool hasCurentLokation() => _curentLokation != null;

  // "doc_afferta" field.
  bool? _docAfferta;
  bool get docAfferta => _docAfferta ?? false;
  bool hasDocAfferta() => _docAfferta != null;

  // "last_name" field.
  String? _lastName;
  String get lastName => _lastName ?? '';
  bool hasLastName() => _lastName != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "company_ref" field.
  DocumentReference? _companyRef;
  DocumentReference? get companyRef => _companyRef;
  bool hasCompanyRef() => _companyRef != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _category = snapshotData['category'] as String?;
    _city = snapshotData['city'] as String?;
    _rating = castToType<double>(snapshotData['rating']);
    _stageDriver = castToType<int>(snapshotData['stage_driver']);
    _otklikiIspolnitel = castToType<int>(snapshotData['otkliki_ispolnitel']);
    _assignedIspolnitel =
        snapshotData['assigned_ispolnitel'] as DocumentReference?;
    _status = snapshotData['status'] as String?;
    _curentLokation = getDataList(snapshotData['curent_lokation']);
    _docAfferta = snapshotData['doc_afferta'] as bool?;
    _lastName = snapshotData['last_name'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _companyRef = snapshotData['company_ref'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? email,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  String? category,
  String? city,
  double? rating,
  int? stageDriver,
  int? otklikiIspolnitel,
  DocumentReference? assignedIspolnitel,
  String? status,
  bool? docAfferta,
  String? lastName,
  String? displayName,
  DocumentReference? companyRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'category': category,
      'city': city,
      'rating': rating,
      'stage_driver': stageDriver,
      'otkliki_ispolnitel': otklikiIspolnitel,
      'assigned_ispolnitel': assignedIspolnitel,
      'status': status,
      'doc_afferta': docAfferta,
      'last_name': lastName,
      'display_name': displayName,
      'company_ref': companyRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.email == e2?.email &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.category == e2?.category &&
        e1?.city == e2?.city &&
        e1?.rating == e2?.rating &&
        e1?.stageDriver == e2?.stageDriver &&
        e1?.otklikiIspolnitel == e2?.otklikiIspolnitel &&
        e1?.assignedIspolnitel == e2?.assignedIspolnitel &&
        e1?.status == e2?.status &&
        listEquality.equals(e1?.curentLokation, e2?.curentLokation) &&
        e1?.docAfferta == e2?.docAfferta &&
        e1?.lastName == e2?.lastName &&
        e1?.displayName == e2?.displayName &&
        e1?.companyRef == e2?.companyRef;
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.email,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.category,
        e?.city,
        e?.rating,
        e?.stageDriver,
        e?.otklikiIspolnitel,
        e?.assignedIspolnitel,
        e?.status,
        e?.curentLokation,
        e?.docAfferta,
        e?.lastName,
        e?.displayName,
        e?.companyRef
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}