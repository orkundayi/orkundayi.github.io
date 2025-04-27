import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: screenWidth < 600 ? 60 : 100,
              bottom: screenWidth < 600 ? 40 : 80,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  l10n.getInTouch.toUpperCase(),
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: isMobile ? 32 : null,
                    color: theme.colorScheme.primary,
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
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: theme.colorScheme.surface,
            child: _buildContactContent(context),
          ),
        ],
      ),
    );
  }

  Widget _buildContactContent(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildEmailItem(context),
        SizedBox(height: screenWidth < 600 ? 16 : 20),
        _buildSocialButtonsRow(context),
      ],
    );
  }

  Widget _buildEmailItem(BuildContext context) {
    final theme = Theme.of(context);
    final emailAddress = "orkundayi@flutech.org";
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return HoverContainer(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: isMobile ? 24 : 40,
          horizontal: isMobile ? 20 : 60,
        ),
        child: isMobile
            ? _buildMobileEmailContent(context, emailAddress, theme)
            : _buildDesktopEmailContent(context, emailAddress, theme),
      ),
      onTap: () => _launchUrl("mailto:$emailAddress"),
    );
  }

  Widget _buildMobileEmailContent(BuildContext context, String emailAddress, ThemeData theme) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Icon(
                  Icons.email_outlined,
                  color: theme.colorScheme.primary,
                  size: 25,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                l10n.contactInfoTitle,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          l10n.contactInfoDesc,
          style: TextStyle(
            fontSize: 14,
            color: theme.colorScheme.onSurface.withOpacity(0.7),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.emailTitle,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              emailAddress,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
              maxLines: 1,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopEmailContent(BuildContext context, String emailAddress, ThemeData theme) {
    final l10n = AppLocalizations.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Icon(
              Icons.email_outlined,
              color: theme.colorScheme.primary,
              size: 40,
            ),
          ),
        ),
        const SizedBox(width: 40),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.contactInfoTitle,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.contactInfoDesc,
                style: TextStyle(
                  fontSize: 16,
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.emailTitle,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            emailAddress,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface,
                            ),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButtonsRow(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 768;

    if (isSmallScreen) {
      return Column(
        children: [
          _buildSocialButton(
            context: context,
            icon: LineIcons.github,
            label: "GitHub",
            description: l10n.githubDesc,
            url: "https://github.com/orkundayi",
            isMobile: screenWidth < 600,
          ),
          SizedBox(height: screenWidth < 600 ? 12 : 16),
          _buildSocialButton(
            context: context,
            icon: LineIcons.linkedin,
            label: "LinkedIn",
            description: l10n.linkedinDesc,
            url: "https://linkedin.com/in/orkundayi",
            isMobile: screenWidth < 600,
          ),
        ],
      );
    }

    return Row(
      children: [
        Expanded(
          child: _buildSocialButton(
            context: context,
            icon: LineIcons.github,
            label: "GitHub",
            description: l10n.githubDesc,
            url: "https://github.com/orkundayi",
            isMobile: false,
          ),
        ),
        const SizedBox(width: 30),
        Expanded(
          child: _buildSocialButton(
            context: context,
            icon: LineIcons.linkedin,
            label: "LinkedIn",
            description: l10n.linkedinDesc,
            url: "https://linkedin.com/in/orkundayi",
            isMobile: false,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String description,
    required String url,
    required bool isMobile,
  }) {
    final theme = Theme.of(context);

    return HoverContainer(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(isMobile ? 16 : 30),
        child: Row(
          children: [
            Container(
              width: isMobile ? 40 : 60,
              height: isMobile ? 40 : 60,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(isMobile ? 8 : 12),
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: theme.colorScheme.primary,
                  size: isMobile ? 20 : 28,
                ),
              ),
            ),
            SizedBox(width: isMobile ? 12 : 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: (isMobile ? theme.textTheme.titleMedium : theme.textTheme.titleLarge)?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: isMobile ? 3 : 6),
                  Text(
                    description,
                    style: (isMobile ? theme.textTheme.bodyMedium : theme.textTheme.bodyLarge)?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward,
              color: theme.colorScheme.primary,
              size: isMobile ? 20 : 24,
            ),
          ],
        ),
      ),
      onTap: () => _launchUrl(url),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    } catch (e) {
      debugPrint('Could not launch $url: $e');
    }
  }
}

// Hover efektini daha kolay uygulamak için stateful bir widget
class HoverContainer extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const HoverContainer({
    super.key,
    required this.child,
    required this.onTap,
  });

  @override
  State<HoverContainer> createState() => _HoverContainerState();
}

class _HoverContainerState extends State<HoverContainer> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click, // Mouse imlecini el şeklinde göster
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withOpacity(_isHovered ? 0.2 : 0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
            border: Border.all(
              color: _isHovered ? theme.colorScheme.primary : theme.colorScheme.onSurface.withOpacity(0.1),
              width: _isHovered ? 2 : 1,
            ),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
