object DataModulePrincipal: TDataModulePrincipal
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 375
  Width = 552
  object FDConnection1: TFDConnection
    Params.Strings = (
      'User_Name=admin'
      'DriverID=MSAcc')
    LoginPrompt = False
    Left = 160
    Top = 136
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 384
    Top = 200
  end
  object FDPhysMSAccessDriverLink1: TFDPhysMSAccessDriverLink
    Left = 352
    Top = 112
  end
end
