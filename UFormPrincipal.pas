unit UFormPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ImgList, Vcl.ComCtrls, Vcl.StdCtrls,
  System.Actions, Vcl.ActnList, Vcl.StdActns, Vcl.Menus, Vcl.ToolWin,
  Vcl.ActnMan, Vcl.ActnCtrls, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ExtCtrls,
  DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, GridsEh,
  DBAxisGridsEh, DBGridEh, Vcl.Ribbon, Vcl.RibbonLunaStyleActnCtrls,
  Vcl.ActnMenus, Vcl.RibbonActnMenus, frxClass, frxDBSet, System.DateUtils, System.UITypes,
  frxExportCSV, EhLibVCL, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdExplicitTLSClientServerBase, System.IniFiles, System.ImageList,
  frxExportBaseDialog;

type
  TFormPrincipal = class(TForm)
    ActionManager1: TActionManager;
    FileExit1: TFileExit;
    caInforme: TControlAction;
    StatusBar1: TStatusBar;
    ImageList1: TImageList;
    Panel1: TPanel;
    MonthCalendar1: TMonthCalendar;
    DBGridEh1: TDBGridEh;
    Panel2: TPanel;
    Ribbon1: TRibbon;
    EditNombreCobrador: TEdit;
    RibbonPage1: TRibbonPage;
    RibbonPage2: TRibbonPage;
    RibbonPage3: TRibbonPage;
    RibbonApplicationMenuBar1: TRibbonApplicationMenuBar;
    caRecCobradores: TControlAction;
    caRecSectores: TControlAction;
    caAnticipos: TControlAction;
    RibbonGroup1: TRibbonGroup;
    frxReportInforme: TfrxReport;
    frxDBDatasetTalonarios: TfrxDBDataset;
    frxDBDatasetRestoVacaciones: TfrxDBDataset;
    caBaseCobradores: TControlAction;
    caBaseSectores: TControlAction;
    RibbonGroup2: TRibbonGroup;
    caCopiaBase: TControlAction;
    RibbonGroup3: TRibbonGroup;
    caImpObseraciones: TControlAction;
    caInfo: TControlAction;
    caBorrarBD: TControlAction;
    caRestaurar: TControlAction;
    OpenDialog1: TOpenDialog;
    RibbonGroup4: TRibbonGroup;
    caNoLiquidacion: TControlAction;
    frxCSVExport1: TfrxCSVExport;
    caTipos: TControlAction;
    RibbonGroup5: TRibbonGroup;
    caZoomMasLetra: TControlAction;
    caZoomMenos: TControlAction;
    caInformeUno: TControlAction;
    RibbonGroup6: TRibbonGroup;
    caBorraAnticipos: TControlAction;
    caBorraObserva: TControlAction;
    RibbonGroup8: TRibbonGroup;
    lBaseDatosActiva: TLabel;
    caOtrabase: TControlAction;
    caCopiaFTP: TControlAction;
    caPonerLiquidado: TControlAction;
    frxDBDatasetPatines: TfrxDBDataset;
    caPatines: TControlAction;
    procedure caInformeExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EditNombreCobradorChange(Sender: TObject);
    procedure MonthCalendar1Click(Sender: TObject);
    procedure caRecCobradoresExecute(Sender: TObject);
    procedure caRecSectoresExecute(Sender: TObject);
    procedure caAnticiposExecute(Sender: TObject);
    procedure frxReportInformeGetValue(const VarName: string;
      var Value: Variant);
    procedure caBaseCobradoresExecute(Sender: TObject);
    procedure caBaseSectoresExecute(Sender: TObject);
    procedure caCopiaBaseExecute(Sender: TObject);
    procedure caImpObseracionesExecute(Sender: TObject);
    procedure caInfoExecute(Sender: TObject);
    procedure caBorrarBDExecute(Sender: TObject);
    procedure caRestaurarExecute(Sender: TObject);
    procedure caNoLiquidacionExecute(Sender: TObject);
    procedure caSiLiquidacionExecute(Sender: TObject);
    procedure caTiposExecute(Sender: TObject);
    procedure caZoomMasLetraExecute(Sender: TObject);
    procedure caZoomMenosExecute(Sender: TObject);
    procedure caInformeUnoExecute(Sender: TObject);
    procedure caBorraAnticiposExecute(Sender: TObject);
    procedure caBorraObservaExecute(Sender: TObject);
    procedure lBaseDatosActivaClick(Sender: TObject);
    procedure caOtrabaseExecute(Sender: TObject);
    procedure caPatinesExecute(Sender: TObject);
  private
    { Private declarations }
    Authenticated: Boolean;
    procedure ShowFrame(FrameName: string; PanelName: string);
    procedure ExecMethod(OnObject: TObject; MethodName: string) ;
  public
    { Public declarations }
    procedure ActualizaEvento();
    procedure ActualizaMas();
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

uses
  UDataModuleTalonarios, UDMPrincipal, UFormImprimeFactEmpleados,
  UFormImprimeFactSectores, UFormImprimeAntiEmpleados, UFormBaseEmpleados,
  UFormBaseSectores, UFormImprimeObservaciones, UFormAboutBox, UFormBaseTipo,
  UFormEliminaDatos, UFormEliminaDatosObserva;

{$R *.dfm}

type
  TFrameClass = class of TFrame;

type
   TExec = procedure of object;

procedure TFormPrincipal.ExecMethod(OnObject: TObject; MethodName: string) ;
var
   Routine: TMethod;
   Exec: TExec;
begin
   Routine.Data := Pointer(OnObject) ;
   Routine.Code := OnObject.MethodAddress(MethodName) ;
   if NOT Assigned(Routine.Code) then Exit;
   Exec := TExec(Routine) ;
   Exec;
end;

procedure TFormPrincipal.caInformeExecute(Sender: TObject);
begin
  DataModuleTalonarios.ImprimeInformeDia;
  if frxReportInforme.LoadFromFile('.\reporte_dia.fr3') then
    if frxReportInforme.PrepareReport(True) then
        frxReportInforme.ShowPreparedReport;
end;

procedure TFormPrincipal.caInformeUnoExecute(Sender: TObject);
begin
  DataModuleTalonarios.ImprimeInformeDia;
  if frxReportInforme.LoadFromFile('.\reporte_dia_uno.fr3') then
    if frxReportInforme.PrepareReport(True) then
        frxReportInforme.ShowPreparedReport;
end;

procedure TFormPrincipal.ShowFrame(FrameName: string; PanelName: string);
var
  Frame: TFrame;
  FrameClass: TFrameClass;
begin
  Frame := FindComponent(FrameName) as TFrame;
  //if Assigned(Frame) then
  //Frame.Free;
  if Assigned(Frame) then
  begin
    Frame.Destroy;
    Frame := FindComponent(FrameName) as TFrame;
  end;

  if not Assigned(Frame) then
  begin
    FrameClass := TFrameClass(FindClass ('T' + FrameName));
    Frame := FrameClass.Create(Self);
    Frame.Parent := FindComponent(PanelName) as TPanel;
    Frame.Visible := True;
    Frame.Name := FrameName;
    Frame.Align := alClient;
  end;
  Frame.BringToFront;

end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
  ShowFrame('FrameTickets', 'Panel2');
  MonthCalendar1.Date := Date();
  DataModuleTalonarios.talonario.fecha := MonthCalendar1.Date;
  DataModuleTalonarios.base.fecha := DataModuleTalonarios.talonario.fecha;
  DataModuleTalonarios.AbreDatosBasicos();
  DataModuleTalonarios.AbreCobradores(4);
  lBaseDatosActiva.Caption := DataModulePrincipal.nombasedatos;
end;

procedure TFormPrincipal.EditNombreCobradorChange(Sender: TObject);
begin
  DataModuleTalonarios.FiltraCobradores(EditNombreCobrador.Text);
end;

procedure TFormPrincipal.MonthCalendar1Click(Sender: TObject);
begin
  DataModuleTalonarios.base.fecha := MonthCalendar1.Date;
  DataModuleTalonarios.talonario.fecha := MonthCalendar1.Date;
end;

procedure TFormPrincipal.ActualizaEvento();
var
  Frame: TFrame;
begin
  Frame := FindComponent('FrameTickets') as TFrame;
  ExecMethod(Frame, 'ActualizaSector');
end;

procedure TFormPrincipal.caRecCobradoresExecute(Sender: TObject);
begin
  FormImprimeFactEmpleados := TFormImprimeFactEmpleados.Create(Application);
  FormImprimeFactEmpleados.ShowModal;
  FormImprimeFactEmpleados.FreeOnRelease;
end;

procedure TFormPrincipal.caRecSectoresExecute(Sender: TObject);
begin
  FormImprimeFactSectores := TFormImprimeFactSectores.Create(Application);
  FormImprimeFactSectores.ShowModal;
  FormImprimeFactSectores.FreeOnRelease;
end;

procedure TFormPrincipal.caAnticiposExecute(Sender: TObject);
begin
  FormImprimeAntiEmpleados := TFormImprimeAntiEmpleados.Create(Application);
  FormImprimeAntiEmpleados.ShowModal;
  FormImprimeAntiEmpleados.FreeOnRelease;
end;

procedure TFormPrincipal.frxReportInformeGetValue(const VarName: string;
  var Value: Variant);
begin
  if CompareText(VarName, 'fecha_informe') = 0 then
     Value := StrToDate(FormatDateTime('dd/mm/yyyy', IncDay(DataModuleTalonarios.base.fecha)));
end;

procedure TFormPrincipal.lBaseDatosActivaClick(Sender: TObject);
begin
  ShowMessage(DataModulePrincipal.basedatos);
end;

procedure TFormPrincipal.caBaseCobradoresExecute(Sender: TObject);
begin
  FormBaseEmpleados := TFormBaseEmpleados.Create(Application);
  FormBaseEmpleados.ShowModal;
  FormBaseEmpleados.FreeOnRelease;
end;

procedure TFormPrincipal.caBaseSectoresExecute(Sender: TObject);
begin
  FormBaseSectores := TFormBaseSectores.Create(Application);
  FormBaseSectores.ShowModal;
  FormBaseSectores.FreeOnRelease;
end;

procedure TFormPrincipal.caCopiaBaseExecute(Sender: TObject);
var
  s: string;
  f: string;
  h: string;
  t: string;
  //n: string;
begin
  s := DataModulePrincipal.basedatos;
  f := FormatDateTime('ddmmyyyy', Date);
  t := ExtractFilePath(s);
  //n := ExtractFileExt(s);
  h := t + 'hamacas_be' + '_' + f + '.mlx';
  DataModulePrincipal.FDConnection1.Close;
  CopyFile(PChar(s), PChar(h), True);

  MessageDlg('Base de datos copiada ' + s + '_' + f, mtInformation, [mbOk], 0);

  DataModulePrincipal.FDConnection1.Open();
  DataModuleTalonarios.AbreDatosBasicos();
  DataModuleTalonarios.AbreCobradores(4);

end;

procedure TFormPrincipal.caImpObseracionesExecute(Sender: TObject);
begin
  FormImprimeObservaciones := TFormImprimeObservaciones.Create(Application);
  FormImprimeObservaciones.ShowModal;
  FormImprimeObservaciones.FreeOnRelease;
end;

procedure TFormPrincipal.caInfoExecute(Sender: TObject);
begin
  FormAboutBox := TFormAboutBox.Create(Application);
  FormAboutBox.ShowModal;
  FormAboutBox.FreeOnRelease;
end;

procedure TFormPrincipal.caBorraAnticiposExecute(Sender: TObject);
begin
  FormEliminaDatos := TFormEliminaDatos.Create(Application);
  FormEliminaDatos.ShowModal;
  FormEliminaDatos.FreeOnRelease;
end;

procedure TFormPrincipal.caBorraObservaExecute(Sender: TObject);
begin
  FormEliminaDatosObserva := TFormEliminaDatosObserva.Create(Application);
  FormEliminaDatosObserva.ShowModal;
  FormEliminaDatosObserva.FreeOnRelease;
end;

procedure TFormPrincipal.caBorrarBDExecute(Sender: TObject);
begin
  if MessageDlg('Borrar todos los datos?', mtConfirmation, mbYesNo,0 ) = mrYes then
    DataModuleTalonarios.BorrarBaseDatos();
end;

procedure TFormPrincipal.caRestaurarExecute(Sender: TObject);
var
  s: string;
  d: string;
  t: string;
begin
  s := ExtractFilePath(DataModulePrincipal.basedatos);
  OpenDialog1.InitialDir := s;
  if OpenDialog1.Execute = True then
  begin
    d := OpenDialog1.Files[0];
    t := s + 'hamacas_be.mlx';
    DataModulePrincipal.FDConnection1.Close;
    CopyFile(PChar(d), PChar(t), True);
    DataModulePrincipal.FDConnection1.Open();
    DataModuleTalonarios.AbreDatosBasicos();
    DataModuleTalonarios.AbreCobradores(4);
    MessageDlg('Base de datos restaurada', mtInformation, [mbOk], 0);
  end;
end;

procedure TFormPrincipal.caNoLiquidacionExecute(Sender: TObject);
begin
  if MessageDlg('Volver a habilitar la liquidacion del dia?', mtConfirmation, mbYesNo,0 ) = mrYes then
    DataModuleTalonarios.NoLiquidacion();
end;

procedure TFormPrincipal.caSiLiquidacionExecute(Sender: TObject);
begin
  if MessageDlg('Volver a marcar la liquidacion del dia?', mtConfirmation, mbYesNo,0 ) = mrYes then
    DataModuleTalonarios.SiLiquidacion();
end;

procedure TFormPrincipal.caOtrabaseExecute(Sender: TObject);
var
  s: string;
  d: string;
begin
  s := ExtractFilePath(DataModulePrincipal.basedatos);
  OpenDialog1.InitialDir := s;
  if OpenDialog1.Execute = True then
  begin
    d := OpenDialog1.Files[0];
    //t := s + 'hamacas_be.mlx';
    DataModulePrincipal.basedatos := d;
    DataModulePrincipal.nombasedatos := ExtractFileName(d);
    lBaseDatosActiva.Caption := DataModulePrincipal.nombasedatos;
    DataModulePrincipal.FDConnection1.Close;
    //CopyFile(PChar(d), PChar(t), True);
    DataModulePrincipal.FDConnection1.Params.Values['DataBase'] := d;
    DataModulePrincipal.FDConnection1.Open();
    DataModuleTalonarios.AbreDatosBasicos();
    DataModuleTalonarios.AbreCobradores(4);
    MessageDlg('Base de datos: ' + DataModulePrincipal.nombasedatos + ' ACTIVA' , mtInformation, [mbOk], 0);
  end;

end;

procedure TFormPrincipal.caPatinesExecute(Sender: TObject);
begin
  DataModuleTalonarios.ImprimeInformePatinesDia;
  if frxReportInforme.LoadFromFile('.\reporte_dia_patines.fr3') then
    if frxReportInforme.PrepareReport(True) then
        frxReportInforme.ShowPreparedReport;
end;

procedure TFormPrincipal.ActualizaMas;
var
  Frame: TFrame;
begin
  Frame := FindComponent('FrameTickets') as TFrame;
  ExecMethod(Frame, 'ActualizaMas');

end;

procedure TFormPrincipal.caTiposExecute(Sender: TObject);
begin
  FormBaseTipos := TFormBaseTipos.Create(Application);
  FormBaseTipos.ShowModal;
  FormBaseTipos.FreeOnRelease;
end;

procedure TFormPrincipal.caZoomMasLetraExecute(Sender: TObject);
var
  Frame: TFrame;
begin
  Frame := FindComponent('FrameTickets') as TFrame;
  ExecMethod(Frame, 'AumentaLetra');

end;

procedure TFormPrincipal.caZoomMenosExecute(Sender: TObject);
var
  Frame: TFrame;
begin
  Frame := FindComponent('FrameTickets') as TFrame;
  ExecMethod(Frame, 'ReduceLetra');

end;

end.
