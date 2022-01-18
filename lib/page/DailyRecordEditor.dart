import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:headache_app/persistence/dailyRecord/DailyRecordDb.dart';
import 'package:headache_app/persistence/dailyRecord/DailyRecord.dart';
import 'package:headache_app/component/LabeledCheckbox.dart';
import 'package:headache_app/component/PainScaleSelector.dart';
import 'package:headache_app/component/MedicineUsageEditor.dart';

class DailyRecordEditor extends StatefulWidget {
  DateTime dateTime;

  DailyRecordEditor(this.dateTime);

  @override
  _DailyRecordEditorState createState() => _DailyRecordEditorState(dateTime);
}

class _DailyRecordEditorState extends State<DailyRecordEditor> {
  DailyRecordDb _dailyRecordDb = DailyRecordDb();
  DateTime _dateTime;
  late DailyRecord _dailyRecord;

  _DailyRecordEditorState(this._dateTime) {
    final date = DailyRecord.getDate(_dateTime);
    _dailyRecord = DailyRecord(date);
  }

  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    refreshDataList();
  }

  refreshDataList() {
    setState(() {
      getAllData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DateFormat('yyyy年MM月dd日').format(_dateTime)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ExpansionTile(
              title: const Text('頭痛情形'),
              children: <Widget>[
                Column(
                  children: <Widget>[
                    PainScaleSelector(
                      label: '早上',
                      value: _dailyRecord.morningPainScale,
                      onChanged: (int newValue) {
                        setState(() {
                          _dailyRecord.morningPainScale = newValue;
                        });
                      }
                    ),
                    PainScaleSelector(
                      label: '下午',
                      value: _dailyRecord.afternoonPainScale,
                      onChanged: (int newValue) {
                        setState(() {
                          _dailyRecord.afternoonPainScale = newValue;
                        });
                      }
                    ),
                    PainScaleSelector(
                      label: '晚上',
                      value: _dailyRecord.nightPainScale,
                      onChanged: (int newValue) {
                        setState(() {
                          _dailyRecord.nightPainScale = newValue;
                        });
                      }
                    ),
                    PainScaleSelector(
                      label: '睡眠',
                      value: _dailyRecord.sleepingPainScale,
                      onChanged: (int newValue) {
                        setState(() {
                          _dailyRecord.sleepingPainScale = newValue;
                        });
                      }
                    ),
                    Row(
                      children: <Widget>[
                        Text('當日頭痛幾小時？'),
                        DropdownButton<int>(
                          value: _dailyRecord.headacheHours,
                          items: List.generate(24, (index) => index, growable: true).map((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString().padLeft(2, '0')),
                            );
                          }).toList(),
                          onChanged: (int? newValue) {
                            setState(() {
                              _dailyRecord.headacheHours = newValue ?? _dailyRecord.headacheHours;
                            });
                          },
                        ),
                        Text('小時'),
                        DropdownButton<int>(
                          value: _dailyRecord.headacheMinutes,
                          items: List.generate(13, (index) => index * 5, growable: true).map((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value.toString().padLeft(2, '0')),
                            );
                          }).toList(),
                          onChanged: (int? newValue) {
                            setState(() {
                              _dailyRecord.headacheMinutes = newValue ?? _dailyRecord.headacheMinutes;
                            });
                          },
                        ),
                        Text('分')
                      ]
                    )
                  ]
                )
              ]
            ),
            ExpansionTile(
                title: const Text('可能伴隨症狀及預兆'),
                children: <Widget>[
                  ListTile(title: Text('是否伴隨下列症狀：')),
                  LabeledCheckbox(
                    label: '有噁心的感覺嗎？',
                    value: _dailyRecord.disgusted,
                    onChanged: (bool newValue) {
                      setState(() {
                        _dailyRecord.disgusted = newValue;
                      });
                    }
                  ),
                  LabeledCheckbox(
                    label: '有嘔吐嗎？',
                    value: _dailyRecord.vomited,
                    onChanged: (bool newValue) {
                      setState(() {
                        _dailyRecord.vomited = newValue;
                      });
                    }
                  ),
                  LabeledCheckbox(
                    label: '有頭暈嗎？',
                    value: _dailyRecord.dizzy,
                    onChanged: (bool newValue) {
                      setState(() {
                        _dailyRecord.dizzy = newValue;
                      });
                    }
                  ),
                  LabeledCheckbox(
                    label: '對光線敏感嗎？',
                    value: _dailyRecord.sensitiveToLight,
                    onChanged: (bool newValue) {
                      setState(() {
                        _dailyRecord.sensitiveToLight = newValue;
                      });
                    }
                  ),
                  LabeledCheckbox(
                    label: '對聲音敏感嗎？',
                    value: _dailyRecord.sensitiveToSound,
                    onChanged: (bool newValue) {
                      setState(() {
                        _dailyRecord.sensitiveToSound = newValue;
                      });
                    }
                  ),
                  LabeledCheckbox(
                    label: '對氣味敏感嗎？',
                    value: _dailyRecord.sensitiveToSmell,
                    onChanged: (bool newValue) {
                      setState(() {
                        _dailyRecord.sensitiveToSmell = newValue;
                      });
                    }
                  ),
                  LabeledCheckbox(
                    label: '頭痛感覺像脈搏般一下一下的跳動嗎？',
                    value: _dailyRecord.headacheLikeBeating,
                    onChanged: (bool newValue) {
                      setState(() {
                        _dailyRecord.headacheLikeBeating = newValue;
                      });
                    }
                  ),
                  LabeledCheckbox(
                    label: '頭痛由單側開始嗎？',
                    value: _dailyRecord.headacheStartFromOneSide,
                    onChanged: (bool newValue) {
                      setState(() {
                        _dailyRecord.headacheStartFromOneSide = newValue;
                      });
                    }
                  ),
                  LabeledCheckbox(
                    label: '痛點會亂跑嗎？',
                    value: _dailyRecord.painPointRunningAround,
                    onChanged: (bool newValue) {
                      setState(() {
                        _dailyRecord.painPointRunningAround = newValue;
                      });
                    }
                  ),
                  LabeledCheckbox(
                    label: '身體活動會加重頭痛嗎？',
                    value: _dailyRecord.physicalActivityAggravateHeadache,
                    onChanged: (bool newValue) {
                      setState(() {
                        _dailyRecord.physicalActivityAggravateHeadache = newValue;
                      });
                    }
                  ),
                  ListTile(title: Text('頭痛前會有何預兆出現嗎？')),
                  LabeledCheckbox(
                    label: '眼前出現閃光？',
                    value: _dailyRecord.eyeFlashes,
                    onChanged: (bool newValue) {
                      setState(() {
                        _dailyRecord.eyeFlashes = newValue;
                      });
                    }
                  ),
                  LabeledCheckbox(
                    label: '部分視野看不見？',
                    value: _dailyRecord.partialBlindness,
                    onChanged: (bool newValue) {
                      setState(() {
                        _dailyRecord.partialBlindness = newValue;
                      });
                    }
                  )
                ]
            ),
            ExpansionTile(
                title: const Text('用藥紀錄'),
                children: <Widget>[
                  MedicineUsageEditor(
                      value: _dailyRecord.medicineUsage,
                      onChanged: (String newValue) {
                        setState(() {
                          _dailyRecord.medicineUsage = newValue;
                        });
                      }
                  )
                ]
            ),
            ExpansionTile(
                title: const Text('日常活動記錄'),
                children: <Widget>[
                  PainScaleSelector(
                    label: '壓力程度',
                    value: _dailyRecord.dailyStressScale,
                    onChanged: (int newValue) {
                      setState(() {
                        _dailyRecord.dailyStressScale = newValue;
                      });
                    }
                  ),
                  LabeledCheckbox(
                    label: '是否有月經？',
                    value: _dailyRecord.hasMenstruation,
                    onChanged: (bool newValue) {
                      setState(() {
                        _dailyRecord.hasMenstruation = newValue;
                      });
                    }
                  ),
                  LabeledCheckbox(
                    label: '是否有不寧腿？',
                    value: _dailyRecord.hasRestlessLegSyndrome,
                    onChanged: (bool newValue) {
                      setState(() {
                        _dailyRecord.hasRestlessLegSyndrome = newValue;
                      });
                    }
                  ),
                  Row(
                    children: <Widget>[
                      const Text('舒張壓'),
                      Flexible(
                        child: TextFormField(
                          initialValue: _dailyRecord.diastolicBloodPressure,
                          keyboardType: const TextInputType.numberWithOptions(),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^\d{0,3}')),
                          ],
                          onChanged: (text) {
                            setState(() {
                              _dailyRecord.diastolicBloodPressure = text;
                            });
                          }
                        )
                      ),
                      const Text('mmHg')
                    ]
                  ),
                  Row(
                    children: <Widget>[
                      const Text('收縮壓'),
                      Flexible(
                        child: TextFormField(
                          initialValue: _dailyRecord.systolicBloodPressure,
                          keyboardType: const TextInputType.numberWithOptions(),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^\d{0,3}')),
                          ],
                          onChanged: (text) {
                            setState(() {
                              _dailyRecord.systolicBloodPressure = text;
                            });
                          }
                        )
                      ),
                      const Text('mmHg')
                    ]
                  )
                ]
            ),
            Row(
              children: <Widget>[
                RaisedButton(
                  child: Text('確定'),
                  onPressed: () {
                    _dailyRecordDb.save(_dailyRecord);
                  }
                ),
                RaisedButton(
                  child: Text('取消'),
                  onPressed: () {
                    Navigator.pop(context);
                  }
                )
              ]
            )
          ]
        )
      )
    );
  }

  void getAllData() async {
    final date = DailyRecord.getDate(_dateTime);
    DailyRecord? dailyRecord = await _dailyRecordDb.findOneByDate(date);
    if (null != dailyRecord) {
      setState(() {
        _dailyRecord = dailyRecord;
      });
    }
  }
}