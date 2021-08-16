unit UFormGestionTicket;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, DBGridEhGrouping,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, GridsEh, DBAxisGridsEh, DBGridEh,
  Vcl.ComCtrls, Vcl.DBCtrls, Vcl.ToolWin, System.DateUtils, Data.DB, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.ImgList;

type
  TFormGestionTicket = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    DBGridEh1: TDBGridEh;
    DBGridEh2: TDBGridEh;
    DBGridEh3: TDBGridEh;
    ComboBox1: TComboBox;
    GroupBox3: TGroupBox;
    Label3: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    ScrollBox1: TScrollBox;
    DBText1: TDBText;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButtonLiquidar: TSpeedButton;
    SpeedButtonBorrarFactura: TSpeedButton;
    DBGridEh4: TDBGridEh;
    DBNavigator1: TDBNavigator;
    SpeedButton1: TSpeedButton;
    DateTimePicker1: TDateTimePicker;
    RadioGroup1: TRadioGroup;
    Label9: TLabel;
    Label10: TLabel;
    DBGridEh5: TDBGridEh;
    Label11: TLabel;
    DBMemo1: TDBMemo;
    DBNavigator2: TDBNavigator;
    SpeedButtonObservaciones: TSpeedButton;
    ButtonAnadirTalonarios: TButton;
    ImageList1: TImageList;
    SpeedButton4: TSpeedButton;
    Label7: TLabel;
    SpeedButton5: TSpeedButton;
    DateTimePicker2: TDateTimePicker;
    SpeedButtonModificar: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3Change(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButtonLiquidarClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure SpeedButtonBorrarFacturaClick(Sender: TObject);
    procedure SpeedButtonCerrarClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButtonObservacionesClick(Sender: TObject);
    procedure DateTimePicker1Change(Sender: TObject);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure DBGridEh2GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure DBRadioGroup1Change(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure DBGridEh3GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure DBGridEh5GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure ButtonAnadirTalonariosClick(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButtonModificarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Nuevo;
    procedure Editar;
    procedure Modifica;
    procedure Corregir;
  end;

var
  FormGestionTicket: TFormGestionTicket;

implementation

uses
  UDMTickets;

{$R *.dfm}

procedure TFormGestionTicket.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DataModuleTickets.FDQueryTicketsDelDia.Refresh;
end;

procedure TFormGestionTicket.FormCreate(Sender: TObject);
var
  ntipo: string;
  tipo: integer;
  nsector: string;
  sector: integer;
begin
  DataModuleTickets.FDQueryTipos.Open();
  (*
  DataModuleTickets.FDQueryTipos.First;
  while Not DataModuleTickets.FDQueryTipos.Eof do
  begin
    ntipo := DataModuleTickets.FDQueryTipos.FieldByName('nombre').AsString;
    tipo :=  DataModuleTickets.FDQueryTipos.FieldByName('id').AsInteger;
    ComboBox2.Items.AddObject(ntipo, TObject(tipo));
    DataModuleTickets.FDQueryTipos.Next;
  end;
  *)
  DataModuleTickets.FDQuerySectores.Open();
  DataModuleTickets.FDQuerySectores.First;
  while Not DataModuleTickets.FDQuerySectores.Eof do
  begin
    nsector :=  DataModuleTickets.FDQuerySectores.FieldByName('sector').AsString + ' - ' + DataModuleTickets.FDQuerySectores.FieldByName('playa').AsString;
    sector :=  DataModuleTickets.FDQuerySectores.FieldByName('id').AsInteger;
    ComboBox1.Items.AddObject(nsector, TObject(sector));
    DataModuleTickets.FDQuerySectores.Next;
  end;

end;

procedure TFormGestionTicket.Nuevo;
begin
  // Nuevo talonario

  Label1.Caption := DataModuleTickets.FDQueryEmpleadosSinTickets.FieldByName('id').AsString;
  Label3.Caption := DataModuleTickets.FDQueryEmpleadosSinTickets.FieldByName('nombre').AsString;
  Label2.Caption := 'SIN TALONARIOS PARA HOY';

  DataModuleTickets.MiNTicket.empleado_id := DataModuleTickets.FDQueryEmpleadosSinTickets.FieldByName('id').AsInteger;
  DataModuleTickets.MiNTicket.fecha := DataModuleTickets.ElDia;

  FormGestionTicket.Caption := 'NUEVA EMISION DE TALONARIOS DE ' + Label3.Caption;
  DateTimePicker1.Date := DataModuleTickets.MiNTicket.fecha;
  GroupBox1.Visible := False;
  GroupBox2.Top := 0;
  FormGestionTicket.Height := ScrollBox1.Top + GroupBox2.Height + 180;

  ComboBox1.ItemIndex := DataModuleTickets.UltimoSector(DataModuleTickets.MiNTicket.empleado_id);

  DataModuleTickets.Nuevo();
  DataModuleTickets.observaciones;
end;

procedure TFormGestionTicket.RadioGroup1Click(Sender: TObject);
begin
  (*
  Edit2.NumbersOnly := False;
  Edit2.Text := '';
  Edit2.NumbersOnly := True;
  Edit3.NumbersOnly := False;
  Edit3.Text := '';
  Edit3.NumbersOnly := True;
  *)

  Edit2.Clear;
  Edit3.Clear;

  DataModuleTickets.MiNTicket.tipos_id := RadioGroup1.ItemIndex + 1;
  DataModuleTickets.MiTicket.tipos_id := RadioGroup1.ItemIndex + 1;

  if RadioGroup1.ItemIndex = 0 then
  begin
    DataModuleTickets.FDQueryTipos.Locate('id', 1,[loCaseInsensitive]);
    Edit1.Text :=  DataModuleTickets.FDQueryTipos.FieldByName('letra').AsString;
  end;

  if RadioGroup1.ItemIndex = 1 then
  begin
    DataModuleTickets.FDQueryTipos.Locate('id', 2,[loCaseInsensitive]);
    Edit1.Text :=  DataModuleTickets.FDQueryTipos.FieldByName('letra').AsString;
  end;

  DataModuleTickets.FDQueryUltimosNumeros.Close();
  DataModuleTickets.FDQueryUltimosNumeros.Params.ParamByName('T').AsInteger := DataModuleTickets.MiNTicket.tipos_id;
  DataModuleTickets.FDQueryUltimosNumeros.Open();
end;

procedure TFormGestionTicket.SpeedButton1Click(Sender: TObject);
begin
  if MessageDlg('Borrar talonario', mtConfirmation, mbYesNo, 0) = mrYes then
    DataModuleTickets.FDQueryTickets.Delete;
end;

procedure TFormGestionTicket.SpeedButton2Click(Sender: TObject);
begin
  DataModuleTickets.LineUp();
end;

procedure TFormGestionTicket.SpeedButton3Click(Sender: TObject);
begin
  DataModuleTickets.LineDown();
end;

procedure TFormGestionTicket.SpeedButton4Click(Sender: TObject);
begin
  if DataModuleTickets.FDQueryTickets.Active = True then
    if DataModuleTickets.FDQueryTickets.State <> dsBrowse then
      DataModuleTickets.FDQueryTickets.Post;

  if DataModuleTickets.FDQueryTicketsFacturacion.Active = True then
    if DataModuleTickets.FDQueryTicketsFacturacion.State <> dsBrowse then
      DataModuleTickets.FDQueryTicketsFacturacion.Post;

  if DataModuleTickets.FDQueryAnticipos.Active = True then
    if DataModuleTickets.FDQueryAnticipos.State <> dsBrowse then
      DataModuleTickets.FDQueryAnticipos.Post;

  //FormGestionTicket.Close;
end;

procedure TFormGestionTicket.SpeedButton5Click(Sender: TObject);
begin
  FormGestionTicket.Close;
end;

procedure TFormGestionTicket.SpeedButtonBorrarFacturaClick(Sender: TObject);
begin
  if MessageDlg('Borrar talonario', mtConfirmation, mbYesNo, 0) = mrYes then
  begin
    DataModuleTickets.FDQueryTicketsFacturacion.Delete;
    DataModuleTickets.FDQuerySumaTickets.Refresh;
  end;
end;

procedure TFormGestionTicket.SpeedButtonCerrarClick(Sender: TObject);
begin
  FormGestionTicket.Close;
end;

procedure TFormGestionTicket.SpeedButtonLiquidarClick(Sender: TObject);
begin
  FormGestionTicket.Position := poMainFormCenter;
  //SpeedButtonLiquidar.Enabled := False;
  //SpeedButtonBorrarFactura.Enabled := False;
  //GroupBox1.Enabled := False;
  //GroupBox2.Top := 327;

  DataModuleTickets.MiNTicket.fecha := StrToDate(FormatDateTime('dd/mm/yyyy', DateTimePicker2.Date));
  GroupBox2.Top := GroupBox1.Height + 6;
  GroupBox2.Visible := True;

  FormGestionTicket.Height := ScrollBox1.Top + GroupBox1.Height + GroupBox2.Height;

  DataModuleTickets.Liquida();

  DateTimePicker1.Date := DateTimePicker2.Date;
end;

procedure TFormGestionTicket.SpeedButtonModificarClick(Sender: TObject);
begin
  (*
  FormCambiaFecha := TFormCambiaFecha.Create(Application);
  FormCambiaFecha.MonthCalendar1.Date := DateTimePicker1.Date;
  // FormCambiaFecha.ComboBox1.ItemIndex := LongInt(ComboBox1.Items.Objects[ComboBox1.ItemIndex]);
  FormCambiaFecha.ShowModal;
  FormCambiaFecha.FreeOnRelease;
  *)
end;

procedure TFormGestionTicket.SpeedButtonObservacionesClick(Sender: TObject);
begin
  (*
  FormObservaciones := TFormObservaciones.Create(Application);
  FormObservaciones.ShowModal;
  FormObservaciones.FreeOnRelease;
  *)
end;

procedure TFormGestionTicket.ButtonAnadirTalonariosClick(Sender: TObject);
begin
  if ComboBox1.ItemIndex = -1 then
  begin
    MessageDlg('FALTA SELECCIONAR SECTOR', mtError, [mbOK], 0);
    Exit;
  end;

  if RadioGroup1.ItemIndex = -1 then
  begin
    MessageDlg('FALTA SELECCIONAR ALQUILER', mtError, [mbOK], 0);
    Exit;
  end;

  if Edit1.Text = '' then
  begin
    MessageDlg('FALTA LETRA', mtError, [mbOK], 0);
    Exit;
  end;

  if Edit2.Text = '' then
  begin
    MessageDlg('FALTA INICIO DE NUMERACION', mtError, [mbOK], 0);
    Exit;
  end;

  if Edit3.Text = '' then
  begin
    MessageDlg('FALTA FINAL DE NUMERACION', mtError, [mbOK], 0);
    Exit;
  end;

  DataModuleTickets.MiTicket.tipos_id := RadioGroup1.ItemIndex + 1;
  DataModuleTickets.MiTicket.sectores_id := LongInt(ComboBox1.Items.Objects[ComboBox1.ItemIndex]);

  if RadioGroup1.ItemIndex = 0 then
    DataModuleTickets.MiTicket.letra := Edit1.Text;
  if RadioGroup1.ItemIndex = 1 then
    DataModuleTickets.MiTicket.letra := Edit1.Text;

  DataModuleTickets.MiTicket.desde := StrToInt(Edit2.Text);
  DataModuleTickets.MiTicket.hasta := StrToInt(Edit3.Text);

  if DataModuleTickets.CheckNumero = True then
  begin
    MessageDlg('ERROR DE NUMERACION', mtWarning, mbOKCancel, 0);
    Exit;
  end;

  DataModuleTickets.CreaTickets();

  DataModuleTickets.RefrescaTickets;
end;

procedure TFormGestionTicket.ComboBox1Change(Sender: TObject);
begin
  DataModuleTickets.MiTicket.sectores_id := LongInt(ComboBox1.Items.Objects[ComboBox1.ItemIndex]);
end;

procedure TFormGestionTicket.DateTimePicker1Change(Sender: TObject);
begin
  DataModuleTickets.MiNTicket.fecha := StrToDate(FormatDateTime('dd/mm/yyyy', DateTimePicker1.Date));
  DataModuleTickets.FDQueryTickets.Open();
  DataModuleTickets.FDQueryTickets.Params.ParamByName('E').AsInteger := DataModuleTickets.MiNTicket.empleado_id;
  DataModuleTickets.FDQueryTickets.Params.ParamByName('F').AsDateTime := StrToDate(FormatDateTime('dd/mm/yyyy', DateTimePicker1.Date));
  DataModuleTickets.FDQueryTickets.Refresh;
end;

procedure TFormGestionTicket.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  if DBGridEh1.DataSource.DataSet.FieldByName('tipos_id').AsInteger = 1 then
    AFont.Color := clBlack;
  if DBGridEh1.DataSource.DataSet.FieldByName('tipos_id').AsInteger = 2 then
    AFont.Color := clBlue;
end;

procedure TFormGestionTicket.DBGridEh2GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  if DBGridEh2.DataSource.DataSet.FieldByName('tipos_id').AsInteger = 1 then
    AFont.Color := clBlack;
  if DBGridEh2.DataSource.DataSet.FieldByName('tipos_id').AsInteger = 2 then
    AFont.Color := clBlue;
end;

procedure TFormGestionTicket.DBGridEh3GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  if DBGridEh3.DataSource.DataSet.FieldByName('tipos_id').AsInteger = 1 then
    AFont.Color := clBlack;
  if DBGridEh3.DataSource.DataSet.FieldByName('tipos_id').AsInteger = 2 then
    AFont.Color := clBlue;
end;

procedure TFormGestionTicket.DBGridEh5GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  if DBGridEh5.DataSource.DataSet.FieldByName('tipos_id').AsInteger = 1 then
    AFont.Color := clBlack;
  if DBGridEh5.DataSource.DataSet.FieldByName('tipos_id').AsInteger = 2 then
    AFont.Color := clBlue;
end;

procedure TFormGestionTicket.DBRadioGroup1Change(Sender: TObject);
var
  i: integer;
begin
  DataModuleTickets.FDQueryTickets.Open();
  i :=  RadioGroup1.ItemIndex;
  DataModuleTickets.FDQueryTipos.Locate('id', i,[loCaseInsensitive]);
  Edit1.Text :=  DataModuleTickets.FDQueryTipos.FieldByName('letra').AsString;

  DataModuleTickets.MiTicket.tipos_id := i;

  DataModuleTickets.FDQueryUltimosNumeros.Close();
  DataModuleTickets.FDQueryUltimosNumeros.Params.ParamByName('T').AsInteger := i;
  DataModuleTickets.FDQueryUltimosNumeros.Open();
end;

procedure TFormGestionTicket.Edit1Change(Sender: TObject);
begin
  DataModuleTickets.MiTicket.letra := Edit1.Text;
end;

procedure TFormGestionTicket.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key in ['A'..'Z', 'a'..'z', #46, #8] then
  else
    Key := #0;
end;

procedure TFormGestionTicket.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  if Key in [#8, '0' .. '9'] then
  else
    Key := #0;
end;

procedure TFormGestionTicket.Edit3Change(Sender: TObject);
begin
  if Edit3.Text = '' then
    Exit;

  if StrToInt(Edit3.Text) > 100000 then
    Edit3.Text := '100000';
end;

procedure TFormGestionTicket.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
  if Key in [#8, '0' .. '9'] then
  else
    Key := #0;
end;

procedure TFormGestionTicket.Editar;
begin
  // Operaciones de liquidacion

  DateTimePicker1.Date := IncDay (DataModuleTickets.FDQueryTicketsDelDia.FieldByName('fecha').AsDateTime);
  DateTimePicker2.Date := IncDay (DataModuleTickets.FDQueryTicketsDelDia.FieldByName('fecha').AsDateTime);

  Label1.Caption := DataModuleTickets.FDQueryTicketsDelDia.FieldByName('empleados_id').AsString;
  Label3.Caption := DataModuleTickets.FDQueryTicketsDelDia.FieldByName('nomempleado').AsString;
  Label2.Caption := DataModuleTickets.FDQueryTicketsDelDia.FieldByName('fecha').AsString;

  FormGestionTicket.Caption := 'LIQUIDACION DE ' + Label3.Caption + ' DE FECHA ' + Label2.Caption;

  DataModuleTickets.MiNTicket.empleado_id := DataModuleTickets.FDQueryTicketsDelDia.FieldByName('empleados_id').AsInteger;
  DataModuleTickets.MiNTicket.fecha := StrToDate(FormatDateTime('dd/mm/yyyy', DateTimePicker2.Date));

  GroupBox2.Visible := False;

  FormGestionTicket.Height := ScrollBox1.Top + GroupBox1.Height + 180;
  FormGestionTicket.Top := 0;

  ComboBox1.ItemIndex := DataModuleTickets.UltimoSector(DataModuleTickets.MiNTicket.empleado_id);

  DataModuleTickets.Edita();
  DataModuleTickets.observaciones;
end;

procedure TFormGestionTicket.Modifica;
begin
  // Modifica el ya liquidado

  FormGestionTicket.Height := ScrollBox1.Top + GroupBox1.Height + GroupBox2.Height;
  FormGestionTicket.Top := 0;

  Label1.Caption := DataModuleTickets.FDQueryTicketsDelDia.FieldByName('empleados_id').AsString;
  Label3.Caption := DataModuleTickets.FDQueryTicketsDelDia.FieldByName('nomempleado').AsString;
  Label2.Caption := DataModuleTickets.FDQueryTicketsDelDia.FieldByName('fecha').AsString;

  FormGestionTicket.Caption := 'LIQUIDACION DE ' + Label3.Caption + ' DE FECHA ' + Label2.Caption;

  DataModuleTickets.MiNTicket.empleado_id := DataModuleTickets.FDQueryTicketsDelDia.FieldByName('empleados_id').AsInteger;
  DateTimePicker1.Date := DataModuleTickets.UltimoDia(DataModuleTickets.MiNTicket.empleado_id, DataModuleTickets.FDQueryTicketsDelDia.FieldByName('fecha').AsDateTime);
  DateTimePicker2.Date := DateTimePicker1.Date;
  DataModuleTickets.MiNTicket.fecha := StrToDate(FormatDateTime('dd/mm/yyyy', DateTimePicker1.Date));

  //SpeedButtonLiquidar.Enabled := False;
  //SpeedButtonBorrarFactura.Enabled := False;
  //GroupBox1.Enabled := False;

  ComboBox1.ItemIndex := DataModuleTickets.UltimoSector(DataModuleTickets.MiNTicket.empleado_id);

  DataModuleTickets.Modifica();
  DataModuleTickets.observaciones;
end;

procedure TFormGestionTicket.Corregir;
begin
  // Corregir talonario sin liquidar

  Label1.Caption := DataModuleTickets.FDQueryTicketsDelDia.FieldByName('empleados_id').AsString;
  Label3.Caption := DataModuleTickets.FDQueryTicketsDelDia.FieldByName('nomempleado').AsString;
  Label2.Caption := DataModuleTickets.FDQueryTicketsDelDia.FieldByName('fecha').AsString;

  DataModuleTickets.MiNTicket.empleado_id := DataModuleTickets.FDQueryTicketsDelDia.FieldByName('empleados_id').AsInteger;
  DataModuleTickets.MiNTicket.fecha := StrToDate(FormatDateTime('dd/mm/yyyy', DataModuleTickets.FDQueryTicketsDelDia.FieldByName('fecha').AsDateTime));

  FormGestionTicket.Caption := 'MODIFICACION DE ' + Label3.Caption + ' DE FECHA ' + Label2.Caption;
  FormGestionTicket.Height := 540;
  DateTimePicker1.Date := DataModuleTickets.MiNTicket.fecha;
  GroupBox1.Visible := False;
  GroupBox2.Top := 0;

  FormGestionTicket.Height := ScrollBox1.Top + GroupBox2.Height + 180;
  FormGestionTicket.Top := 0;

  ComboBox1.ItemIndex := DataModuleTickets.UltimoSector(DataModuleTickets.MiNTicket.empleado_id);

  DataModuleTickets.Corrige();
  DataModuleTickets.observaciones;
end;

end.
