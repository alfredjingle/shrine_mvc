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

import 'package:scoped_model/scoped_model.dart';

import 'package:shrine_mvc/src/model.dart' show AppStateModel, Category, I18n;

import 'package:shrine_mvc/src/view.dart'
    show SetState, kShrineBrown900, kShrinePink100, kShrinePink400;

class CategoryMenuPage extends StatelessWidget {
  const CategoryMenuPage({
    Key key,
    this.onCategoryTap,
  }) : super(key: key);

  final VoidCallback onCategoryTap;

  Widget _buildCategory(Category category, BuildContext context) {
    final String categoryString =
        category.toString().replaceAll('Category.', '').toUpperCase();
    final ThemeData theme = Theme.of(context);
    return GestureDetector(
              onTap: () {
                AppStateModel().setCategory(category);
                if (onCategoryTap != null) {
                  onCategoryTap();
                }
              },
              child: AppStateModel().selectedCategory == category
                  ? Column(
                      children: <Widget>[
                        const SizedBox(height: 16.0),
                        I18n.t(
                          categoryString,
                          style: theme.textTheme.body2,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 14.0),
                        Container(
                          width: 70.0,
                          height: 2.0,
                          color: kShrinePink400,
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: I18n.t(
                        categoryString,
                        style: theme.textTheme.body2
                            .copyWith(color: kShrineBrown900.withAlpha(153)),
                        textAlign: TextAlign.center,
                      ),
                    ),
            );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(top: 40.0),
        color: kShrinePink100,
        child: ListView(
          children: Category.values
              .map((Category c) => _buildCategory(c, context))
              .toList(),
        ),
      ),
    );
  }
}
