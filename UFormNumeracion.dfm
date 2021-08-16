object FormNumeracion: TFormNumeracion
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Numeracion'
  ClientHeight = 334
  ClientWidth = 308
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 56
    Top = 104
    Width = 34
    Height = 13
    Caption = 'Desde:'
  end
  object Label2: TLabel
    Left = 56
    Top = 160
    Width = 32
    Height = 13
    Caption = 'Hasta:'
  end
  object Label3: TLabel
    Left = 56
    Top = 48
    Width = 29
    Height = 13
    Caption = 'Letra:'
  end
  object Label4: TLabel
    Left = 121
    Top = 29
    Width = 31
    Height = 13
    Caption = 'Label4'
  end
  object Label5: TLabel
    Left = 121
    Top = 85
    Width = 31
    Height = 13
    Caption = 'Label5'
  end
  object Label6: TLabel
    Left = 121
    Top = 141
    Width = 31
    Height = 13
    Caption = 'Label6'
  end
  object Label7: TLabel
    Left = 56
    Top = 203
    Width = 29
    Height = 13
    Caption = 'Precio'
  end
  object eDesde: TEdit
    Left = 112
    Top = 101
    Width = 121
    Height = 21
    TabOrder = 1
    OnKeyPress = eDesdeKeyPress
  end
  object eHasta: TEdit
    Left = 112
    Top = 157
    Width = 121
    Height = 21
    TabOrder = 2
    OnKeyPress = eHastaKeyPress
  end
  object eLetra: TEdit
    Left = 112
    Top = 45
    Width = 121
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 0
    OnKeyPress = eLetraKeyPress
  end
  object Button1: TButton
    Left = 77
    Top = 241
    Width = 75
    Height = 41
    Caption = 'CANCELAR'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 158
    Top = 241
    Width = 107
    Height = 41
    Caption = 'CAMBIAR'
    TabOrder = 4
    OnClick = Button2Click
  end
  object ePrecio: TEdit
    Left = 112
    Top = 200
    Width = 121
    Height = 21
    TabOrder = 5
    OnKeyPress = ePrecioKeyPress
  end
end
