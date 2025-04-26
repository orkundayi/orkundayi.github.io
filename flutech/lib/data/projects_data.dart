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
];
