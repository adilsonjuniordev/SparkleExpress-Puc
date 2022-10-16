import 'package:gsheets/gsheets.dart';
import 'package:sparkle_express/app/env/env.dart';

import '../models/recibo_fields.dart';

final _credentials = Env.i['google_cloud_key']!;
final _spreadsheetId = Env.i['sheet_id_data']!;
final _gsheets = GSheets(_credentials);
late final Worksheet? _userSheet;

class RecibosSheetsApi {
  static Future init() async {
    print(_credentials);
    print(_spreadsheetId);
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _userSheet = await _getWorkSheet(spreadsheet, title: 'recibos');

      final firstRow = ReciboFields.getFields();
      _userSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      throw Exception();
    }
  }

  static Future<Worksheet> _getWorkSheet(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future insert(List<Map<String, dynamic>> recibo) async {
    if (_userSheet == null) return;
    _userSheet!.values.map.appendRows(recibo);
  }

  static Future<bool> verify(String idRecibo) async {
    if (_userSheet == null) return false;

    var colunaA = await _userSheet!.values.column(1);
    if (colunaA.contains(idRecibo)) {
      return true;
    }
    return false;
  }
}
