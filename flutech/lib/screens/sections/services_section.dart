import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutech/widgets/service_card.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final l10n = AppLocalizations.of(context);
    final isMobile = screenSize.width < 600;

    final services = [
      ServiceCard(
        icon: Icons.phone_android,
        title: l10n.mobileAppDevTitle,
        description: l10n.mobileAppDevDesc,
      ),
      ServiceCard(
        icon: Icons.design_services,
        title: l10n.uiUxDesignTitle,
        description: l10n.uiUxDesignDesc,
      ),
      ServiceCard(
        icon: Icons.api,
        title: l10n.apiIntegrationTitle,
        description: l10n.apiIntegrationDesc,
      ),
      ServiceCard(
        icon: Icons.storage,
        title: l10n.backendSolutionsTitle,
        description: l10n.backendSolutionsDesc,
      ),
      ServiceCard(
        icon: Icons.architecture,
        title: l10n.appArchitectureTitle,
        description: l10n.appArchitectureDesc,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Contact ve Project section'ları ile aynı stil
        Text(
          l10n.services.toUpperCase(),
          style: TextStyle(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
            fontSize: isMobile ? 14 : 16,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          l10n.whatICanDoForYou,
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
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: screenSize.width > 1100 ? 3 : (screenSize.width > 650 ? 2 : 1),
            childAspectRatio: 1.2,
            crossAxisSpacing: 30,
            mainAxisSpacing: 30,
          ),
          itemCount: services.length,
          itemBuilder: (context, index) => services[index],
        ),
      ],
    );
  }
}
