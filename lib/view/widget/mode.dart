import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/services/themeservice.dart';

class Mode extends StatelessWidget {
  const Mode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  const moonIcon = CupertinoIcons.moon_stars;
    return Container(
      child:
          IconButton( icon: const Icon(
            moonIcon,
            color: Colors.black,
          ),
          onPressed: (){
            ThemeService().chageTheme();
          },
          )
        
      
    ) ;
  }
}