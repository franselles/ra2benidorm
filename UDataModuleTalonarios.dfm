object DataModuleTalonarios: TDataModuleTalonarios
  OldCreateOrder = False
  Height = 614
  Width = 906
  object fdqCobradores: TFDQuery
    AfterScroll = fdqCobradoresAfterScroll
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT empleados.id, empleados.nombre, empleados.estado_id'
      'FROM empleados'
      'WHERE empleados.estado_id < :E'
      'ORDER BY empleados.nombre;')
    Left = 56
    Top = 24
    ParamData = <
      item
        Name = 'E'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object fdqCobradoresid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object fdqCobradoresnombre: TWideStringField
      FieldName = 'nombre'
      Origin = 'nombre'
      Size = 255
    end
    object fdqCobradoresestado_id: TIntegerField
      FieldName = 'estado_id'
      Origin = 'estado_id'
    end
  end
  object dsCobradores: TDataSource
    AutoEdit = False
    DataSet = fdqCobradores
    Left = 56
    Top = 80
  end
  object fdqTickets: TFDQuery
    BeforePost = fdqTicketsBeforePost
    AfterPost = fdqTicketsAfterPost
    BeforeDelete = fdqTicketsBeforeDelete
    OnCalcFields = fdqTicketsCalcFields
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT'
      ' tickets.id, tickets.fecha, tickets.empleados_id,'
      ' tickets.sectores_id, tickets.tipos_id, tickets.letra,'
      ' tickets.desde, tickets.hasta, tickets.real,'
      
        ' tickets.orden, tickets.facturado, tickets.referencia_id, ticket' +
        's.precio'
      'FROM tickets'
      
        'WHERE (tickets.empleados_id = :EM) AND (tickets.fecha = :FE) AND' +
        ' (tickets.facturado = :FA)'
      
        'ORDER BY tickets.empleados_id ASC, tickets.fecha ASC, tickets.ti' +
        'pos_id ASC, tickets.orden ASC;')
    Left = 184
    Top = 24
    ParamData = <
      item
        Name = 'EM'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'FE'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'FA'
        DataType = ftBoolean
        ParamType = ptInput
        Value = Null
      end>
    object fdqTicketsid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object fdqTicketsfecha: TSQLTimeStampField
      FieldName = 'fecha'
      Origin = 'fecha'
    end
    object fdqTicketsempleados_id: TIntegerField
      FieldName = 'empleados_id'
      Origin = 'empleados_id'
    end
    object fdqTicketssectores_id: TIntegerField
      FieldName = 'sectores_id'
      Origin = 'sectores_id'
    end
    object fdqTicketstipos_id: TIntegerField
      FieldName = 'tipos_id'
      Origin = 'tipos_id'
    end
    object fdqTicketsletra: TWideStringField
      FieldName = 'letra'
      Origin = 'letra'
      Size = 1
    end
    object fdqTicketsdesde: TIntegerField
      FieldName = 'desde'
      Origin = 'desde'
    end
    object fdqTicketshasta: TIntegerField
      FieldName = 'hasta'
      Origin = 'hasta'
    end
    object fdqTicketsreal: TIntegerField
      FieldName = 'real'
      Origin = '[real]'
    end
    object fdqTicketsorden: TIntegerField
      FieldName = 'orden'
      Origin = 'orden'
    end
    object fdqTicketsfacturado: TBooleanField
      FieldName = 'facturado'
      Origin = 'facturado'
      Required = True
    end
    object fdqTicketsreferencia_id: TIntegerField
      FieldName = 'referencia_id'
      Origin = 'referencia_id'
    end
    object fdqTicketscantidad: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'cantidad'
      Calculated = True
    end
    object fdqTicketsnomcobrador: TStringField
      FieldKind = fkLookup
      FieldName = 'nomcobrador'
      LookupDataSet = fdqNombres
      LookupKeyFields = 'id'
      LookupResultField = 'nombre'
      KeyFields = 'empleados_id'
      Size = 100
      Lookup = True
    end
    object fdqTicketsnomsector: TStringField
      FieldKind = fkLookup
      FieldName = 'nomsector'
      LookupDataSet = fdqSectores
      LookupKeyFields = 'id'
      LookupResultField = 'sector'
      KeyFields = 'sectores_id'
      Size = 100
      Lookup = True
    end
    object fdqTicketsnomplaya: TStringField
      FieldKind = fkLookup
      FieldName = 'nomplaya'
      LookupDataSet = fdqSectores
      LookupKeyFields = 'id'
      LookupResultField = 'playa'
      KeyFields = 'sectores_id'
      Size = 100
      Lookup = True
    end
    object fdqTicketsnomtipo: TStringField
      FieldKind = fkLookup
      FieldName = 'nomtipo'
      LookupDataSet = fdqTipos
      LookupKeyFields = 'id'
      LookupResultField = 'nombre'
      KeyFields = 'tipos_id'
      Size = 100
      Lookup = True
    end
    object fdqTicketsprecio: TCurrencyField
      FieldName = 'precio'
      Origin = 'precio'
    end
    object fdqTicketsimporte: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'importe'
      Calculated = True
    end
  end
  object dsTickets: TDataSource
    DataSet = fdqTickets
    Left = 184
    Top = 80
  end
  object fdqTotalTickets: TFDQuery
    Connection = DataModulePrincipal.FDConnection1
    Left = 296
    Top = 24
  end
  object fdqTipos: TFDQuery
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT'
      'tipos.id, tipos.nombre, tipos.precio, tipos.letra'
      'FROM'
      'tipos;')
    Left = 400
    Top = 24
    object fdqTiposid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object fdqTiposnombre: TWideStringField
      FieldName = 'nombre'
      Origin = 'nombre'
      Size = 255
    end
    object fdqTiposprecio: TCurrencyField
      FieldName = 'precio'
      Origin = 'precio'
    end
    object fdqTiposletra: TWideStringField
      FieldName = 'letra'
      Origin = 'letra'
      Size = 1
    end
  end
  object dsTotalTickets: TDataSource
    AutoEdit = False
    DataSet = fdqTotalTickets
    Left = 296
    Top = 80
  end
  object fdqSectores: TFDQuery
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT'
      'sectores.id, sectores.playas_id, sectores.sector'
      'FROM sectores'
      'ORDER BY sectores.id ASC;')
    Left = 480
    Top = 24
    object fdqSectoresid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      IdentityInsert = True
    end
    object fdqSectoresplayas_id: TIntegerField
      FieldName = 'playas_id'
      Origin = 'playas_id'
    end
    object fdqSectoressector: TWideStringField
      FieldName = 'sector'
      Origin = 'sector'
      Size = 255
    end
    object fdqSectoresplaya: TStringField
      FieldKind = fkLookup
      FieldName = 'playa'
      LookupDataSet = fdqPlayas
      LookupKeyFields = 'id'
      LookupResultField = 'playa'
      KeyFields = 'playas_id'
      Size = 100
      Lookup = True
    end
  end
  object fdqPlayas: TFDQuery
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT playas.id, playas.playa'
      'FROM playas;')
    Left = 560
    Top = 24
    object fdqPlayasid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object fdqPlayasplaya: TWideStringField
      FieldName = 'playa'
      Origin = 'playa'
      Size = 255
    end
  end
  object fdqNombres: TFDQuery
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT empleados.id, empleados.nombre, empleados.estado_id'
      'FROM empleados;')
    Left = 648
    Top = 24
    object fdqNombresid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object fdqNombresnombre: TWideStringField
      FieldName = 'nombre'
      Origin = 'nombre'
      Size = 255
    end
    object fdqNombresestado_id: TIntegerField
      FieldName = 'estado_id'
      Origin = 'estado_id'
    end
  end
  object fdqTickets2: TFDQuery
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT'
      ' tickets.id, tickets.fecha, tickets.empleados_id,'
      ' tickets.sectores_id, tickets.tipos_id, tickets.letra,'
      ' tickets.desde, tickets.hasta, tickets.real,'
      
        ' tickets.orden, tickets.facturado, tickets.referencia_id, ticket' +
        's.precio'
      'FROM tickets;')
    Left = 184
    Top = 144
  end
  object fdqSumaTickets: TFDQuery
    OnCalcFields = fdqSumaTicketsCalcFields
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT'
      'tickets.fecha,'
      'tickets.empleados_id,'
      'tickets.tipos_id,'
      'tickets.precio,'
      'Sum(tickets.desde) AS SD,'
      'Sum(tickets.real) AS SR,'
      
        'Sum(IIf(([tickets].[real]-[tickets].[desde])>=0,([tickets].[real' +
        ']-[tickets].[desde])+1,0)) AS diferencia'
      'FROM'
      'tickets'
      'WHERE'
      
        '(tickets.empleados_id = :EM) AND ((tickets.fecha = :FE) AND (tic' +
        'kets.facturado = :FA))'
      'GROUP BY'
      'tickets.fecha,'
      'tickets.empleados_id,'
      'tickets.tipos_id,'
      'tickets.precio;')
    Left = 184
    Top = 216
    ParamData = <
      item
        Name = 'EM'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'FE'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'FA'
        DataType = ftBoolean
        ParamType = ptInput
        Value = Null
      end>
    object fdqSumaTicketsfecha: TSQLTimeStampField
      FieldName = 'fecha'
      Origin = 'fecha'
    end
    object fdqSumaTicketsempleados_id: TIntegerField
      FieldName = 'empleados_id'
      Origin = 'empleados_id'
    end
    object fdqSumaTicketstipos_id: TIntegerField
      FieldName = 'tipos_id'
      Origin = 'tipos_id'
    end
    object fdqSumaTicketsSD: TFloatField
      AutoGenerateValue = arDefault
      FieldName = 'SD'
      Origin = 'SD'
      ProviderFlags = []
      ReadOnly = True
    end
    object fdqSumaTicketsSR: TFloatField
      AutoGenerateValue = arDefault
      FieldName = 'SR'
      Origin = 'SR'
      ProviderFlags = []
      ReadOnly = True
    end
    object fdqSumaTicketscantidad: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'cantidad'
      Calculated = True
    end
    object fdqSumaTicketsdiferencia: TFloatField
      AutoGenerateValue = arDefault
      FieldName = 'diferencia'
      Origin = 'diferencia'
      ProviderFlags = []
      ReadOnly = True
    end
    object fdqSumaTicketsnomtipo: TStringField
      FieldKind = fkLookup
      FieldName = 'nomtipo'
      LookupDataSet = fdqTipos
      LookupKeyFields = 'id'
      LookupResultField = 'nombre'
      KeyFields = 'tipos_id'
      Size = 100
      Lookup = True
    end
    object fdqSumaTicketsprecio: TCurrencyField
      FieldName = 'precio'
      Origin = 'precio'
    end
    object fdqSumaTicketsimporte: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'importe'
      Calculated = True
    end
  end
  object dsSumaTickets: TDataSource
    AutoEdit = False
    DataSet = fdqSumaTickets
    Left = 184
    Top = 272
  end
  object dsTotal: TDataSource
    DataSet = cdsTotal
    Left = 184
    Top = 392
  end
  object fdqTalonarios: TFDQuery
    AfterScroll = fdqTalonariosAfterScroll
    OnCalcFields = fdqTalonariosCalcFields
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      
        'SELECT TOP 1 tickets.empleados_id, tickets.fecha, tickets.sector' +
        'es_id, tickets.facturado'
      'FROM tickets'
      'WHERE (tickets.empleados_id = :EM)'
      
        'GROUP BY tickets.empleados_id, tickets.fecha, tickets.sectores_i' +
        'd, tickets.facturado'
      'ORDER BY tickets.fecha DESC;')
    Left = 56
    Top = 144
    ParamData = <
      item
        Name = 'EM'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object fdqTalonariosempleados_id: TIntegerField
      FieldName = 'empleados_id'
      Origin = 'empleados_id'
    end
    object fdqTalonariosfecha: TSQLTimeStampField
      FieldName = 'fecha'
      Origin = 'fecha'
    end
    object fdqTalonariossectores_id: TIntegerField
      FieldName = 'sectores_id'
      Origin = 'sectores_id'
    end
    object fdqTalonariosfacturado: TBooleanField
      FieldName = 'facturado'
      Origin = 'facturado'
      Required = True
    end
    object fdqTalonariosestado: TStringField
      FieldKind = fkCalculated
      FieldName = 'estado'
      Size = 100
      Calculated = True
    end
    object fdqTalonariosnomempleado: TStringField
      FieldKind = fkLookup
      FieldName = 'nomempleado'
      LookupDataSet = fdqNombres
      LookupKeyFields = 'id'
      LookupResultField = 'nombre'
      KeyFields = 'empleados_id'
      Size = 100
      Lookup = True
    end
  end
  object fdqCheckNumeros: TFDQuery
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT'
      'tickets.id, tickets.tipos_id,'
      'tickets.letra, tickets.desde, tickets.real, tickets.hasta'
      'FROM'
      'tickets'
      'WHERE'
      '(tickets.tipos_id = :T) AND'
      '(tickets.letra = :L) AND'
      '(((tickets.desde >= :N1) AND'
      '(tickets.desde <= :N2)) OR'
      '((tickets.hasta >= :N3) AND'
      '(tickets.hasta <= :N4)));')
    Left = 56
    Top = 248
    ParamData = <
      item
        Name = 'T'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'L'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'N1'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'N2'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'N3'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'N4'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object fdqCheckNumerostipos_id: TIntegerField
      FieldName = 'tipos_id'
      Origin = 'tipos_id'
    end
    object fdqCheckNumerosletra: TWideStringField
      FieldName = 'letra'
      Origin = 'letra'
      Size = 1
    end
    object fdqCheckNumerosdesde: TIntegerField
      FieldName = 'desde'
      Origin = 'desde'
    end
    object fdqCheckNumerosreal: TIntegerField
      FieldName = 'real'
      Origin = '[real]'
    end
    object fdqCheckNumerosid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
  end
  object fdqInforme: TFDQuery
    OnCalcFields = fdqInformeCalcFields
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT'
      'tickets.fecha, tickets.sectores_id, sectores.sector,'
      'tickets.empleados_id, tickets.facturado, empleados.nombre,'
      'sectores.playas_id, playas.playa, playas.orden_impresion'
      'FROM'
      
        '(playas INNER JOIN sectores ON playas.id = sectores.playas_id) I' +
        'NNER JOIN (empleados INNER JOIN tickets ON empleados.id = ticket' +
        's.empleados_id) ON sectores.id = tickets.sectores_id'
      'WHERE'
      
        '((tickets.facturado = False) AND ((tickets.tipos_id < 4) OR (tic' +
        'kets.tipos_id > 5)))'
      
        'GROUP BY tickets.fecha, tickets.sectores_id, sectores.sector, ti' +
        'ckets.empleados_id, tickets.facturado, empleados.nombre, sectore' +
        's.playas_id, playas.playa, playas.orden_impresion'
      
        'ORDER BY playas.orden_impresion, tickets.sectores_id, tickets.em' +
        'pleados_id;'
      ''
      ''
      ''
      '')
    Left = 576
    Top = 120
    object fdqInformenumeros: TStringField
      FieldKind = fkCalculated
      FieldName = 'numeros'
      Size = 2000
      Calculated = True
    end
    object fdqInformenumeros1: TStringField
      FieldKind = fkCalculated
      FieldName = 'numeros1'
      Size = 2000
      Calculated = True
    end
    object fdqInformefecha: TSQLTimeStampField
      FieldName = 'fecha'
      Origin = 'fecha'
    end
    object fdqInformesectores_id: TIntegerField
      FieldName = 'sectores_id'
      Origin = 'sectores_id'
    end
    object fdqInformeempleados_id: TIntegerField
      FieldName = 'empleados_id'
      Origin = 'empleados_id'
    end
    object fdqInformenombre: TWideStringField
      FieldName = 'nombre'
      Origin = 'nombre'
      Size = 255
    end
    object fdqInformeplayas_id: TIntegerField
      FieldName = 'playas_id'
      Origin = 'playas_id'
    end
    object fdqInformeplaya: TWideStringField
      FieldName = 'playa'
      Origin = 'playa'
      Size = 255
    end
    object fdqInformesector: TWideStringField
      FieldName = 'sector'
      Origin = 'sector'
      Size = 255
    end
    object fdqInformefeca: TDateTimeField
      FieldKind = fkCalculated
      FieldName = 'feca'
      Calculated = True
    end
    object fdqInformeorden_impresion: TIntegerField
      FieldName = 'orden_impresion'
      Origin = 'orden_impresion'
    end
    object fdqInformenumeros2: TStringField
      FieldKind = fkCalculated
      FieldName = 'numeros2'
      Size = 2000
      Calculated = True
    end
    object fdqInformenumeros3: TStringField
      FieldKind = fkCalculated
      FieldName = 'numeros3'
      Size = 2000
      Calculated = True
    end
  end
  object dsInforme: TDataSource
    AutoEdit = False
    DataSet = fdqInforme
    Left = 576
    Top = 176
  end
  object fdqInformeDetalle: TFDQuery
    MasterSource = dsInforme
    MasterFields = 'feca;sectores_id;empleados_id'
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT'
      'tickets.fecha, tickets.sectores_id,'
      'tickets.tipos_id, tickets.empleados_id,'
      'tickets.letra, tickets.real, tickets.orden, tickets.desde'
      'FROM'
      'tickets'
      'WHERE'
      
        '(tickets.fecha = :feca) AND (tickets.sectores_id = :sectores_id)' +
        ' AND (tickets.empleados_id = :empleados_id)'
      'ORDER BY'
      
        'tickets.empleados_id, tickets.sectores_id ASC, tickets.tipos_id ' +
        'ASC, tickets.orden ASC;')
    Left = 576
    Top = 232
    ParamData = <
      item
        Name = 'FECA'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'SECTORES_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'EMPLEADOS_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object fdqInformeDetallefecha: TSQLTimeStampField
      FieldName = 'fecha'
      Origin = 'fecha'
    end
    object fdqInformeDetallesectores_id: TIntegerField
      FieldName = 'sectores_id'
      Origin = 'sectores_id'
    end
    object fdqInformeDetalletipos_id: TIntegerField
      FieldName = 'tipos_id'
      Origin = 'tipos_id'
    end
    object fdqInformeDetalleempleados_id: TIntegerField
      FieldName = 'empleados_id'
      Origin = 'empleados_id'
    end
    object fdqInformeDetalleletra: TWideStringField
      FieldName = 'letra'
      Origin = 'letra'
      Size = 1
    end
    object fdqInformeDetallereal: TIntegerField
      FieldName = 'real'
      Origin = '[real]'
    end
    object fdqInformeDetalleorden: TIntegerField
      FieldName = 'orden'
      Origin = 'orden'
    end
    object fdqInformeDetalledesde: TIntegerField
      FieldName = 'desde'
      Origin = 'desde'
    end
  end
  object dsTalonarios: TDataSource
    AutoEdit = False
    DataSet = fdqTalonarios
    Left = 56
    Top = 200
  end
  object dsSectores: TDataSource
    DataSet = fdqSectores
    Left = 480
    Top = 88
  end
  object fdqInformeSectores: TFDQuery
    OnCalcFields = fdqInformeSectoresCalcFields
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT tickets.fecha, tickets.sectores_id, tickets.facturado'
      'FROM tickets'
      'WHERE'
      ' (tickets.sectores_id >= :SI) AND'
      ' (tickets.sectores_id <= :SF) AND'
      ' (tickets.fecha >= :FI) AND'
      ' (tickets.fecha <= :FF) AND'
      ' (tickets.facturado = True)'
      'GROUP BY tickets.fecha, tickets.sectores_id, tickets.facturado'
      'ORDER BY tickets.sectores_id;')
    Left = 674
    Top = 120
    ParamData = <
      item
        Name = 'SI'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'SF'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'FI'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'FF'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end>
    object fdqInformeSectoresfecha: TSQLTimeStampField
      FieldName = 'fecha'
      Origin = 'fecha'
    end
    object fdqInformeSectoressectores_id: TIntegerField
      FieldName = 'sectores_id'
      Origin = 'sectores_id'
    end
    object fdqInformeSectoreshamacas: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'hamacas'
      Calculated = True
    end
    object fdqInformeSectoressombrillas: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'sombrillas'
      Calculated = True
    end
    object fdqInformeSectorestotal: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'total'
      Calculated = True
    end
    object fdqInformeSectoresfeca: TDateField
      FieldKind = fkCalculated
      FieldName = 'feca'
      Calculated = True
    end
    object fdqInformeSectoresnomsector: TStringField
      FieldKind = fkLookup
      FieldName = 'nomsector'
      LookupDataSet = fdqSectores
      LookupKeyFields = 'id'
      LookupResultField = 'sector'
      KeyFields = 'sectores_id'
      Size = 100
      Lookup = True
    end
    object fdqInformeSectoresnomplaya: TStringField
      FieldKind = fkLookup
      FieldName = 'nomplaya'
      LookupDataSet = fdqSectores
      LookupKeyFields = 'id'
      LookupResultField = 'playa'
      KeyFields = 'sectores_id'
      Size = 100
      Lookup = True
    end
    object fdqInformeSectoresfacturado: TBooleanField
      FieldName = 'facturado'
      Origin = 'facturado'
      Required = True
    end
    object fdqInformeSectorestotaleuros: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'totaleuros'
      Calculated = True
    end
    object fdqInformeSectorestoldos: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'toldos'
      Calculated = True
    end
  end
  object dsInformeSectores: TDataSource
    AutoEdit = False
    DataSet = fdqInformeSectores
    Left = 674
    Top = 184
  end
  object fdqInformeSectoresDetalle: TFDQuery
    MasterSource = dsInformeSectores
    MasterFields = 'sectores_id;feca'
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT'
      'tickets.fecha,'
      'tickets.sectores_id,'
      'tickets.tipos_id,'
      'tickets.precio,'
      'Sum(tickets.desde) AS SD,'
      'Sum(tickets.real) AS SR,'
      'tickets.facturado,'
      
        'Sum(IIf(([tickets].[real]-[tickets].[desde])>=0,([tickets].[real' +
        ']-[tickets].[desde])+1,0)) AS diferencia'
      'FROM'
      'tickets'
      'WHERE'
      
        '(tickets.sectores_id = :sectores_id) AND (tickets.fecha = :feca)' +
        ' AND (tickets.facturado = True)'
      'GROUP BY'
      'tickets.fecha,'
      'tickets.sectores_id,'
      'tickets.tipos_id,'
      'tickets.precio,'
      'tickets.facturado;')
    Left = 674
    Top = 248
    ParamData = <
      item
        Name = 'SECTORES_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'FECA'
        DataType = ftDate
        ParamType = ptInput
        Value = Null
      end>
    object fdqInformeSectoresDetallefecha: TSQLTimeStampField
      FieldName = 'fecha'
      Origin = 'fecha'
    end
    object fdqInformeSectoresDetallesectores_id: TIntegerField
      FieldName = 'sectores_id'
      Origin = 'sectores_id'
    end
    object fdqInformeSectoresDetalletipos_id: TIntegerField
      FieldName = 'tipos_id'
      Origin = 'tipos_id'
    end
    object fdqInformeSectoresDetalleSD: TFloatField
      AutoGenerateValue = arDefault
      FieldName = 'SD'
      Origin = 'SD'
      ProviderFlags = []
      ReadOnly = True
    end
    object fdqInformeSectoresDetalleSR: TFloatField
      AutoGenerateValue = arDefault
      FieldName = 'SR'
      Origin = 'SR'
      ProviderFlags = []
      ReadOnly = True
    end
    object fdqInformeSectoresDetallediferencia: TFloatField
      AutoGenerateValue = arDefault
      FieldName = 'diferencia'
      Origin = 'diferencia'
      ProviderFlags = []
      ReadOnly = True
    end
    object fdqInformeSectoresDetallefacturado: TBooleanField
      FieldName = 'facturado'
      Origin = 'facturado'
      Required = True
    end
    object fdqInformeSectoresDetalleprecio: TCurrencyField
      FieldName = 'precio'
      Origin = 'precio'
    end
  end
  object fdqInformeEmpleado: TFDQuery
    OnCalcFields = fdqInformeEmpleadoCalcFields
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT tickets.fecha, tickets.empleados_id, tickets.facturado'
      'FROM tickets'
      'WHERE'
      ' (tickets.empleados_id >= :EI) AND'
      ' (tickets.empleados_id <= :EF) AND'
      ' (tickets.fecha >= :FI) AND'
      ' (tickets.fecha <= :FF) AND'
      ' (tickets.facturado = True)'
      'GROUP BY tickets.fecha, tickets.empleados_id, tickets.facturado'
      'ORDER BY tickets.empleados_id;')
    Left = 674
    Top = 304
    ParamData = <
      item
        Name = 'EI'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'EF'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'FI'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'FF'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end>
    object fdqInformeEmpleadofecha: TSQLTimeStampField
      FieldName = 'fecha'
      Origin = 'fecha'
    end
    object fdqInformeEmpleadoempleados_id: TIntegerField
      FieldName = 'empleados_id'
      Origin = 'empleados_id'
    end
    object fdqInformeEmpleadohamacas: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'hamacas'
      Calculated = True
    end
    object fdqInformeEmpleadosombrillas: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'sombrillas'
      Calculated = True
    end
    object fdqInformeEmpleadototal: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'total'
      Calculated = True
    end
    object fdqInformeEmpleadofeca: TDateField
      FieldKind = fkCalculated
      FieldName = 'feca'
      Calculated = True
    end
    object fdqInformeEmpleadonomempleado: TStringField
      FieldKind = fkLookup
      FieldName = 'nomempleado'
      LookupDataSet = fdqNombres
      LookupKeyFields = 'id'
      LookupResultField = 'nombre'
      KeyFields = 'empleados_id'
      Size = 100
      Lookup = True
    end
    object fdqInformeEmpleadofacturado: TBooleanField
      FieldName = 'facturado'
      Origin = 'facturado'
      Required = True
    end
    object fdqInformeEmpleadototaleuros: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'totaleuros'
      Calculated = True
    end
    object fdqInformeEmpleadotoldos: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'toldos'
      Calculated = True
    end
    object fdqInformeEmpleadoticket6: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'ticket 6'
      Calculated = True
    end
    object fdqInformeEmpleadoticket3: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'ticket 3'
      Calculated = True
    end
    object fdqInformeEmpleadoticketaux: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'ticket aux'
      Calculated = True
    end
  end
  object dsInformeEmpleado: TDataSource
    AutoEdit = False
    DataSet = fdqInformeEmpleado
    Left = 674
    Top = 368
  end
  object fdqInformeEmpleadoDetalle: TFDQuery
    MasterSource = dsInformeEmpleado
    MasterFields = 'feca;empleados_id'
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT'
      'tickets.fecha,'
      'tickets.empleados_id,'
      'tickets.tipos_id,'
      'tickets.precio,'
      'Sum(tickets.desde) AS SD,'
      'Sum(tickets.real) AS SR,'
      'tickets.facturado,'
      
        'Sum(IIf(([tickets].[real]-[tickets].[desde])>=0,([tickets].[real' +
        ']-[tickets].[desde])+1,0)) AS diferencia'
      'FROM'
      'tickets'
      'WHERE'
      
        '(tickets.empleados_id = :empleados_id) AND (tickets.fecha = :fec' +
        'a) AND (tickets.facturado = True)'
      'GROUP BY'
      'tickets.fecha,'
      'tickets.empleados_id,'
      'tickets.tipos_id,'
      'tickets.precio,'
      'tickets.facturado;')
    Left = 674
    Top = 424
    ParamData = <
      item
        Name = 'EMPLEADOS_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'FECA'
        DataType = ftDate
        ParamType = ptInput
        Value = Null
      end>
    object fdqInformeEmpleadoDetallefecha: TSQLTimeStampField
      FieldName = 'fecha'
      Origin = 'fecha'
    end
    object fdqInformeEmpleadoDetalleempleados_id: TIntegerField
      FieldName = 'empleados_id'
      Origin = 'empleados_id'
    end
    object fdqInformeEmpleadoDetalletipos_id: TIntegerField
      FieldName = 'tipos_id'
      Origin = 'tipos_id'
    end
    object fdqInformeEmpleadoDetalleSD: TFloatField
      AutoGenerateValue = arDefault
      FieldName = 'SD'
      Origin = 'SD'
      ProviderFlags = []
      ReadOnly = True
    end
    object fdqInformeEmpleadoDetalleSR: TFloatField
      AutoGenerateValue = arDefault
      FieldName = 'SR'
      Origin = 'SR'
      ProviderFlags = []
      ReadOnly = True
    end
    object fdqInformeEmpleadoDetallediferencia: TFloatField
      AutoGenerateValue = arDefault
      FieldName = 'diferencia'
      Origin = 'diferencia'
      ProviderFlags = []
      ReadOnly = True
    end
    object fdqInformeEmpleadoDetallefacturado: TBooleanField
      FieldName = 'facturado'
      Origin = 'facturado'
      Required = True
    end
    object fdqInformeEmpleadoDetalleprecio: TCurrencyField
      FieldName = 'precio'
      Origin = 'precio'
    end
  end
  object fdqInformeAnticipos: TFDQuery
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT'
      
        'anticipos.id, anticipos.empleados_id, anticipos.fecha, anticipos' +
        '.cantidad'
      'FROM'
      'anticipos'
      'WHERE'
      ' (anticipos.empleados_id >= :EI) AND'
      ' (anticipos.empleados_id <= :EF) AND'
      ' (anticipos.fecha >= :FI) AND'
      ' (anticipos.fecha <= :FF)'
      'ORDER BY empleados_id, fecha ASC;')
    Left = 578
    Top = 320
    ParamData = <
      item
        Name = 'EI'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'EF'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'FI'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'FF'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end>
    object fdqInformeAnticiposid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object fdqInformeAnticiposempleados_id: TIntegerField
      FieldName = 'empleados_id'
      Origin = 'empleados_id'
    end
    object fdqInformeAnticiposfecha: TSQLTimeStampField
      FieldName = 'fecha'
      Origin = 'fecha'
    end
    object fdqInformeAnticiposcantidad: TCurrencyField
      FieldName = 'cantidad'
      Origin = 'cantidad'
    end
    object fdqInformeAnticiposnomempleado: TStringField
      FieldKind = fkLookup
      FieldName = 'nomempleado'
      LookupDataSet = fdqNombres
      LookupKeyFields = 'id'
      LookupResultField = 'nombre'
      KeyFields = 'empleados_id'
      Size = 100
      Lookup = True
    end
  end
  object dsInformeAnticipos: TDataSource
    AutoEdit = False
    DataSet = fdqInformeAnticipos
    Left = 578
    Top = 371
  end
  object fdqRestoVacaciones: TFDQuery
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT empleados.id, empleados.nombre, empleados.estado_id'
      
        'FROM empleados LEFT JOIN tickets ON empleados.id = tickets.emple' +
        'ados_id'
      'WHERE NOT EXISTS'
      '(SELECT tickets.empleados_id, tickets.fecha, tickets.facturado'
      'FROM tickets'
      
        'WHERE ((empleados.id = tickets.empleados_id) AND (tickets.factur' +
        'ado = False))) AND (empleados.estado_id < 4)'
      'GROUP BY empleados.id, empleados.nombre, empleados.estado_id')
    Left = 456
    Top = 320
    object fdqRestoVacacionesid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object fdqRestoVacacionesnombre: TWideStringField
      FieldName = 'nombre'
      Origin = 'nombre'
      Size = 255
    end
    object fdqRestoVacacionesestado_id: TIntegerField
      FieldName = 'estado_id'
      Origin = 'estado_id'
    end
  end
  object dsRestoVacaciones: TDataSource
    AutoEdit = False
    DataSet = fdqRestoVacaciones
    Left = 464
    Top = 384
  end
  object dsNombres: TDataSource
    DataSet = fdqNombres
    Left = 648
    Top = 72
  end
  object fdqEstados: TFDQuery
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT estados.id, estados.descripcion'
      'FROM estados;')
    Left = 288
    Top = 144
  end
  object dsEstados: TDataSource
    AutoEdit = False
    DataSet = fdqEstados
    Left = 296
    Top = 200
  end
  object dsAnticipos: TDataSource
    DataSet = fdqAnticipos
    Left = 296
    Top = 320
  end
  object fdqAnticipos: TFDQuery
    AfterInsert = fdqAnticiposAfterInsert
    BeforePost = fdqAnticiposBeforePost
    AfterScroll = fdqAnticiposAfterScroll
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT'
      
        'anticipos.id, anticipos.empleados_id, anticipos.fecha, anticipos' +
        '.cantidad, year(anticipos.fecha) AS AN, month(anticipos.fecha) A' +
        'S MO'
      'FROM'
      'anticipos'
      'WHERE'
      
        '(empleados_id = :E) AND (year(anticipos.fecha) = :A) AND (month(' +
        'anticipos.fecha) = :M)'
      'ORDER BY fecha ASC;')
    Left = 296
    Top = 264
    ParamData = <
      item
        Name = 'E'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'A'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'M'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object fdqAnticiposid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object fdqAnticiposempleados_id: TIntegerField
      FieldName = 'empleados_id'
      Origin = 'empleados_id'
    end
    object fdqAnticiposfecha: TSQLTimeStampField
      FieldName = 'fecha'
      Origin = 'fecha'
    end
    object fdqAnticiposcantidad: TCurrencyField
      FieldName = 'cantidad'
      Origin = 'cantidad'
    end
    object fdqAnticiposAN: TSmallintField
      FieldName = 'AN'
      Origin = 'fecha'
      ProviderFlags = []
    end
    object fdqAnticiposMO: TSmallintField
      FieldName = 'MO'
      Origin = 'fecha'
      ProviderFlags = []
    end
  end
  object fdqInformeObservacion: TFDQuery
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT'
      
        'observaciones.id, observaciones.empleados_id, observaciones.fech' +
        'a, observaciones.observacion, observaciones.visto'
      'FROM'
      'observaciones'
      'WHERE'
      ' (observaciones.empleados_id >= :EI) AND'
      ' (observaciones.empleados_id <= :EF) AND'
      ' (observaciones.fecha >= :FI) AND'
      ' (observaciones.fecha <= :FF)'
      'ORDER BY empleados_id, fecha ASC;')
    Left = 802
    Top = 267
    ParamData = <
      item
        Name = 'EI'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'EF'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'FI'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'FF'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end>
    object fdqInformeObservacionid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object fdqInformeObservacionempleados_id: TIntegerField
      FieldName = 'empleados_id'
      Origin = 'empleados_id'
    end
    object fdqInformeObservacionfecha: TSQLTimeStampField
      FieldName = 'fecha'
      Origin = 'fecha'
    end
    object fdqInformeObservacionobservacion: TWideMemoField
      FieldName = 'observacion'
      Origin = 'observacion'
      BlobType = ftWideMemo
    end
    object fdqInformeObservacionvisto: TBooleanField
      FieldName = 'visto'
      Origin = 'visto'
      Required = True
    end
    object fdqInformeObservacionnomempleados: TStringField
      FieldKind = fkLookup
      FieldName = 'nomempleados'
      LookupDataSet = fdqNombres
      LookupKeyFields = 'id'
      LookupResultField = 'nombre'
      KeyFields = 'empleados_id'
      Size = 100
      Lookup = True
    end
  end
  object dsInformeObservacion: TDataSource
    AutoEdit = False
    DataSet = fdqInformeObservacion
    Left = 802
    Top = 323
  end
  object fdqObservaciones: TFDQuery
    AfterInsert = fdqObservacionesAfterInsert
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT'
      'observaciones.id, observaciones.empleados_id,'
      'observaciones.fecha, observaciones.observacion,'
      'observaciones.visto'
      'FROM observaciones'
      'WHERE empleados_id = :E')
    Left = 384
    Top = 144
    ParamData = <
      item
        Name = 'E'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object fdqObservacionesid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object fdqObservacionesempleados_id: TIntegerField
      FieldName = 'empleados_id'
      Origin = 'empleados_id'
    end
    object fdqObservacionesfecha: TSQLTimeStampField
      FieldName = 'fecha'
      Origin = 'fecha'
    end
    object fdqObservacionesobservacion: TWideMemoField
      FieldName = 'observacion'
      Origin = 'observacion'
      BlobType = ftMemo
    end
    object fdqObservacionesvisto: TBooleanField
      FieldName = 'visto'
      Origin = 'visto'
      Required = True
    end
  end
  object dsObservaciones: TDataSource
    DataSet = fdqObservaciones
    Left = 384
    Top = 208
  end
  object fdqSumaAnticipos: TFDQuery
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      
        'SELECT anticipos.empleados_id, Year(anticipos.fecha) AS AN, Mont' +
        'h(anticipos.fecha) AS MO, Sum(anticipos.cantidad) AS SC'
      'FROM anticipos'
      
        'GROUP BY anticipos.empleados_id, Year(anticipos.fecha), Month(an' +
        'ticipos.fecha), anticipos.empleados_id, Year(anticipos.fecha), M' +
        'onth(anticipos.fecha)'
      
        'HAVING (empleados_id = :E) AND (year(anticipos.fecha) = :A) AND ' +
        '(month(anticipos.fecha) = :M)')
    Left = 296
    Top = 392
    ParamData = <
      item
        Name = 'E'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'A'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'M'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object fdqSumaAnticiposempleados_id: TIntegerField
      FieldName = 'empleados_id'
      Origin = 'empleados_id'
    end
    object fdqSumaAnticiposAN: TSmallintField
      AutoGenerateValue = arDefault
      FieldName = 'AN'
      Origin = 'AN'
      ProviderFlags = []
      ReadOnly = True
    end
    object fdqSumaAnticiposMO: TSmallintField
      AutoGenerateValue = arDefault
      FieldName = 'MO'
      Origin = 'MO'
      ProviderFlags = []
      ReadOnly = True
    end
    object fdqSumaAnticiposSC: TCurrencyField
      AutoGenerateValue = arDefault
      FieldName = 'SC'
      Origin = 'SC'
      ProviderFlags = []
      ReadOnly = True
    end
  end
  object dsSumaAnticipos: TDataSource
    DataSet = fdqSumaAnticipos
    Left = 296
    Top = 456
  end
  object fdcBorraTickets: TFDCommand
    Connection = DataModulePrincipal.FDConnection1
    CommandText.Strings = (
      'DELETE * FROM tickets;')
    Left = 56
    Top = 328
  end
  object fdcBorraAnticipos: TFDCommand
    Connection = DataModulePrincipal.FDConnection1
    CommandText.Strings = (
      'DELETE * FROM anticipos;')
    Left = 56
    Top = 392
  end
  object fdcBorraObservaciones: TFDCommand
    Connection = DataModulePrincipal.FDConnection1
    CommandText.Strings = (
      'DELETE * FROM observaciones;')
    Left = 56
    Top = 456
  end
  object fdqUltimoTalonario: TFDQuery
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT'
      ' tickets.id, tickets.fecha, tickets.empleados_id,'
      ' tickets.facturado, tickets.referencia_id'
      'FROM tickets'
      
        'WHERE (tickets.empleados_id = :EM) AND (tickets.fecha = :FE) AND' +
        ' (tickets.facturado = :FA)'
      'ORDER BY tickets.empleados_id ASC, tickets.fecha ASC;')
    Left = 776
    Top = 24
    ParamData = <
      item
        Name = 'EM'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'FE'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'FA'
        DataType = ftBoolean
        ParamType = ptInput
        Value = Null
      end>
  end
  object dsTipos: TDataSource
    AutoEdit = False
    DataSet = fdqTipos
    Left = 400
    Top = 88
  end
  object fdcBorraSelAnticipos: TFDCommand
    Connection = DataModulePrincipal.FDConnection1
    CommandText.Strings = (
      'DELETE *, anticipos.empleados_id, anticipos.fecha'
      'FROM anticipos'
      'WHERE'
      ' (anticipos.empleados_id >= :EI) AND'
      ' (anticipos.empleados_id <= :EF) AND'
      ' (anticipos.fecha >= :FI) AND'
      ' (anticipos.fecha <= :FF);')
    ParamData = <
      item
        Name = 'EI'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'EF'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'FI'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'FF'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end>
    Left = 456
    Top = 464
  end
  object fdqBorraSelObserva: TFDCommand
    Connection = DataModulePrincipal.FDConnection1
    CommandText.Strings = (
      'DELETE *, observaciones.empleados_id, observaciones.fecha'
      'FROM observaciones'
      'WHERE'
      ' (observaciones.empleados_id >= :EI) AND'
      ' (observaciones.empleados_id <= :EF) AND'
      ' (observaciones.fecha >= :FI) AND'
      ' (observaciones.fecha <= :FF);')
    ParamData = <
      item
        Name = 'EI'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'EF'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'FI'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'FF'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end>
    Left = 576
    Top = 488
  end
  object cdsTotal: TClientDataSet
    PersistDataPacket.Data = {
      3C0000009619E0BD0100000018000000010000000000030000003C0005746F74
      616C080004000000010007535542545950450200490006004D6F6E6579000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 184
    Top = 336
    object cdsTotaltotal: TCurrencyField
      FieldName = 'total'
    end
  end
  object fdqFacturadoDia: TFDQuery
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT'
      ' tickets.id, tickets.fecha, tickets.empleados_id,'
      ' tickets.facturado, tickets.referencia_id'
      'FROM tickets'
      
        'WHERE (tickets.empleados_id = :EM) AND (tickets.fecha = :FE) AND' +
        ' (tickets.facturado = :FA)'
      'ORDER BY tickets.empleados_id ASC, tickets.fecha ASC;')
    Left = 800
    Top = 120
    ParamData = <
      item
        Name = 'EM'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'FE'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'FA'
        DataType = ftBoolean
        ParamType = ptInput
        Value = Null
      end>
  end
  object fdqInformePatines: TFDQuery
    OnCalcFields = fdqInformePatinesCalcFields
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT'
      'tickets.fecha, tickets.sectores_id, sectores.sector,'
      'tickets.empleados_id, tickets.facturado, empleados.nombre,'
      'sectores.playas_id, playas.playa, playas.orden_impresion'
      'FROM'
      
        '(playas INNER JOIN sectores ON playas.id = sectores.playas_id) I' +
        'NNER JOIN (empleados INNER JOIN tickets ON empleados.id = ticket' +
        's.empleados_id) ON sectores.id = tickets.sectores_id'
      'WHERE'
      
        '((tickets.facturado = False) AND ((tickets.tipos_id = 4) OR (tic' +
        'kets.tipos_id = 5)))'
      
        'GROUP BY tickets.fecha, tickets.sectores_id, sectores.sector, ti' +
        'ckets.empleados_id, tickets.facturado, empleados.nombre, sectore' +
        's.playas_id, playas.playa, playas.orden_impresion'
      
        'ORDER BY playas.orden_impresion, tickets.sectores_id, tickets.em' +
        'pleados_id;'
      ''
      ''
      ''
      '')
    Left = 480
    Top = 152
    object StringField1: TStringField
      FieldKind = fkCalculated
      FieldName = 'numeros'
      Size = 2000
      Calculated = True
    end
    object StringField2: TStringField
      FieldKind = fkCalculated
      FieldName = 'numeros1'
      Size = 2000
      Calculated = True
    end
    object SQLTimeStampField1: TSQLTimeStampField
      FieldName = 'fecha'
      Origin = 'fecha'
    end
    object IntegerField1: TIntegerField
      FieldName = 'sectores_id'
      Origin = 'sectores_id'
    end
    object IntegerField2: TIntegerField
      FieldName = 'empleados_id'
      Origin = 'empleados_id'
    end
    object WideStringField1: TWideStringField
      FieldName = 'nombre'
      Origin = 'nombre'
      Size = 255
    end
    object IntegerField3: TIntegerField
      FieldName = 'playas_id'
      Origin = 'playas_id'
    end
    object WideStringField2: TWideStringField
      FieldName = 'playa'
      Origin = 'playa'
      Size = 255
    end
    object WideStringField3: TWideStringField
      FieldName = 'sector'
      Origin = 'sector'
      Size = 255
    end
    object DateTimeField1: TDateTimeField
      FieldKind = fkCalculated
      FieldName = 'feca'
      Calculated = True
    end
    object IntegerField4: TIntegerField
      FieldName = 'orden_impresion'
      Origin = 'orden_impresion'
    end
  end
  object dsInformePatines: TDataSource
    AutoEdit = False
    DataSet = fdqInformePatines
    Left = 480
    Top = 208
  end
  object fdqInformePatinesDet: TFDQuery
    MasterSource = dsInformePatines
    MasterFields = 'feca;sectores_id;empleados_id'
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT'
      'tickets.fecha, tickets.sectores_id,'
      'tickets.tipos_id, tickets.empleados_id,'
      'tickets.letra, tickets.real, tickets.orden, tickets.desde'
      'FROM'
      'tickets'
      'WHERE'
      
        '(tickets.fecha = :feca) AND (tickets.sectores_id = :sectores_id)' +
        ' AND (tickets.empleados_id = :empleados_id)'
      'ORDER BY'
      
        'tickets.empleados_id, tickets.sectores_id ASC, tickets.tipos_id ' +
        'ASC, tickets.orden ASC;')
    Left = 480
    Top = 264
    ParamData = <
      item
        Name = 'FECA'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'SECTORES_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'EMPLEADOS_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object SQLTimeStampField2: TSQLTimeStampField
      FieldName = 'fecha'
      Origin = 'fecha'
    end
    object IntegerField5: TIntegerField
      FieldName = 'sectores_id'
      Origin = 'sectores_id'
    end
    object IntegerField6: TIntegerField
      FieldName = 'tipos_id'
      Origin = 'tipos_id'
    end
    object IntegerField7: TIntegerField
      FieldName = 'empleados_id'
      Origin = 'empleados_id'
    end
    object WideStringField4: TWideStringField
      FieldName = 'letra'
      Origin = 'letra'
      Size = 1
    end
    object IntegerField8: TIntegerField
      FieldName = 'real'
      Origin = '[real]'
    end
    object IntegerField9: TIntegerField
      FieldName = 'orden'
      Origin = 'orden'
    end
    object IntegerField10: TIntegerField
      FieldName = 'desde'
      Origin = 'desde'
    end
  end
end
