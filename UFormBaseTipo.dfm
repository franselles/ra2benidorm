object FormBaseTipos: TFormBaseTipos
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Alquiler de ...'
  ClientHeight = 280
  ClientWidth = 494
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
    Left = 8
    Top = 8
    Width = 476
    Height = 49
    DataSource = DataModuleTalonarios.dsTipos
    VisibleButtons = [nbPrior, nbNext, nbInsert, nbEdit, nbPost, nbCancel, nbRefresh]
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
    Left = 8
    Top = 63
    Width = 476
    Height = 138
    AutoFitColWidths = True
    DataSource = DataModuleTalonarios.dsTipos
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
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'nombre'
        Footers = <>
        Width = 127
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'precio'
        Footers = <>
      end
      item
        DynProps = <>
        EditButtons = <>
        FieldName = 'letra'
        Footers = <>
        Width = 48
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object Button1: TButton
    Left = 371
    Top = 216
    Width = 113
    Height = 49
    Caption = 'CERRAR'
    TabOrder = 2
    OnClick = Button1Click
  end
end
