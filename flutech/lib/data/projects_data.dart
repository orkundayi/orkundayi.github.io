import 'package:flutter/material.dart';

class Project {
  final String? titleEn;
  final String? titleTr;
  final String? descriptionEn;
  final String? descriptionTr;
  final List<String>? tagsEn;
  final List<String>? tagsTr;
  final Color color;
  final String? imageAsset;
  final String? storeUrl;
  final String? localStoreImageAsset;
  final String? apkPath; // Yeni: APK dosyası için path
  final List<String>? screenshotAssets;
  final List<Map<String, dynamic>>? featuresEn;
  final List<Map<String, dynamic>>? featuresTr;

  // For backward compatibility
  String get title => titleEn ?? '';
  String get description => descriptionEn ?? '';
  List<String> get tags => tagsEn ?? [];

  Project({
    this.titleEn,
    this.titleTr,
    this.descriptionEn,
    this.descriptionTr,
    this.tagsEn,
    this.tagsTr,
    required this.color,
    this.imageAsset,
    this.storeUrl,
    this.localStoreImageAsset,
    this.apkPath,
    this.screenshotAssets,
    this.featuresEn,
    this.featuresTr,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      titleEn: json['titleEn'] as String?,
      titleTr: json['titleTr'] as String?,
      descriptionEn: json['descriptionEn'] as String?,
      descriptionTr: json['descriptionTr'] as String?,
      tagsEn: (json['tagsEn'] as List?)?.map((e) => e as String).toList(),
      tagsTr: (json['tagsTr'] as List?)?.map((e) => e as String).toList(),
      color: Color(int.parse(json['color'].toString().replaceFirst('#', '0xff'))),
      imageAsset: json['imageAsset'] as String?,
      storeUrl: json['storeUrl'] as String?,
      localStoreImageAsset: json['localStoreImageAsset'] as String?,
      apkPath: json['apkPath'] as String?,
      screenshotAssets: (json['screenshotAssets'] as List?)?.map((e) => e as String).toList(),
      featuresEn: (json['featuresEn'] as List?)?.map((e) => Map<String, dynamic>.from(e)).toList(),
      featuresTr: (json['featuresTr'] as List?)?.map((e) => Map<String, dynamic>.from(e)).toList(),
    );
  }
}

final List<Map<String, dynamic>> projectsData = [
  {
    'titleEn': 'FluBlocks Tetris',
    'titleTr': 'FluBlocks Tetris',
    'descriptionEn':
        'A modern Tetris game built with Flutter. Challenge yourself with this classic game reimagined for mobile devices.',
    'descriptionTr':
        'Flutter ile geliştirilmiş modern bir Tetris oyunu. Bu klasik oyunun mobil cihazlar için yeniden tasarlanmış haliyle kendinize meydan okuyun.',
    'tagsEn': ['Flutter', 'Game', 'Google Play'],
    'tagsTr': ['Flutter', 'Oyun', 'Google Play'],
    'color': '#673AB7', // Rengi hex string formatında tanımla
    'imageAsset': 'assets/images/store/flublocks/flublocks-icon.png',
    'storeUrl': 'https://play.google.com/store/apps/details?id=com.orkun.flutter_tetris',
    'localStoreImageAsset': 'assets/images/store/google_play_badge.png',
    'screenshotAssets': [
      'assets/images/store/flublocks/flublocks-1.png',
      'assets/images/store/flublocks/flublocks-2.png',
      'assets/images/store/flublocks/flublocks-3.png',
      'assets/images/store/flublocks/flublocks-4.png',
      'assets/images/store/flublocks/flublocks-5.png',
    ],
    'featuresEn': [
      {
        'icon': Icons.gamepad,
        'title': 'Classic Tetris Experience',
        'description': 'Enjoy the nostalgia of classic Tetris with a modern touch and smooth controls.'
      },
      {
        'icon': Icons.speed,
        'title': 'Multiple Difficulty Levels',
        'description': 'Test your skills with increasing speeds and challenges as you progress.'
      },
      {
        'icon': Icons.palette,
        'title': 'Clean Visual Design',
        'description': 'Sleek, modern interfaces that let you focus on the gameplay.'
      },
      {
        'icon': Icons.leaderboard,
        'title': 'Score Tracking',
        'description': 'Keep track of your highest scores and challenge yourself to beat them.'
      },
    ],
    'featuresTr': [
      {
        'icon': Icons.gamepad,
        'title': 'Klasik Tetris Deneyimi',
        'description': 'Klasik Tetris nostaljisini modern dokunuş ve akıcı kontrollerle yaşayın.'
      },
      {
        'icon': Icons.speed,
        'title': 'Birden Fazla Zorluk Seviyesi',
        'description': 'İlerledikçe artan hız ve zorluklarla yeteneklerinizi test edin.'
      },
      {
        'icon': Icons.palette,
        'title': 'Temiz Görsel Tasarım',
        'description': 'Oyun deneyimine odaklanmanızı sağlayan şık ve modern arayüzler.'
      },
      {
        'icon': Icons.leaderboard,
        'title': 'Skor Takibi',
        'description': 'En yüksek skorlarınızı takip edin ve kendinize meydan okuyun.'
      },
    ],
  },
  {
    'titleEn': 'Intent Tester',
    'titleTr': 'Intent Tester',
    'descriptionEn':
        'With this tool developed in Flutter, you can quickly and practically test Android intent operations. Specially designed for developers, this solution makes intent management easier and debugging more efficient. Perform your tests effortlessly with easy integration, intuitive interface, and smooth performance!',
    'descriptionTr':
        'Flutter ile geliştirilen bu araç sayesinde Android intent işlemlerini hızlı ve pratik bir şekilde test edebilirsiniz. Geliştiriciler için özel olarak tasarlanan bu çözüm, intent yönetimini kolaylaştırarak hata ayıklama sürecini daha verimli hale getirir. Kolay entegrasyon, sezgisel arayüz ve akıcı performans ile testlerinizi zahmetsizce gerçekleştirin!',
    'tagsEn': ['Flutter', 'Android', 'Intent', 'APK'],
    'tagsTr': ['Flutter', 'Android', 'Intent', 'APK'],
    'color': '#009688',
    'imageAsset': null,
    'storeUrl': null,
    'apkPath': 'flutech/assets/apk/connection.apk',
    'localStoreImageAsset': null,
    'screenshotAssets': [
      'assets/images/store/connection/connection-1.png',
      'assets/images/store/connection/connection-2.png',
      'assets/images/store/connection/connection-3.png',
      'assets/images/store/connection/connection-4.png',
    ],
    'featuresEn': [
      {
        'icon': Icons.bolt,
        'title': 'Quick Intent Testing',
        'description': 'Test Android intents rapidly without writing extra code.'
      },
      {
        'icon': Icons.bug_report,
        'title': 'Debug Friendly',
        'description': 'Designed for developers to make debugging easier.'
      },
      {
        'icon': Icons.touch_app,
        'title': 'Intuitive UI',
        'description': 'Simple and user-friendly interface for seamless testing.'
      },
      {
        'icon': Icons.integration_instructions,
        'title': 'Easy Integration',
        'description': 'Integrate and use the tool in your workflow effortlessly.'
      },
      {
        'icon': Icons.sync_alt,
        'title': 'Postman Integration',
        'description': 'Works integrated with Postman, enabling automated API testing.'
      },
      {
        'icon': Icons.storage,
        'title': 'Manual & Local Test Support',
        'description': 'Optionally store data locally for manual testing.'
      },
    ],
    'featuresTr': [
      {
        'icon': Icons.bolt,
        'title': 'Hızlı Intent Testi',
        'description': 'Ekstra kod yazmadan Android intent işlemlerini hızlıca test edin.'
      },
      {
        'icon': Icons.bug_report,
        'title': 'Hata Ayıklama Dostu',
        'description': 'Geliştiriciler için hata ayıklamayı kolaylaştıracak şekilde tasarlandı.'
      },
      {
        'icon': Icons.touch_app,
        'title': 'Sezgisel Arayüz',
        'description': 'Kolay ve kullanıcı dostu arayüz ile zahmetsiz test.'
      },
      {
        'icon': Icons.integration_instructions,
        'title': 'Kolay Entegrasyon',
        'description': 'Aracı iş akışınıza zahmetsizce entegre edin ve kullanın.'
      },
      {
        'icon': Icons.sync_alt,
        'title': 'Postman Entegrasyonu',
        'description': 'Postman ile entegre çalışabilir, API testlerini otomatikleştirebilirsiniz.'
      },
      {
        'icon': Icons.storage,
        'title': 'Manuel & Lokal Test Desteği',
        'description': 'İsterseniz verileri lokalde tutarak manuel testlerinizi de kolayca gerçekleştirebilirsiniz.'
      },
    ],
  },
];
