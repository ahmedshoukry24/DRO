import 'package:dro_patient_app/UI/Style/style.dart';
import 'package:flutter/material.dart';

import 'CustomDialog.dart';

class SharedLoadingDialog{

  Style _style = Style();

  Widget loading(BuildContext context){
    return MyCustomDialog(
      content: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(right: _style.getWidthSize(context)*0.06),
            child: CircularProgressIndicator(),
          ),
          Text('Loading...')
        ],
      ),
    );
  }

}