program RA2;

uses
  Vcl.Forms,
  MidasLib,
  UDMPrincipal in 'UDMPrincipal.pas' {DataModulePrincipal: TDataModule},
  UDataModuleTalonarios in 'UDataModuleTalonarios.pas' {DataModuleTalonarios: TDataModule},
  UFormPrincipal in 'UFormPrincipal.pas' {FormPrincipal},
  UFrameTickets in 'UFrameTickets.pas' {FrameTickets: TFrame},
  Vcl.Themes,
  Vcl.Styles,
  UFormImprimeFactEmpleados in 'UFormImprimeFactEmpleados.pas' {FormImprimeFactEmpleados},
  UFormImprimeFactSectores in 'UFormImprimeFactSectores.pas' {FormImprimeFactSectores},
  UFormEliminaDatosObserva in 'UFormEliminaDatosObserva.pas' {FormEliminaDatosObserva},
  UFormBaseEmpleados in 'UFormBaseEmpleados.pas' {FormBaseEmpleados},
  UFormBaseSectores in 'UFormBaseSectores.pas' {FormBaseSectores},
  UFormImprimeObservaciones in 'UFormImprimeObservaciones.pas' {FormImprimeObservaciones},
  UFormNumeracion in 'UFormNumeracion.pas' {FormNumeracion},
  UFormAboutBox in 'UFormAboutBox.pas' {FormAboutBox},
  UFormBaseTipo in 'UFormBaseTipo.pas' {FormBaseTipos},
  UFormImprimeAntiEmpleados in 'UFormImprimeAntiEmpleados.pas' {FormImprimeAntiEmpleados},
  UFormEliminaDatos in 'UFormEliminaDatos.pas' {FormEliminaDatos};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'RA - Gestion Hamacas';
  Application.CreateForm(TDataModulePrincipal, DataModulePrincipal);
  Application.CreateForm(TDataModuleTalonarios, DataModuleTalonarios);
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
