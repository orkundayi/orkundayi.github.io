import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutech/widgets/web_header.dart';
import 'dart:html' as html;
import 'package:flutter/gestures.dart';
import 'package:flutech/data/projects_data.dart';
import 'package:go_router/go_router.dart';

class ProjectDetailPage extends StatefulWidget {
  final Project project;
  final int index;

  const ProjectDetailPage({super.key, required this.project, required this.index});

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  String _currentRoute = 'projects';

  void _onSectionSelected(String route) {
    setState(() {
      _currentRoute = route;
    });

    // GoRouter kullanarak route yönlendirmesi
    if (route == 'home') {
      context.go('/');
    } else if (route == 'projects') {
      context.go('/');
    }
  }

  // Tam ekran fotoğraf gösterimi için yardımcı fonksiyon
  void _showFullScreenImage(String imageAsset) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.95),
      builder: (context) => GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Stack(
          children: [
            Center(
              child: InteractiveViewer(
                child: Image.asset(imageAsset),
              ),
            ),
            Positioned(
              top: 32,
              right: 32,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.white, size: 32),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 800;

    final currentLocale = Localizations.localeOf(context).languageCode;
    final title = (currentLocale == 'tr' ? widget.project.titleTr : widget.project.titleEn) ?? '';
    final description = (currentLocale == 'tr' ? widget.project.descriptionTr : widget.project.descriptionEn) ?? '';

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Column(
        children: [
          WebHeader(
            currentRoute: _currentRoute,
            onSectionSelected: _onSectionSelected,
            showFullMenu: false,
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: MaterialScrollBehavior().copyWith(
                dragDevices: {
                  PointerDeviceKind.touch, // Sadece mobil/touch için drag-scroll aktif
                },
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Başlık ve açıklama
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: isMobile ? 40 : 64,
                            horizontal: 24,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(32),
                              bottomRight: Radius.circular(32),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: colorScheme.shadow.withOpacity(0.2),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 8),
                              SelectableText(
                                title,
                                style: theme.textTheme.displaySmall?.copyWith(
                                  color: Colors.white, // Başlık her zaman beyaz
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 18),
                              SelectableText(
                                description,
                                style: theme.textTheme.titleLarge?.copyWith(
                                  color: Colors.white.withOpacity(0.92), // Açıklama her zaman beyaz
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Galeri bölümü
                    if (widget.project.screenshotAssets != null && widget.project.screenshotAssets!.isNotEmpty)
                      ScrollConfiguration(
                        behavior: MaterialScrollBehavior().copyWith(
                          dragDevices: {
                            PointerDeviceKind.touch,
                            PointerDeviceKind.mouse, // Sadece galeri için mouse drag aktif
                          },
                        ),
                        child: _buildImageGallery(theme, colorScheme, isMobile),
                      ),
                    const SizedBox(height: 24),

                    // Google Play butonu
                    if (widget.project.storeUrl != null)
                      Center(
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              html.window.open(widget.project.storeUrl!, '_blank');
                            },
                            icon: Icon(Icons.android, color: Colors.white, size: 28),
                            label: Text(
                              l10n.openInGooglePlay,
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                              textStyle: const TextStyle(fontSize: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              elevation: 3,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 32),

                    // Özellikler bölümü
                    if ((widget.project.featuresEn ?? []).isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                              decoration: BoxDecoration(
                                color: colorScheme.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: SelectableText(
                                l10n.projectFeatures,
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.primary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 24),
                            ..._buildFeatureCardsModern(theme, colorScheme),
                          ],
                        ),
                      ),
                    const SizedBox(height: 40),

                    // Geri dönüş butonu
                    Center(
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Ana sayfaya dön
                            context.go('/');
                          },
                          icon: Icon(Icons.arrow_back),
                          label: Text(l10n.backToProjects),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                            textStyle: const TextStyle(fontSize: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageGallery(ThemeData theme, ColorScheme colorScheme, bool isMobile) {
    final images = widget.project.screenshotAssets!;
    if (images.isEmpty) return SizedBox.shrink();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final double maxImageHeight = (screenHeight * 0.7).clamp(300, 700);
    final double imageWidth = isMobile
        ? screenWidth * 0.92
        : screenWidth * 0.32 > 340
            ? 340
            : screenWidth * 0.32;
    if (isMobile) {
      return _MobileGalleryPageView(
        images: images,
        maxImageHeight: maxImageHeight,
        imageWidth: imageWidth,
        onImageTap: _showFullScreenImage,
        colorScheme: colorScheme,
      );
    }
    // Masaüstü/küçük ekran web: scrollable galeri + sağ/sol oklar
    return _WebGalleryWithArrows(
      images: images,
      maxImageHeight: maxImageHeight,
      imageWidth: imageWidth,
      onImageTap: _showFullScreenImage,
      colorScheme: colorScheme,
    );
  }

  List<Widget> _buildFeatureCardsModern(ThemeData theme, ColorScheme colorScheme) {
    final locale = Localizations.localeOf(context).languageCode;
    final features = locale == 'tr' ? (widget.project.featuresTr ?? []) : (widget.project.featuresEn ?? []);
    if (features.isEmpty) return [];

    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return features.map((feature) {
      return _FeatureHoverCard(
        isMobile: isMobile,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 20 : 32,
            horizontal: isMobile ? 16 : 32,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: isMobile ? 40 : 60,
                height: isMobile ? 40 : 60,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.13),
                  borderRadius: BorderRadius.circular(isMobile ? 10 : 16),
                ),
                child: Center(
                  child: Icon(
                    feature['icon'] as IconData,
                    color: colorScheme.primary,
                    size: isMobile ? 22 : 32,
                  ),
                ),
              ),
              SizedBox(width: isMobile ? 14 : 28),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feature['title'] as String,
                      style: (isMobile ? theme.textTheme.titleMedium : theme.textTheme.titleLarge)?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                        fontSize: isMobile ? 16 : 20,
                      ),
                    ),
                    SizedBox(height: isMobile ? 6 : 10),
                    Text(
                      feature['description'] as String,
                      style: (isMobile ? theme.textTheme.bodyMedium : theme.textTheme.bodyLarge)?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.85),
                        height: 1.4,
                        fontSize: isMobile ? 13 : 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}

// Web için sağ/sol oklu scrollable galeri
class _WebGalleryWithArrows extends StatefulWidget {
  final List<String> images;
  final double maxImageHeight;
  final double imageWidth;
  final void Function(String) onImageTap;
  final ColorScheme colorScheme;

  const _WebGalleryWithArrows({
    required this.images,
    required this.maxImageHeight,
    required this.imageWidth,
    required this.onImageTap,
    required this.colorScheme,
  });
  @override
  State<_WebGalleryWithArrows> createState() => _WebGalleryWithArrowsState();
}

class _WebGalleryWithArrowsState extends State<_WebGalleryWithArrows> {
  final ScrollController _controller = ScrollController();
  bool _canScrollLeft = false;
  bool _canScrollRight = true;

  void _updateScrollButtons() {
    final maxScroll = _controller.position.maxScrollExtent;
    final current = _controller.offset;
    setState(() {
      _canScrollLeft = current > 10;
      _canScrollRight = current < maxScroll - 10;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateScrollButtons);
  }

  @override
  void dispose() {
    _controller.removeListener(_updateScrollButtons);
    _controller.dispose();
    super.dispose();
  }

  void _scrollBy(double offset) {
    final target = _controller.offset + offset;
    _controller.animateTo(
      target.clamp(0, _controller.position.maxScrollExtent),
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: widget.maxImageHeight + 32,
            child: Stack(
              alignment: Alignment.center,
              children: [
                ListView.separated(
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  itemCount: widget.images.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 32),
                  itemBuilder: (context, index) {
                    return MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => widget.onImageTap(widget.images[index]),
                        child: Container(
                          constraints: BoxConstraints(
                            maxHeight: widget.maxImageHeight,
                            maxWidth: widget.imageWidth,
                          ),
                          margin: EdgeInsets.only(
                            left: index == 0 ? 0 : 8,
                            right: index == widget.images.length - 1 ? 0 : 8,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: [
                              BoxShadow(
                                color: widget.colorScheme.primary.withOpacity(0.10),
                                blurRadius: 18,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(28),
                            child: Image.asset(
                              widget.images[index],
                              fit: BoxFit.contain,
                              height: widget.maxImageHeight,
                              width: widget.imageWidth,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                if (_canScrollLeft)
                  Positioned(
                    left: 0,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => _scrollBy(-widget.imageWidth - 32),
                        child: AnimatedOpacity(
                          opacity: _canScrollLeft ? 1 : 0,
                          duration: const Duration(milliseconds: 200),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Icon(Icons.arrow_back_ios_new, size: 28),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (_canScrollRight)
                  Positioned(
                    right: 0,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => _scrollBy(widget.imageWidth + 32),
                        child: AnimatedOpacity(
                          opacity: _canScrollRight ? 1 : 0,
                          duration: const Duration(milliseconds: 200),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.7),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Mobilde tam sayfa PageView ve dot göstergesi
class _MobileGalleryPageView extends StatefulWidget {
  final List<String> images;
  final double maxImageHeight;
  final double imageWidth;
  final void Function(String) onImageTap;
  final ColorScheme colorScheme;

  const _MobileGalleryPageView({
    required this.images,
    required this.maxImageHeight,
    required this.imageWidth,
    required this.onImageTap,
    required this.colorScheme,
  });
  @override
  State<_MobileGalleryPageView> createState() => _MobileGalleryPageViewState();
}

class _MobileGalleryPageViewState extends State<_MobileGalleryPageView> {
  int _current = 0;
  late final PageController _controller;
  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color dotActiveColor = widget.colorScheme.primary;
    final Color dotInactiveColor = widget.colorScheme.primary.withOpacity(0.25);

    return Column(
      children: [
        SizedBox(
          height: widget.maxImageHeight + 24,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.images.length,
            onPageChanged: (i) => setState(() => _current = i),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => widget.onImageTap(widget.images[index]),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: widget.colorScheme.primary.withOpacity(0.10),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: Image.asset(
                    widget.images[index],
                    fit: BoxFit.contain,
                    height: widget.maxImageHeight,
                    width: widget.imageWidth,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.images.length,
            (i) => GestureDetector(
              onTap: () {
                _controller.animateToPage(i, duration: const Duration(milliseconds: 350), curve: Curves.easeInOut);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _current == i ? 24 : 10,
                height: 10,
                decoration: BoxDecoration(
                  color: _current == i ? dotActiveColor : dotInactiveColor,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

// ContactSection'daki HoverContainer'ın sadeleştirilmiş hali, sadece hover efekti ve kutu görünümü için:
class _FeatureHoverCard extends StatefulWidget {
  final Widget child;
  final bool isMobile;
  const _FeatureHoverCard({required this.child, required this.isMobile});

  @override
  State<_FeatureHoverCard> createState() => _FeatureHoverCardState();
}

class _FeatureHoverCardState extends State<_FeatureHoverCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.only(bottom: widget.isMobile ? 16 : 28),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(widget.isMobile ? 14 : 22),
          boxShadow: [
            BoxShadow(
              color: colorScheme.primary.withOpacity(_isHovered ? 0.18 : 0.08),
              blurRadius: widget.isMobile ? 10 : 18,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(
            color: _isHovered ? colorScheme.primary : colorScheme.outline.withOpacity(0.08),
            width: _isHovered ? 2 : 1,
          ),
        ),
        child: widget.child,
      ),
    );
  }
}
