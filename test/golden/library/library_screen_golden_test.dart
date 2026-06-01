import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:shorts_ai/features/auth/providers/auth_provider.dart';
import 'package:shorts_ai/features/library/library_screen.dart';
import 'package:shorts_ai/features/library/providers/library_provider.dart';
import 'package:shorts_ai/shared/models/project.dart';

import '../golden_test_helper.dart';

void main() {
  setUpGoldenTests();

  testGoldens('library screen all tab GOLDEN', (tester) async {
    await pumpResponsiveGolden(
      tester,
      authState: Authenticated(goldenUser),
      overrides: [
        libraryProjectsProvider(LibraryTab.all).overrideWith(
          (ref) => Stream.value(_projects()),
        ),
        libraryCountsProvider.overrideWith(
          (ref) => Stream.value(LibraryCounts.fromProjects(_projects())),
        ),
      ],
      builder: () => const LibraryScreen(),
    );
    await expectResponsiveGolden(tester, 'library_screen');
  });
}

List<Project> _projects() {
  final now = DateTime(2026, 6, 1, 9);
  return [
    Project(
      id: 'golden-library-1',
      userId: goldenUser.id,
      title: 'Draft launch story',
      status: ProjectStatus.draft,
      duration: 32,
      createdAt: now,
      updatedAt: now,
    ),
    Project(
      id: 'golden-library-2',
      userId: goldenUser.id,
      title: 'Published tutorial',
      status: ProjectStatus.published,
      duration: 51,
      createdAt: now,
      updatedAt: now,
    ),
  ];
}
