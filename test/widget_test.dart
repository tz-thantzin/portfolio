import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:portfolio/view_models/home_view_model.dart';

// ---------------------- Mock Classes ----------------------
class MockHomeViewModel extends Mock implements HomeViewModel {}

class FakeGlobalKey extends Fake implements GlobalKey<State<StatefulWidget>> {}

void main() {
  // TestWidgetsFlutterBinding.ensureInitialized();
  //
  // setUpAll(() {
  //   registerFallbackValue(FakeGlobalKey());
  // });
  //
  // late MockHomeViewModel mockHomeViewModel;
  //
  // setUp(() {
  //   mockHomeViewModel = MockHomeViewModel();
  //   VisibilityDetectorController.instance.updateInterval = Duration.zero;
  //
  //   when(() => mockHomeViewModel.isDrawerOpen).thenReturn(false);
  //
  //   when(() => mockHomeViewModel.closeDrawer()).thenReturn(null);
  //   when(() => mockHomeViewModel.scrollToSection(any())).thenReturn(null);
  // });
  //
  // Widget buildTestableWidget() {
  //   return ChangeNotifierProvider<HomeViewModel>.value(
  //     value: mockHomeViewModel,
  //     child: const MyPortfolioApp(),
  //   );
  // }
}
