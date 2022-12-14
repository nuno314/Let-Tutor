// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String?,
      name: json['name'] as String?,
      avatar: json['avatar'] as String?,
      email: json['email'] as String?,
      country: json['country'] as String?,
      phoneNumber: json['phone'] as String?,
      isPhoneActivated: json['isPhoneActivated'] as bool?,
      birthday: json['birthday'] as String?,
      level: json['level'] as String?,
      learnTopics: (json['learnTopics'] as List<dynamic>?)
          ?.map((e) => LearnTopic.fromJson(e as Map<String, dynamic>))
          .toList(),
      testPreparations: (json['testPreparations'] as List<dynamic>?)
          ?.map((e) => Test.fromJson(e as Map<String, dynamic>))
          .toList(),
      specialties: (json['specialties'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$SpecialtyEnumMap, e))
          .toList(),
      wallet: json['walletInfo'] == null
          ? null
          : Wallet.fromJson(json['walletInfo'] as Map<String, dynamic>),
      requireNote: json['requireNote'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'avatar': instance.avatar,
      'country': instance.country,
      'phone': instance.phoneNumber,
      'isPhoneActivated': instance.isPhoneActivated,
      'birthday': instance.birthday,
      'level': instance.level,
      'learnTopics': instance.learnTopics,
      'testPreparations': instance.testPreparations,
      'specialties':
          instance.specialties?.map((e) => _$SpecialtyEnumMap[e]!).toList(),
      'walletInfo': instance.wallet,
      'requireNote': instance.requireNote,
    };

const _$SpecialtyEnumMap = {
  Specialty.all: 'all',
  Specialty.kidEnglish: 'kidEnglish',
  Specialty.businessEnglish: 'businessEnglish',
  Specialty.conversational: 'conversational',
  Specialty.starters: 'starters',
  Specialty.movers: 'movers',
  Specialty.flyers: 'flyers',
  Specialty.ket: 'ket',
  Specialty.pet: 'pet',
  Specialty.ielts: 'ielts',
  Specialty.toefl: 'toefl',
  Specialty.toeic: 'toeic',
};

LearnTopic _$LearnTopicFromJson(Map<String, dynamic> json) => LearnTopic(
      id: json['id'] as int?,
      key: json['key'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$LearnTopicToJson(LearnTopic instance) =>
    <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'name': instance.name,
    };

Test _$TestFromJson(Map<String, dynamic> json) => Test(
      id: json['id'] as int?,
      key: json['key'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$TestToJson(Test instance) => <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'name': instance.name,
    };
