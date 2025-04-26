import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutech/widgets/theme_switch.dart';
import 'package:flutech/widgets/language_selector.dart';

class WebHeader extends StatelessWidget {
  final String currentRoute;
  final Function(String) onSectionSelected;
  final bool showFullMenu;

  const WebHeader({
    super.key,
    required this.currentRoute,
    required this.onSectionSelected,
    this.showFullMenu = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 768;

    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => onSectionSelected('home'),
              child: Row(
                children: [
                  Text(
                    'Flutech.Dev',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (showFullMenu && !isSmallScreen)
            Row(
              children: [
                _buildNavItem('home', l10n.home, context),
                _buildNavItem('about', l10n.about, context),
                _buildNavItem('services', l10n.services, context),
                _buildNavItem('projects', l10n.projects, context),
                _buildNavItem('contact', l10n.contact, context),
                const SizedBox(width: 8),
                const ThemeSwitch(),
                const SizedBox(width: 8),
                const LanguageSelector(),
              ],
            )
          else if (!showFullMenu && !isSmallScreen)
            Row(
              children: [
                _buildNavItem('home', l10n.home, context),
                const SizedBox(width: 8),
                const ThemeSwitch(),
                const SizedBox(width: 8),
                const LanguageSelector(),
              ],
            )
          else
            Row(
              children: [
                const LanguageSelector(isCompact: true),
                const SizedBox(width: 4),
                const ThemeSwitch(),
                const SizedBox(width: 4),
                if (showFullMenu)
                  IconButton(
                    onPressed: () {
                      _showMobileMenu(context);
                    },
                    icon: Icon(Icons.menu),
                  ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String route, String title, BuildContext context) {
    final theme = Theme.of(context);
    final isActive = currentRoute == route;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: () => onSectionSelected(route),
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isActive ? theme.colorScheme.primary : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isActive ? theme.colorScheme.primary : theme.colorScheme.onSurface,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    if (!showFullMenu) return;

    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home, color: theme.colorScheme.primary),
                title: Text(l10n.about),
                onTap: () {
                  Navigator.pop(context);
                  onSectionSelected('home');
                },
              ),
              ListTile(
                leading: Icon(Icons.person, color: theme.colorScheme.primary),
                title: Text(l10n.about),
                onTap: () {
                  Navigator.pop(context);
                  onSectionSelected('about');
                },
              ),
              ListTile(
                leading: Icon(Icons.design_services, color: theme.colorScheme.primary),
                title: Text(l10n.services),
                onTap: () {
                  Navigator.pop(context);
                  onSectionSelected('services');
                },
              ),
              ListTile(
                leading: Icon(Icons.work, color: theme.colorScheme.primary),
                title: Text(l10n.projects),
                onTap: () {
                  Navigator.pop(context);
                  onSectionSelected('projects');
                },
              ),
              ListTile(
                leading: Icon(Icons.mail, color: theme.colorScheme.primary),
                title: Text(l10n.contact),
                onTap: () {
                  Navigator.pop(context);
                  onSectionSelected('contact');
                },
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.settings, size: 20, color: theme.colorScheme.onSurface.withOpacity(0.6)),
                        SizedBox(width: 8),
                        Text(
                          l10n.settings,
                          style: TextStyle(
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const LanguageSelector(isCompact: true),
                        const SizedBox(width: 20),
                        const ThemeSwitch(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
