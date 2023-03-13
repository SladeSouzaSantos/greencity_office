import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:greencity_sustentavel_office/ui/pages/pages.dart';
import 'package:mocktail/mocktail.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter{}

void main(){

  late LoginPresenter presenter;
  late StreamController<String> emailErrorController;
  late StreamController<String> passwordErrorController;
  late StreamController<bool> isFormValidController;

  Future<void> loadPage(WidgetTester widgetTester) async{
    presenter = LoginPresenterSpy();
    emailErrorController = StreamController<String>();
    passwordErrorController = StreamController<String>();
    isFormValidController = StreamController<bool>();

    when(() => presenter.emailErrorStream).thenAnswer((_) => emailErrorController.stream);
    when(() => presenter.passwordErrorStream).thenAnswer((_) => passwordErrorController.stream);
    when(() => presenter.isFormValidStream).thenAnswer((_) => isFormValidController.stream);

    final loginPage = MaterialApp(home: LoginPage(presenter: presenter));
    await widgetTester.pumpWidget(loginPage);
  }
  
  tearDown((){
    emailErrorController.close();
    passwordErrorController.close();
    isFormValidController.close();
  });

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

  testWidgets("Deve mostrar mensagem de error se o email for inválido.", (WidgetTester widgetTester) async{
    await loadPage(widgetTester);

    emailErrorController.add("any error");
    await widgetTester.pump();

    expect(find.text("any error"), findsOneWidget);

  });

  testWidgets("Não deve mostrar mensagem de error se o email for válido.", (WidgetTester widgetTester) async{
    await loadPage(widgetTester);

    emailErrorController.add("");
    await widgetTester.pump();

    expect(
      find.descendant(of: find.bySemanticsLabel("E-mail"), matching: find.byType(Text)),
        findsOneWidget,
    );

  });

  testWidgets("Deve mostrar mensagem de error se o senha for inválido.", (WidgetTester widgetTester) async{
    await loadPage(widgetTester);

    passwordErrorController.add("any error");
    await widgetTester.pump();

    expect(find.text("any error"), findsOneWidget);

  });

  testWidgets("Não deve mostrar mensagem de error se o senha for válido.", (WidgetTester widgetTester) async{
    await loadPage(widgetTester);

    passwordErrorController.add("");
    await widgetTester.pump();

    expect(
      find.descendant(of: find.bySemanticsLabel("Senha"), matching: find.byType(Text)),
      findsOneWidget,
    );

  });

  testWidgets("Deve habilitar button se form for válido.", (WidgetTester widgetTester) async{
    await loadPage(widgetTester);

    isFormValidController.add(true);
    await widgetTester.pump();

    final button = widgetTester.widget<ElevatedButton>(find.byType(ElevatedButton));
    expect(button.onPressed, isNotNull);

  });

}