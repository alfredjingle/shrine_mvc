// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';

// import 'package:scoped_model/scoped_model.dart';

import 'package:shrine_mvc/src/model.dart' show AppStateModel, Category, I10n;

import 'package:shrine_mvc/src/view.dart'
    show
        AsymmetricView,
        Backdrop,
        CategoryMenuPage,
        ExpandingBottomSheet,
        SetState,
        ShrineApp;
import 'package:shrine_mvc/src/view.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({this.category = Category.all});

  final Category category;

  @override
  Widget build(BuildContext context) {
    AppStateModel().loadProducts();
    return AsymmetricView(products: AppStateModel().getProducts());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    this.expandingBottomSheet,
    this.backdrop,
    Key key,
  }) : super(key: key);

  final ExpandingBottomSheet expandingBottomSheet;
  final Backdrop backdrop;

  @override
  Widget build(BuildContext context) {
    Widget child = expandingBottomSheet ??
        ExpandingBottomSheet(hideController: ShrineApp.aniController);

    return SetState(builder: (context, _) {
      return Stack(
        children: <Widget>[
          Backdrop(
            frontLayer: ProductPage(),
            backLayer: CategoryMenuPage(
                onCategoryTap: () => ShrineApp.aniController.forward()),
            frontTitle: I10n.t('Shrine'),
            backTitle: I10n.t('Menu'),
            controller: ShrineApp.aniController,
          ),
          Align(child: child, alignment: Alignment.bottomRight),
        ],
      );
    });
  }
}
