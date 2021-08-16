unit UDMTickets;

interface

uses
  System.SysUtils, System.Classes,
  FireDAC.Stan.Param,
  Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Datasnap.DBClient, System.DateUtils;

type
  TNTicket = record
    id: integer;
    empleado_id: integer;
    fecha: TDateTime;
    sectores_id: integer;
    tipos_id: integer;
    letra: string;
    orden: integer;
  end;

type
  TTicket  = record
    tickets_id: integer;
    sectores_id: integer;
    tipos_id: integer;
    letra: string;
    desde: integer;
    hasta: integer;
    real: integer;
    orden: integer;
    orden2: integer;
    referencia: integer;
  end;

type
  TDataModuleTickets = class(TDataModule)
    DataSourceEmpleadosSinTickets: TDataSource;
    FDQueryEmpleadosSinTickets: TFDQuery;
    FDQueryEmpleadosEstado: TFDQuery;
    FDQueryEmpleadosEstadonombre: TWideStringField;
    DataSourceEmpleadosEstado: TDataSource;
    FDQueryEmpleadosEstadoid: TFDAutoIncField;
    FDQueryEmpleadosEstadoestado_id: TIntegerField;
    FDQueryTickets: TFDQuery;
    DataSourceTickets: TDataSource;
    FDQueryTipos: TFDQuery;
    FDQueryTiposid: TFDAutoIncField;
    FDQueryTiposnombre: TWideStringField;
    FDQuerySectores: TFDQuery;
    FDQuerySectoresid: TFDAutoIncField;
    FDQuerySectoresplayas_id: TIntegerField;
    FDQuerySectoressector: TWideStringField;
    FDQuerySectoresplaya: TWideStringField;
    FDQuerySumaTickets: TFDQuery;
    DataSourceSumaTickets: TDataSource;
    FDQueryTiposprecio: TCurrencyField;
    FDQueryTiposletra: TWideStringField;
    FDQueryCheckNumeros: TFDQuery;
    FDQueryCheckNumerostipos_id: TIntegerField;
    FDQueryCheckNumerosletra: TWideStringField;
    FDQueryCheckNumerosdesde: TIntegerField;
    FDQueryCheckNumerosreal: TIntegerField;
    FDQueryUltimosNumeros: TFDQuery;
    DataSourceUltimosNumeros: TDataSource;
    FDQueryEmpleados: TFDQuery;
    FDQueryEmpleadosid: TFDAutoIncField;
    FDQueryEmpleadosnombre: TWideStringField;
    FDQueryEmpleadosestado_id: TIntegerField;
    FDQueryPlayas: TFDQuery;
    FDQueryPlayasid: TFDAutoIncField;
    FDQueryPlayasplaya: TWideStringField;
    FDQueryTicketsid: TFDAutoIncField;
    FDQueryTicketsempleados_id: TIntegerField;
    FDQueryTicketssectores_id: TIntegerField;
    FDQueryTicketstipos_id: TIntegerField;
    FDQueryTicketsletra: TWideStringField;
    FDQueryTicketsdesde: TIntegerField;
    FDQueryTicketshasta: TIntegerField;
    FDQueryTicketsreal: TIntegerField;
    FDQueryTicketsorden: TIntegerField;
    FDQueryTicketsorden2: TIntegerField;
    FDQueryTicketsFacturacion: TFDQuery;
    DataSourceTicketsFacturacion: TDataSource;
    FDQueryTicketsFacturacionid: TFDAutoIncField;
    FDQueryTicketsFacturacionempleados_id: TIntegerField;
    FDQueryTicketsFacturacionsectores_id: TIntegerField;
    FDQueryTicketsFacturaciontipos_id: TIntegerField;
    FDQueryTicketsFacturacionletra: TWideStringField;
    FDQueryTicketsFacturaciondesde: TIntegerField;
    FDQueryTicketsFacturacionhasta: TIntegerField;
    FDQueryTicketsFacturacionreal: TIntegerField;
    FDQueryTicketsFacturacionorden: TIntegerField;
    FDQueryTicketsFacturacionorden2: TIntegerField;
    FDQueryTicketsnomempleado: TStringField;
    FDQueryTicketsnomsectores: TStringField;
    FDQueryTicketsnomtipo: TStringField;
    FDQueryTicketsFacturacionnomtipo: TStringField;
    FDQueryTicketsFacturacionnomempleado: TStringField;
    FDQueryTicketsDelDia: TFDQuery;
    DataSourceTicketsDelDia: TDataSource;
    FDQueryTicketsDelDiaempleados_id: TIntegerField;
    FDQueryTicketsDelDiafacturado: TBooleanField;
    FDQueryTicketsDelDianomempleado: TStringField;
    FDQueryEmpleadosSinTicketsid: TFDAutoIncField;
    FDQueryEmpleadosSinTicketsnombre: TWideStringField;
    FDQueryUltimosNumerostipos_id: TIntegerField;
    FDQueryUltimosNumerosMletra: TWideStringField;
    FDQueryUltimosNumerosMreal: TIntegerField;
    FDQueryCheckNumerosid: TFDAutoIncField;
    FDQueryTicketsFacturacionnomsector: TStringField;
    FDQuerySumaTicketsfecha: TSQLTimeStampField;
    FDQuerySumaTicketsempleados_id: TIntegerField;
    FDQuerySumaTicketstipos_id: TIntegerField;
    FDQuerySumaTicketsSD: TFloatField;
    FDQuerySumaTicketsSR: TFloatField;
    FDQueryTicketsFacturacionmprecio: TCurrencyField;
    FDQueryTicketsFacturacionimporte: TIntegerField;
    FDQueryTicketsFacturacioncantidad: TIntegerField;
    FDQuerySumaTicketsmprecio: TCurrencyField;
    FDQuerySumaTicketsimporte: TIntegerField;
    FDQuerySumaTicketscantidad: TIntegerField;
    FDQuerySumaTicketsnomtipo: TStringField;
    ClientDataSetTotal: TClientDataSet;
    ClientDataSetTotaltotal: TIntegerField;
    DataSourceTotal: TDataSource;
    FDQueryTicketsFacturacionfacturado: TBooleanField;
    FDQueryDiferencia: TFDQuery;
    FDQuerySumaTicketsdiferencia: TFloatField;
    FDQueryInforme: TFDQuery;
    FDQueryInformeDetalle: TFDQuery;
    DataSourceInforme: TDataSource;
    FDQueryInformenumeros: TStringField;
    FDQueryInformeDetallefecha: TSQLTimeStampField;
    FDQueryInformeDetallesectores_id: TIntegerField;
    FDQueryInformeDetalletipos_id: TIntegerField;
    FDQueryInformeDetalleempleados_id: TIntegerField;
    FDQueryInformeDetalleletra: TWideStringField;
    FDQueryInformeDetallereal: TIntegerField;
    FDQueryInformeDetalleorden: TIntegerField;
    FDQueryInformefecha: TSQLTimeStampField;
    FDQueryInformesectores_id: TIntegerField;
    FDQueryInformeempleados_id: TIntegerField;
    FDQueryInformenombre: TWideStringField;
    FDQueryInformeplayas_id: TIntegerField;
    FDQueryInformeplaya: TWideStringField;
    FDQueryInformesector: TWideStringField;
    FDQueryAnticipos: TFDQuery;
    DataSourceAnticipos: TDataSource;
    FDQueryAnticiposid: TFDAutoIncField;
    FDQueryAnticiposempleados_id: TIntegerField;
    FDQueryAnticiposfecha: TSQLTimeStampField;
    FDQueryAnticiposcantidad: TCurrencyField;
    FDQueryObservaciones: TFDQuery;
    DataSourceObservaciones: TDataSource;
    FDQueryObservacionesid: TFDAutoIncField;
    FDQueryObservacionesempleados_id: TIntegerField;
    FDQueryObservacionesfecha: TSQLTimeStampField;
    FDQueryObservacionesobservacion: TWideMemoField;
    FDQueryObservacionesvisto: TBooleanField;
    FDQueryEstados: TFDQuery;
    DataSourceEstados: TDataSource;
    FDQueryInformefeca: TDateTimeField;
    FDQueryTicketsfecha: TSQLTimeStampField;
    FDQueryTicketsFacturacionfecha: TSQLTimeStampField;
    FDQueryTicketsDelDiafecha: TSQLTimeStampField;
    FDQueryTicketscantidad: TIntegerField;
    FDQueryTicketsreferencia_id: TIntegerField;
    FDQueryTicketsFacturacionreferencia_id: TIntegerField;
    FDQuerySumaTicketsDados: TFDQuery;
    SQLTimeStampField1: TSQLTimeStampField;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    FloatField1: TFloatField;
    FloatField2: TFloatField;
    CurrencyField1: TCurrencyField;
    IntegerField3: TIntegerField;
    IntegerField4: TIntegerField;
    StringField1: TStringField;
    FloatField3: TFloatField;
    DataSourceSumaTicketsDados: TDataSource;
    FDQueryTicketsDelDianombre: TWideStringField;
    DataSourcePlayas: TDataSource;
    FDQueryBaseSectores: TFDQuery;
    FDQueryBaseSectoresid: TFDAutoIncField;
    FDQueryBaseSectoresplayas_id: TIntegerField;
    FDQueryBaseSectoressector: TWideStringField;
    DataSourceBaseSectores: TDataSource;
    FDQueryAnticiposAN: TSmallintField;
    FDQueryAnticiposMO: TSmallintField;
    FDQueryInformenumeros1: TStringField;
    FDQueryInformeorden_impresion: TIntegerField;
    FDQueryInformeDetalledesde: TIntegerField;
    FDQueryInformeEmpleado: TFDQuery;
    FDQueryInformeEmpleadoDetalle: TFDQuery;
    DataSourceInformeEmpleado: TDataSource;
    FDQueryInformeEmpleadofecha: TSQLTimeStampField;
    FDQueryInformeEmpleadoempleados_id: TIntegerField;
    FDQueryInformeEmpleadoDetallefecha: TSQLTimeStampField;
    FDQueryInformeEmpleadoDetalleempleados_id: TIntegerField;
    FDQueryInformeEmpleadoDetalletipos_id: TIntegerField;
    FDQueryInformeEmpleadoDetalleSD: TFloatField;
    FDQueryInformeEmpleadoDetalleSR: TFloatField;
    FDQueryInformeEmpleadoDetallediferencia: TFloatField;
    FDQueryInformeEmpleadohamacas: TIntegerField;
    FDQueryInformeEmpleadosombrillas: TIntegerField;
    FDQueryInformeEmpleadototal: TIntegerField;
    FDQueryInformeEmpleadototaleuros: TIntegerField;
    FDQueryInformeEmpleadonomempleado: TStringField;
    FDQueryInformeEmpleadofeca: TDateField;
    FDQueryInformeSectores: TFDQuery;
    FDQueryInformeSectoresfecha: TSQLTimeStampField;
    FDQueryInformeSectoressectores_id: TIntegerField;
    FDQueryInformeSectoreshamacas: TIntegerField;
    FDQueryInformeSectoressombrillas: TIntegerField;
    FDQueryInformeSectorestotal: TIntegerField;
    FDQueryInformeSectorestotaleuros: TIntegerField;
    FDQueryInformeSectoresfeca: TDateField;
    FDQueryInformeSectoresnomsector: TStringField;
    FDQueryInformeSectoresnomplaya: TStringField;
    DataSourceInformeSectores: TDataSource;
    FDQueryInformeSectoresDetalle: TFDQuery;
    FDQueryInformeSectoresDetallefecha: TSQLTimeStampField;
    FDQueryInformeSectoresDetallesectores_id: TIntegerField;
    FDQueryInformeSectoresDetalletipos_id: TIntegerField;
    FDQueryInformeSectoresDetalleSD: TFloatField;
    FDQueryInformeSectoresDetalleSR: TFloatField;
    FDQueryInformeSectoresDetallediferencia: TFloatField;
    FDQueryEmpleadosSinTicketsestado_id: TIntegerField;
    FDQueryInformeAnticipos: TFDQuery;
    FDQueryInformeAnticiposid: TFDAutoIncField;
    FDQueryInformeAnticiposempleados_id: TIntegerField;
    FDQueryInformeAnticiposfecha: TSQLTimeStampField;
    FDQueryInformeAnticiposcantidad: TCurrencyField;
    FDQueryInformeAnticiposnomempleado: TStringField;
    DataSourceInformeAnticipos: TDataSource;
    FDQueryUltimosTickets: TFDQuery;
    FDQueryResumenTickets: TFDQuery;
    FDQueryResumenTicketsid: TFDAutoIncField;
    FDQueryResumenTicketsfecha: TSQLTimeStampField;
    FDQueryResumenTicketsempleados_id: TIntegerField;
    FDQueryResumenTicketssectores_id: TIntegerField;
    FDQueryResumenTicketstipos_id: TIntegerField;
    FDQueryResumenTicketsletra: TWideStringField;
    FDQueryResumenTicketsdesde: TIntegerField;
    FDQueryResumenTicketshasta: TIntegerField;
    FDQueryResumenTicketsreal: TIntegerField;
    FDQueryResumenTicketsorden: TIntegerField;
    FDQueryResumenTicketsorden2: TIntegerField;
    FDQueryResumenTicketsreferencia_id: TIntegerField;
    DataSourceResumenTickets: TDataSource;
    FDQueryResumenTicketsnombre: TWideStringField;
    FDQueryResumenTicketsfacturado: TBooleanField;
    FDQueryVacaciones: TFDQuery;
    FDQueryDetalleVacaciones: TFDQuery;
    FDQueryVacacionesfecha: TSQLTimeStampField;
    FDQueryVacacionessectores_id: TIntegerField;
    FDQueryVacacionessector: TWideStringField;
    FDQueryVacacionesempleados_id: TIntegerField;
    FDQueryVacacionesnombre: TWideStringField;
    FDQueryVacacionesplayas_id: TIntegerField;
    FDQueryVacacionesplaya: TWideStringField;
    FDQueryVacacionesorden_impresion: TIntegerField;
    FDQueryVacacionesfeca: TDateField;
    DataSourceVacaciones: TDataSource;
    FDQueryVacacionesnumeros: TStringField;
    FDQueryVacacionesnumeros1: TStringField;
    FDQueryUltimoSector: TFDQuery;
    FDQueryUltimoSectorMF: TSQLTimeStampField;
    FDQueryUltimoSectorempleados_id: TIntegerField;
    FDQueryUltimoSectorUS_id: TIntegerField;
    FDQueryRestoVacaciones: TFDQuery;
    FDQueryRestoVacacionesid: TFDAutoIncField;
    FDQueryRestoVacacionesnombre: TWideStringField;
    FDQueryRestoVacacionesestado_id: TIntegerField;
    DataSourceRestoVacaciones: TDataSource;
    FDQueryInformeObservacion: TFDQuery;
    DataSourceInformeObservacion: TDataSource;
    FDQueryInformeObservacionid: TFDAutoIncField;
    FDQueryInformeObservacionempleados_id: TIntegerField;
    FDQueryInformeObservacionfecha: TSQLTimeStampField;
    FDQueryInformeObservacionobservacion: TWideMemoField;
    FDQueryInformeObservacionvisto: TBooleanField;
    FDQueryInformeObservacionnomempleados: TStringField;
    procedure FDQueryDetalleTicketsFacturacionCalcFields(DataSet: TDataSet);
    procedure FDQuerySumaTicketsCalcFields(DataSet: TDataSet);
    procedure FDQueryDetalleTicketsFacturacionAfterPost(DataSet: TDataSet);
    procedure FDQuerySumaTotalTicketsCalcFields(DataSet: TDataSet);
    procedure FDQueryDetalleTicketsFacturacionBeforePost(DataSet: TDataSet);
    procedure FDQueryDetalleTicketsCalcFields(DataSet: TDataSet);
    procedure FDQueryTicketsFacturacionCalcFields(DataSet: TDataSet);
    procedure FDQueryTicketsFacturacionAfterPost(DataSet: TDataSet);
    procedure FDQueryTicketsFacturacionBeforePost(DataSet: TDataSet);
    procedure FDQueryInformeCalcFields(DataSet: TDataSet);
    procedure FDQueryObservacionesBeforePost(DataSet: TDataSet);
    procedure FDQueryEmpleadosEstadoBeforePost(DataSet: TDataSet);
    procedure FDQueryTicketsCalcFields(DataSet: TDataSet);
    procedure FDQuerySumaTicketsDadosCalcFields(DataSet: TDataSet);
    procedure FDQueryTicketsFacturacionBeforeDelete(DataSet: TDataSet);
    procedure FDQueryAnticiposBeforePost(DataSet: TDataSet);
    procedure FDQueryInformeEmpleadoCalcFields(DataSet: TDataSet);
    procedure FDQueryInformeSectoresCalcFields(DataSet: TDataSet);
    procedure FDQueryAnticiposAfterInsert(DataSet: TDataSet);
    procedure FDQueryObservacionesAfterInsert(DataSet: TDataSet);
    procedure FDQueryVacacionesCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    MiTicket: TTicket;
    MiNTicket: TNTicket;
    ElDia: TDateTime;
    Empleado: integer;
    procedure EmpleadosSinTickets(l: TDateTime);
    procedure ListaConTickets(l: TDateTime);
    procedure EmpleadosEstado(e: integer);
    procedure SectoresEstado();
    procedure CreaTickets();
    procedure InsertaTickets(ddd: integer; hhh: integer; lll: Char);

    procedure Nuevo();
    procedure Edita();
    procedure Lista();
    procedure Modifica();
    procedure Corrige();
    procedure Liquida();
    procedure RefrescaTickets();

    function CheckNumero(): boolean;

    function SumaTotal(): integer;

    procedure LineUp();
    procedure LineDown();

    procedure observaciones();

    procedure ImprimeEmpleadoDia(e1: integer; e2: integer; f1: TDateTime; f2: TDateTime);
    procedure ImprimeSectorDia(s1: integer; s2: integer; f1: TDateTime; f2: TDateTime);
    procedure ImprimeAnticipoDia(e1: integer; e2: integer; f1: TDateTime; f2: TDateTime);
    procedure ImprimeObservacionDia(e1: integer; e2: integer; f1: TDateTime; f2: TDateTime);

    function UltimoDia(e: integer; f: TDate): TDate;

    procedure CambiaFechaSector(f: TDate; s: integer);
    function UltimoSector(e: integer): integer;
  end;

var
  DataModuleTickets: TDataModuleTickets;

implementation

uses
  UDMPrincipal;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDataModuleTickets.observaciones;
begin
  FDQueryObservaciones.Close;
  FDQueryObservaciones.Params.ParamByName('E').AsInteger := MiNTicket.empleado_id;
  FDQueryObservaciones.Open();
  FDQueryObservaciones.Refresh;
end;

function TDataModuleTickets.CheckNumero(): Boolean;
begin
  FDQueryCheckNumeros.Close;
  FDQueryCheckNumeros.ParamByName('T').AsInteger := MiTicket.tipos_id;
  FDQueryCheckNumeros.ParamByName('L').AsString := MiTicket.letra;
  FDQueryCheckNumeros.ParamByName('N1').AsInteger := MiTicket.desde;
  FDQueryCheckNumeros.ParamByName('N2').AsInteger := MiTicket.desde;
  FDQueryCheckNumeros.ParamByName('N3').AsInteger := MiTicket.hasta;
  FDQueryCheckNumeros.ParamByName('N4').AsInteger := MiTicket.hasta;
  FDQueryCheckNumeros.Open();
  FDQueryCheckNumeros.Refresh;
  FDQueryCheckNumeros.First;
  if FDQueryCheckNumeros.Eof then
    Result := False
  else
    Result := True;
end;


procedure TDataModuleTickets.RefrescaTickets();
begin
  FDQueryTicketsDelDia.Params.ParamByName('F').AsDateTime := ElDia;
  FDQueryTicketsDelDia.Refresh;
  FDQueryTickets.Close;
  FDQueryTickets.Params.ParamByName('E').AsInteger := MiNTicket.empleado_id;
  FDQueryTickets.Params.ParamByName('F').AsDateTime := MiNTicket.fecha;
  FDQueryTickets.Open;
end;

function TDataModuleTickets.SumaTotal(): integer;
var
  i: integer;
begin
  i := 0;
  FDQuerySumaTickets.First;
  while not FDQuerySumaTickets.Eof do
  begin
    i := i + FDQuerySumaTickets.FieldByName('importe').AsInteger;
    FDQuerySumaTickets.Next;
  end;

  Result := i;
end;

procedure TDataModuleTickets.Nuevo();
begin
  // Nuevo talonario

  FDQueryTickets.Close;
  FDQueryTicketsFacturacion.Close;
  FDQuerySumaTickets.Close;
  ClientDataSetTotal.Close;
end;

procedure TDataModuleTickets.Lista();
var
  d: TDateTime;
begin
  d := IncDay(ElDia);
  FDQueryInformeDetalle.Open();
  FDQueryInforme.Close;
  FDQueryInforme.Params.ParamByName('FE').AsDateTime := StrToDate(FormatDateTime('dd/mm/yyyy', d));
  FDQueryInforme.Open();
  FDQueryDetalleVacaciones.Open();
  FDQueryVacaciones.Close;
  FDQueryVacaciones.Params.ParamByName('FE').AsDateTime := StrToDate(FormatDateTime('dd/mm/yyyy', d));
  FDQueryVacaciones.Open();
  FDQueryRestoVacaciones.Close;
  FDQueryRestoVacaciones.Params.ParamByName('F').AsDateTime := StrToDate(FormatDateTime('dd/mm/yyyy', d));
  FDQueryRestoVacaciones.Open();
end;

procedure TDataModuleTickets.Modifica();
var
  d, m, y: word;
begin
  // Operaciones de liquidacion y modificacion

  FDQueryObservaciones.Close;
  FDQueryObservaciones.Params.ParamByName('E').AsInteger := FDQueryTicketsDelDia.FieldByName('empleados_id').AsInteger;
  FDQueryObservaciones.Open();

  FDQueryTicketsFacturacion.Close;
  FDQueryTicketsFacturacion.Params.ParamByName('E').AsInteger := FDQueryTicketsDelDia.FieldByName('empleados_id').AsInteger;
  FDQueryTicketsFacturacion.Params.ParamByName('F').AsDateTime := FDQueryTicketsDelDia.FieldByName('fecha').AsDateTime;
  FDQueryTicketsFacturacion.Open();

  FDQuerySumaTickets.Open();

  ClientDataSetTotal.Open;
  ClientDataSetTotal.Edit;
  ClientDataSetTotal.FieldByName('total').AsInteger := SumaTotal;
  ClientDataSetTotal.Post;

  FDQueryTickets.Params.ParamByName('E').AsInteger := MiNTicket.empleado_id;
  FDQueryTickets.Params.ParamByName('F').AsDateTime := MiNTicket.fecha;
  FDQueryTickets.Open();
  FDQueryTickets.Refresh;
  FDQuerySumaTicketsDados.Open();

  FDQueryAnticipos.Close;
  DecodeDate(FDQueryTicketsDelDia.FieldByName('fecha').AsDateTime, y, m, d);
  FDQueryAnticipos.Params.ParamByName('E').AsInteger := FDQueryTicketsDelDia.FieldByName('empleados_id').AsInteger;
  FDQueryAnticipos.Params.ParamByName('M').AsInteger := m;
  FDQueryAnticipos.Params.ParamByName('A').AsInteger := y;
  FDQueryAnticipos.Open();

end;

procedure TDataModuleTickets.Corrige();
var
  d, m, y: word;
begin
  // Corregir talonario sin liquidar

  FDQueryObservaciones.Close;
  FDQueryObservaciones.Params.ParamByName('E').AsInteger := FDQueryTicketsDelDia.FieldByName('empleados_id').AsInteger;
  FDQueryObservaciones.Open();

  (*
  FDQueryTicketsFacturacion.Close;
  FDQueryTicketsFacturacion.Params.ParamByName('E').AsInteger := FDQueryTicketsDelDia.FieldByName('empleados_id').AsInteger;
  FDQueryTicketsFacturacion.Params.ParamByName('F').AsDateTime := FDQueryTicketsDelDia.FieldByName('fecha').AsDateTime;
  FDQueryTicketsFacturacion.Open();

  FDQuerySumaTickets.Open();


  ClientDataSetTotal.Open;
  ClientDataSetTotal.Edit;
  ClientDataSetTotal.FieldByName('total').AsInteger := SumaTotal;
  ClientDataSetTotal.Post;
  *)

  FDQueryAnticipos.Close;
  DecodeDate(FDQueryTicketsDelDia.FieldByName('fecha').AsDateTime, y, m, d);
  FDQueryAnticipos.Params.ParamByName('E').AsInteger := FDQueryTicketsDelDia.FieldByName('empleados_id').AsInteger;
  FDQueryAnticipos.Params.ParamByName('M').AsInteger := m;
  FDQueryAnticipos.Params.ParamByName('A').AsInteger := y;
  FDQueryAnticipos.Open();


  FDQueryTickets.Params.ParamByName('E').AsInteger := MiNTicket.empleado_id;
  FDQueryTickets.Params.ParamByName('F').AsDateTime := MiNTicket.fecha;
  FDQueryTickets.Open();
  FDQueryTickets.Refresh;
  FDQuerySumaTicketsDados.Open();
end;

procedure TDataModuleTickets.Edita();
var
  d, m, y: word;
begin
  FDQueryTickets.Open();
  FDQuerySumaTicketsDados.Open();
  FDQueryAnticipos.Open();
  FDQueryObservaciones.Close;
  FDQueryObservaciones.Params.ParamByName('E').AsInteger := FDQueryTicketsDelDia.FieldByName('empleados_id').AsInteger;
  FDQueryObservaciones.Open();
  FDQueryTicketsFacturacion.Close;
  FDQueryTicketsFacturacion.Params.ParamByName('E').AsInteger := FDQueryTicketsDelDia.FieldByName('empleados_id').AsInteger;
  FDQueryTicketsFacturacion.Params.ParamByName('F').AsDateTime := FDQueryTicketsDelDia.FieldByName('fecha').AsDateTime;
  FDQueryTicketsFacturacion.Open();


  FDQueryAnticipos.Close;
  DecodeDate(FDQueryTicketsDelDia.FieldByName('fecha').AsDateTime, y, m, d);
  FDQueryAnticipos.Params.ParamByName('E').AsInteger := FDQueryTicketsDelDia.FieldByName('empleados_id').AsInteger;
  FDQueryAnticipos.Params.ParamByName('M').AsInteger := m;
  FDQueryAnticipos.Params.ParamByName('A').AsInteger := y;
  FDQueryAnticipos.Open();


  FDQuerySumaTickets.Open();

  ClientDataSetTotal.Open;
  ClientDataSetTotal.Edit;
  ClientDataSetTotal.FieldByName('total').AsInteger := SumaTotal;
  ClientDataSetTotal.Post;

end;

procedure TDataModuleTickets.Liquida();
begin
  FDQueryTickets.Open();
  FDQuerySumaTicketsDados.Open();

  FDQueryTicketsFacturacion.First;

  MiNTicket.orden := 1;

  FDQueryTickets.DisableControls;

  while not FDQueryTicketsFacturacion.Eof do
  begin
    if FDQueryTickets.Locate('referencia_id', FDQueryTicketsFacturacion.FieldByName('id').AsInteger, [loCaseInsensitive]) = True  then
    begin
      FDQueryTickets.Edit;
      FDQueryTickets.FieldByName('desde').AsInteger := FDQueryTicketsFacturacion.FieldByName('real').AsInteger;
      FDQueryTickets.FieldByName('hasta').AsInteger := FDQueryTicketsFacturacion.FieldByName('hasta').AsInteger;
      FDQueryTickets.FieldByName('real').AsInteger := FDQueryTicketsFacturacion.FieldByName('hasta').AsInteger;
      FDQueryTickets.Post;
    end else
    if FDQueryTicketsFacturacion.FieldByName('real').AsInteger < FDQueryTicketsFacturacion.FieldByName('hasta').AsInteger then
    begin
      FDQueryTickets.Insert;
      FDQueryTickets.FieldByName('sectores_id').AsInteger := FDQueryTicketsFacturacion.FieldByName('sectores_id').AsInteger;
      FDQueryTickets.FieldByName('tipos_id').AsInteger := FDQueryTicketsFacturacion.FieldByName('tipos_id').AsInteger;
      FDQueryTickets.FieldByName('empleados_id').AsInteger := FDQueryTicketsFacturacion.FieldByName('empleados_id').AsInteger;
      FDQueryTickets.FieldByName('fecha').AsDateTime :=  StrToDate(FormatDateTime('dd/mm/yyyy', MiNTicket.fecha));
      FDQueryTickets.FieldByName('letra').AsString := FDQueryTicketsFacturacion.FieldByName('letra').AsString;
      FDQueryTickets.FieldByName('desde').AsInteger := FDQueryTicketsFacturacion.FieldByName('real').AsInteger;
      FDQueryTickets.FieldByName('hasta').AsInteger := FDQueryTicketsFacturacion.FieldByName('hasta').AsInteger;
      FDQueryTickets.FieldByName('real').AsInteger := FDQueryTicketsFacturacion.FieldByName('hasta').AsInteger;
      FDQueryTickets.FieldByName('orden').AsInteger := MiNTicket.orden;
      FDQueryTickets.FieldByName('orden2').AsInteger := MiNTicket.orden;
      FDQueryTickets.FieldByName('referencia_id').AsInteger := FDQueryTicketsFacturacion.FieldByName('id').AsInteger;
      FDQueryTickets.Post;

      Inc(MiNTicket.orden);
    end;

    FDQueryTickets.EnableControls;

    FDQueryTicketsFacturacion.Edit;
    FDQueryTicketsFacturacion.FieldByName('facturado').AsBoolean := True;
    FDQueryTicketsFacturacion.Post;

    FDQueryTicketsFacturacion.Next;
  end;

  FDQueryTickets.Params.ParamByName('E').AsInteger := MiNTicket.empleado_id;
  FDQueryTickets.Params.ParamByName('F').AsDateTime := StrToDate(FormatDateTime('dd/mm/yyyy', MiNTicket.fecha));
  FDQueryTickets.Refresh;
end;

procedure TDataModuleTickets.EmpleadosSinTickets(l: TDateTime);
begin
  FDQueryEmpleadosSinTickets.Close();
  FDQueryEmpleadosSinTickets.Params.ParamByName('F').AsDateTime := StrToDate(FormatDateTime('dd/mm/yyyy', l));
  FDQueryEmpleadosSinTickets.Open();
end;

procedure TDataModuleTickets.ListaConTickets(l: TDateTime);
begin
  FDQueryTicketsDelDia.Close;
  FDQueryTicketsDelDia.Params.ParamByName('F').AsDateTime := StrToDate(FormatDateTime('dd/mm/yyyy', l));
  FDQueryTicketsDelDia.Open();
end;

procedure TDataModuleTickets.EmpleadosEstado(e: integer);
Begin
  FDQueryEstados.Open();
  if FDQueryEmpleadosEstado.Active = True then
    FDQueryEmpleadosEstado.Close;
  FDQueryEmpleadosEstado.ParamByName('E').AsInteger := e;
  FDQueryEmpleadosEstado.Open();
end;

procedure TDataModuleTickets.SectoresEstado();
begin
  FDQueryPlayas.Open();
  FDQueryBaseSectores.Open();
end;

procedure TDataModuleTickets.FDQueryAnticiposAfterInsert(DataSet: TDataSet);
begin
  DataSet.FieldByName('fecha').AsDateTime := StrToDate(FormatDateTime('dd/mm/yyyy', Date));
end;

procedure TDataModuleTickets.FDQueryAnticiposBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('cantidad').AsInteger = 0 then
  begin
    DataSet.Cancel;
    Exit;
  end;

  DataSet.FieldByName('empleados_id').AsInteger := MiNTicket.empleado_id;
end;

Procedure TDataModuleTickets.FDQueryDetalleTicketsCalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('sectorplaya').AsString :=
    DataSet.FieldByName('sector').AsString + ' - ' + DataSet.FieldByName('playa').AsString;
end;

procedure TDataModuleTickets.FDQueryDetalleTicketsFacturacionAfterPost(
  DataSet: TDataSet);
begin
  FDQuerySumaTickets.Refresh;
end;

procedure TDataModuleTickets.FDQueryDetalleTicketsFacturacionBeforePost(
  DataSet: TDataSet);
begin
  if (DataSet.FieldByName('real').AsInteger > DataSet.FieldByName('hasta').AsInteger) or
   (DataSet.FieldByName('real').AsInteger < DataSet.FieldByName('desde').AsInteger) then
   DataSet.Cancel;

   Exit;
end;

procedure TDataModuleTickets.FDQueryDetalleTicketsFacturacionCalcFields(
  DataSet: TDataSet);
begin
  DataSet.FieldByName('importe').AsCurrency := (DataSet.FieldByName('real').AsInteger -
    DataSet.FieldByName('desde').AsInteger) * DataSet.FieldByName('precio').AsCurrency;

  DataSet.FieldByName('sectorplaya').AsString :=
    DataSet.FieldByName('sector').AsString + ' - ' + DataSet.FieldByName('playa').AsString;
end;

procedure TDataModuleTickets.FDQueryEmpleadosEstadoBeforePost(
  DataSet: TDataSet);
begin
  if DataSet.FieldByName('estado_id').AsInteger = 0 then
    DataSet.FieldByName('estado_id').AsInteger := 1;
end;

procedure TDataModuleTickets.FDQueryInformeCalcFields(DataSet: TDataSet);
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

  FDQueryInformeDetalle.Refresh;
  FDQueryInformeDetalle.First;
  l := '';
  s := '';
  s1 := '';
  x := 0;

  while Not FDQueryInformeDetalle.Eof do
  begin
    t := FDQueryInformeDetalle.FieldByName('tipos_id').AsInteger;
    a := FDQueryInformeDetalle.FieldByName('letra').AsString;
    n := FDQueryInformeDetalle.FieldByName('desde').AsString;
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
    FDQueryInformeDetalle.Next;
  end;

  DataSet.FieldByName('numeros').AsString := s;
  DataSet.FieldByName('numeros1').AsString := s1;
end;

procedure TDataModuleTickets.FDQueryInformeEmpleadoCalcFields(
  DataSet: TDataSet);
var
  t: integer;
  h: integer;
  s: integer;
begin
  DataSet.FieldByName('feca').AsDateTime := DataSet.FieldByName('fecha').AsDateTime;

  if FDQueryInformeEmpleadoDetalle.Active = False then
    FDQueryInformeEmpleadoDetalle.Open();

  FDQueryInformeEmpleadoDetalle.Refresh;
  FDQueryInformeEmpleadoDetalle.First;
  while not FDQueryInformeEmpleadoDetalle.Eof do
  begin
    t := FDQueryInformeEmpleadoDetalle.FieldByName('tipos_id').AsInteger;

    if t = 1 then
      DataSet.FieldByName('hamacas').AsInteger := FDQueryInformeEmpleadoDetalle.FieldByName('diferencia').AsInteger;

    if t = 2 then
      DataSet.FieldByName('sombrillas').AsInteger := FDQueryInformeEmpleadoDetalle.FieldByName('diferencia').AsInteger;

   FDQueryInformeEmpleadoDetalle.Next;
  end;

  DataSet.FieldByName('total').AsInteger := DataSet.FieldByName('hamacas').AsInteger + DataSet.FieldByName('sombrillas').AsInteger;
  DataSet.FieldByName('totaleuros').AsInteger := DataSet.FieldByName('total').AsInteger * 4;
end;

procedure TDataModuleTickets.FDQueryInformeSectoresCalcFields(
  DataSet: TDataSet);
var
  t: integer;
  h: integer;
  s: integer;
begin
  DataSet.FieldByName('feca').AsDateTime := DataSet.FieldByName('fecha').AsDateTime;

  if FDQueryInformeSectoresDetalle.Active = False then
    FDQueryInformeSectoresDetalle.Open();

  FDQueryInformeSectoresDetalle.Refresh;
  FDQueryInformeSectoresDetalle.First;
  while not FDQueryInformeSectoresDetalle.Eof do
  begin
    t := FDQueryInformeSectoresDetalle.FieldByName('tipos_id').AsInteger;

    if t = 1 then
      DataSet.FieldByName('hamacas').AsInteger := FDQueryInformeSectoresDetalle.FieldByName('diferencia').AsInteger;

    if t = 2 then
      DataSet.FieldByName('sombrillas').AsInteger := FDQueryInformeSectoresDetalle.FieldByName('diferencia').AsInteger;

   FDQueryInformeSectoresDetalle.Next;
  end;

  DataSet.FieldByName('total').AsInteger := DataSet.FieldByName('hamacas').AsInteger + DataSet.FieldByName('sombrillas').AsInteger;
  DataSet.FieldByName('totaleuros').AsInteger := DataSet.FieldByName('total').AsInteger * 4;

end;

procedure TDataModuleTickets.FDQueryObservacionesAfterInsert(DataSet: TDataSet);
begin
  DataSet.FieldByName('fecha').AsDateTime := StrToDate(FormatDateTime('dd/mm/yyyy', Date));
end;

procedure TDataModuleTickets.FDQueryObservacionesBeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('visto').AsBoolean = False then
    DataSet.FieldByName('visto').AsBoolean :=False;
  DataSet.FieldByName('empleados_id').AsInteger := MiNTicket.empleado_id;
end;

procedure TDataModuleTickets.FDQuerySumaTicketsCalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('cantidad').AsCurrency := DataSet.FieldByName('diferencia').AsInteger;
  DataSet.FieldByName('importe').AsCurrency := DataSet.FieldByName('cantidad').AsInteger *
    DataSet.FieldByName('mprecio').AsInteger;
end;

procedure TDataModuleTickets.FDQuerySumaTicketsDadosCalcFields(
  DataSet: TDataSet);
begin
  DataSet.FieldByName('cantidad').AsCurrency := DataSet.FieldByName('diferencia').AsInteger;
  DataSet.FieldByName('importe').AsCurrency := DataSet.FieldByName('cantidad').AsInteger *
    DataSet.FieldByName('mprecio').AsInteger;
end;

procedure TDataModuleTickets.FDQuerySumaTotalTicketsCalcFields(
  DataSet: TDataSet);
begin
  DataSet.FieldByName('importetotal').AsCurrency := ((DataSet.FieldByName('sumadereal').AsInteger -
    DataSet.FieldByName('sumadedesde').AsInteger) * DataSet.FieldByName('precio').AsCurrency);
end;

procedure TDataModuleTickets.FDQueryTicketsCalcFields(DataSet: TDataSet);
begin
  if DataSet.FieldByName('real').AsInteger = DataSet.FieldByName('desde').AsInteger  then
    DataSet.FieldByName('cantidad').AsInteger := 0
  else
    DataSet.FieldByName('cantidad').AsInteger := (DataSet.FieldByName('real').AsInteger) -
    (DataSet.FieldByName('desde').AsInteger) + 1;
end;

procedure TDataModuleTickets.FDQueryTicketsFacturacionAfterPost(
  DataSet: TDataSet);
begin

    if FDQueryTickets.Locate('referencia_id', DataSet.FieldByName('id').AsInteger, [loCaseInsensitive]) = True  then
    begin
      FDQueryTickets.Edit;
      FDQueryTickets.FieldByName('desde').AsInteger := FDQueryTicketsFacturacion.FieldByName('real').AsInteger;
      FDQueryTickets.FieldByName('hasta').AsInteger := FDQueryTicketsFacturacion.FieldByName('hasta').AsInteger;
      FDQueryTickets.FieldByName('real').AsInteger := FDQueryTicketsFacturacion.FieldByName('hasta').AsInteger;
      FDQueryTickets.Post;
    end;

  FDQuerySumaTickets.Refresh;
  ClientDataSetTotal.Edit;
  ClientDataSetTotal.FieldByName('total').AsInteger := SumaTotal;
  ClientDataSetTotal.Post;
end;

procedure TDataModuleTickets.FDQueryTicketsFacturacionBeforeDelete(
  DataSet: TDataSet);
begin
    if FDQueryTickets.Locate('referencia_id', DataSet.FieldByName('id').AsInteger, [loCaseInsensitive]) = True  then
    begin
      FDQueryTickets.Edit;
      FDQueryTickets.FieldByName('desde').AsInteger := FDQueryTicketsFacturacion.FieldByName('desde').AsInteger;
      FDQueryTickets.FieldByName('hasta').AsInteger := FDQueryTicketsFacturacion.FieldByName('hasta').AsInteger;
      FDQueryTickets.FieldByName('real').AsInteger := FDQueryTicketsFacturacion.FieldByName('hasta').AsInteger;
      FDQueryTickets.Post;
    end;
end;

Procedure TDataModuleTickets.FDQueryTicketsFacturacionBeforePost(
  DataSet: TDataSet);
begin
  if DataSet.FieldByName('real').AsInteger = 0 then
  begin
    DataSet.FieldByName('real').AsInteger := DataSet.FieldByName('desde').AsInteger
  end;

  if DataSet.FieldByName('real').AsInteger > DataSet.FieldByName('hasta').AsInteger then
  begin
    DataSet.Cancel;
  end;

  if DataSet.FieldByName('real').AsInteger < DataSet.FieldByName('desde').AsInteger then
  begin
    DataSet.Cancel;
  end;
end;

procedure TDataModuleTickets.FDQueryTicketsFacturacionCalcFields(
  DataSet: TDataSet);
begin
  if DataSet.FieldByName('real').AsInteger = DataSet.FieldByName('desde').AsInteger  then
    DataSet.FieldByName('cantidad').AsInteger := 0
  else
    DataSet.FieldByName('cantidad').AsInteger := (DataSet.FieldByName('real').AsInteger) -
    (DataSet.FieldByName('desde').AsInteger) + 1;
  DataSet.FieldByName('importe').AsInteger := (DataSet.FieldByName('cantidad').AsInteger *
    DataSet.FieldByName('mprecio').AsInteger);
end;

procedure TDataModuleTickets.FDQueryVacacionesCalcFields(DataSet: TDataSet);
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

  FDQueryDetalleVacaciones.Refresh;
  FDQueryDetalleVacaciones.First;
  l := '';
  s := '';
  s1 := '';
  x := 0;

  while Not FDQueryDetalleVacaciones.Eof do
  begin
    t := FDQueryDetalleVacaciones.FieldByName('tipos_id').AsInteger;
    a := FDQueryDetalleVacaciones.FieldByName('letra').AsString;
    n := FDQueryDetalleVacaciones.FieldByName('desde').AsString;
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
    FDQueryDetalleVacaciones.Next;
  end;

  DataSet.FieldByName('numeros').AsString := s;
  DataSet.FieldByName('numeros1').AsString := s1;
end;

procedure TDataModuleTickets.CreaTickets();
var
  lll: Char;
  l: integer;
  dd: integer;
  hh: integer;
  ll: string;
begin
  FDQueryTipos.Open();
  FDQuerySectores.Open();
  FDQueryTickets.Open();
  dd := MiTicket.desde;
  hh := MiTicket.hasta;
  ll := MiTicket.letra;
  lll := ll[1];
  MiNTicket.orden := 10 * MiTicket.tipos_id;

  FDQuerySumaTicketsDados.Open();

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

  FDQueryTipos.Refresh;
  FDQueryTipos.Locate('id', MiTicket.tipos_id, [loCaseInsensitive]);
  FDQueryTipos.Edit;
  FDQueryTipos.FieldByName('letra').AsString := lll;
  FDQueryTipos.Post;
end;

procedure TDataModuleTickets.InsertaTickets(ddd: integer; hhh: integer; lll: Char);
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
    FDQueryTickets.Append;
    FDQueryTickets.FieldByName('sectores_id').AsInteger := MiTicket.sectores_id;
    FDQueryTickets.FieldByName('tipos_id').AsInteger := MiTicket.tipos_id;
    FDQueryTickets.FieldByName('empleados_id').AsInteger := MiNTicket.empleado_id;
    FDQueryTickets.FieldByName('fecha').AsString :=  FormatDateTime('dd/mm/yyyy', MiNTicket.fecha);
    FDQueryTickets.FieldByName('letra').AsString := lll;
    FDQueryTickets.FieldByName('desde').AsInteger := ddf;
    FDQueryTickets.FieldByName('hasta').AsInteger := hhf;
    FDQueryTickets.FieldByName('real').AsInteger := hhf;
    FDQueryTickets.FieldByName('orden').AsInteger := MiNTicket.orden;
    FDQueryTickets.FieldByName('orden2').AsInteger := MiNTicket.orden;
    FDQueryTickets.Post;

    ddf := hhf + 1;
    hhf := ddf + 99;
    Inc(MiNTicket.orden);
  end;
end;

procedure TDataModuleTickets.LineUp();
var
  cur, prev: integer;
  idligne: integer;
begin
  if (FDQueryTickets.RecordCount = 0) then
    Exit;
  FDQueryTickets.DisableControls;
  try
    if (FDQueryTickets.RecNo > 0) then
    begin
      cur := FDQueryTickets.FieldByName('orden').AsInteger;
      idligne := FDQueryTickets.FieldByName('id').AsInteger;
      FDQueryTickets.Prior;
      prev := FDQueryTickets.FieldByName('orden').AsInteger;
      FDQueryTickets.Edit;
      FDQueryTickets.FieldByName('orden').AsInteger := cur;
      FDQueryTickets.Post;
      FDQueryTickets.Locate('id', idligne, [loCaseInsensitive]);
      FDQueryTickets.Edit;
      FDQueryTickets.FieldByName('orden').AsInteger := prev;
      FDQueryTickets.Post;
    end;
  finally
      FDQueryTickets.EnableControls;
  end;
    FDQueryTickets.Refresh;
end;

procedure TDataModuleTickets.LineDown();
var
  cur, prev: integer;
  idligne: integer;
begin
  if (FDQueryTickets.RecordCount = 0) then
    Exit;
  FDQueryTickets.DisableControls;
  try
    if (FDQueryTickets.RecNo > 0) then
    begin
      cur := FDQueryTickets.FieldByName('orden').AsInteger;
      idligne := FDQueryTickets.FieldByName('id').AsInteger;
      FDQueryTickets.Next;
      prev := FDQueryTickets.FieldByName('orden').AsInteger;
      FDQueryTickets.Edit;
      FDQueryTickets.FieldByName('orden').AsInteger := cur;
      FDQueryTickets.Post;
      FDQueryTickets.Locate('id', idligne, [loCaseInsensitive]);
      FDQueryTickets.Edit;
      FDQueryTickets.FieldByName('orden').AsInteger := prev;
      FDQueryTickets.Post;
    end;
  finally
      FDQueryTickets.EnableControls;
  end;
    FDQueryTickets.Refresh;
end;

procedure TDataModuleTickets.ImprimeEmpleadoDia(e1: integer; e2: integer; f1: TDateTime; f2: TDateTime);
begin
  FDQueryInformeEmpleado.Close;
  FDQueryInformeEmpleado.ParamByName('EI').AsInteger := e1;
  FDQueryInformeEmpleado.ParamByName('EF').AsInteger := e2;
  FDQueryInformeEmpleado.ParamByName('FI').AsDateTime := StrToDate(FormatDateTime('dd/mm/yyyy', f1));
  FDQueryInformeEmpleado.ParamByName('FF').AsDateTime := StrToDate(FormatDateTime('dd/mm/yyyy', f2));
  FDQueryInformeEmpleado.Open();
  FDQueryInformeEmpleadoDetalle.Open();
end;

procedure TDataModuleTickets.ImprimeSectorDia(s1: integer; s2: integer; f1: TDateTime; f2: TDateTime);
begin
  FDQueryInformeSectores.Close;
  FDQueryInformeSectores.ParamByName('SI').AsInteger := s1;
  FDQueryInformeSectores.ParamByName('SF').AsInteger := s2;
  FDQueryInformeSectores.ParamByName('FI').AsDateTime := StrToDate(FormatDateTime('dd/mm/yyyy', f1));
  FDQueryInformeSectores.ParamByName('FF').AsDateTime := StrToDate(FormatDateTime('dd/mm/yyyy', f2));
  FDQueryInformeSectores.Open();
  FDQueryInformeSectoresDetalle.Open();
end;

procedure TDataModuleTickets.ImprimeAnticipoDia(e1: integer; e2: integer; f1: TDateTime; f2: TDateTime);
begin
  FDQueryInformeAnticipos.Close;
  FDQueryInformeAnticipos.ParamByName('EI').AsInteger := e1;
  FDQueryInformeAnticipos.ParamByName('EF').AsInteger := e2;
  FDQueryInformeAnticipos.ParamByName('FI').AsDateTime := StrToDate(FormatDateTime('dd/mm/yyyy', f1));
  FDQueryInformeAnticipos.ParamByName('FF').AsDateTime := StrToDate(FormatDateTime('dd/mm/yyyy', f2));
  FDQueryInformeAnticipos.Open();
end;

procedure TDataModuleTickets.ImprimeObservacionDia(e1: integer; e2: integer; f1: TDateTime; f2: TDateTime);
begin
  FDQueryInformeObservacion.Close;
  FDQueryInformeObservacion.ParamByName('EI').AsInteger := e1;
  FDQueryInformeObservacion.ParamByName('EF').AsInteger := e2;
  FDQueryInformeObservacion.ParamByName('FI').AsDateTime := StrToDate(FormatDateTime('dd/mm/yyyy', f1));
  FDQueryInformeObservacion.ParamByName('FF').AsDateTime := StrToDate(FormatDateTime('dd/mm/yyyy', f2));
  FDQueryInformeObservacion.Open();
end;


function TDataModuleTickets.UltimoDia(e: integer; f: TDate): TDate;
begin
  FDQueryUltimosTickets.Close;
  FDQueryUltimosTickets.ParamByName('F').AsDateTime := StrToDate(FormatDateTime('dd/mm/yyyy', f));
  FDQueryUltimosTickets.Open();

  if FDQueryUltimosTickets.Locate('empleados_id', e, [loCaseInsensitive]) = True then
  begin
    Result := FDQueryUltimosTickets.FieldByName('MF').AsDateTime;
  end else
    Result := IncDay(Date);
end;

procedure TDataModuleTickets.CambiaFechaSector(f: TDate; s: integer);
begin
  FDQueryTickets.First;
  while not FDQueryTickets.Eof do
  begin
    FDQueryTickets.Edit;
    FDQueryTickets.FieldByName('fecha').AsDateTime := StrToDate(FormatDateTime('dd/mm/yyyy', f));
    FDQueryTickets.FieldByName('sectores_id').AsInteger := s;
    FDQueryTickets.Post;
    FDQueryTickets.Next;
  end;
  FDQueryTickets.Refresh;
end;

function TDataModuleTickets.UltimoSector(e:integer): integer;
begin
  FDQueryUltimoSector.Close;
  FDQueryUltimoSector.ParamByName('E').AsInteger := MiNTicket.empleado_id;
  FDQueryUltimoSector.Open();
  FDQueryUltimoSector.Refresh;
  FDQueryUltimoSector.First;
  if not FDQueryUltimoSector.Eof then
    Result := FDQueryUltimoSector.FieldByName('US_id').AsInteger - 1
  else
    Result := -1;
end;

end.
