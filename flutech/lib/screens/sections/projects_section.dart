import 'package:flutech/data/projects_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutech/providers/language_provider.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final l10n = AppLocalizations.of(context);
    final currentLocale = Provider.of<LanguageProvider>(context).locale.languageCode;

    final projects = projectsData.map((data) => Project.fromJson(data)).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          l10n.projects.toUpperCase(),
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: screenSize.width < 600 ? 32 : null,
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
        const SizedBox(height: 60),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: screenSize.width > 1100 ? 3 : (screenSize.width > 650 ? 2 : 1),
            childAspectRatio: 0.8,
            crossAxisSpacing: 30,
            mainAxisSpacing: 30,
          ),
          itemCount: projects.length,
          itemBuilder: (context, index) => _buildProjectCard(context, projects[index], currentLocale),
        ),
      ],
    );
  }

  Widget _buildProjectCard(BuildContext context, Project project, String currentLocale) {
    final theme = Theme.of(context);
    final Color projectColor = project.color;

    final title = (currentLocale == 'tr' ? project.titleTr : project.titleEn) ?? '';
    final description = (currentLocale == 'tr' ? project.descriptionTr : project.descriptionEn) ?? '';
    final tags = (currentLocale == 'tr' ? project.tagsTr : project.tagsEn) ?? [];

    // Projenin index'ini bulmak için
    final projectIndex =
        projectsData.indexWhere((data) => data['titleEn'] == project.titleEn && data['titleTr'] == project.titleTr);

    return ProjectHoverCard(
      onTap: () {
        if (project.screenshotAssets != null && project.screenshotAssets!.isNotEmpty) {
          // GoRouter kullanarak yönlendirme
          context.go('/project/$projectIndex');
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          project.screenshotAssets != null && project.screenshotAssets!.isNotEmpty
              ? Stack(
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        border: null,
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset(
                        project.screenshotAssets![0],
                        fit: BoxFit.cover,
                      ),
                    ),
                    if (project.screenshotAssets!.length > 1)
                      Positioned(
                        right: 10,
                        top: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.photo_library,
                                color: Colors.white,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "${project.screenshotAssets!.length}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                )
              : _buildDefaultImagePlaceholder(projectColor, theme),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: tags.map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultImagePlaceholder(Color projectColor, ThemeData theme) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withOpacity(0.7),
          ],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.smartphone,
          size: 70,
          color: Colors.white.withOpacity(0.8),
        ),
      ),
    );
  }
}

// HoverContainer ile aynı mantığı kullanan proje kartları için özel widget
class ProjectHoverCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const ProjectHoverCard({
    super.key,
    required this.child,
    required this.onTap,
  });

  @override
  State<ProjectHoverCard> createState() => _ProjectHoverCardState();
}

class _ProjectHoverCardState extends State<ProjectHoverCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
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
          clipBehavior: Clip.antiAlias,
          child: widget.child,
        ),
      ),
    );
  }
}
