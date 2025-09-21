import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:portfolio/my_portfolio_main.dart';
import 'package:portfolio/view_models/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

// ---------------------- Mock Classes ----------------------
class MockHomeViewModel extends Mock implements HomeViewModel {}

class FakeGlobalKey extends Fake implements GlobalKey<State<StatefulWidget>> {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    registerFallbackValue(FakeGlobalKey());
  });

  late MockHomeViewModel mockHomeViewModel;

  setUp(() {
    mockHomeViewModel = MockHomeViewModel();
    VisibilityDetectorController.instance.updateInterval = Duration.zero;

    when(() => mockHomeViewModel.setupHashChangeListener()).thenAnswer((
      _,
    ) async {
      mockHomeViewModel.cancelTimers();
    });

    when(() => mockHomeViewModel.isDrawerOpen).thenReturn(false);

    when(() => mockHomeViewModel.handleNavigation(any())).thenReturn(null);
    when(() => mockHomeViewModel.closeDrawer()).thenReturn(null);
    when(() => mockHomeViewModel.scrollToSection(any())).thenReturn(null);
  });

  Widget buildTestableWidget() {
    return ChangeNotifierProvider<HomeViewModel>.value(
      value: mockHomeViewModel,
      child: const MyPortfolioApp(),
    );
  }

  testWidgets('App loads and navigates sections', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget());
    await tester.pumpAndSettle(const Duration(milliseconds: 500));

    // Check that MyPortfolioApp is loaded
    expect(find.byType(MyPortfolioApp), findsOneWidget);

    expect(find.text('Thant Zin'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('About'), findsOneWidget);
    expect(find.text('Educations'), findsWidgets);
    expect(find.text('Skills'), findsOneWidget);
    expect(find.text('Contact'), findsOneWidget);

    await tester.tap(find.text('About'));
    await tester.pump(const Duration(milliseconds: 500));

    verify(() => mockHomeViewModel.handleNavigation(any())).called(1);

    await tester.tap(find.text('Home'));
    await tester.pump(const Duration(milliseconds: 500));

    verify(() => mockHomeViewModel.handleNavigation(any())).called(1);
  });

  tearDown(() {
    mockHomeViewModel.cancelTimers();
  });
}
