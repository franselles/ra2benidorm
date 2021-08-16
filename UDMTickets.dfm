object DataModuleTickets: TDataModuleTickets
  OldCreateOrder = False
  Height = 679
  Width = 1037
  object DataSourceEmpleadosSinTickets: TDataSource
    AutoEdit = False
    DataSet = FDQueryEmpleadosSinTickets
    Left = 88
    Top = 104
  end
  object FDQueryEmpleadosSinTickets: TFDQuery
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT empleados.id, empleados.nombre, empleados.estado_id'
      
        'FROM empleados LEFT JOIN tickets ON empleados.id = tickets.emple' +
        'ados_id'
      'WHERE NOT EXISTS'
      '(SELECT tickets.empleados_id, tickets.fecha'
      'FROM tickets'
      
        'WHERE ((empleados.id = tickets.empleados_id) AND (tickets.fecha ' +
        '= :F ))) AND (empleados.estado_id < 4)'
      'GROUP BY empleados.id, empleados.nombre, empleados.estado_id')
    Left = 88
    Top = 40
    ParamData = <
      item
        Name = 'F'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end>
    object FDQueryEmpleadosSinTicketsid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQueryEmpleadosSinTicketsnombre: TWideStringField
      FieldName = 'nombre'
      Origin = 'nombre'
      Size = 255
    end
    object FDQueryEmpleadosSinTicketsestado_id: TIntegerField
      FieldName = 'estado_id'
      Origin = 'estado_id'
    end
  end
  object FDQueryEmpleadosEstado: TFDQuery
    BeforePost = FDQueryEmpleadosEstadoBeforePost
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT'
      'empleados.id, empleados.nombre, empleados.estado_id'
      'FROM'
      'empleados'
      'WHERE'
      '(empleados.estado_id) < :E'
      'ORDER BY'
      'empleados.nombre ASC;')
    Left = 304
    Top = 24
    ParamData = <
      item
        Name = 'E'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object FDQueryEmpleadosEstadoid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      Visible = False
    end
    object FDQueryEmpleadosEstadonombre: TWideStringField
      DisplayWidth = 60
      FieldName = 'nombre'
      Origin = 'nombre'
      Size = 100
    end
    object FDQueryEmpleadosEstadoestado_id: TIntegerField
      FieldName = 'estado_id'
      Origin = 'estado_id'
      Visible = False
    end
  end
  object DataSourceEmpleadosEstado: TDataSource
    DataSet = FDQueryEmpleadosEstado
    Left = 304
    Top = 80
  end
  object FDQueryTickets: TFDQuery
    OnCalcFields = FDQueryTicketsCalcFields
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT'
      'tickets.id, tickets.fecha, tickets.empleados_id,'
      'tickets.sectores_id, tickets.tipos_id,'
      'tickets.letra, tickets.desde, tickets.hasta,'
      
        'tickets.real, tickets.orden, tickets.orden2, tickets.referencia_' +
        'id'
      'FROM'
      'tickets'
      'WHERE'
      '(tickets.empleados_id = :E) AND (tickets.fecha = :F)'
      'ORDER BY'
      'tickets.tipos_id ASC, tickets.orden ASC;')
    Left = 80
    Top = 272
    ParamData = <
      item
        Name = 'E'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'F'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end>
    object FDQueryTicketsid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQueryTicketsempleados_id: TIntegerField
      FieldName = 'empleados_id'
      Origin = 'empleados_id'
    end
    object FDQueryTicketssectores_id: TIntegerField
      FieldName = 'sectores_id'
      Origin = 'sectores_id'
    end
    object FDQueryTicketstipos_id: TIntegerField
      FieldName = 'tipos_id'
      Origin = 'tipos_id'
    end
    object FDQueryTicketsletra: TWideStringField
      FieldName = 'letra'
      Origin = 'letra'
      Size = 1
    end
    object FDQueryTicketsdesde: TIntegerField
      FieldName = 'desde'
      Origin = 'desde'
    end
    object FDQueryTicketshasta: TIntegerField
      FieldName = 'hasta'
      Origin = 'hasta'
    end
    object FDQueryTicketsreal: TIntegerField
      FieldName = 'real'
      Origin = '[real]'
    end
    object FDQueryTicketsorden: TIntegerField
      FieldName = 'orden'
      Origin = 'orden'
    end
    object FDQueryTicketsorden2: TIntegerField
      FieldName = 'orden2'
      Origin = 'orden2'
    end
    object FDQueryTicketsnomempleado: TStringField
      FieldKind = fkLookup
      FieldName = 'nomempleado'
      LookupDataSet = FDQueryEmpleados
      LookupKeyFields = 'id'
      LookupResultField = 'nombre'
      KeyFields = 'empleados_id'
      Size = 150
      Lookup = True
    end
    object FDQueryTicketsnomsectores: TStringField
      FieldKind = fkLookup
      FieldName = 'nomsectores'
      LookupDataSet = FDQuerySectores
      LookupKeyFields = 'id'
      LookupResultField = 'sector'
      KeyFields = 'sectores_id'
      Size = 150
      Lookup = True
    end
    object FDQueryTicketsnomtipo: TStringField
      FieldKind = fkLookup
      FieldName = 'nomtipo'
      LookupDataSet = FDQueryTipos
      LookupKeyFields = 'id'
      LookupResultField = 'nombre'
      KeyFields = 'tipos_id'
      Size = 150
      Lookup = True
    end
    object FDQueryTicketsfecha: TSQLTimeStampField
      FieldName = 'fecha'
      Origin = 'fecha'
    end
    object FDQueryTicketscantidad: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'cantidad'
      Calculated = True
    end
    object FDQueryTicketsreferencia_id: TIntegerField
      FieldName = 'referencia_id'
      Origin = 'referencia_id'
    end
  end
  object DataSourceTickets: TDataSource
    DataSet = FDQueryTickets
    Left = 80
    Top = 328
  end
  object FDQueryTipos: TFDQuery
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT'
      'tipos.id, tipos.nombre, tipos.precio, tipos.letra'
      'FROM'
      'tipos;')
    Left = 456
    Top = 32
    object FDQueryTiposid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQueryTiposnombre: TWideStringField
      FieldName = 'nombre'
      Origin = 'nombre'
      Size = 255
    end
    object FDQueryTiposprecio: TCurrencyField
      FieldName = 'precio'
      Origin = 'precio'
    end
    object FDQueryTiposletra: TWideStringField
      FieldName = 'letra'
      Origin = 'letra'
      Size = 1
    end
  end
  object FDQuerySectores: TFDQuery
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT'
      'sectores.id, sectores.playas_id, sectores.sector, playas.playa'
      
        'FROM playas INNER JOIN sectores ON playas.id = sectores.playas_i' +
        'd;')
    Left = 432
    Top = 112
    object FDQuerySectoresid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQuerySectoresplayas_id: TIntegerField
      FieldName = 'playas_id'
      Origin = 'playas_id'
    end
    object FDQuerySectoressector: TWideStringField
      FieldName = 'sector'
      Origin = 'sector'
      Size = 255
    end
    object FDQuerySectoresplaya: TWideStringField
      FieldName = 'playa'
      Origin = 'playa'
      Size = 255
    end
  end
  object FDQuerySumaTickets: TFDQuery
    OnCalcFields = FDQuerySumaTicketsCalcFields
    MasterSource = DataSourceTicketsFacturacion
    MasterFields = 'fecha;empleados_id'
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT'
      'tickets.fecha,'
      'tickets.empleados_id,'
      'tickets.tipos_id,'
      'Sum(tickets.desde) AS SD,'
      'Sum(tickets.real) AS SR,'
      
        'Sum(IIf(([tickets].[real]-[tickets].[desde])>0,([tickets].[real]' +
        '-[tickets].[desde])+1,0)) AS diferencia'
      'FROM'
      'tickets'
      'WHERE'
      
        '(tickets.empleados_id = :empleados_id) AND (tickets.fecha = :fec' +
        'ha)'
      'GROUP BY'
      'tickets.fecha,'
      'tickets.empleados_id,'
      'tickets.tipos_id;')
    Left = 232
    Top = 408
    ParamData = <
      item
        Name = 'EMPLEADOS_ID'
        ParamType = ptInput
      end
      item
        Name = 'FECHA'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end>
    object FDQuerySumaTicketsfecha: TSQLTimeStampField
      FieldName = 'fecha'
      Origin = 'fecha'
    end
    object FDQuerySumaTicketsempleados_id: TIntegerField
      FieldName = 'empleados_id'
      Origin = 'empleados_id'
    end
    object FDQuerySumaTicketstipos_id: TIntegerField
      FieldName = 'tipos_id'
      Origin = 'tipos_id'
    end
    object FDQuerySumaTicketsSD: TFloatField
      AutoGenerateValue = arDefault
      FieldName = 'SD'
      Origin = 'SD'
      ProviderFlags = []
      ReadOnly = True
    end
    object FDQuerySumaTicketsSR: TFloatField
      AutoGenerateValue = arDefault
      FieldName = 'SR'
      Origin = 'SR'
      ProviderFlags = []
      ReadOnly = True
    end
    object FDQuerySumaTicketsmprecio: TCurrencyField
      FieldKind = fkLookup
      FieldName = 'mprecio'
      LookupDataSet = FDQueryTipos
      LookupKeyFields = 'id'
      LookupResultField = 'precio'
      KeyFields = 'tipos_id'
      Lookup = True
    end
    object FDQuerySumaTicketsimporte: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'importe'
      Calculated = True
    end
    object FDQuerySumaTicketscantidad: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'cantidad'
      Calculated = True
    end
    object FDQuerySumaTicketsnomtipo: TStringField
      FieldKind = fkLookup
      FieldName = 'nomtipo'
      LookupDataSet = FDQueryTipos
      LookupKeyFields = 'id'
      LookupResultField = 'nombre'
      KeyFields = 'tipos_id'
      Size = 150
      Lookup = True
    end
    object FDQuerySumaTicketsdiferencia: TFloatField
      AutoGenerateValue = arDefault
      FieldName = 'diferencia'
      Origin = 'diferencia'
      ProviderFlags = []
      ReadOnly = True
    end
  end
  object DataSourceSumaTickets: TDataSource
    AutoEdit = False
    DataSet = FDQuerySumaTickets
    Left = 232
    Top = 480
  end
  object FDQueryCheckNumeros: TFDQuery
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
    Left = 616
    Top = 320
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
    object FDQueryCheckNumerostipos_id: TIntegerField
      FieldName = 'tipos_id'
      Origin = 'tipos_id'
    end
    object FDQueryCheckNumerosletra: TWideStringField
      FieldName = 'letra'
      Origin = 'letra'
      Size = 1
    end
    object FDQueryCheckNumerosdesde: TIntegerField
      FieldName = 'desde'
      Origin = 'desde'
    end
    object FDQueryCheckNumerosreal: TIntegerField
      FieldName = 'real'
      Origin = '[real]'
    end
    object FDQueryCheckNumerosid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
  end
  object FDQueryUltimosNumeros: TFDQuery
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT'
      'tickets.tipos_id,'
      'Max(tickets.letra) AS Mletra,'
      'Max(tickets.real) AS Mreal'
      'FROM tickets'
      'WHERE tickets.tipos_id = :T'
      'GROUP BY tickets.tipos_id;'
      '')
    Left = 632
    Top = 72
    ParamData = <
      item
        Name = 'T'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object FDQueryUltimosNumerostipos_id: TIntegerField
      FieldName = 'tipos_id'
      Origin = 'tipos_id'
    end
    object FDQueryUltimosNumerosMletra: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'Mletra'
      Origin = 'Mletra'
      ProviderFlags = []
      ReadOnly = True
      Size = 255
    end
    object FDQueryUltimosNumerosMreal: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'Mreal'
      Origin = 'Mreal'
      ProviderFlags = []
      ReadOnly = True
    end
  end
  object DataSourceUltimosNumeros: TDataSource
    AutoEdit = False
    DataSet = FDQueryUltimosNumeros
    Left = 616
    Top = 144
  end
  object FDQueryEmpleados: TFDQuery
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT'
      'empleados.id, empleados.nombre, empleados.estado_id'
      'FROM'
      'empleados')
    Left = 432
    Top = 224
    object FDQueryEmpleadosid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQueryEmpleadosnombre: TWideStringField
      FieldName = 'nombre'
      Origin = 'nombre'
      Size = 255
    end
    object FDQueryEmpleadosestado_id: TIntegerField
      FieldName = 'estado_id'
      Origin = 'estado_id'
    end
  end
  object FDQueryPlayas: TFDQuery
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT playas.id, playas.playa'
      'FROM playas;')
    Left = 504
    Top = 152
    object FDQueryPlayasid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQueryPlayasplaya: TWideStringField
      FieldName = 'playa'
      Origin = 'playa'
      Size = 255
    end
  end
  object FDQueryTicketsFacturacion: TFDQuery
    BeforePost = FDQueryTicketsFacturacionBeforePost
    AfterPost = FDQueryTicketsFacturacionAfterPost
    BeforeDelete = FDQueryTicketsFacturacionBeforeDelete
    OnCalcFields = FDQueryTicketsFacturacionCalcFields
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT'
      'tickets.id, tickets.fecha, tickets.empleados_id,'
      'tickets.sectores_id, tickets.tipos_id,'
      'tickets.letra, tickets.desde, tickets.hasta,'
      'tickets.real, tickets.orden, tickets.orden2,'
      'tickets.facturado, tickets.referencia_id'
      'FROM'
      'tickets'
      'WHERE'
      '(tickets.empleados_id = :E) AND (tickets.fecha = :F)'
      'ORDER BY'
      'tickets.tipos_id ASC, tickets.orden ASC;')
    Left = 88
    Top = 408
    ParamData = <
      item
        Name = 'E'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'F'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end>
    object FDQueryTicketsFacturacionid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQueryTicketsFacturacionempleados_id: TIntegerField
      FieldName = 'empleados_id'
      Origin = 'empleados_id'
    end
    object FDQueryTicketsFacturacionsectores_id: TIntegerField
      FieldName = 'sectores_id'
      Origin = 'sectores_id'
    end
    object FDQueryTicketsFacturaciontipos_id: TIntegerField
      FieldName = 'tipos_id'
      Origin = 'tipos_id'
    end
    object FDQueryTicketsFacturacionletra: TWideStringField
      FieldName = 'letra'
      Origin = 'letra'
      Size = 1
    end
    object FDQueryTicketsFacturaciondesde: TIntegerField
      FieldName = 'desde'
      Origin = 'desde'
    end
    object FDQueryTicketsFacturacionhasta: TIntegerField
      FieldName = 'hasta'
      Origin = 'hasta'
    end
    object FDQueryTicketsFacturacionreal: TIntegerField
      FieldName = 'real'
      Origin = '[real]'
    end
    object FDQueryTicketsFacturacionorden: TIntegerField
      FieldName = 'orden'
      Origin = 'orden'
    end
    object FDQueryTicketsFacturacionorden2: TIntegerField
      FieldName = 'orden2'
      Origin = 'orden2'
    end
    object FDQueryTicketsFacturacionnomtipo: TStringField
      FieldKind = fkLookup
      FieldName = 'nomtipo'
      LookupDataSet = FDQueryTipos
      LookupKeyFields = 'id'
      LookupResultField = 'nombre'
      KeyFields = 'tipos_id'
      Size = 150
      Lookup = True
    end
    object FDQueryTicketsFacturacionnomempleado: TStringField
      FieldKind = fkLookup
      FieldName = 'nomempleado'
      LookupDataSet = FDQueryEmpleados
      LookupKeyFields = 'id'
      LookupResultField = 'nombre'
      KeyFields = 'empleados_id'
      Size = 150
      Lookup = True
    end
    object FDQueryTicketsFacturacionnomsector: TStringField
      FieldKind = fkLookup
      FieldName = 'nomsector'
      LookupDataSet = FDQuerySectores
      LookupKeyFields = 'id'
      LookupResultField = 'sector'
      KeyFields = 'sectores_id'
      Size = 150
      Lookup = True
    end
    object FDQueryTicketsFacturacionmprecio: TCurrencyField
      FieldKind = fkLookup
      FieldName = 'mprecio'
      LookupDataSet = FDQueryTipos
      LookupKeyFields = 'id'
      LookupResultField = 'precio'
      KeyFields = 'tipos_id'
      Lookup = True
    end
    object FDQueryTicketsFacturacionimporte: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'importe'
      Calculated = True
    end
    object FDQueryTicketsFacturacioncantidad: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'cantidad'
      Calculated = True
    end
    object FDQueryTicketsFacturacionfacturado: TBooleanField
      FieldName = 'facturado'
      Origin = 'facturado'
      Required = True
    end
    object FDQueryTicketsFacturacionfecha: TSQLTimeStampField
      FieldName = 'fecha'
      Origin = 'fecha'
    end
    object FDQueryTicketsFacturacionreferencia_id: TIntegerField
      FieldName = 'referencia_id'
      Origin = 'referencia_id'
    end
  end
  object DataSourceTicketsFacturacion: TDataSource
    DataSet = FDQueryTicketsFacturacion
    Left = 88
    Top = 480
  end
  object FDQueryTicketsDelDia: TFDQuery
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT'
      'tickets.fecha, tickets.empleados_id,'
      'tickets.facturado, empleados.nombre'
      
        'FROM empleados INNER JOIN tickets ON empleados.id = tickets.empl' +
        'eados_id'
      'WHERE '
      '(tickets.fecha = :F)'
      'GROUP BY'
      'tickets.fecha, tickets.empleados_id,'
      ' tickets.facturado, empleados.nombre;')
    Left = 216
    Top = 272
    ParamData = <
      item
        Name = 'F'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end>
    object FDQueryTicketsDelDiaempleados_id: TIntegerField
      FieldName = 'empleados_id'
      Origin = 'empleados_id'
    end
    object FDQueryTicketsDelDianombre: TWideStringField
      FieldName = 'nombre'
      Origin = 'nombre'
      Size = 255
    end
    object FDQueryTicketsDelDianomempleado: TStringField
      FieldKind = fkLookup
      FieldName = 'nomempleado'
      LookupDataSet = FDQueryEmpleados
      LookupKeyFields = 'id'
      LookupResultField = 'nombre'
      KeyFields = 'empleados_id'
      Size = 150
      Lookup = True
    end
    object FDQueryTicketsDelDiafacturado: TBooleanField
      FieldName = 'facturado'
      Origin = 'facturado'
      Required = True
    end
    object FDQueryTicketsDelDiafecha: TSQLTimeStampField
      FieldName = 'fecha'
      Origin = 'fecha'
    end
  end
  object DataSourceTicketsDelDia: TDataSource
    AutoEdit = False
    DataSet = FDQueryTicketsDelDia
    Left = 224
    Top = 328
  end
  object ClientDataSetTotal: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'total'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 536
    Top = 336
    Data = {
      280000009619E0BD010000001800000001000000000003000000280005746F74
      616C04000100000000000000}
    object ClientDataSetTotaltotal: TIntegerField
      FieldName = 'total'
      DisplayFormat = '#,#'
    end
  end
  object DataSourceTotal: TDataSource
    DataSet = ClientDataSetTotal
    Left = 552
    Top = 392
  end
  object FDQueryDiferencia: TFDQuery
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT'
      'tickets.empleados_id, tickets.tipos_id,'
      'tickets.fecha,'
      '[tickets]![real]-[tickets]![desde] AS diferencia,'
      'tickets.desde'
      'FROM'
      'tickets'
      'WHERE'
      '(tickets.empleados_id = :E) AND (tickets.fecha = :F)'
      'GROUP BY'
      'tickets.empleados_id, tickets.tipos_id,'
      'tickets.fecha,'
      '[tickets]![real]-[tickets]![desde],'
      'tickets.desde;')
    Left = 424
    Top = 344
    ParamData = <
      item
        Name = 'E'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'F'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end>
    MacroData = <
      item
        Value = Null
      end>
  end
  object FDQueryInforme: TFDQuery
    OnCalcFields = FDQueryInformeCalcFields
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT'
      'tickets.fecha, tickets.sectores_id, sectores.sector,'
      'tickets.empleados_id, empleados.nombre,'
      'sectores.playas_id, playas.playa, playas.orden_impresion'
      'FROM'
      
        '(playas INNER JOIN sectores ON playas.id = sectores.playas_id) I' +
        'NNER JOIN (empleados INNER JOIN tickets ON empleados.id = ticket' +
        's.empleados_id) ON sectores.id = tickets.sectores_id'
      'WHERE'
      '(tickets.fecha = :FE)'
      
        'GROUP BY tickets.fecha, tickets.sectores_id, sectores.sector, ti' +
        'ckets.empleados_id, empleados.nombre, sectores.playas_id, playas' +
        '.playa, playas.orden_impresion'
      
        'ORDER BY tickets.fecha, tickets.sectores_id, tickets.empleados_i' +
        'd;'
      ''
      ''
      ''
      '')
    Left = 136
    Top = 160
    ParamData = <
      item
        Name = 'FE'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end>
    object FDQueryInformenumeros: TStringField
      FieldKind = fkCalculated
      FieldName = 'numeros'
      Size = 2000
      Calculated = True
    end
    object FDQueryInformenumeros1: TStringField
      FieldKind = fkCalculated
      FieldName = 'numeros1'
      Size = 2000
      Calculated = True
    end
    object FDQueryInformefecha: TSQLTimeStampField
      FieldName = 'fecha'
      Origin = 'fecha'
    end
    object FDQueryInformesectores_id: TIntegerField
      FieldName = 'sectores_id'
      Origin = 'sectores_id'
    end
    object FDQueryInformeempleados_id: TIntegerField
      FieldName = 'empleados_id'
      Origin = 'empleados_id'
    end
    object FDQueryInformenombre: TWideStringField
      FieldName = 'nombre'
      Origin = 'nombre'
      Size = 255
    end
    object FDQueryInformeplayas_id: TIntegerField
      FieldName = 'playas_id'
      Origin = 'playas_id'
    end
    object FDQueryInformeplaya: TWideStringField
      FieldName = 'playa'
      Origin = 'playa'
      Size = 255
    end
    object FDQueryInformesector: TWideStringField
      FieldName = 'sector'
      Origin = 'sector'
      Size = 255
    end
    object FDQueryInformefeca: TDateTimeField
      FieldKind = fkCalculated
      FieldName = 'feca'
      Calculated = True
    end
    object FDQueryInformeorden_impresion: TIntegerField
      FieldName = 'orden_impresion'
      Origin = 'orden_impresion'
    end
  end
  object FDQueryInformeDetalle: TFDQuery
    MasterSource = DataSourceInforme
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
        ' AND (tickets.empleados_id = :empleados_id);')
    Left = 280
    Top = 176
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
    object FDQueryInformeDetallefecha: TSQLTimeStampField
      FieldName = 'fecha'
      Origin = 'fecha'
    end
    object FDQueryInformeDetallesectores_id: TIntegerField
      FieldName = 'sectores_id'
      Origin = 'sectores_id'
    end
    object FDQueryInformeDetalletipos_id: TIntegerField
      FieldName = 'tipos_id'
      Origin = 'tipos_id'
    end
    object FDQueryInformeDetalleempleados_id: TIntegerField
      FieldName = 'empleados_id'
      Origin = 'empleados_id'
    end
    object FDQueryInformeDetalleletra: TWideStringField
      FieldName = 'letra'
      Origin = 'letra'
      Size = 1
    end
    object FDQueryInformeDetallereal: TIntegerField
      FieldName = 'real'
      Origin = '[real]'
    end
    object FDQueryInformeDetalleorden: TIntegerField
      FieldName = 'orden'
      Origin = 'orden'
    end
    object FDQueryInformeDetalledesde: TIntegerField
      FieldName = 'desde'
      Origin = 'desde'
    end
  end
  object DataSourceInforme: TDataSource
    AutoEdit = False
    DataSet = FDQueryInforme
    Left = 168
    Top = 208
  end
  object FDQueryAnticipos: TFDQuery
    AfterInsert = FDQueryAnticiposAfterInsert
    BeforePost = FDQueryAnticiposBeforePost
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
    Left = 480
    Top = 440
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
    object FDQueryAnticiposid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQueryAnticiposempleados_id: TIntegerField
      FieldName = 'empleados_id'
      Origin = 'empleados_id'
    end
    object FDQueryAnticiposfecha: TSQLTimeStampField
      FieldName = 'fecha'
      Origin = 'fecha'
    end
    object FDQueryAnticiposcantidad: TCurrencyField
      FieldName = 'cantidad'
      Origin = 'cantidad'
    end
    object FDQueryAnticiposAN: TSmallintField
      FieldName = 'AN'
      Origin = 'fecha'
      ProviderFlags = []
    end
    object FDQueryAnticiposMO: TSmallintField
      FieldName = 'MO'
      Origin = 'fecha'
      ProviderFlags = []
    end
  end
  object DataSourceAnticipos: TDataSource
    DataSet = FDQueryAnticipos
    Left = 480
    Top = 496
  end
  object FDQueryObservaciones: TFDQuery
    AfterInsert = FDQueryObservacionesAfterInsert
    BeforePost = FDQueryObservacionesBeforePost
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT'
      'observaciones.id, observaciones.empleados_id,'
      'observaciones.fecha, observaciones.observacion,'
      'observaciones.visto'
      'FROM observaciones'
      'WHERE empleados_id = :E')
    Left = 672
    Top = 368
    ParamData = <
      item
        Name = 'E'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object FDQueryObservacionesid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQueryObservacionesempleados_id: TIntegerField
      FieldName = 'empleados_id'
      Origin = 'empleados_id'
    end
    object FDQueryObservacionesfecha: TSQLTimeStampField
      FieldName = 'fecha'
      Origin = 'fecha'
    end
    object FDQueryObservacionesobservacion: TWideMemoField
      FieldName = 'observacion'
      Origin = 'observacion'
      BlobType = ftMemo
    end
    object FDQueryObservacionesvisto: TBooleanField
      FieldName = 'visto'
      Origin = 'visto'
      Required = True
    end
  end
  object DataSourceObservaciones: TDataSource
    DataSet = FDQueryObservaciones
    Left = 672
    Top = 432
  end
  object FDQueryEstados: TFDQuery
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT estados.id, estados.descripcion'
      'FROM estados;')
    Left = 688
    Top = 192
  end
  object DataSourceEstados: TDataSource
    AutoEdit = False
    DataSet = FDQueryEstados
    Left = 696
    Top = 248
  end
  object FDQuerySumaTicketsDados: TFDQuery
    OnCalcFields = FDQuerySumaTicketsDadosCalcFields
    MasterSource = DataSourceTickets
    MasterFields = 'empleados_id;fecha'
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT'
      'tickets.fecha,'
      'tickets.empleados_id,'
      'tickets.tipos_id,'
      'Sum(tickets.desde) AS SD,'
      'Sum(tickets.real) AS SR,'
      
        'Sum(IIf(([tickets].[real]-[tickets].[desde])>0,([tickets].[real]' +
        '-[tickets].[desde])+1,0)) AS diferencia'
      'FROM'
      'tickets'
      'WHERE'
      
        '(tickets.empleados_id = :empleados_id) AND (tickets.fecha = :fec' +
        'ha)'
      'GROUP BY'
      'tickets.fecha,'
      'tickets.empleados_id,'
      'tickets.tipos_id;')
    Left = 360
    Top = 392
    ParamData = <
      item
        Name = 'EMPLEADOS_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'FECHA'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end>
    object SQLTimeStampField1: TSQLTimeStampField
      FieldName = 'fecha'
      Origin = 'fecha'
    end
    object IntegerField1: TIntegerField
      FieldName = 'empleados_id'
      Origin = 'empleados_id'
    end
    object IntegerField2: TIntegerField
      FieldName = 'tipos_id'
      Origin = 'tipos_id'
    end
    object FloatField1: TFloatField
      AutoGenerateValue = arDefault
      FieldName = 'SD'
      Origin = 'SD'
      ProviderFlags = []
      ReadOnly = True
    end
    object FloatField2: TFloatField
      AutoGenerateValue = arDefault
      FieldName = 'SR'
      Origin = 'SR'
      ProviderFlags = []
      ReadOnly = True
    end
    object CurrencyField1: TCurrencyField
      FieldKind = fkLookup
      FieldName = 'mprecio'
      LookupDataSet = FDQueryTipos
      LookupKeyFields = 'id'
      LookupResultField = 'precio'
      KeyFields = 'tipos_id'
      Lookup = True
    end
    object IntegerField3: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'importe'
      Calculated = True
    end
    object IntegerField4: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'cantidad'
      Calculated = True
    end
    object StringField1: TStringField
      FieldKind = fkLookup
      FieldName = 'nomtipo'
      LookupDataSet = FDQueryTipos
      LookupKeyFields = 'id'
      LookupResultField = 'nombre'
      KeyFields = 'tipos_id'
      Size = 150
      Lookup = True
    end
    object FloatField3: TFloatField
      AutoGenerateValue = arDefault
      FieldName = 'diferencia'
      Origin = 'diferencia'
      ProviderFlags = []
      ReadOnly = True
    end
  end
  object DataSourceSumaTicketsDados: TDataSource
    AutoEdit = False
    DataSet = FDQuerySumaTicketsDados
    Left = 360
    Top = 440
  end
  object DataSourcePlayas: TDataSource
    AutoEdit = False
    DataSet = FDQueryPlayas
    Left = 536
    Top = 200
  end
  object FDQueryBaseSectores: TFDQuery
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT'
      'sectores.id, sectores.playas_id, sectores.sector'
      'FROM sectores')
    Left = 544
    Top = 48
    object FDQueryBaseSectoresid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQueryBaseSectoresplayas_id: TIntegerField
      FieldName = 'playas_id'
      Origin = 'playas_id'
    end
    object FDQueryBaseSectoressector: TWideStringField
      FieldName = 'sector'
      Origin = 'sector'
      Size = 255
    end
  end
  object DataSourceBaseSectores: TDataSource
    DataSet = FDQueryBaseSectores
    Left = 544
    Top = 96
  end
  object FDQueryInformeEmpleado: TFDQuery
    OnCalcFields = FDQueryInformeEmpleadoCalcFields
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT tickets.fecha, tickets.empleados_id'
      'FROM tickets'
      'WHERE'
      ' (tickets.empleados_id >= :EI) AND'
      ' (tickets.empleados_id <= :EF) AND'
      ' (tickets.fecha >= :FI) AND'
      ' (tickets.fecha <= :FF)'
      'GROUP BY tickets.fecha, tickets.empleados_id'
      'ORDER BY tickets.empleados_id;')
    Left = 800
    Top = 48
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
    object FDQueryInformeEmpleadofecha: TSQLTimeStampField
      FieldName = 'fecha'
      Origin = 'fecha'
    end
    object FDQueryInformeEmpleadoempleados_id: TIntegerField
      FieldName = 'empleados_id'
      Origin = 'empleados_id'
    end
    object FDQueryInformeEmpleadohamacas: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'hamacas'
      Calculated = True
    end
    object FDQueryInformeEmpleadosombrillas: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'sombrillas'
      Calculated = True
    end
    object FDQueryInformeEmpleadototal: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'total'
      Calculated = True
    end
    object FDQueryInformeEmpleadototaleuros: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'totaleuros'
      Calculated = True
    end
    object FDQueryInformeEmpleadonomempleado: TStringField
      FieldKind = fkLookup
      FieldName = 'nomempleado'
      LookupDataSet = FDQueryEmpleados
      LookupKeyFields = 'id'
      LookupResultField = 'nombre'
      KeyFields = 'empleados_id'
      Size = 200
      Lookup = True
    end
    object FDQueryInformeEmpleadofeca: TDateField
      FieldKind = fkCalculated
      FieldName = 'feca'
      Calculated = True
    end
  end
  object FDQueryInformeEmpleadoDetalle: TFDQuery
    MasterSource = DataSourceInformeEmpleado
    MasterFields = 'feca;empleados_id'
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT'
      'tickets.fecha,'
      'tickets.empleados_id,'
      'tickets.tipos_id,'
      'Sum(tickets.desde) AS SD,'
      'Sum(tickets.real) AS SR,'
      
        'Sum(IIf(([tickets].[real]-[tickets].[desde])>0,([tickets].[real]' +
        '-[tickets].[desde])+1,0)) AS diferencia'
      'FROM'
      'tickets'
      'WHERE'
      
        '(tickets.empleados_id = :empleados_id) AND (tickets.fecha = :fec' +
        'a)'
      'GROUP BY'
      'tickets.fecha,'
      'tickets.empleados_id,'
      'tickets.tipos_id;')
    Left = 800
    Top = 168
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
    object FDQueryInformeEmpleadoDetallefecha: TSQLTimeStampField
      FieldName = 'fecha'
      Origin = 'fecha'
    end
    object FDQueryInformeEmpleadoDetalleempleados_id: TIntegerField
      FieldName = 'empleados_id'
      Origin = 'empleados_id'
    end
    object FDQueryInformeEmpleadoDetalletipos_id: TIntegerField
      FieldName = 'tipos_id'
      Origin = 'tipos_id'
    end
    object FDQueryInformeEmpleadoDetalleSD: TFloatField
      AutoGenerateValue = arDefault
      FieldName = 'SD'
      Origin = 'SD'
      ProviderFlags = []
      ReadOnly = True
    end
    object FDQueryInformeEmpleadoDetalleSR: TFloatField
      AutoGenerateValue = arDefault
      FieldName = 'SR'
      Origin = 'SR'
      ProviderFlags = []
      ReadOnly = True
    end
    object FDQueryInformeEmpleadoDetallediferencia: TFloatField
      AutoGenerateValue = arDefault
      FieldName = 'diferencia'
      Origin = 'diferencia'
      ProviderFlags = []
      ReadOnly = True
    end
  end
  object DataSourceInformeEmpleado: TDataSource
    AutoEdit = False
    DataSet = FDQueryInformeEmpleado
    Left = 800
    Top = 96
  end
  object FDQueryInformeSectores: TFDQuery
    OnCalcFields = FDQueryInformeSectoresCalcFields
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT tickets.fecha, tickets.sectores_id'
      'FROM tickets'
      'WHERE'
      ' (tickets.sectores_id >= :SI) AND'
      ' (tickets.sectores_id <= :SF) AND'
      ' (tickets.fecha >= :FI) AND'
      ' (tickets.fecha <= :FF)'
      'GROUP BY tickets.fecha, tickets.sectores_id'
      'ORDER BY tickets.sectores_id;')
    Left = 816
    Top = 264
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
    object FDQueryInformeSectoresfecha: TSQLTimeStampField
      FieldName = 'fecha'
      Origin = 'fecha'
    end
    object FDQueryInformeSectoressectores_id: TIntegerField
      FieldName = 'sectores_id'
      Origin = 'sectores_id'
    end
    object FDQueryInformeSectoreshamacas: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'hamacas'
      Calculated = True
    end
    object FDQueryInformeSectoressombrillas: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'sombrillas'
      Calculated = True
    end
    object FDQueryInformeSectorestotal: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'total'
      Calculated = True
    end
    object FDQueryInformeSectorestotaleuros: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'totaleuros'
      Calculated = True
    end
    object FDQueryInformeSectoresfeca: TDateField
      FieldKind = fkCalculated
      FieldName = 'feca'
      Calculated = True
    end
    object FDQueryInformeSectoresnomsector: TStringField
      FieldKind = fkLookup
      FieldName = 'nomsector'
      LookupDataSet = FDQuerySectores
      LookupKeyFields = 'id'
      LookupResultField = 'sector'
      KeyFields = 'sectores_id'
      Size = 200
      Lookup = True
    end
    object FDQueryInformeSectoresnomplaya: TStringField
      FieldKind = fkLookup
      FieldName = 'nomplaya'
      LookupDataSet = FDQuerySectores
      LookupKeyFields = 'id'
      LookupResultField = 'playa'
      KeyFields = 'sectores_id'
      Size = 200
      Lookup = True
    end
  end
  object DataSourceInformeSectores: TDataSource
    AutoEdit = False
    DataSet = FDQueryInformeSectores
    Left = 816
    Top = 328
  end
  object FDQueryInformeSectoresDetalle: TFDQuery
    MasterSource = DataSourceInformeSectores
    MasterFields = 'sectores_id;feca'
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT'
      'tickets.fecha,'
      'tickets.sectores_id,'
      'tickets.tipos_id,'
      'Sum(tickets.desde) AS SD,'
      'Sum(tickets.real) AS SR,'
      
        'Sum(IIf(([tickets].[real]-[tickets].[desde])>0,([tickets].[real]' +
        '-[tickets].[desde])+1,0)) AS diferencia'
      'FROM'
      'tickets'
      'WHERE'
      '(tickets.sectores_id = :sectores_id) AND (tickets.fecha = :feca)'
      'GROUP BY'
      'tickets.fecha,'
      'tickets.sectores_id,'
      'tickets.tipos_id;')
    Left = 824
    Top = 408
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
    object FDQueryInformeSectoresDetallefecha: TSQLTimeStampField
      FieldName = 'fecha'
      Origin = 'fecha'
    end
    object FDQueryInformeSectoresDetallesectores_id: TIntegerField
      FieldName = 'sectores_id'
      Origin = 'sectores_id'
    end
    object FDQueryInformeSectoresDetalletipos_id: TIntegerField
      FieldName = 'tipos_id'
      Origin = 'tipos_id'
    end
    object FDQueryInformeSectoresDetalleSD: TFloatField
      AutoGenerateValue = arDefault
      FieldName = 'SD'
      Origin = 'SD'
      ProviderFlags = []
      ReadOnly = True
    end
    object FDQueryInformeSectoresDetalleSR: TFloatField
      AutoGenerateValue = arDefault
      FieldName = 'SR'
      Origin = 'SR'
      ProviderFlags = []
      ReadOnly = True
    end
    object FDQueryInformeSectoresDetallediferencia: TFloatField
      AutoGenerateValue = arDefault
      FieldName = 'diferencia'
      Origin = 'diferencia'
      ProviderFlags = []
      ReadOnly = True
    end
  end
  object FDQueryInformeAnticipos: TFDQuery
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
    Left = 792
    Top = 464
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
    object FDQueryInformeAnticiposid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQueryInformeAnticiposempleados_id: TIntegerField
      FieldName = 'empleados_id'
      Origin = 'empleados_id'
    end
    object FDQueryInformeAnticiposfecha: TSQLTimeStampField
      FieldName = 'fecha'
      Origin = 'fecha'
    end
    object FDQueryInformeAnticiposcantidad: TCurrencyField
      FieldName = 'cantidad'
      Origin = 'cantidad'
    end
    object FDQueryInformeAnticiposnomempleado: TStringField
      FieldKind = fkLookup
      FieldName = 'nomempleado'
      LookupDataSet = FDQueryEmpleados
      LookupKeyFields = 'id'
      LookupResultField = 'nombre'
      KeyFields = 'empleados_id'
      Size = 200
      Lookup = True
    end
  end
  object DataSourceInformeAnticipos: TDataSource
    AutoEdit = False
    DataSet = FDQueryInformeAnticipos
    Left = 792
    Top = 520
  end
  object FDQueryUltimosTickets: TFDQuery
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT'
      'Max(tickets.fecha) AS MF,'
      'tickets.empleados_id'
      'FROM tickets'
      'GROUP BY'
      'tickets.empleados_id'
      'HAVING'
      '(Max(tickets.fecha) > :F)'
      'ORDER BY'
      'Max(tickets.fecha);'
      '')
    Left = 624
    Top = 496
    ParamData = <
      item
        Name = 'F'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end>
  end
  object FDQueryResumenTickets: TFDQuery
    Connection = DataModulePrincipal.FDConnection1
    UpdateOptions.AssignedValues = [uvUpdateNonBaseFields]
    SQL.Strings = (
      'SELECT'
      ' tickets.id, tickets.fecha, tickets.empleados_id,'
      ' tickets.sectores_id, tickets.tipos_id, tickets.letra,'
      
        ' empleados.nombre, tickets.desde, tickets.hasta, tickets.real, t' +
        'ickets.orden,'
      ' tickets.orden2, tickets.facturado, tickets.referencia_id'
      
        'FROM tickets INNER JOIN empleados ON empleados.id = tickets.empl' +
        'eados_id;'
      '')
    Left = 328
    Top = 248
    object FDQueryResumenTicketsid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQueryResumenTicketsfecha: TSQLTimeStampField
      FieldName = 'fecha'
      Origin = 'fecha'
    end
    object FDQueryResumenTicketsempleados_id: TIntegerField
      FieldName = 'empleados_id'
      Origin = 'empleados_id'
    end
    object FDQueryResumenTicketssectores_id: TIntegerField
      FieldName = 'sectores_id'
      Origin = 'sectores_id'
    end
    object FDQueryResumenTicketstipos_id: TIntegerField
      FieldName = 'tipos_id'
      Origin = 'tipos_id'
    end
    object FDQueryResumenTicketsletra: TWideStringField
      FieldName = 'letra'
      Origin = 'letra'
      Size = 1
    end
    object FDQueryResumenTicketsdesde: TIntegerField
      FieldName = 'desde'
      Origin = 'desde'
    end
    object FDQueryResumenTicketshasta: TIntegerField
      FieldName = 'hasta'
      Origin = 'hasta'
    end
    object FDQueryResumenTicketsreal: TIntegerField
      FieldName = 'real'
      Origin = '[real]'
    end
    object FDQueryResumenTicketsorden: TIntegerField
      FieldName = 'orden'
      Origin = 'orden'
    end
    object FDQueryResumenTicketsorden2: TIntegerField
      FieldName = 'orden2'
      Origin = 'orden2'
    end
    object FDQueryResumenTicketsreferencia_id: TIntegerField
      FieldName = 'referencia_id'
      Origin = 'referencia_id'
    end
    object FDQueryResumenTicketsnombre: TWideStringField
      FieldName = 'nombre'
      Origin = 'nombre'
      Size = 255
    end
    object FDQueryResumenTicketsfacturado: TBooleanField
      FieldName = 'facturado'
      Origin = 'facturado'
      Required = True
    end
  end
  object DataSourceResumenTickets: TDataSource
    AutoEdit = False
    DataSet = FDQueryResumenTickets
    Left = 336
    Top = 304
  end
  object FDQueryVacaciones: TFDQuery
    OnCalcFields = FDQueryVacacionesCalcFields
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT'
      
        'tickets.fecha, tickets.sectores_id, sectores.sector, tickets.fac' +
        'turado,'
      'tickets.empleados_id, empleados.nombre,'
      'sectores.playas_id, playas.playa, playas.orden_impresion'
      'FROM'
      
        '(playas INNER JOIN sectores ON playas.id = sectores.playas_id) I' +
        'NNER JOIN (empleados INNER JOIN tickets ON empleados.id = ticket' +
        's.empleados_id) ON sectores.id = tickets.sectores_id'
      'WHERE'
      '(tickets.fecha > :FE) AND (tickets.facturado = False)'
      
        'GROUP BY tickets.fecha, tickets.sectores_id, sectores.sector, ti' +
        'ckets.facturado, tickets.empleados_id, empleados.nombre, sectore' +
        's.playas_id, playas.playa, playas.orden_impresion'
      
        'ORDER BY tickets.fecha, tickets.sectores_id, tickets.empleados_i' +
        'd;')
    Left = 184
    Top = 544
    ParamData = <
      item
        Name = 'FE'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end>
    object FDQueryVacacionesfecha: TSQLTimeStampField
      FieldName = 'fecha'
      Origin = 'fecha'
    end
    object FDQueryVacacionessectores_id: TIntegerField
      FieldName = 'sectores_id'
      Origin = 'sectores_id'
    end
    object FDQueryVacacionessector: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'sector'
      Origin = 'sector'
      ProviderFlags = []
      ReadOnly = True
      Size = 255
    end
    object FDQueryVacacionesempleados_id: TIntegerField
      FieldName = 'empleados_id'
      Origin = 'empleados_id'
    end
    object FDQueryVacacionesnombre: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'nombre'
      Origin = 'nombre'
      ProviderFlags = []
      ReadOnly = True
      Size = 255
    end
    object FDQueryVacacionesplayas_id: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'playas_id'
      Origin = 'playas_id'
      ProviderFlags = []
      ReadOnly = True
    end
    object FDQueryVacacionesplaya: TWideStringField
      AutoGenerateValue = arDefault
      FieldName = 'playa'
      Origin = 'playa'
      ProviderFlags = []
      ReadOnly = True
      Size = 255
    end
    object FDQueryVacacionesorden_impresion: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'orden_impresion'
      Origin = 'orden_impresion'
      ProviderFlags = []
      ReadOnly = True
    end
    object FDQueryVacacionesfeca: TDateField
      FieldKind = fkCalculated
      FieldName = 'feca'
      Calculated = True
    end
    object FDQueryVacacionesnumeros: TStringField
      FieldKind = fkCalculated
      FieldName = 'numeros'
      Size = 2000
      Calculated = True
    end
    object FDQueryVacacionesnumeros1: TStringField
      FieldKind = fkCalculated
      FieldName = 'numeros1'
      Size = 2000
      Calculated = True
    end
  end
  object FDQueryDetalleVacaciones: TFDQuery
    MasterSource = DataSourceVacaciones
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
        ' AND (tickets.empleados_id = :empleados_id);')
    Left = 312
    Top = 544
    ParamData = <
      item
        Name = 'FECA'
        DataType = ftDate
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
  end
  object DataSourceVacaciones: TDataSource
    AutoEdit = False
    DataSet = FDQueryVacaciones
    Left = 184
    Top = 600
  end
  object FDQueryUltimoSector: TFDQuery
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      
        'SELECT Max(tickets.fecha) AS MF, tickets.empleados_id, Last(tick' +
        'ets.sectores_id) AS US_id'
      'FROM tickets'
      'WHERE tickets.empleados_id = :E'
      'GROUP BY tickets.empleados_id;'
      '')
    Left = 624
    Top = 560
    ParamData = <
      item
        Name = 'E'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object FDQueryUltimoSectorMF: TSQLTimeStampField
      AutoGenerateValue = arDefault
      FieldName = 'MF'
      Origin = 'MF'
      ProviderFlags = []
      ReadOnly = True
    end
    object FDQueryUltimoSectorempleados_id: TIntegerField
      FieldName = 'empleados_id'
      Origin = 'empleados_id'
    end
    object FDQueryUltimoSectorUS_id: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'US_id'
      Origin = 'US_id'
      ProviderFlags = []
      ReadOnly = True
    end
  end
  object FDQueryRestoVacaciones: TFDQuery
    Connection = DataModulePrincipal.FDConnection1
    SQL.Strings = (
      'SELECT empleados.id, empleados.nombre, empleados.estado_id'
      
        'FROM empleados LEFT JOIN tickets ON empleados.id = tickets.emple' +
        'ados_id'
      'WHERE NOT EXISTS'
      '(SELECT tickets.empleados_id, tickets.fecha, tickets.facturado'
      'FROM tickets'
      
        'WHERE ((empleados.id = tickets.empleados_id) AND (tickets.fecha ' +
        '>= :F ) AND (tickets.facturado = False))) AND (empleados.estado_' +
        'id < 4)'
      'GROUP BY empleados.id, empleados.nombre, empleados.estado_id')
    Left = 392
    Top = 600
    ParamData = <
      item
        Name = 'F'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end>
    object FDQueryRestoVacacionesid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQueryRestoVacacionesnombre: TWideStringField
      FieldName = 'nombre'
      Origin = 'nombre'
      Size = 255
    end
    object FDQueryRestoVacacionesestado_id: TIntegerField
      FieldName = 'estado_id'
      Origin = 'estado_id'
    end
  end
  object DataSourceRestoVacaciones: TDataSource
    DataSet = FDQueryRestoVacaciones
    Left = 488
    Top = 632
  end
  object FDQueryInformeObservacion: TFDQuery
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
    Left = 792
    Top = 576
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
    object FDQueryInformeObservacionid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object FDQueryInformeObservacionempleados_id: TIntegerField
      FieldName = 'empleados_id'
      Origin = 'empleados_id'
    end
    object FDQueryInformeObservacionfecha: TSQLTimeStampField
      FieldName = 'fecha'
      Origin = 'fecha'
    end
    object FDQueryInformeObservacionobservacion: TWideMemoField
      FieldName = 'observacion'
      Origin = 'observacion'
      BlobType = ftWideMemo
    end
    object FDQueryInformeObservacionvisto: TBooleanField
      FieldName = 'visto'
      Origin = 'visto'
      Required = True
    end
    object FDQueryInformeObservacionnomempleados: TStringField
      FieldKind = fkLookup
      FieldName = 'nomempleados'
      LookupDataSet = FDQueryEmpleados
      LookupKeyFields = 'id'
      LookupResultField = 'nombre'
      KeyFields = 'empleados_id'
      Size = 200
      Lookup = True
    end
  end
  object DataSourceInformeObservacion: TDataSource
    AutoEdit = False
    DataSet = FDQueryInformeObservacion
    Left = 792
    Top = 632
  end
end
