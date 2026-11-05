import 'package:flutter_test/flutter_test.dart';
import 'package:lyca/main.dart';

void main() {
  testWidgets('Splash screen displays brand title and tagline', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that splash screen brand elements are present
    expect(find.text('Lyca'), findsOneWidget);
    expect(find.text('Mobile'), findsOneWidget);
    expect(find.text('Connect your world'), findsOneWidget);
  });
}
