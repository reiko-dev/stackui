//Classe que gerencia animações de opacidade.
import 'package:flutter/material.dart';

import 'package:stackui/widgets/animations/reiko/animations/foo_animation.dart';
import 'package:stackui/widgets/animations/reiko/handlers/handle_foo_animations.dart';
import 'package:stackui/widgets/animations/reiko/animations/translate_animation.dart';

class HandleTranslateAnimations extends HandleFooAnimations {
  @override
  List<FooAnimation> animations = List<TranslateAnimation>();

  @override
  add({
    beginValue,
    finalValue,
    startAnimation,
    endAnimation,
    curve,
  }) {
    //
    var newAnimation = TranslateAnimation(
      beginValue: beginValue,
      finalValue: finalValue,
      startAnimation: startAnimation,
      endAnimation: endAnimation,
      curve: curve,
    );
    newAnimation.validateValues();
    animations.add(newAnimation);
    validateIntervalBetweenAnimations();
  }

  //Retorna o valor da animação em execução do momento.
  //O valor inicial é o da primeira animação, embora nenhuma animação esteja em execução.
  //O valor dado no intervalo entre animações é o da seguinte animação a ser executada.
  @override
  Offset currentAnimationValue(double controllerValue) {
    for (var a in animations) {
      if (controllerValue <= a.endAnimation) return a.animation.value;
    }
    return animations[animations.length - 1].animation.value;
  }
}