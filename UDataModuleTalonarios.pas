unit UDataModuleTalonarios;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Datasnap.DBClient, System.DateUtils;

type
  TBase = record
    empleados_id: integer;
    fecha: TDate;
    sectores_id: integer;
    sectores_id_ant: integer;
    nombre: string;
    sector: string;
    facturado: Boolean;
    fecha_ant: TDate;
    ultimo: boolean;
    todo: boolean;
  end;

type
  TTalonario = record
    empleados_id: integer;
    fecha: TDate;
    sectores_id: integer;
    tipos_id: integer;
    facturado: boolean;
    orden: integer;
  end;

type
  TTicket  = record
    empleados_id: integer;
    tickets_id: integer;
    sectores_id: integer;
    fecha: TDate;
    tipos_id: integer;
    letra: string;
    desde: integer;
    hasta: integer;
    real: integer;
    orden: integer;
    orden2: integer;
    referencia: integer;
    facturado: boolean;
    precio: Currency;
  end;

type
  TDataModuleTalonarios = class(TDataModule)
    fdqCobradores: TFDQuery;
    fdqCobradoresid: TFDAutoIncField;
    fdqCobradoresnombre: TWideStringField;
    fdqCobradoresestado_id: TIntegerField;
    dsCobradores: TDataSource;
    fdqTickets: TFDQuery;
    fdqTicketsid: TFDAutoIncField;
    fdqTicketsfecha: TSQLTimeStampField;
    fdqTicketsempleados_id: TIntegerField;
    fdqTicketssectores_id: TIntegerField;
    fdqTicketstipos_id: TIntegerField;
    fdqTicketsletra: TWideStringField;
    fdqTicketsdesde: TIntegerField;
    fdqTicketshasta: TIntegerField;
    fdqTicketsreal: TIntegerField;
    fdqTicketsorden: TIntegerField;
    fdqTicketsfacturado: TBooleanField;
    fdqTicketsreferencia_id: TIntegerField;
    dsTickets: TDataSource;
    fdqTicketscantidad: TIntegerField;
    fdqTotalTickets: TFDQuery;
    fdqTipos: TFDQuery;
    fdqTiposid: TFDAutoIncField;
    fdqTiposnombre: TWideStringField;
    fdqTiposprecio: TCurrencyField;
    fdqTiposletra: TWideStringField;
    dsTotalTickets: TDataSource;
    fdqSectores: TFDQuery;
    fdqSectoresid: TFDAutoIncField;
    fdqSectoresplayas_id: TIntegerField;
    fdqSectoressector: TWideStringField;
    fdqPlayas: TFDQuery;
    fdqPlayasid: TFDAutoIncField;
    fdqPlayasplaya: TWideStringField;
    fdqNombres: TFDQuery;
    fdqNombresid: TFDAutoIncField;
    fdqNombresnombre: TWideStringField;
    fdqNombresestado_id: TIntegerField;
    fdqTicketsnomcobrador: TStringField;
    fdqTicketsnomsector: TStringField;
    fdqTicketsnomplaya: TStringField;
    fdqTicketsnomtipo: TStringField;
    fdqTickets2: TFDQuery;
    fdqSumaTickets: TFDQuery;
    fdqSumaTicketsfecha: TSQLTimeStampField;
    fdqSumaTicketsempleados_id: TIntegerField;
    fdqSumaTicketstipos_id: TIntegerField;
    fdqSumaTicketsSD: TFloatField;
    fdqSumaTicketsSR: TFloatField;
    fdqSumaTicketscantidad: TIntegerField;
    fdqSumaTicketsdiferencia: TFloatField;
    fdqSumaTicketsnomtipo: TStringField;
    dsSumaTickets: TDataSource;
    dsTotal: TDataSource;
    fdqTalonarios: TFDQuery;
    fdqCheckNumeros: TFDQuery;
    fdqCheckNumerostipos_id: TIntegerField;
    fdqCheckNumerosletra: TWideStringField;
    fdqCheckNumerosdesde: TIntegerField;
    fdqCheckNumerosreal: TIntegerField;
    fdqCheckNumerosid: TFDAutoIncField;
    fdqInforme: TFDQuery;
    fdqInformenumeros: TStringField;
    fdqInformenumeros1: TStringField;
    fdqInformefecha: TSQLTimeStampField;
    fdqInformesectores_id: TIntegerField;
    fdqInformeempleados_id: TIntegerField;
    fdqInformenombre: TWideStringField;
    fdqInformeplayas_id: TIntegerField;
    fdqInformeplaya: TWideStringField;
    fdqInformesector: TWideStringField;
    fdqInformefeca: TDateTimeField;
    fdqInformeorden_impresion: TIntegerField;
    dsInforme: TDataSource;
    fdqInformeDetalle: TFDQuery;
    fdqInformeDetallefecha: TSQLTimeStampField;
    fdqInformeDetallesectores_id: TIntegerField;
    fdqInformeDetalletipos_id: TIntegerField;
    fdqInformeDetalleempleados_id: TIntegerField;
    fdqInformeDetalleletra: TWideStringField;
    fdqInformeDetallereal: TIntegerField;
    fdqInformeDetalleorden: TIntegerField;
    fdqInformeDetalledesde: TIntegerField;
    fdqTalonariosempleados_id: TIntegerField;
    fdqTalonariosfecha: TSQLTimeStampField;
    fdqTalonariossectores_id: TIntegerField;
    fdqTalonariosfacturado: TBooleanField;
    fdqTalonariosestado: TStringField;
    dsTalonarios: TDataSource;
    fdqTalonariosnomempleado: TStringField;
    dsSectores: TDataSource;
    fdqInformeSectores: TFDQuery;
    fdqInformeSectoresfecha: TSQLTimeStampField;
    fdqInformeSectoressectores_id: TIntegerField;
    fdqInformeSectoreshamacas: TIntegerField;
    fdqInformeSectoressombrillas: TIntegerField;
    fdqInformeSectorestotal: TIntegerField;
    fdqInformeSectoresfeca: TDateField;
    dsInformeSectores: TDataSource;
    fdqInformeSectoresDetalle: TFDQuery;
    fdqInformeSectoresDetallefecha: TSQLTimeStampField;
    fdqInformeSectoresDetallesectores_id: TIntegerField;
    fdqInformeSectoresDetalletipos_id: TIntegerField;
    fdqInformeSectoresDetalleSD: TFloatField;
    fdqInformeSectoresDetalleSR: TFloatField;
    fdqInformeSectoresDetallediferencia: TFloatField;
    fdqInformeEmpleado: TFDQuery;
    fdqInformeEmpleadofecha: TSQLTimeStampField;
    fdqInformeEmpleadoempleados_id: TIntegerField;
    fdqInformeEmpleadohamacas: TIntegerField;
    fdqInformeEmpleadosombrillas: TIntegerField;
    fdqInformeEmpleadototal: TIntegerField;
    fdqInformeEmpleadofeca: TDateField;
    dsInformeEmpleado: TDataSource;
    fdqInformeEmpleadoDetalle: TFDQuery;
    fdqInformeEmpleadoDetallefecha: TSQLTimeStampField;
    fdqInformeEmpleadoDetalleempleados_id: TIntegerField;
    fdqInformeEmpleadoDetalletipos_id: TIntegerField;
    fdqInformeEmpleadoDetalleSD: TFloatField;
    fdqInformeEmpleadoDetalleSR: TFloatField;
    fdqInformeEmpleadoDetallediferencia: TFloatField;
    fdqInformeEmpleadonomempleado: TStringField;
    fdqInformeSectoresnomsector: TStringField;
    fdqInformeSectoresnomplaya: TStringField;
    fdqInformeAnticipos: TFDQuery;
    fdqInformeAnticiposid: TFDAutoIncField;
    fdqInformeAnticiposempleados_id: TIntegerField;
    fdqInformeAnticiposfecha: TSQLTimeStampField;
    fdqInformeAnticiposcantidad: TCurrencyField;
    dsInformeAnticipos: TDataSource;
    fdqInformeAnticiposnomempleado: TStringField;
    fdqRestoVacaciones: TFDQuery;
    fdqRestoVacacionesid: TFDAutoIncField;
    fdqRestoVacacionesnombre: TWideStringField;
    fdqRestoVacacionesestado_id: TIntegerField;
    dsRestoVacaciones: TDataSource;
    dsNombres: TDataSource;
    fdqEstados: TFDQuery;
    dsEstados: TDataSource;
    dsAnticipos: TDataSource;
    fdqAnticipos: TFDQuery;
    fdqAnticiposid: TFDAutoIncField;
    fdqAnticiposempleados_id: TIntegerField;
    fdqAnticiposfecha: TSQLTimeStampField;
    fdqAnticiposcantidad: TCurrencyField;
    fdqAnticiposAN: TSmallintField;
    fdqAnticiposMO: TSmallintField;
    fdqInformeObservacion: TFDQuery;
    fdqInformeObservacionid: TFDAutoIncField;
    fdqInformeObservacionempleados_id: TIntegerField;
    fdqInformeObservacionfecha: TSQLTimeStampField;
    fdqInformeObservacionobservacion: TWideMemoField;
    fdqInformeObservacionvisto: TBooleanField;
    dsInformeObservacion: TDataSource;
    fdqObservaciones: TFDQuery;
    fdqObservacionesid: TFDAutoIncField;
    fdqObservacionesempleados_id: TIntegerField;
    fdqObservacionesfecha: TSQLTimeStampField;
    fdqObservacionesobservacion: TWideMemoField;
    fdqObservacionesvisto: TBooleanField;
    dsObservaciones: TDataSource;
    fdqInformeObservacionnomempleados: TStringField;
    fdqSumaAnticipos: TFDQuery;
    fdqSumaAnticiposempleados_id: TIntegerField;
    fdqSumaAnticiposAN: TSmallintField;
    fdqSumaAnticiposMO: TSmallintField;
    fdqSumaAnticiposSC: TCurrencyField;
    dsSumaAnticipos: TDataSource;
    fdqInformeSectoresDetallefacturado: TBooleanField;
    fdqInformeEmpleadoDetallefacturado: TBooleanField;
    fdqInformeEmpleadofacturado: TBooleanField;
    fdqInformeSectoresfacturado: TBooleanField;
    fdcBorraTickets: TFDCommand;
    fdcBorraAnticipos: TFDCommand;
    fdcBorraObservaciones: TFDCommand;
    fdqSectoresplaya: TStringField;
    fdqUltimoTalonario: TFDQuery;
    dsTipos: TDataSource;
    fdcBorraSelAnticipos: TFDCommand;
    fdqBorraSelObserva: TFDCommand;
    fdqInformeEmpleadoDetalleprecio: TCurrencyField;
    fdqInformeSectoresDetalleprecio: TCurrencyField;
    fdqTicketsprecio: TCurrencyField;
    fdqSumaTicketsprecio: TCurrencyField;
    fdqTicketsimporte: TCurrencyField;
    fdqSumaTicketsimporte: TCurrencyField;
    cdsTotal: TClientDataSet;
    cdsTotaltotal: TCurrencyField;
    fdqInformeEmpleadototaleuros: TCurrencyField;
    fdqInformeSectorestotaleuros: TCurrencyField;
    fdqFacturadoDia: TFDQuery;
    fdqInformeSectorestoldos: TIntegerField;
    fdqInformeEmpleadotoldos: TIntegerField;
    fdqInformePatines: TFDQuery;
    StringField1: TStringField;
    StringField2: TStringField;
    SQLTimeStampField1: TSQLTimeStampField;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    WideStringField1: TWideStringField;
    IntegerField3: TIntegerField;
    WideStringField2: TWideStringField;
    WideStringField3: TWideStringField;
    DateTimeField1: TDateTimeField;
    IntegerField4: TIntegerField;
    dsInformePatines: TDataSource;
    fdqInformePatinesDet: TFDQuery;
    SQLTimeStampField2: TSQLTimeStampField;
    IntegerField5: TIntegerField;
    IntegerField6: TIntegerField;
    IntegerField7: TIntegerField;
    WideStringField4: TWideStringField;
    IntegerField8: TIntegerField;
    IntegerField9: TIntegerField;
    IntegerField10: TIntegerField;
    fdqInformeEmpleadoticket6: TCurrencyField;
    fdqInformeEmpleadoticket3: TCurrencyField;
    fdqInformenumeros2: TStringField;
    fdqInformenumeros3: TStringField;
    fdqInformeEmpleadoticketaux: TCurrencyField;
    procedure fdqTicketsCalcFields(DataSet: TDataSet);

    procedure fdqCobradoresAfterScroll(DataSet: TDataSet);
    procedure fdqTicketsBeforePost(DataSet: TDataSet);
    procedure fdqTicketsAfterPost(DataSet: TDataSet);
    procedure fdqTicketsBeforeDelete(DataSet: TDataSet);
    procedure fdqSumaTicketsCalcFields(DataSet: TDataSet);
    procedure fdqInformeCalcFields(DataSet: TDataSet);
    procedure fdqTalonariosAfterScroll(DataSet: TDataSet);
    procedure fdqTalonariosCalcFields(DataSet: TDataSet);
    procedure fdqInformeEmpleadoCalcFields(DataSet: TDataSet);
    procedure fdqInformeSectoresCalcFields(DataSet: TDataSet);
    procedure fdqAnticiposAfterInsert(DataSet: TDataSet);
    procedure fdqAnticiposBeforePost(DataSet: TDataSet);
    procedure fdqObservacionesAfterInsert(DataSet: TDataSet);
    procedure fdqAnticiposAfterScroll(DataSet: TDataSet);
    procedure fdqInformePatinesCalcFields(DataSet: TDataSet);
    { Private declarations }
  private
    function SoloFecha(f: TDateTime): TDate;
    procedure InsertaTickets(ddd: integer; hhh: integer; lll: Char);
    procedure AnadeTickets(ddd, hhh: integer; lll: Char);
    function SumaTotal(): Currency;
  public
    { Public declarations }
    ticket: TTicket;
    talonario: TTalonario;
    base: TBase;
    procedure AbreDatosBasicos();
    procedure AbreCobradores(e: integer);
    procedure FiltraCobradores(n: string);
    function Letra(i: integer): string;
    function Precio(i: integer): Currency;
    procedure CreaTalonario();
    procedure AnadeTalonario();
    procedure LineUp();
    procedure LineDown();
    procedure SelTicket(e: integer; f: TDate; a: boolean);
    procedure SelTalonario(e: integer);
    // procedure SelUltimo(e: integer; f: TDate; a: boolean);
    procedure FacturadoDia(e: integer; f: TDate; a: boolean);
    procedure SelAnticipo(e: integer; f: TDate);
    procedure Refresca();
    procedure UpTalonario();
    procedure DownTalonario();
    procedure MasTalonario();
    function CheckNumeracion(): Boolean;
    procedure Liquidacion();
    procedure NoLiquidacion();
    procedure SiLiquidacion;
    procedure ImprimeSectorDia(s1: integer; s2: integer; f1: TDateTime; f2: TDateTime);
    procedure ImprimeEmpleadoDia(e1: integer; e2: integer; f1: TDateTime; f2: TDateTime);
    procedure ImprimeAnticipoDia(e1: integer; e2: integer; f1: TDateTime; f2: TDateTime);
    procedure ImprimeObservacionDia(e1: integer; e2: integer; f1: TDateTime; f2: TDateTime);
    procedure BorraAnticipoDia(e1: integer; e2: integer; f1: TDateTime; f2: TDateTime);
    procedure BorraObservaDia(e1: integer; e2: integer; f1: TDateTime; f2: TDateTime);
    procedure ImprimeInformeDia();
    procedure ImprimeInformePatinesDia();
    procedure ActualizaSector();
    procedure BorrarTalonario();
    procedure BorrarTodo();
    procedure BorrarBaseDatos();
  end;

var
  DataModuleTalonarios: TDataModuleTalonarios;

implementation

uses
  UDMPrincipal, UFrameTickets, UFormPrincipal;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TDataModuleTalonarios.SoloFecha(f: TDateTime): TDate;
begin
  Result := StrToDate(FormatDateTime('dd/mm/yyyy', f));
end;

procedure TDataModuleTalonarios.AbreCobradores(e: integer);
begin
  if fdqCobradores.Active = False then
    fdqCobradores.Open();
  fdqCobradores.ParamByName('E').AsInteger := e;
  fdqCobradores.Refresh;
  fdqCobradores.First;
end;

procedure TDataModuleTalonarios.FiltraCobradores(n: string);
begin
  if n = '' then
  begin
    fdqCobradores.Filtered := False;
    Exit;
  end;
  fdqCobradores.Filtered := False;
  fdqCobradores.Filter := 'nombre LIKE ''%' +
    UpperCase(n) + '%'' OR' + ' nombre LIKE ''%' +
    LowerCase(n) + '%''';
  fdqCobradores.Filtered := True;
  fdqCobradores.AfterScroll(fdqCobradores);
end;

procedure TDataModuleTalonarios.fdqTicketsCalcFields(DataSet: TDataSet);
begin
  if DataSet.FieldByName('real').AsInteger < DataSet.FieldByName('desde').AsInteger  then
    DataSet.FieldByName('cantidad').AsInteger := 0
  else
    DataSet.FieldByName('cantidad').AsInteger := (DataSet.FieldByName('real').AsInteger) -
    (DataSet.FieldByName('desde').AsInteger) + 1;

  //if (DataSet.FieldByName('sectores_id').AsInteger = 20) or (DataSet.FieldByName('sectores_id').AsInteger = 21)  then
  //begin
  //  DataSet.FieldByName('importe').AsCurrency := (DataSet.FieldByName('cantidad').AsInteger * 4.5);
  //end else
  //begin
    DataSet.FieldByName('importe').AsCurrency := (DataSet.FieldByName('cantidad').AsInteger * DataSet.FieldByName('precio').AsCurrency);
  //end;
end;

function TDataModuleTalonarios.Letra(i: integer): string;
begin
  if fdqTipos.Active = False then
    fdqTipos.Open();
  fdqTipos.Locate('id', i,[loCaseInsensitive]);
  Result :=  fdqTipos.FieldByName('letra').AsString;
end;

procedure TDataModuleTalonarios.CreaTalonario;
var
  lll: Char;
  l: integer;
  dd: integer;
  hh: integer;
  ll: string;
begin
  dd := ticket.desde;
  hh := ticket.hasta;
  ll := ticket.letra;
  lll := ll[1];

  if fdqTickets.FieldByName('facturado').AsBoolean = True then
    Exit;

  fdqTickets2.Refresh;
  fdqTickets2.Last;
  talonario.orden := fdqTickets2.FieldByName('id').AsInteger + 1;
  //talonario.fecha := base.fecha;


  fdqTickets.Refresh;
  if fdqTickets.IsEmpty = False then
  begin
    ticket.fecha := SoloFecha(fdqTickets.FieldByName('fecha').AsDateTime);
  end else
  begin
    ticket.fecha := SoloFecha(IncDay(base.fecha));           /// CAMBIO talonario.fecha POR  base.fecha
  end;

  if hh < dd then
  begin
    InsertaTickets(dd, 100000, lll);
    l := Ord(lll);
    Inc(l);
    lll := Chr(l);
    InsertaTickets(1, hh, lll);
  end else
  begin
    InsertaTickets(dd, hh, lll);
  end;
  (*
  FDQueryDetalleTickets.Refresh;
  *)

  fdqTipos.Refresh;
  fdqTipos.Locate('id', ticket.tipos_id, [loCaseInsensitive]);
  fdqTipos.Edit;
  fdqTipos.FieldByName('letra').AsString := lll;
  fdqTipos.Post;

  SelTicket(talonario.empleados_id, ticket.fecha, False);
  SelTalonario(talonario.empleados_id);
end;

procedure TDataModuleTalonarios.InsertaTickets(ddd, hhh: integer; lll: Char);
var
  a: integer;
  b: integer;
  dd1: integer;
  hh1: integer;
  ddf: integer;
  hhf: integer;
begin
  dd1 := ddd div 100;
  hh1 := hhh div 100;

  a := hh1 - dd1;

  ddf := ddd;
  hhf := (dd1 * 100) + 100;

  for b := 1 to a do
  begin
    fdqTickets.Insert;
    fdqTickets.FieldByName('sectores_id').AsInteger := ticket.sectores_id;
    fdqTickets.FieldByName('tipos_id').AsInteger := ticket.tipos_id;
    fdqTickets.FieldByName('empleados_id').AsInteger := ticket.empleados_id;
    fdqTickets.FieldByName('fecha').AsDateTime := SoloFecha(ticket.fecha);
    fdqTickets.FieldByName('letra').AsString := lll;
    fdqTickets.FieldByName('desde').AsInteger := ddf;
    fdqTickets.FieldByName('hasta').AsInteger := hhf;
    fdqTickets.FieldByName('real').AsInteger := hhf;
    fdqTickets.FieldByName('orden').AsInteger := talonario.orden;
    //if (ticket.sectores_id = 20) or (ticket.sectores_id = 21) then
    //begin
    //  fdqTickets.FieldByName('precio').AsCurrency := 4.5;
    //end else
    //begin
      fdqTickets.FieldByName('precio').AsCurrency := ticket.precio;
    //end;

    fdqTickets.FieldByName('facturado').AsBoolean := False;
    fdqTickets.Post;

    ddf := hhf + 1;
    hhf := ddf + 99;
    Inc(talonario.orden);
  end;

end;

procedure TDataModuleTalonarios.LineUp;
var
  cur, prev: integer;
  idligne: integer;
begin
  if (fdqTickets.RecordCount = 0) then
    Exit;
  fdqTickets.DisableControls;
  try
    if (fdqTickets.RecNo > 0) then
    begin
      cur := fdqTickets.FieldByName('orden').AsInteger;
      idligne := fdqTickets.FieldByName('id').AsInteger;
      fdqTickets.Prior;
      prev := fdqTickets.FieldByName('orden').AsInteger;
      fdqTickets.Edit;
      fdqTickets.FieldByName('orden').AsInteger := cur;
      fdqTickets.Post;
      fdqTickets.Locate('id', idligne, [loCaseInsensitive]);
      fdqTickets.Edit;
      fdqTickets.FieldByName('orden').AsInteger := prev;
      fdqTickets.Post;
    end;
  finally
      fdqTickets.EnableControls;
  end;
    fdqTickets.Refresh;
end;

procedure TDataModuleTalonarios.LineDown;
var
  cur, prev: integer;
  idligne: integer;
begin
  if (fdqTickets.RecordCount = 0) then
    Exit;
  fdqTickets.DisableControls;
  try
    if (fdqTickets.RecNo > 0) then
    begin
      cur := fdqTickets.FieldByName('orden').AsInteger;
      idligne := fdqTickets.FieldByName('id').AsInteger;
      fdqTickets.Next;
      prev := fdqTickets.FieldByName('orden').AsInteger;
      fdqTickets.Edit;
      fdqTickets.FieldByName('orden').AsInteger := cur;
      fdqTickets.Post;
      fdqTickets.Locate('id', idligne, [loCaseInsensitive]);
      fdqTickets.Edit;
      fdqTickets.FieldByName('orden').AsInteger := prev;
      fdqTickets.Post;
    end;
  finally
      fdqTickets.EnableControls;
  end;
    fdqTickets.Refresh;
end;

procedure TDataModuleTalonarios.AbreDatosBasicos;
begin
  fdqNombres.Open();
  fdqPlayas.Open();
  fdqSectores.Open();
  fdqTipos.Open();
  fdqTickets2.Open();
  fdqTalonarios.Open();
  fdqEstados.Open();
  SelAnticipo(base.empleados_id, base.fecha);
end;

procedure TDataModuleTalonarios.SelTicket(e: integer; f: TDate; a: boolean);
begin

  if fdqTickets.Active = False then
    fdqTickets.Open();
  fdqTickets.ParamByName('EM').AsInteger := e;
  fdqTickets.ParamByName('FE').AsDateTime := SoloFecha(f);
  fdqTickets.ParamByName('FA').AsBoolean := a;
  fdqTickets.Refresh;
  if fdqSumaTickets.Active = False then
    fdqSumaTickets.Open();
  fdqSumaTickets.ParamByName('EM').AsInteger := e;
  fdqSumaTickets.ParamByName('FE').AsDateTime := SoloFecha(f);
  fdqSumaTickets.ParamByName('FA').AsBoolean := a;
  fdqSumaTickets.Refresh;
  if cdsTotal.Active = False then
    cdsTotal.Open();
  cdsTotal.Edit;
  cdsTotal.FieldByName('total').AsCurrency := SumaTotal;
  cdsTotal.Post;
end;

procedure TDataModuleTalonarios.fdqCobradoresAfterScroll(DataSet: TDataSet);
begin
  talonario.empleados_id := DataSet.FieldByName('id').AsInteger;
  base.empleados_id := talonario.empleados_id;
  base.nombre := DataSet.FieldByName('nombre').AsString;
  base.todo := False;

  FacturadoDia(base.empleados_id, base.fecha, true);

  SelTalonario(talonario.empleados_id);

  talonario.fecha := SoloFecha(fdqTalonarios.FieldByName('fecha').AsDateTime);    /// AQUI CAMBIA FECHA FALLO2

  talonario.facturado := fdqTalonarios.FieldByName('facturado').AsBoolean;
  // base.facturado := fdqTalonarios.FieldByName('facturado').AsBoolean;

  //SelTicket(talonario.empleados_id, talonario.fecha, talonario.facturado);
  //base.sectores_id_ant := fdqTalonarios.FieldByName('sectores_id').AsInteger;

  //SelUltimo(talonario.empleados_id, base.fecha, talonario.facturado);

  SelAnticipo(talonario.empleados_id, base.fecha);

  SelTicket(talonario.empleados_id, talonario.fecha, talonario.facturado);
  base.sectores_id_ant := fdqTalonarios.FieldByName('sectores_id').AsInteger;

  //FacturadoDia(base.empleados_id, base.fecha, true);

  FormPrincipal.ActualizaMas;
end;

procedure TDataModuleTalonarios.fdqTicketsBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('real').AsInteger > DataSet.FieldByName('hasta').AsInteger then
  begin
    DataSet.Cancel;
  end;

  if (DataSet.FieldByName('real').AsInteger < DataSet.FieldByName('desde').AsInteger) and
   (DataSet.FieldByName('real').AsInteger <> 0) then
  begin
    DataSet.Cancel;
  end;
end;

procedure TDataModuleTalonarios.fdqTicketsAfterPost(DataSet: TDataSet);
begin
    if fdqTickets2.Locate('referencia_id', DataSet.FieldByName('id').AsInteger, [loCaseInsensitive]) = True  then
    begin
      fdqTickets2.Edit;

      if (fdqTickets.FieldByName('real').AsInteger = 0) then
      begin
        fdqTickets2.FieldByName('desde').AsInteger := DataSet.FieldByName('desde').AsInteger;
        fdqTickets2.FieldByName('hasta').AsInteger := DataSet.FieldByName('hasta').AsInteger;
        fdqTickets2.FieldByName('real').AsInteger := DataSet.FieldByName('hasta').AsInteger;
      end;

      if (fdqTickets.FieldByName('real').AsInteger = fdqTickets.FieldByName('desde').AsInteger) then
      begin
        fdqTickets2.FieldByName('desde').AsInteger := DataSet.FieldByName('real').AsInteger + 1;
        fdqTickets2.FieldByName('hasta').AsInteger := DataSet.FieldByName('hasta').AsInteger;
        fdqTickets2.FieldByName('real').AsInteger := DataSet.FieldByName('hasta').AsInteger;
      end;


      if (fdqTickets.FieldByName('real').AsInteger < fdqTickets.FieldByName('hasta').AsInteger) and
        (fdqTickets.FieldByName('real').AsInteger > fdqTickets.FieldByName('desde').AsInteger) then
      begin
        fdqTickets2.FieldByName('desde').AsInteger := DataSet.FieldByName('real').AsInteger + 1;
        fdqTickets2.FieldByName('hasta').AsInteger := DataSet.FieldByName('hasta').AsInteger;
        fdqTickets2.FieldByName('real').AsInteger := DataSet.FieldByName('hasta').AsInteger;
      end;

      if (fdqTickets.FieldByName('real').AsInteger = fdqTickets.FieldByName('hasta').AsInteger) then
      begin
        fdqTickets2.FieldByName('desde').AsInteger := DataSet.FieldByName('real').AsInteger;
        fdqTickets2.FieldByName('hasta').AsInteger := DataSet.FieldByName('hasta').AsInteger;
        fdqTickets2.FieldByName('real').AsInteger := 0;
      end;

      fdqTickets2.Post;
    end;

  fdqSumaTickets.Refresh;
  cdsTotal.Edit;
  cdsTotal.FieldByName('total').AsCurrency := SumaTotal;
  cdsTotal.Post;

  //fdqTickets.Next;
end;

procedure TDataModuleTalonarios.fdqTicketsBeforeDelete(DataSet: TDataSet);
begin
    if fdqTickets2.Locate('referencia_id', DataSet.FieldByName('id').AsInteger, [loCaseInsensitive]) = True  then
    begin
      fdqTickets2.Edit;
      fdqTickets2.FieldByName('desde').AsInteger := DataSet.FieldByName('desde').AsInteger;
      fdqTickets2.FieldByName('hasta').AsInteger := DataSet.FieldByName('hasta').AsInteger;
      fdqTickets2.FieldByName('real').AsInteger := DataSet.FieldByName('hasta').AsInteger;
      fdqTickets2.Post;
    end;
end;

procedure TDataModuleTalonarios.fdqSumaTicketsCalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('cantidad').AsCurrency := DataSet.FieldByName('diferencia').AsInteger;
  //if (DataSet.FieldByName('sectores_id').AsInteger = 20) or (DataSet.FieldByName('sectores_id').AsInteger = 21) then
  //begin
  //  DataSet.FieldByName('importe').AsCurrency := DataSet.FieldByName('cantidad').AsInteger * 4.5;
  //end else
  //begin
    DataSet.FieldByName('importe').AsCurrency := DataSet.FieldByName('cantidad').AsInteger * DataSet.FieldByName('precio').AsCurrency;
  //end;
end;

function TDataModuleTalonarios.SumaTotal: Currency;
var
  i: Currency;
begin
  i := 0;
  fdqSumaTickets.First;
  while not fdqSumaTickets.Eof do
  begin
    i := i + fdqSumaTickets.FieldByName('importe').AsCurrency;
    fdqSumaTickets.Next;
  end;

  Result := i;
end;

procedure TDataModuleTalonarios.SelTalonario(e: integer);
var
  n: integer;
begin

  (*
  if fdqTalonarios.Active = False then
    fdqTalonarios.Open();
  fdqTalonarios.ParamByName('EM').AsInteger := e;
  fdqTalonarios.Refresh;
  fdqTalonarios.First;

  *)
  ////////////////////////////////

  n := 1;

  if base.ultimo = True then
  begin
    n := 1;  // por facturar
  end else
  begin
    n := 2;  // ya facturado
  end;

  if base.todo = True then
    n := 1000;

  //e := 2;

  if fdqTalonarios.Active = True then
    fdqTalonarios.Close();
  //fdqTalonarios.Close;
  fdqTalonarios.SQL.BeginUpdate;
  try
    fdqTalonarios.SQL.Clear;
    fdqTalonarios.SQL.Add('SELECT TOP ' + IntToStr(n) + ' tickets.empleados_id, tickets.fecha, tickets.sectores_id, tickets.facturado');
    fdqTalonarios.SQL.Add('FROM tickets');
    fdqTalonarios.SQL.Add('WHERE (tickets.empleados_id = :EM)');
    fdqTalonarios.SQL.Add('GROUP BY tickets.empleados_id, tickets.fecha, tickets.sectores_id, tickets.facturado');
    fdqTalonarios.SQL.Add('ORDER BY tickets.fecha DESC;');
  finally
    fdqTalonarios.SQL.EndUpdate;
  end;
  fdqTalonarios.ParamByName('EM').AsInteger := e;
  fdqTalonarios.Params[0].ParamType := ptInput;
  fdqTalonarios.Params[0].DataType := ftInteger;
  fdqTalonarios.Open;
  fdqTalonarios.Refresh;
  fdqTalonarios.First;


end;

procedure TDataModuleTalonarios.UpTalonario;
var
  e: integer;
  f: TDateTime;
  a: boolean;
begin
  fdqTalonarios.Next;
  e := fdqTalonarios.FieldByName('empleados_id').AsInteger;
  a := fdqTalonarios.FieldByName('facturado').AsBoolean;
  f := SoloFecha(fdqTalonarios.FieldByName('fecha').AsDateTime);
  SelTicket(e, f, a);
  //SelUltimo(e, f, true);
  FacturadoDia(e, f, true);
end;

procedure TDataModuleTalonarios.DownTalonario;
var
  e: integer;
  f: TDateTime;
  a: boolean;
begin
  fdqTalonarios.Prior;
  e := fdqTalonarios.FieldByName('empleados_id').AsInteger;
  a := fdqTalonarios.FieldByName('facturado').AsBoolean;
  f := SoloFecha(fdqTalonarios.FieldByName('fecha').AsDateTime);
  SelTicket(e, f, a);
  //SelUltimo(e, f, true);
  FacturadoDia(e, f, true);
end;

procedure TDataModuleTalonarios.FacturadoDia(e: integer; f: TDate; a: boolean);
begin
  //f := IncDay(base.fecha);
  f := base.fecha;
  //a := True;

  if fdqFacturadoDia.Active = False then
    fdqFacturadoDia.Open();
  fdqFacturadoDia.ParamByName('EM').AsInteger := e;
  fdqFacturadoDia.ParamByName('FE').AsDateTime := SoloFecha(f);
  fdqFacturadoDia.ParamByName('FA').AsBoolean := True;
  fdqFacturadoDia.Refresh;
  fdqFacturadoDia.First;

  if fdqFacturadoDia.IsEmpty then
    base.ultimo := True     // por facturar
  else
    base.ultimo := False;  // ya facturado
end;

function TDataModuleTalonarios.CheckNumeracion: Boolean;
begin
  fdqCheckNumeros.Close;
  fdqCheckNumeros.ParamByName('T').AsInteger := ticket.tipos_id;
  fdqCheckNumeros.ParamByName('L').AsString := ticket.letra;
  fdqCheckNumeros.ParamByName('N1').AsInteger := ticket.desde;
  fdqCheckNumeros.ParamByName('N2').AsInteger := ticket.desde;
  fdqCheckNumeros.ParamByName('N3').AsInteger := ticket.hasta;
  fdqCheckNumeros.ParamByName('N4').AsInteger := ticket.hasta;
  fdqCheckNumeros.Open();
  fdqCheckNumeros.Refresh;
  fdqCheckNumeros.First;
  if fdqCheckNumeros.Eof then
    Result := False
  else
    Result := True;
end;

procedure TDataModuleTalonarios.Liquidacion;
begin
  fdqTickets.First;

  if fdqTickets.IsEmpty then
    Exit;

  //if fdqTickets.FieldByName('facturado').AsBoolean = True then
  //  Exit;

  fdqTickets2.Refresh;
  fdqTickets2.Last;
  talonario.orden := fdqTickets2.FieldByName('id').AsInteger + 1;

  fdqTickets.DisableControls;

  while not fdqTickets.Eof do
  begin
    if fdqTickets2.Locate('referencia_id', fdqTickets.FieldByName('id').AsInteger, [loCaseInsensitive]) = True  then
    begin
      fdqTickets2.Edit;


      //if fdqTickets.FieldByName('real').AsInteger = fdqTickets.FieldByName('desde').AsInteger then

      if fdqTickets.FieldByName('real').AsInteger = 0 then
      begin
        //fdqTickets2.FieldByName('desde').AsInteger := fdqTickets.FieldByName('real').AsInteger;
        fdqTickets2.FieldByName('desde').AsInteger := fdqTickets.FieldByName('desde').AsInteger + 1;
      end else
      begin
        fdqTickets2.FieldByName('desde').AsInteger := fdqTickets.FieldByName('real').AsInteger + 1;
      end;

      fdqTickets2.FieldByName('hasta').AsInteger := fdqTickets.FieldByName('hasta').AsInteger;
      fdqTickets2.FieldByName('real').AsInteger := fdqTickets.FieldByName('hasta').AsInteger;
      fdqTickets2.Post;
    end else
    begin

      ////////////////    11111111111
      ///
      if (fdqTickets.FieldByName('real').AsInteger = 0) then
      begin
        fdqTickets2.Insert;
        fdqTickets2.FieldByName('sectores_id').AsInteger := ticket.sectores_id;
        fdqTickets2.FieldByName('tipos_id').AsInteger := fdqTickets.FieldByName('tipos_id').AsInteger;
        fdqTickets2.FieldByName('empleados_id').AsInteger := fdqTickets.FieldByName('empleados_id').AsInteger;
        fdqTickets2.FieldByName('fecha').AsDateTime :=  SoloFecha(IncDay(ticket.fecha));  /// AQUI DEBERIA SER base.fecha ??? MEJOR
        fdqTickets2.FieldByName('letra').AsString := fdqTickets.FieldByName('letra').AsString;

        fdqTickets2.FieldByName('desde').AsInteger := fdqTickets.FieldByName('desde').AsInteger;

        fdqTickets2.FieldByName('hasta').AsInteger := fdqTickets.FieldByName('hasta').AsInteger;
        fdqTickets2.FieldByName('real').AsInteger := fdqTickets.FieldByName('hasta').AsInteger;
        fdqTickets2.FieldByName('precio').AsCurrency := fdqTickets.FieldByName('precio').AsCurrency;
        fdqTickets2.FieldByName('orden').AsInteger := talonario.orden;
        fdqTickets2.FieldByName('facturado').AsBoolean := False;
        fdqTickets2.FieldByName('referencia_id').AsInteger := fdqTickets.FieldByName('id').AsInteger;
        fdqTickets2.Post;

        Inc(talonario.orden);
      end;

      ////////////////      222222222222222
      ///
      if ((fdqTickets.FieldByName('real').AsInteger = fdqTickets.FieldByName('desde').AsInteger) and (
        fdqTickets.FieldByName('real').AsInteger < fdqTickets.FieldByName('hasta').AsInteger))then
      begin
        fdqTickets2.Insert;
        fdqTickets2.FieldByName('sectores_id').AsInteger := ticket.sectores_id;
        fdqTickets2.FieldByName('tipos_id').AsInteger := fdqTickets.FieldByName('tipos_id').AsInteger;
        fdqTickets2.FieldByName('empleados_id').AsInteger := fdqTickets.FieldByName('empleados_id').AsInteger;
        fdqTickets2.FieldByName('fecha').AsDateTime :=  SoloFecha(IncDay(ticket.fecha));     /// AQUI DEBERIA SER base.fecha ??? MEJOR
        fdqTickets2.FieldByName('letra').AsString := fdqTickets.FieldByName('letra').AsString;

        fdqTickets2.FieldByName('desde').AsInteger := fdqTickets.FieldByName('real').AsInteger + 1;

        fdqTickets2.FieldByName('hasta').AsInteger := fdqTickets.FieldByName('hasta').AsInteger;
        fdqTickets2.FieldByName('real').AsInteger := fdqTickets.FieldByName('hasta').AsInteger;
        fdqTickets2.FieldByName('precio').AsCurrency := fdqTickets.FieldByName('precio').AsCurrency;
        fdqTickets2.FieldByName('orden').AsInteger := talonario.orden;
        fdqTickets2.FieldByName('facturado').AsBoolean := False;
        fdqTickets2.FieldByName('referencia_id').AsInteger := fdqTickets.FieldByName('id').AsInteger;
        fdqTickets2.Post;

        Inc(talonario.orden);
      end;

      ////////////////         3333333333333333333
      ///
      if (fdqTickets.FieldByName('real').AsInteger < fdqTickets.FieldByName('hasta').AsInteger) and
        (fdqTickets.FieldByName('real').AsInteger > fdqTickets.FieldByName('desde').AsInteger) then
      begin
        fdqTickets2.Insert;
        fdqTickets2.FieldByName('sectores_id').AsInteger := ticket.sectores_id;
        fdqTickets2.FieldByName('tipos_id').AsInteger := fdqTickets.FieldByName('tipos_id').AsInteger;
        fdqTickets2.FieldByName('empleados_id').AsInteger := fdqTickets.FieldByName('empleados_id').AsInteger;
        fdqTickets2.FieldByName('fecha').AsDateTime :=  SoloFecha(IncDay(ticket.fecha));      /// AQUI DEBERIA SER base.fecha ??? MEJOR
        fdqTickets2.FieldByName('letra').AsString := fdqTickets.FieldByName('letra').AsString;

        fdqTickets2.FieldByName('desde').AsInteger := fdqTickets.FieldByName('real').AsInteger + 1;

        fdqTickets2.FieldByName('hasta').AsInteger := fdqTickets.FieldByName('hasta').AsInteger;
        fdqTickets2.FieldByName('real').AsInteger := fdqTickets.FieldByName('hasta').AsInteger;
        fdqTickets2.FieldByName('precio').AsCurrency := fdqTickets.FieldByName('precio').AsCurrency;
        fdqTickets2.FieldByName('orden').AsInteger := talonario.orden;
        fdqTickets2.FieldByName('facturado').AsBoolean := False;
        fdqTickets2.FieldByName('referencia_id').AsInteger := fdqTickets.FieldByName('id').AsInteger;
        fdqTickets2.Post;

        Inc(talonario.orden);
      end;
    end;





    fdqTickets.Edit;
    fdqTickets.FieldByName('facturado').AsBoolean := True;
    fdqTickets.FieldByName('fecha').AsDateTime :=  SoloFecha(ticket.fecha);
    fdqTickets.Post;

    fdqTickets.Next;
  end;

  fdqTickets.EnableControls;

  base.todo := False;

  //SelUltimo(talonario.empleados_id, base.fecha, True);
  FacturadoDia(talonario.empleados_id, base.fecha, True);
  SelTalonario(talonario.empleados_id);
  SelTicket(talonario.empleados_id, SoloFecha(IncDay(ticket.fecha)), False);
  fdqTalonarios.Refresh;
end;

procedure TDataModuleTalonarios.fdqInformeCalcFields(DataSet: TDataSet);
var
  s: string;
  s1: string;
  s2: string;
  s3: string;
  t: integer;
  x: integer;
  l: string;
  a: string;
  n: string;
begin
  DataSet.FieldByName('feca').AsDateTime := DataSet.FieldByName('fecha').AsDateTime;


  if fdqInformeDetalle.Active = False then
    fdqInformeDetalle.Open();
  fdqInformeDetalle.Refresh;
  fdqInformeDetalle.First;
  l := '';
  s := '';
  s1 := '';
  s2 := '';
  s3 := '';
  x := 0;

  while Not fdqInformeDetalle.Eof do
  begin
    t := fdqInformeDetalle.FieldByName('tipos_id').AsInteger;
    a := fdqInformeDetalle.FieldByName('letra').AsString;
    n := fdqInformeDetalle.FieldByName('desde').AsString;
    if x <> t then
    begin
      l := '';
      x := t;
    end;

    if t = 1 then
    begin
      if a <> l then
      begin
        l := a;
        s := s + ' ' + l + ' ' + n + ' ';
      end else
        s := s + ' '  + n + ' ';
    end;

    if t = 2 then
    begin
      if a <> l then
      begin
        l := a;
        s1 := s1 + ' ' + l + ' ' + n + ' ';
      end else
        s1 := s1 + ' '  + n + ' ';
    end;

    if t = 3 then
    begin
      if a <> l then
      begin
        l := a;
        s1 := s1 + ' *' + l + ' *' + n + ' ';
      end else
        s1 := s1 + ' *'  + n + ' ';
    end;

    if t = 6 then
    begin
      if a <> l then
      begin
        l := a;
        s2 := s2 + ' ' + l + ' ' + n + ' ';
      end else
        s2 := s2 + ' '  + n + ' ';
    end;

    if t = 7 then
    begin
      if a <> l then
      begin
        l := a;
        s3 := s3 + ' ' + l + ' ' + n + ' ';
      end else
        s3 := s3 + ' '  + n + ' ';
    end;

    fdqInformeDetalle.Next;
  end;

  DataSet.FieldByName('numeros').AsString := s;
  DataSet.FieldByName('numeros1').AsString := s1;
  DataSet.FieldByName('numeros2').AsString := s2;
  DataSet.FieldByName('numeros3').AsString := s3;
end;

procedure TDataModuleTalonarios.fdqTalonariosAfterScroll(DataSet: TDataSet);
begin
  //base.fecha := DataSet.FieldByName('fecha').AsDateTime;
  base.sectores_id := DataSet.FieldByName('sectores_id').AsInteger;
  base.facturado :=  DataSet.FieldByName('facturado').AsBoolean;
  base.fecha_ant := SoloFecha(DataSet.FieldByName('fecha').AsDateTime);
  FormPrincipal.ActualizaEvento;

  if DateToStr(base.fecha_ant) = '30/12/1899' then
  begin
    base.fecha_ant := base.fecha;
  end;

  SelAnticipo(base.empleados_id, base.fecha_ant);
end;

procedure TDataModuleTalonarios.fdqTalonariosCalcFields(DataSet: TDataSet);
begin
  if DataSet.FieldByName('facturado').AsBoolean = False then
  begin
    DataSet.FieldByName('estado').AsString := 'ENTREGADOS'
  end else
  begin
    DataSet.FieldByName('estado').AsString := DateToStr(DataSet.FieldByName('fecha').AsDateTime);
  end;
end;

procedure TDataModuleTalonarios.ImprimeSectorDia(s1, s2: integer; f1,
  f2: TDateTime);
begin
  fdqInformeSectores.Close;
  fdqInformeSectores.ParamByName('SI').AsInteger := s1;
  fdqInformeSectores.ParamByName('SF').AsInteger := s2;
  fdqInformeSectores.ParamByName('FI').AsDateTime := SoloFecha(f1);
  fdqInformeSectores.ParamByName('FF').AsDateTime := SoloFecha(f2);
  fdqInformeSectores.Open();
  fdqInformeSectores.Open();
end;

procedure TDataModuleTalonarios.ImprimeEmpleadoDia(e1, e2: integer; f1,
  f2: TDateTime);
begin
  fdqInformeEmpleado.Close;
  fdqInformeEmpleado.ParamByName('EI').AsInteger := e1;
  fdqInformeEmpleado.ParamByName('EF').AsInteger := e2;
  fdqInformeEmpleado.ParamByName('FI').AsDateTime := SoloFecha(f1);
  fdqInformeEmpleado.ParamByName('FF').AsDateTime := SoloFecha(f2);
  fdqInformeEmpleado.Open();
  fdqInformeEmpleado.Open();
end;

procedure TDataModuleTalonarios.fdqInformeEmpleadoCalcFields(DataSet: TDataSet);
var
  t: integer;
  p1: Currency;
  p2: Currency;
  p3: Currency;
  p6: Currency;
  p7: Currency;
  p8: Currency;
begin
  DataSet.FieldByName('feca').AsDateTime := DataSet.FieldByName('fecha').AsDateTime;

  p1 := 4;
  p2 := 4;
  p3 := 6;
  p6 := 4;
  p7 := 4;
  p8 := 4;

  if fdqInformeEmpleadoDetalle.Active = False then
    fdqInformeEmpleadoDetalle.Open();

  fdqInformeEmpleadoDetalle.Refresh;
  fdqInformeEmpleadoDetalle.First;
  while not fdqInformeEmpleadoDetalle.Eof do
  begin
    t := fdqInformeEmpleadoDetalle.FieldByName('tipos_id').AsInteger;

    if t = 1 then
    begin
      DataSet.FieldByName('hamacas').AsInteger := fdqInformeEmpleadoDetalle.FieldByName('diferencia').AsInteger;
      p1 := fdqInformeEmpleadoDetalle.FieldByName('precio').AsCurrency;
    end;

    if t = 2 then
    begin
      DataSet.FieldByName('sombrillas').AsInteger := fdqInformeEmpleadoDetalle.FieldByName('diferencia').AsInteger;
      p2 := fdqInformeEmpleadoDetalle.FieldByName('precio').AsCurrency;
    end;

    if t = 3 then
    begin
      DataSet.FieldByName('toldos').AsInteger := fdqInformeEmpleadoDetalle.FieldByName('diferencia').AsInteger;
      p3 := fdqInformeEmpleadoDetalle.FieldByName('precio').AsCurrency;
    end;

    if t = 6 then
    begin
      DataSet.FieldByName('ticket 6').AsInteger := fdqInformeEmpleadoDetalle.FieldByName('diferencia').AsInteger;
      p6 := fdqInformeEmpleadoDetalle.FieldByName('precio').AsCurrency;
    end;

    if t = 7 then
    begin
      DataSet.FieldByName('ticket 3').AsInteger := fdqInformeEmpleadoDetalle.FieldByName('diferencia').AsInteger;
      p7 := fdqInformeEmpleadoDetalle.FieldByName('precio').AsCurrency;
    end;


//    if t = 8 then
//    begin
//      DataSet.FieldByName('ticket aux').AsInteger := fdqInformeEmpleadoDetalle.FieldByName('diferencia').AsInteger;
//      p8 := fdqInformeEmpleadoDetalle.FieldByName('precio').AsCurrency;
//    end;

   fdqInformeEmpleadoDetalle.Next;
  end;

  DataSet.FieldByName('total').AsInteger := DataSet.FieldByName('hamacas').AsInteger + DataSet.FieldByName('sombrillas').AsInteger  +
   DataSet.FieldByName('toldos').AsInteger +
   DataSet.FieldByName('ticket 6').AsInteger +
   DataSet.FieldByName('ticket 3').AsInteger +
   DataSet.FieldByName('ticket aux').AsInteger;
  DataSet.FieldByName('totaleuros').AsCurrency := (DataSet.FieldByName('hamacas').AsInteger * p1) +
   (DataSet.FieldByName('sombrillas').AsInteger * p2) +
   (DataSet.FieldByName('toldos').AsInteger * p3) +
   (DataSet.FieldByName('ticket 6').AsInteger * p6) +
   (DataSet.FieldByName('ticket 3').AsInteger * p7) +
   (DataSet.FieldByName('ticket aux').AsInteger * p8);

end;

procedure TDataModuleTalonarios.fdqInformePatinesCalcFields(DataSet: TDataSet);
var
  s: string;
  s1: string;
  t: integer;
  x: integer;
  l: string;
  a: string;
  n: string;
begin
  DataSet.FieldByName('feca').AsDateTime := DataSet.FieldByName('fecha').AsDateTime;


  if fdqInformePatinesDet.Active = False then
    fdqInformePatinesDet.Open();
  fdqInformePatinesDet.Refresh;
  fdqInformePatinesDet.First;
  l := '';
  s := '';
  s1 := '';
  x := 0;

  while Not fdqInformePatinesDet.Eof do
  begin
    t := fdqInformePatinesDet.FieldByName('tipos_id').AsInteger;
    a := fdqInformePatinesDet.FieldByName('letra').AsString;
    n := fdqInformePatinesDet.FieldByName('desde').AsString;
    if x <> t then
    begin
      l := '';
      x := t;
    end;

    if t = 4 then
    begin
      if a <> l then
      begin
        l := a;
        s := s + ' ' + l + ' ' + n + ' ';
      end else
        s := s + ' '  + n + ' ';
    end;

    if t = 5 then
    begin
      if a <> l then
      begin
        l := a;
        s1 := s1 + ' ' + l + ' ' + n + ' ';
      end else
        s1 := s1 + ' '  + n + ' ';
    end;

    fdqInformePatinesDet.Next;
  end;

  DataSet.FieldByName('numeros').AsString := s;
  DataSet.FieldByName('numeros1').AsString := s1;

end;

procedure TDataModuleTalonarios.fdqInformeSectoresCalcFields(DataSet: TDataSet);
var
  t: integer;
  p1: Currency;
  p2: Currency;
  p3: Currency;
begin
  DataSet.FieldByName('feca').AsDateTime := DataSet.FieldByName('fecha').AsDateTime;

  if fdqInformeSectoresDetalle.Active = False then
    fdqInformeSectoresDetalle.Open();

  p1 := 4;
  p2 := 4;
  p3 := 6;

  fdqInformeSectoresDetalle.Refresh;
  fdqInformeSectoresDetalle.First;

  while not fdqInformeSectoresDetalle.Eof do
  begin
    t := fdqInformeSectoresDetalle.FieldByName('tipos_id').AsInteger;

    if t = 1 then
    begin
      DataSet.FieldByName('hamacas').AsInteger := fdqInformeSectoresDetalle.FieldByName('diferencia').AsInteger;
      p1 := fdqInformeSectoresDetalle.FieldByName('precio').AsCurrency;
    end;

    if t = 2 then
    begin
      DataSet.FieldByName('sombrillas').AsInteger := fdqInformeSectoresDetalle.FieldByName('diferencia').AsInteger;
      p2 := fdqInformeSectoresDetalle.FieldByName('precio').AsCurrency;
    end;

    if t = 3 then
    begin
      DataSet.FieldByName('toldos').AsInteger := fdqInformeSectoresDetalle.FieldByName('diferencia').AsInteger;
      p3 := fdqInformeSectoresDetalle.FieldByName('precio').AsCurrency;
    end;

   fdqInformeSectoresDetalle.Next;
  end;

  DataSet.FieldByName('total').AsInteger := DataSet.FieldByName('hamacas').AsInteger + DataSet.FieldByName('sombrillas').AsInteger + DataSet.FieldByName('toldos').AsInteger;
  DataSet.FieldByName('totaleuros').AsCurrency := (DataSet.FieldByName('hamacas').AsInteger * p1) + (DataSet.FieldByName('sombrillas').AsInteger * p2) + (DataSet.FieldByName('toldos').AsInteger * p3);

end;

procedure TDataModuleTalonarios.ImprimeAnticipoDia(e1, e2: integer; f1,
  f2: TDateTime);
begin
  fdqInformeAnticipos.Close;
  fdqInformeAnticipos.ParamByName('EI').AsInteger := e1;
  fdqInformeAnticipos.ParamByName('EF').AsInteger := e2;
  fdqInformeAnticipos.ParamByName('FI').AsDateTime := SoloFecha(f1);
  fdqInformeAnticipos.ParamByName('FF').AsDateTime := SoloFecha(f2);
  fdqInformeAnticipos.Open();
end;

procedure TDataModuleTalonarios.ImprimeInformeDia;
begin
  fdqInformeDetalle.Open();
  fdqInforme.Close;
  fdqInforme.Open();
  fdqRestoVacaciones.Close;
  fdqRestoVacaciones.Open();
  fdqInforme.Refresh;
  fdqInformeDetalle.Refresh;
end;

procedure TDataModuleTalonarios.ImprimeInformePatinesDia;
begin
  fdqInformePatinesDet.Open();
  fdqInformePatines.Close;
  fdqInformePatines.Open();
  fdqRestoVacaciones.Close;
  fdqRestoVacaciones.Open();
  fdqInformePatines.Refresh;
  fdqInformePatinesDet.Refresh;
end;

procedure TDataModuleTalonarios.ActualizaSector;
begin
  fdqTickets.DisableControls;
  if fdqTickets.IsEmpty = False then
  begin
    fdqTickets.First;
    while not fdqTickets.eof do
    begin
      fdqTickets.Edit;
      fdqTickets.FieldByName('sectores_id').AsInteger := talonario.sectores_id;
      fdqTickets.Post;
      fdqTickets.Next;
    end;
  end;
  fdqTalonarios.Refresh;
  fdqTickets.EnableControls;
end;

procedure TDataModuleTalonarios.BorrarTalonario;
begin
  fdqTickets.Delete;
end;

procedure TDataModuleTalonarios.BorrarTodo;
begin
  fdqTickets.First;
  if fdqTickets.IsEmpty = False then
  begin
    while not fdqTickets.Eof do
    begin
      fdqTickets.Delete;
      fdqTickets.First;
    end;
  end;
  fdqTalonarios.Refresh;
end;

procedure TDataModuleTalonarios.fdqAnticiposAfterInsert(DataSet: TDataSet);
begin
  DataSet.FieldByName('fecha').AsDateTime := SoloFecha(Date);
end;

procedure TDataModuleTalonarios.fdqAnticiposBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('cantidad').AsInteger = 0 then
  begin
    DataSet.Cancel;
    Exit;
  end;
  DataSet.FieldByName('empleados_id').AsInteger := base.empleados_id;
end;

procedure TDataModuleTalonarios.ImprimeObservacionDia(e1, e2: integer; f1,
  f2: TDateTime);
begin
  fdqInformeObservacion.Close;
  fdqInformeObservacion.ParamByName('EI').AsInteger := e1;
  fdqInformeObservacion.ParamByName('EF').AsInteger := e2;
  fdqInformeObservacion.ParamByName('FI').AsDateTime := SoloFecha(f1);
  fdqInformeObservacion.ParamByName('FF').AsDateTime := SoloFecha(f2);
  fdqInformeObservacion.Open();
end;

procedure TDataModuleTalonarios.SelAnticipo(e: integer; f: TDate);
begin
  if fdqSumaAnticipos.Active = False then
    fdqSumaAnticipos.Open();

  if fdqAnticipos.Active = False then
    fdqAnticipos.Open();
  fdqAnticipos.ParamByName('E').AsInteger := e;
  fdqAnticipos.ParamByName('M').AsInteger := MonthOf(f);
  fdqAnticipos.ParamByName('A').AsInteger := YearOf(f);
  fdqAnticipos.Refresh;
  fdqAnticipos.First;

  if fdqObservaciones.Active = False then
    fdqObservaciones.Open();
  fdqObservaciones.ParamByName('E').AsInteger := e;
  fdqObservaciones.Refresh;


end;

procedure TDataModuleTalonarios.fdqObservacionesAfterInsert(DataSet: TDataSet);
begin
  DataSet.FieldByName('empleados_id').AsInteger := base.empleados_id;
  DataSet.FieldByName('fecha').AsDateTime := SoloFecha(Date);
  DataSet.FieldByName('visto').AsBoolean := False;
end;

procedure TDataModuleTalonarios.fdqAnticiposAfterScroll(DataSet: TDataSet);
begin
  if fdqSumaAnticipos.Active = False then
    fdqSumaAnticipos.Open();
  fdqSumaAnticipos.ParamByName('E').AsInteger := DataSet.FieldByName('empleados_id').AsInteger;
  fdqSumaAnticipos.ParamByName('M').AsInteger := DataSet.FieldByName('MO').AsInteger;
  fdqSumaAnticipos.ParamByName('A').AsInteger := DataSet.FieldByName('AN').AsInteger;
  fdqSumaAnticipos.Refresh;
end;

procedure TDataModuleTalonarios.MasTalonario;
var
  e: integer;
  f: TDateTime;
begin
  fdqTalonarios.Next;
  e := base.empleados_id;
  f := base.fecha;
  base.facturado := False;
  SelTicket(e, f, False);
  FormPrincipal.ActualizaEvento;
end;

procedure TDataModuleTalonarios.AnadeTalonario;
var
  lll: Char;
  l: integer;
  dd: integer;
  hh: integer;
  ll: string;
begin
  dd := ticket.desde;
  hh := ticket.hasta;
  ll := ticket.letra;
  lll := ll[1];

  if fdqTickets.FieldByName('facturado').AsBoolean = False then
    Exit;

  fdqTickets2.Refresh;
  fdqTickets2.Last;
  talonario.orden := fdqTickets2.FieldByName('id').AsInteger + 1;
  //talonario.fecha := base.fecha;

  ticket.fecha := SoloFecha(fdqTickets.FieldByName('fecha').AsDateTime);

  if hh < dd then
  begin
    InsertaTickets(dd, 100000, lll);
    l := Ord(lll);
    Inc(l);
    lll := Chr(l);
    AnadeTickets(1, hh, lll);
  end else
  begin
    AnadeTickets(dd, hh, lll);
  end;
  (*
  FDQueryDetalleTickets.Refresh;
  *)

  fdqTipos.Refresh;
  fdqTipos.Locate('id', ticket.tipos_id, [loCaseInsensitive]);
  fdqTipos.Edit;
  fdqTipos.FieldByName('letra').AsString := lll;
  fdqTipos.Post;

  SelTicket(talonario.empleados_id, ticket.fecha, True);
  //SelTalonario(talonario.empleados_id);
end;

procedure TDataModuleTalonarios.AnadeTickets(ddd, hhh: integer; lll: Char);
var
  a: integer;
  b: integer;
  dd1: integer;
  hh1: integer;
  ddf: integer;
  hhf: integer;
begin
  dd1 := ddd div 100;
  hh1 := hhh div 100;

  a := hh1 - dd1;

  ddf := ddd;
  hhf := (dd1 * 100) + 100;

  for b := 1 to a do
  begin
    fdqTickets.Insert;
    fdqTickets.FieldByName('sectores_id').AsInteger := base.sectores_id;
    fdqTickets.FieldByName('tipos_id').AsInteger := ticket.tipos_id;
    fdqTickets.FieldByName('empleados_id').AsInteger := ticket.empleados_id;
    fdqTickets.FieldByName('fecha').AsDateTime := SoloFecha(ticket.fecha);
    fdqTickets.FieldByName('letra').AsString := lll;
    fdqTickets.FieldByName('desde').AsInteger := ddf;
    fdqTickets.FieldByName('hasta').AsInteger := hhf;
    fdqTickets.FieldByName('real').AsInteger := hhf;
    fdqTickets.FieldByName('orden').AsInteger := talonario.orden;
    fdqTickets.FieldByName('facturado').AsBoolean := True;
    //if (base.sectores_id =20) or (base.sectores_id = 21) then
    //begin
    //  fdqTickets.FieldByName('precio').AsCurrency := 4.5;
    //end else
    //begin
      fdqTickets.FieldByName('precio').AsCurrency := ticket.precio;
    //end;

    fdqTickets.Post;

    ddf := hhf + 1;
    hhf := ddf + 99;
    Inc(talonario.orden);
  end;

end;

procedure TDataModuleTalonarios.BorraAnticipoDia(e1, e2: integer; f1,
  f2: TDateTime);
begin
  fdcBorraSelAnticipos.ParamByName('EI').AsInteger := e1;
  fdcBorraSelAnticipos.ParamByName('EF').AsInteger := e2;
  fdcBorraSelAnticipos.ParamByName('FI').AsDateTime := SoloFecha(f1);
  fdcBorraSelAnticipos.ParamByName('FF').AsDateTime := SoloFecha(f2);
  fdcBorraSelAnticipos.Execute();
end;

procedure TDataModuleTalonarios.BorraObservaDia(e1, e2: integer; f1,
  f2: TDateTime);
begin
  fdqBorraSelObserva.ParamByName('EI').AsInteger := e1;
  fdqBorraSelObserva.ParamByName('EF').AsInteger := e2;
  fdqBorraSelObserva.ParamByName('FI').AsDateTime := SoloFecha(f1);
  fdqBorraSelObserva.ParamByName('FF').AsDateTime := SoloFecha(f2);
  fdqBorraSelObserva.Execute();
end;

procedure TDataModuleTalonarios.BorrarBaseDatos;
begin
  fdcBorraTickets.Execute();
  fdcBorraAnticipos.Execute();
  fdcBorraObservaciones.Execute();
  fdqTickets.Refresh;
  fdqCobradores.First;
end;

procedure TDataModuleTalonarios.NoLiquidacion;
var
  f: TDate;
begin
  fdqTickets.DisableControls;
  fdqTickets.First;

  f := fdqTickets.FieldByName('fecha').AsDateTime;

  while not fdqTickets.Eof  do
  begin
    fdqTickets.Edit;
    fdqTickets.FieldByName('facturado').AsBoolean := False;
    fdqTickets.Post;

    fdqTickets.Next;
  end;
  fdqTickets.EnableControls;

  SelTicket(talonario.empleados_id, SoloFecha(f), False);
  fdqTalonarios.Refresh;
  UpTalonario;
end;

procedure TDataModuleTalonarios.SiLiquidacion;
var
  f: TDate;
begin
  fdqTickets.DisableControls;
  fdqTickets.First;

  f := fdqTickets.FieldByName('fecha').AsDateTime;

  while not fdqTickets.Eof  do
  begin
    fdqTickets.Edit;
    fdqTickets.FieldByName('facturado').AsBoolean := True;
    fdqTickets.Post;

    fdqTickets.Next;
  end;
  fdqTickets.EnableControls;

  SelTicket(talonario.empleados_id, SoloFecha(f), False);
  fdqTalonarios.Refresh;
  UpTalonario;
end;

function TDataModuleTalonarios.Precio(i: integer): Currency;
begin
  if fdqTipos.Active = False then
    fdqTipos.Open();
  fdqTipos.Locate('id', i,[loCaseInsensitive]);
  Result :=  fdqTipos.FieldByName('precio').AsCurrency;
end;

(*
procedure TDataModuleTalonarios.SelUltimo(e: integer; f: TDate; a: boolean);
begin

  //f := IncDay(base.fecha);
  f := base.fecha;
  //a := True;

  if fdqUltimoTalonario.Active = False then
    fdqUltimoTalonario.Open();
  fdqUltimoTalonario.ParamByName('EM').AsInteger := e;
  fdqUltimoTalonario.ParamByName('FE').AsDateTime := SoloFecha(f);
  fdqUltimoTalonario.ParamByName('FA').AsBoolean := a;
  fdqUltimoTalonario.Refresh;
  fdqUltimoTalonario.First;

  if fdqUltimoTalonario.IsEmpty then
    base.ultimo := True
  else
    base.ultimo := False;

end;

*)


procedure TDataModuleTalonarios.Refresca;
begin
  //SelUltimo(talonario.empleados_id, base.fecha, True);
  FacturadoDia(talonario.empleados_id, base.fecha, True);
  SelTalonario(talonario.empleados_id);
end;

end.
