import 'package:gsheets/gsheets.dart';

class RecibosSheetsApi {
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "taxi-effe7",
  "private_key_id": "03c662d00e65fec5d711a0d5c61a0f0489057117",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC9edrtCc/ZQ3aV\n3hqLxtHzltUWJVvy0ug8A50rBoTdu8g2stlJlaIE+VKGrsZQpOltiKYGnyVjgaG1\nV99S9hVwQXel+hp+UXO6a/b/0mrQHq+DbFQkddrjhJiR8JFsmNZs6/4Ks561E7Id\n3gdM1s4HCof/z2SN8qvowguB+fmHlQ7Jr26Jqv5UM4TFFHjY0uEXqd1gSdbwdxQM\ns9FAEt8Vio00W/BwUPCihDaPL9we0URSfQp77QFG65K/pujQVBwPau5r30ugW8yi\nA+E2Bu+PLTdbJ47POZtyDbmTWVYqEr5yzjtJQ9vnhXXBEOuA9iQHs3cWjUJ6dAOw\nrEBxumNdAgMBAAECggEAGzeT0RTlvGnKcQC0g3uN0RXLiiDXsmvFXEmQnAuVrlw5\nCFJsj/tkiJ5f0mTsq8zkkw1b+/uEXWTTm78Bn2Ml9TgSPc9NWvPMUe0MT/cjzL17\nrL803v/m72OuntgVq6nQs1i650Kh+5TWsx+foNQCSFSk8IQUB6fiNc8Z5BPKWkU5\nqFvQ2vKtLIEWW3QCd173JnBe3SwwyAkMs2hyvbm3pNls+AlloYO8r2kP9BGTAEq+\nue4w+IgFOxpM4vFSxOXpDLaUjuecgEQcE8+8QsEgOtZvBvwtYmHdHSA7VWCymWnM\nCTBxwjqa7F+rB4K10K04ZziHQwL50sIegmpvkyTbKQKBgQDsuelbgmfZbURtjjJM\nkvfkIAv/qt/aeYJHEs8pTcop225/3v1apPmJXXWtyc5haSgaovDRHzNh2n6RCbEV\nurm9o6FcS1BXDsM44T5xLUmgHAxxoL3zyNV6U6bf8Jp5UGDPngEwWY8vvDJBuszn\nGULCIsN3RMCU31bYpxXLnvfNpwKBgQDM5xtEEJNAxULgtC5tAqYAPyYR/K/SCV7x\nurfyICybYLIAkS9wyUq5zFMGX9paTG2+lEZd1hcQ9AaKrZQ1I2YasTIDicr14JqU\nhD5WkVJ3pIw+s2sQYIfuBbpSYrsqPXwM4WfbYjwsfwK6AI/n0GwNM5w65XsvAADo\nIHV/fpyPWwKBgQCUafpj5N428spz5TKjz4CbBXyATiEKWCPVa3V1789PbsNYZ/Vv\nXv8ToASncF5zs/nwuTdB5M3SC6pOREVB2k+ZFX2U36L+8cJzZsQ/MKV4PB2RH7X3\noXI1vzxgKfivFjWb9PPJ3FxpERRxISxVtwCjtifWHsSekWdhbV+8yW2TAQKBgCVf\nDVEHuOO6Vq1HD6SgNAide+MR9DtZrDBofr4xchFQvIZv9Hgcrn1er9Hcz6VihS2a\nO49HyeM0rrDCYeKjNy8tHFMa4aKguXDXAcumK6VYpJ+W97L/+CrIbqgyC7LzjdmH\njvqrWxA+hg/IpHaCRALQY/E2A5aZ6JBtwyBixkk7AoGBANFQ7PWueuAqBn70/boW\nwxdCba2SHnOWpTqazUAD3qG7jKJasVwKwBOIfkNvRdoDPmeC6Cu3bLMcI/HGE8V2\n1oLGiZDtalHe/8/blk5PR9SxfGsiPc1EacHVeYaxs86TJqYZpfpNyKufmiQ6t5kU\nFAYSCnbpV/gNqbWkbv9i6n5S\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@taxi-effe7.iam.gserviceaccount.com",
  "client_id": "112112384537313370927",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40taxi-effe7.iam.gserviceaccount.com"
}

''';
  static const _spreadsheetId = "1QV-7fV8tALGDs2LUQ2vX0GkE1AKOKCkXjhgXq1LlEPs";
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _userSheet;

  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _userSheet = await _getWorkSheet(spreadsheet, title: 'recibos');
/* 
      final firstRow = ReciboFields.getFields();
      _userSheet!.values.insertRow(1, firstRow); */
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
