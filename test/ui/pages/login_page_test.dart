import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greencity_sustentavel_office/ui/pages/pages.dart';
import 'package:mocktail/mocktail.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter{}

void main(){

  late LoginPresenter presenter;

  Future<void> loadPage(WidgetTester widgetTester) async{
    presenter = LoginPresenterSpy();
    final loginPage = MaterialApp(home: LoginPage(presenter: presenter));
    await widgetTester.pumpWidget(loginPage);
  }

  testWidgets("Deve carregar o state inicial corretamente.", (WidgetTester widgetTester) async{
    await loadPage(widgetTester);

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

  testWidgets("Deve chamar o validate, com valores corretos.", (WidgetTester widgetTester) async{
    await loadPage(widgetTester);

    final email = faker.internet.email();
    await widgetTester.enterText(find.bySemanticsLabel("E-mail"), email);
    verify(() => presenter.validateEmail(email));

    final senha = faker.internet.password();
    await widgetTester.enterText(find.bySemanticsLabel("Senha"), senha);
    verify(() => presenter.validatePassword(senha));

  });

}