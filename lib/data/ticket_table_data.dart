import 'package:pluto_grid/pluto_grid.dart';

final List<PlutoColumn> columns = <PlutoColumn>[
  PlutoColumn(
    title: 'Nr.',
    field: 'nr.',
    type: PlutoColumnType.number(),
    readOnly: true,
    enableRowChecked: true,
    frozen: PlutoColumnFrozen.start,
    width: 70,
  ),
  PlutoColumn(
    title: 'Ticketnr.',
    field: 'ticketnr.',
    type: PlutoColumnType.text(),
  ),
  PlutoColumn(
      title: 'Name',
      field: 'name',
      type: PlutoColumnType.text()
  ),
  PlutoColumn(
      title: 'Typ',
      field: 'typ',
      type: PlutoColumnType.text()
  ),
  PlutoColumn(
    title: 'Beschreibung',
    field: 'beschreibung',
    type: PlutoColumnType.text(),
  ),
  PlutoColumn(
    title: 'Status',
    field: 'status',
    type: PlutoColumnType.select(
        <String>[
          'offen', 'erledigt', "in Arbeit"
        ]
    ),
  ),
  PlutoColumn(
    title: 'Priorität',
    field: 'priorität',
    type: PlutoColumnType.select(
        <String>[
          'niedrig', 'mittel', 'hoch'
        ]
    ),
  ),
  PlutoColumn(
    title: 'Ext. Verantwortliche',
    field: 'ext. Verantwortliche',
    type: PlutoColumnType.text(),
  ),
  PlutoColumn(
    title: 'Von',
    field: 'von',
    type: PlutoColumnType.date(format: 'dd.MM.yyyy'),
  ),
  PlutoColumn(
    title: 'Bis',
    field: 'bis',
    type: PlutoColumnType.date(format: 'dd.MM.yyyy'),
  ),
  PlutoColumn(
      title: 'Projekt',
      field: 'projekt',
      type: PlutoColumnType.text()
  ),
  PlutoColumn(
      title: 'Gebäude',
      field: 'gebäude',
      type: PlutoColumnType.text()
  ),
  PlutoColumn(
    title: 'Stockwerk',
    field: 'stockwerk',
    type: PlutoColumnType.text(),
  ),
  PlutoColumn(
    title: 'Raumnummer',
    field: 'raumnummer',
    type: PlutoColumnType.text(),
  ),
  PlutoColumn(
      title: 'Gewerk',
      field: 'gewerk',
      type: PlutoColumnType.text()
  ),
  PlutoColumn(
    title: 'Angelegt',
    field: 'angelegt',
    type: PlutoColumnType.date(format: 'dd.MM.yyyy'),
  ),
  PlutoColumn(
    title: 'Geändert',
    field: 'geändert',
    type: PlutoColumnType.date(format: 'dd.MM.yyyy'),
  ),
];

final List<PlutoRow> rows = [
  PlutoRow(
    cells: {
      'nr.': PlutoCell(value: 1),
      'ticketnr.': PlutoCell(value: '69325'),
      'name': PlutoCell(value: 'Max Mustermann'),
      'typ': PlutoCell(value: 'Brandschutzübung'),
      'beschreibung': PlutoCell(value: 'Details'),
      'status': PlutoCell(value: 'offen'),
      'priorität': PlutoCell(value: 'hoch'),
      'ext. Verantwortliche': PlutoCell(value: 'Elektro Strippe'),
      'von': PlutoCell(value: DateTime(2023, 2, 22)),
      'bis': PlutoCell(value: DateTime(2025, 3, 27)),
      'projekt': PlutoCell(value: 'Wohnhaus'),
      'gebäude': PlutoCell(value: 'Haus B'),
      'stockwerk': PlutoCell(value: '1.OG'),
      'raumnummer': PlutoCell(value: '1.12'),
      'gewerk': PlutoCell(value: 'Heizung'),
      'angelegt': PlutoCell(value: DateTime(2023, 2, 15)),
      'geändert': PlutoCell(value: DateTime(2025, 3, 15)),
    },
  ),
  PlutoRow(
    cells: {
      'nr.': PlutoCell(value: 2),
      'ticketnr.': PlutoCell(value: '34524'),
      'name': PlutoCell(value: 'Renate Müller'),
      'typ': PlutoCell(value: 'Inspektion'),
      'beschreibung': PlutoCell(value: 'Gibts nicht'),
      'status': PlutoCell(value: 'erledigt'),
      'priorität': PlutoCell(value: 'mittel'),
      'ext. Verantwortliche': PlutoCell(value: 'Maier GmbH'),
      'von': PlutoCell(value: DateTime(2023, 8, 7)),
      'bis': PlutoCell(value: DateTime(2025, 3, 26)),
      'projekt': PlutoCell(value: 'Hausbau'),
      'gebäude': PlutoCell(value: 'Haus A'),
      'stockwerk': PlutoCell(value: '4.OG'),
      'raumnummer': PlutoCell(value: '4.09'),
      'gewerk': PlutoCell(value: 'Bodenbelag'),
      'angelegt': PlutoCell(value: DateTime(2023, 6, 18)),
      'geändert': PlutoCell(value: DateTime(2025, 3, 25)),
    },
  ),
  PlutoRow(
    cells: {
      'nr.': PlutoCell(value: 3),
      'ticketnr.': PlutoCell(value: '45621'),
      'name': PlutoCell(value: 'Maiko Jackson'),
      'typ': PlutoCell(value: 'Mangel'),
      'beschreibung': PlutoCell(value: 'Keine Angabe'),
      'status': PlutoCell(value: 'in Arbeit'),
      'priorität': PlutoCell(value: 'hoch'),
      'ext. Verantwortliche': PlutoCell(value: 'Demmelhuber GmbH'),
      'von': PlutoCell(value: DateTime(2024, 1, 22)),
      'bis': PlutoCell(value: DateTime(2025, 7, 24)),
      'projekt': PlutoCell(value: 'Wohnhaus'),
      'gebäude': PlutoCell(value: 'Haus C'),
      'stockwerk': PlutoCell(value: '5.OG'),
      'raumnummer': PlutoCell(value: '5.01'),
      'gewerk': PlutoCell(value: 'Trockenbau'),
      'angelegt': PlutoCell(value: DateTime(2024, 1, 1)),
      'geändert': PlutoCell(value: DateTime(2025, 4, 1)),
    },
  ),
  ...List.generate(
    7,
        (index) => PlutoRow(
      cells: {
        'nr.': PlutoCell(value: index + 4),
        'ticketnr.': PlutoCell(value: ''),
        'name': PlutoCell(value: ''),
        'typ': PlutoCell(value: ''),
        'beschreibung': PlutoCell(value: ''),
        'status': PlutoCell(value: ''),
        'priorität': PlutoCell(value: ''),
        'ext. Verantwortliche': PlutoCell(value: ''),
        'von': PlutoCell(value: null),
        'bis': PlutoCell(value: null),
        'projekt': PlutoCell(value: ''),
        'gebäude': PlutoCell(value: ''),
        'stockwerk': PlutoCell(value: ''),
        'raumnummer': PlutoCell(value: ''),
        'gewerk': PlutoCell(value: ''),
        'angelegt': PlutoCell(value: null),
        'geändert': PlutoCell(value: null),
      },
    ),
  ),
];