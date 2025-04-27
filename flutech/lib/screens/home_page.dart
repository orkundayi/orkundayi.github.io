import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutech/widgets/web_header.dart';
import 'package:flutech/widgets/web_section.dart';
import 'package:flutech/screens/sections/about_section.dart';
import 'package:flutech/screens/sections/services_section.dart';
import 'package:flutech/screens/sections/projects_section.dart';
import 'package:flutech/screens/sections/contact_section.dart';
import 'package:flutech/widgets/scroll_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  final _scrollController = ScrollController();
  final Map<String, GlobalKey> _sectionKeys = {
    'home': GlobalKey(),
    'about': GlobalKey(),
    'services': GlobalKey(),
    'projects': GlobalKey(),
    'contact': GlobalKey(),
  };
  String _activeSection = 'home';
  bool _isScrollingProgrammatically = false;
  Timer? _scrollTimer;

  // Kaydırma pozisyonunu saklamak için
  static const String _scrollPositionKey = 'home_page_scroll_position';

  // Define minimum section height to improve detection
  final double _minimumSectionHeight = 500;

  // AutomaticKeepAliveClientMixin için gerekli override
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    // Kaydırma pozisyonunu yükle
    _loadScrollPosition();

    // Kaydırma olayını dinle ve pozisyonu kaydet
    _scrollController.addListener(_saveScrollPosition);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _determineActiveSection();
    });
  }

  // Kaydırma pozisyonunu kaydet
  void _saveScrollPosition() {
    if (!_isScrollingProgrammatically) {
      SharedPreferences.getInstance().then((prefs) {
        prefs.setDouble(_scrollPositionKey, _scrollController.offset);
      });
    }
  }

  // Kaydırma pozisyonunu yükle
  Future<void> _loadScrollPosition() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedPosition = prefs.getDouble(_scrollPositionKey);

      if (savedPosition != null) {
        // Sayfanın başlangıç konumu yüklendikten sonra
        // WidgetsBinding.instance kullanarak post-frame işlemini zamanla
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.jumpTo(savedPosition);

            // Pozisyona göre aktif bölümü güncelle
            Future.delayed(Duration(milliseconds: 200), () {
              _determineActiveSection();
            });
          }
        });
      }
    } catch (e) {
      debugPrint('Scroll pozisyonu yüklenirken hata: $e');
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_saveScrollPosition);
    _scrollController.dispose();
    _scrollTimer?.cancel();
    super.dispose();
  }

  // Update section detection to work better with section heights
  void _determineActiveSection() {
    if (_isScrollingProgrammatically) return;

    final scrollOffset = _scrollController.offset;
    final viewportHeight = MediaQuery.of(context).size.height;

    // Always prioritize home when at the top
    if (scrollOffset < 100) {
      if (_activeSection != 'home') {
        setState(() => _activeSection = 'home');
      }
      return;
    }

    // Calculate visibility percentage for each section
    Map<String, double> sectionVisibility = {};
    String currentSection = _activeSection;
    double maxVisibility = 0.0;

    for (final entry in _sectionKeys.entries) {
      final sectionId = entry.key;
      final key = entry.value;

      if (key.currentContext != null) {
        final RenderBox box = key.currentContext!.findRenderObject() as RenderBox;
        final sectionPosition = box.localToGlobal(Offset.zero);
        final sectionHeight = box.size.height;

        // Calculate how much of the section is visible in the viewport
        final topVisible = math.max(0.0, sectionPosition.dy);
        final bottomVisible = math.min(sectionPosition.dy + sectionHeight, viewportHeight);

        final visibleHeight = math.max(0.0, bottomVisible - topVisible);
        final visibilityPercentage = visibleHeight / math.min(sectionHeight, viewportHeight);

        sectionVisibility[sectionId] = visibilityPercentage;

        // Section with most visibility wins
        if (visibilityPercentage > maxVisibility) {
          maxVisibility = visibilityPercentage;
          currentSection = sectionId;
        }

        // If we're well inside a section (> 50% visible), prioritize it
        if (visibilityPercentage > 0.5) {
          currentSection = sectionId;
          break;
        }
      }
    }

    // Only update state if section changed
    if (_activeSection != currentSection) {
      setState(() => _activeSection = currentSection);
      debugPrint('Active section updated to: $currentSection (visibility: ${maxVisibility.toStringAsFixed(2)})');
    }
  }

  // Improved section scrolling with completion detection
  void _scrollToSection(String section) {
    final key = _sectionKeys[section];
    if (key?.currentContext != null) {
      _isScrollingProgrammatically = true;

      // Immediately update UI for responsive feel
      setState(() => _activeSection = section);

      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
        alignment: 0.0, // Align to top
      ).then((_) {
        // Allow animations to settle after scrolling completes
        _scrollTimer?.cancel();
        _scrollTimer = Timer(const Duration(milliseconds: 200), () {
          _isScrollingProgrammatically = false;
          _determineActiveSection();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        // Check scroll position on idle and when scrolling ends
        if (notification is ScrollUpdateNotification || notification is ScrollEndNotification) {
          // Don't process during programmatic scrolling
          if (_isScrollingProgrammatically) return false;

          // Throttle updates for better performance
          _scrollTimer?.cancel();
          _scrollTimer = Timer(const Duration(milliseconds: 150), () {
            if (!_isScrollingProgrammatically) {
              _determineActiveSection();
            }
          });
        }
        return false;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: WebHeader(
            currentRoute: _activeSection,
            onSectionSelected: _scrollToSection,
          ),
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeroSection(context),
              WebSection(
                key: _sectionKeys['about'],
                id: 'about',
                backgroundColor: theme.colorScheme.surface,
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: _minimumSectionHeight,
                  ),
                  child: AboutSection(
                    scrollToContact: () => _scrollToSection('contact'),
                  ),
                ),
              ),
              WebSection(
                key: _sectionKeys['services'],
                id: 'services',
                backgroundColor: theme.colorScheme.surface,
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: _minimumSectionHeight,
                  ),
                  child: ServicesSection(),
                ),
              ),
              WebSection(
                key: _sectionKeys['projects'],
                id: 'projects',
                backgroundColor: theme.colorScheme.surface,
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: _minimumSectionHeight,
                  ),
                  child: ProjectsSection(),
                ),
              ),
              WebSection(
                key: _sectionKeys['contact'],
                id: 'contact',
                backgroundColor: theme.colorScheme.surface,
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: _minimumSectionHeight,
                  ),
                  child: ContactSection(),
                ),
              ),
              _buildFooter(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 800;

    return Container(
      key: _sectionKeys['home'],
      // Ekran yüksekliğinin %90'ını kullan - genellikle daha hızlı render edilir
      height: screenSize.height * 0.9,
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
      ),
      child: Stack(
        // clipBehavior'u none yaparak gereksiz clipping operasyonlarını önle
        clipBehavior: Clip.none,
        children: [
          // Performans için optimize edilmiş grid deseni
          Positioned.fill(
            child: RepaintBoundary(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/grid_pattern.png'),
                    repeat: ImageRepeat.repeat,
                    opacity: 0.1,
                    // Filter quality'yi düşük tutarak render performansını artır
                    filterQuality: FilterQuality.low,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 20 : screenSize.width * 0.1,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.heroTitle,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: theme.colorScheme.primary,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // İlk yüklemede animasyonlu metin, sonrasında düz metin göster
                      Text(
                        l10n.heroDescription,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),

                      const SizedBox(height: 40),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () => _scrollToSection('projects'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                              backgroundColor: theme.colorScheme.primary,
                              foregroundColor: theme.colorScheme.onPrimary,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(l10n.viewProjects),
                          ),
                          const SizedBox(width: 16),
                          OutlinedButton(
                            onPressed: () => _scrollToSection('contact'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                              foregroundColor: theme.colorScheme.primary,
                              side: BorderSide(color: theme.colorScheme.primary, width: 2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(l10n.contactMe),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (!isSmallScreen)
                  Expanded(
                    flex: 2,
                    child: Center(
                      // RepaintBoundary ekleyerek gereksiz repaint'leri önle
                      child: RepaintBoundary(
                        child: Container(
                          width: 350,
                          height: 350,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                theme.colorScheme.primary,
                                theme.colorScheme.secondary,
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: theme.colorScheme.primary.withOpacity(0.2),
                                blurRadius: 30,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.phone_android_sharp,
                              size: 120,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: ScrollIndicator(
                onTap: () => _scrollToSection('about'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Container(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 18 : 30, horizontal: isMobile ? 16 : 0),
      color: theme.colorScheme.primary.withOpacity(0.05),
      child: Center(
        child: ConstrainedBox(
          constraints: isMobile ? BoxConstraints(maxWidth: 400) : BoxConstraints(),
          child: Text(
            '© ${DateTime.now().year} ${l10n.companyName}. ${l10n.allRightsReserved}',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: isMobile ? 13 : null,
              color: theme.colorScheme.onSurface.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
            softWrap: true,
          ),
        ),
      ),
    );
  }
}
