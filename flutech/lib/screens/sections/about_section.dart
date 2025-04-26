import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutSection extends StatelessWidget {
  final VoidCallback scrollToContact;

  const AboutSection({
    super.key,
    required this.scrollToContact,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 768;
    final isMobile = screenSize.width < 600;
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Başlık alanı - diğer bölümlerle aynı stilde
        Text(
          l10n.about.toUpperCase(),
          style: TextStyle(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
            fontSize: isMobile ? 14 : 16,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          l10n.aboutMe,
          style: theme.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: isMobile ? 32 : null,
            color: theme.colorScheme.onBackground,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          width: 70,
          height: 4,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 60),

        if (isSmallScreen)
          Column(
            children: [
              _buildProfileImage(theme),
              const SizedBox(height: 40),
              _buildAboutContent(context),
            ],
          )
        else
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Expanded yerine Align + SizedBox kullanıldı
              Align(
                alignment: Alignment.topCenter,
                child: _buildProfileImage(theme),
              ),
              const SizedBox(width: 60),
              Expanded(
                flex: 3,
                child: _buildAboutContent(context),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildProfileImage(ThemeData theme) {
    // Animasyonlu ve hover efektli profil resmi
    return MouseRegion(
      cursor: SystemMouseCursors.basic,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.primary.withOpacity(0.8),
              theme.colorScheme.tertiary.withOpacity(0.8),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withOpacity(0.15),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
          border: Border.all(
            color: theme.colorScheme.primary.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: SizedBox(
          width: 240,
          height: 240,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              'https://media.licdn.com/dms/image/v2/D5603AQH5nNAyHkUYmg/profile-displayphoto-shrink_800_800/B56ZWpwxqhHEAg-/0/1742309891389?e=1750896000&v=beta&t=LNgAGmfCYG09khuPMJmNGCM28hIeuus_AtKS8eM4Oxg',
              fit: BoxFit.cover, // Oranı korur ve kutuyu doldurur
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAboutContent(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.heroTitle,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onBackground,
            fontSize: isMobile ? 24 : null,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          l10n.aboutDescription,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onBackground.withOpacity(0.8),
            height: 1.7,
            fontSize: isMobile ? 15 : 16,
          ),
        ),
        const SizedBox(height: 30),

        _buildHighlightItem(
          context,
          icon: Icons.calendar_today_outlined,
          text: l10n.sinceDeveloper(DateTime(2021).year),
        ),
        const SizedBox(height: 15),
        _buildHighlightItem(
          context,
          icon: Icons.lightbulb_outline,
          text: l10n.personalProjects,
        ),
        const SizedBox(height: 15),
        _buildHighlightItem(
          context,
          icon: Icons.code,
          text: l10n.flutterDartFocused,
        ),

        const SizedBox(height: 40),

        // Let's Talk butonu - hover efektli
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: scrollToContact,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 32, vertical: isMobile ? 12 : 16),
              decoration: BoxDecoration(
                // Use primary color directly for more emphasis
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.primary.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                // border: Border.all( // Optional: remove border if using solid color
                //   color: colorScheme.primary,
                //   width: 2,
                // ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.letsTalk,
                    style: TextStyle(
                      // Use onPrimary color for text on primary background
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: isMobile ? 14 : 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward,
                    // Use onPrimary color for icon
                    color: colorScheme.onPrimary,
                    size: isMobile ? 18 : 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Helper widget for highlighting key info points
  Widget _buildHighlightItem(BuildContext context, {required IconData icon, required String text}) {
    final theme = Theme.of(context);
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Row(
      children: [
        Icon(
          icon,
          color: theme.colorScheme.primary,
          size: isMobile ? 20 : 22,
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onBackground.withOpacity(0.9),
            fontWeight: FontWeight.w500,
            fontSize: isMobile ? 15 : 16,
          ),
        ),
      ],
    );
  }
}
