import 'dart:ui';

import 'package:flutter/material.dart';

class FrostedGlassWidget extends StatelessWidget {
  const FrostedGlassWidget({
    super.key,
    this.child,
     this.width,
     this.height,
  });
  final Widget? child;
  final double? width;

  final double? height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: width,
        height: height,
        color: Colors.transparent,
        //we use Stack(); because we want the effects be on top of each other,
        //  just like layer in photoshop.
        child: Stack(
          children: [
            //blur effect ==> the third layer of stack
            BackdropFilter(
              filter: ImageFilter.blur(
                //sigmaX is the Horizontal blur
                sigmaX: 4.0,
                //sigmaY is the Vertical blur
                sigmaY: 4.0,
              ),
              //we use this container to scale up the blur effect to fit its
              //  parent, without this container the blur effect doesn't appear.
              child: Container(),
            ),
            //gradient effect ==> the second layer of stack
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white.withOpacity(0.13)),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      //begin color
                      Colors.white.withOpacity(0.15),
                      //end color
                      Colors.white.withOpacity(0.05),
                    ]),
              ),
            ),
            //child ==> the first/top layer of stack
            Center(child: child),
          ],
        ),
      ),
    );
  }
}
