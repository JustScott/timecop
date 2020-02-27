// Copyright 2020 Kenton Hamaluik
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timecop/blocs/timers/bloc.dart';
import 'package:timecop/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:timecop/screens/dashboard/components/ProjectSelectField.dart';
import 'package:timecop/screens/dashboard/components/RunningTimers.dart';
import 'package:timecop/screens/dashboard/components/StartTimerButton.dart';
import 'package:timecop/screens/dashboard/components/StoppedTimerRow.dart';

import 'components/DescriptionField.dart';
import 'components/PopupMenu.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(FontAwesomeIcons.hourglassHalf),
        title: Text("Time Cop"),
        actions: <Widget>[
          PopupMenu(),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: BlocBuilder<TimersBloc, TimersState>(
              builder: (BuildContext context, TimersState timersState) => ListView(
                children: <Widget>[
                  Text(
                    "Stopped Timers",
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.w800
                    )
                  ),
                  Divider(),
                ].followedBy(
                  timersState.timers.where((timer) => timer.endTime != null)
                  .map((timer) => StoppedTimerRow(timer: timer))
                ).toList(),
              ),
            )
          ),
          RunningTimers(),
          BlocProvider<DashboardBloc>(
            create: (_) => DashboardBloc(),
            child: Material(
              elevation: 4.0,
              child: Container(
                //color: Theme.of(context).primaryColor,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ProjectSelectField(),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(4.0, 0, 4.0, 0),
                          child: DescriptionField(),
                        ),
                      ),
                      StartTimerButton(),
                    ],
                  ),
                ),
              ),
            )
          )
        ],
      )
    );
  }
}