object FormBaseEmpleados: TFormBaseEmpleados
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Base de empleados'
  ClientHeight = 551
  ClientWidth = 631
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBNavigator1: TDBNavigator
    Left = 16
    Top = 8
    Width = 594
    Height = 41
    DataSource = DataModuleTalonarios.dsNombres
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbEdit, nbPost, nbCancel, nbRefresh]
    Hints.Strings = (
      'Primer registro'
      'Registro anterior'
      'Registro siguiente'
      'Ultimo registro'
      'A'#241'adir registro'
      'Borrar registro'
      'Editar registro'
      'Aceptar registro'
      'Cancelar registro'
      'Actualizar registro'
      'Aceptar actualizacion'
      'Cancelar actualizacion')
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
  end
  object DBGridEh1: TDBGridEh
    Left = 16
    Top = 55
    Width = 600
    Height = 434
    AllowedOperations = [alopInsertEh, alopUpdateEh, alopAppendEh]
    AutoFitColWidths = True
    DataSource = DataModuleTalonarios.dsNombres
    DynProps = <>
    Flat = True
    IndicatorOptions = [gioShowRowIndicatorEh]
    TabOrder = 1
    Columns = <
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'id'
        Footers = <>
        Title.Caption = 'ID'
        Width = 29
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'nombre'
        Footers = <>
        Title.Caption = 'COBRADOR'
        Width = 463
      end
      item
        LookupParams.KeyFieldNames = 'estado_id'
        LookupParams.LookupDataSet = DataModuleTalonarios.fdqEstados
        LookupParams.LookupDisplayFieldName = 'descripcion'
        LookupParams.LookupKeyFieldNames = 'id'
        DynProps = <>
        EditButtons = <>
        FieldName = 'estado_id'
        Footers = <>
        Title.Caption = 'ESTADO'
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object Button1: TButton
    Left = 496
    Top = 495
    Width = 120
    Height = 48
    Caption = 'CERRAR'
    TabOrder = 2
    OnClick = Button1Click
  end
end
