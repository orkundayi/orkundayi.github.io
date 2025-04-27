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
    final isSmallScreen = screenSize.width < 900;
    final isMobile = screenSize.width < 600;
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 32 : 64, horizontal: isMobile ? 8 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            l10n.aboutMe,
            style: theme.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: isMobile ? 28 : 36,
              color: theme.colorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 18),
          Container(
            width: 70,
            height: 4,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 48),
          isSmallScreen
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildProfileImage(theme),
                    const SizedBox(height: 32),
                    _buildAboutContent(context, isMobile: true),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileImage(theme),
                    const SizedBox(width: 56),
                    Expanded(
                      child: _buildAboutContent(context, isMobile: false),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildProfileImage(ThemeData theme) {
    return Container(
      width: 220,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.network(
          'https://media.licdn.com/dms/image/v2/D5603AQH5nNAyHkUYmg/profile-displayphoto-shrink_800_800/B56ZWpwxqhHEAg-/0/1742309891389?e=1750896000&v=beta&t=LNgAGmfCYG09khuPMJmNGCM28hIeuus_AtKS8eM4Oxg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildAboutContent(BuildContext context, {required bool isMobile}) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          'Orkun Dayı',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onBackground,
            fontSize: isMobile ? 22 : 26,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 18),
        Text(
          l10n.aboutDescription,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onBackground.withOpacity(0.85),
            height: 1.7,
            fontSize: isMobile ? 14 : 16,
          ),
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 28),
        _buildFeatures(context, isMobile: isMobile),
        const SizedBox(height: 32),
        _buildContactButton(context, isMobile: isMobile),
      ],
    );
  }

  Widget _buildFeatures(BuildContext context, {required bool isMobile}) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final features = [
      {
        'icon': Icons.calendar_today_outlined,
        'text': l10n.sinceDeveloper(DateTime(2021).year),
      },
      {
        'icon': Icons.lightbulb_outline,
        'text': l10n.personalProjects,
      },
      {
        'icon': Icons.code,
        'text': l10n.flutterDartFocused,
      },
    ];
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: features
          .map((f) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      f['icon'] as IconData,
                      color: theme.colorScheme.primary,
                      size: isMobile ? 20 : 22,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        f['text'] as String,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onBackground.withOpacity(0.92),
                          fontWeight: FontWeight.w500,
                          fontSize: isMobile ? 14 : 15,
                          height: 1.5,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }

  Widget _buildContactButton(BuildContext context, {required bool isMobile}) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: scrollToContact,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 32, vertical: isMobile ? 12 : 16),
          decoration: BoxDecoration(
            color: colorScheme.primary,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: colorScheme.primary.withOpacity(0.18),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.letsTalk,
                style: TextStyle(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: isMobile ? 14 : 16,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward,
                color: colorScheme.onPrimary,
                size: isMobile ? 18 : 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
