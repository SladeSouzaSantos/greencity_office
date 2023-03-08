import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greencity_sustentavel_office/ui/pages/pages.dart';

void main(){
  testWidgets("Deve carregar o state inicial corretamente.", (WidgetTester widgetTester) async{
    const loginPage = MaterialApp(home: LoginPage());
    await widgetTester.pumpWidget(loginPage);

    final emailTextChildren = find.descendant(of: find.bySemanticsLabel("E-mail"), matching: find.byType(Text));
    expect(
        emailTextChildren,
        findsOneWidget,
        reason: "Quando o TextFormField tiver apenas um filho do tipo Text, significa que ele não apresenta mensagem de error, "
            "pois haverá apenas o labelText como filho."
    );

    final passwordTextChildren = find.descendant(of: find.bySemanticsLabel("Senha"), matching: find.byType(Text));
    expect(
        passwordTextChildren,
        findsOneWidget,
        reason: "Quando o TextFormField tiver apenas um filho do tipo Text, significa que ele não apresenta mensagem de error, "
            "pois haverá apenas o labelText como filho."
    );

    final button = widgetTester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, null);

  });
}