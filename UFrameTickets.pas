unit UFrameTickets;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, GridsEh,
  DBAxisGridsEh, DBGridEh, Vcl.Buttons, Vcl.DBCtrls, System.UITypes, Vcl.Menus,
  Vcl.ImgList, Vcl.ExtCtrls, Data.DB, EhLibVCL, System.ImageList;

type
  TFrameTickets = class(TFrame)
    DBGridEh1: TDBGridEh;
    DBGridEh2: TDBGridEh;
    sbUpTalonario: TSpeedButton;
    sbDownTalonario: TSpeedButton;
    sbUp: TSpeedButton;
    DBGridEh3: TDBGridEh;
    GroupBox1: TGroupBox;
    rbHamacas: TRadioButton;
    rbSombrillas: TRadioButton;
    eLetra: TEdit;
    Label1: TLabel;
    eDesde: TEdit;
    eHasta: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    bInsertarTickets: TButton;
    sbDown: TSpeedButton;
    DBText1: TDBText;
    Label4: TLabel;
    Label5: TLabel;
    pmBorrado: TPopupMenu;
    miBorrarTalonario: TMenuItem;
    miBorrarTodo: TMenuItem;
    Button1: TButton;
    ImageList1: TImageList;
    Label6: TLabel;
    DBNavigator1: TDBNavigator;
    Label7: TLabel;
    DBMemo1: TDBMemo;
    DBNavigator2: TDBNavigator;
    Label8: TLabel;
    DBText2: TDBText;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    lNombre: TLabel;
    sbMasTalonario: TSpeedButton;
    lFecha: TLabel;
    cbSectoresA: TComboBox;
    btLiquidar: TButton;
    sbMas: TSpeedButton;
    lID: TLabel;
    rbToldos: TRadioButton;
    rbPatGra: TRadioButton;
    rbPatPeq: TRadioButton;
    rbTicket6: TRadioButton;
    rbTicket3: TRadioButton;
    rbTicketOtro: TRadioButton;
    procedure eDesdeKeyPress(Sender: TObject; var Key: Char);
    procedure eHastaKeyPress(Sender: TObject; var Key: Char);
    procedure eLetraKeyPress(Sender: TObject; var Key: Char);
    procedure rbHamacasClick(Sender: TObject);
    procedure rbSombrillasClick(Sender: TObject);
    procedure bInsertarTicketsClick(Sender: TObject);
    procedure sbUpTalonarioClick(Sender: TObject);
    procedure sbDownTalonarioClick(Sender: TObject);
    procedure sbUpClick(Sender: TObject);
    procedure sbDownClick(Sender: TObject);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure cbSectoresACloseUp(Sender: TObject);
    procedure miBorrarTalonarioClick(Sender: TObject);
    procedure miBorrarTodoClick(Sender: TObject);
    procedure DBGridEh2GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure sbMasTalonarioClick(Sender: TObject);
    procedure sbAnadeTalonarioClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btLiquidarClick(Sender: TObject);
    procedure sbMasClick(Sender: TObject);
    procedure DBGridEh1KeyPress(Sender: TObject; var Key: Char);
    procedure rbToldosClick(Sender: TObject);
    procedure rbPatGraClick(Sender: TObject);
    procedure rbPatPeqClick(Sender: TObject);
    procedure rbTicket6Click(Sender: TObject);
    procedure rbTicket3Click(Sender: TObject);
    procedure rbTicketOtroClick(Sender: TObject);
  private
    { Private declarations }
      fOnCreate: TNotifyEvent;
      fOnDestroy: TNotifyEvent;
      procedure CargarSectores;
  public
    { Public declarations }
      constructor Create(AOwner:TComponent); override;
      destructor Destroy; override;
  published
    { Published declarations }
    property OnCreate : TNotifyEvent read fOnCreate write fOnCreate;
    property OnDestroy : TNotifyEvent read fOnCreate write fOnDestroy;
    procedure ActualizaSector();
    procedure ActualizaMas();
    procedure AumentaLetra();
    procedure ReduceLetra();
  end;

implementation

uses
  UDataModuleTalonarios, UFormNumeracion;

{$R *.dfm}

constructor TFrameTickets.Create(AOwner: TComponent);
begin
  inherited;
  if Assigned(fOnCreate) then
    fOnCreate(self);
  // codigo
  DataModuleTalonarios.AbreDatosBasicos;
  CargarSectores;
  eLetra.Text := DataModuleTalonarios.Letra(1);
  DataModuleTalonarios.talonario.tipos_id := 1;
  (*
  DBGridEh1.Width := ScrollBox1.Width + 170;
  DBGridEh2.Width := ScrollBox1.Width - 60;
  DBMemo1.Width := ScrollBox1.Width + 170;
  *)
end;

destructor TFrameTickets.Destroy;
begin
  // codigo
  if Assigned(fOnDestroy) then
    fOnDestroy(self);
  inherited;
end;

procedure TFrameTickets.eDesdeKeyPress(Sender: TObject; var Key: Char);
begin
  if CharInSet(Key, [#8, '0' .. '9']) then
  else
    Key := #0;
end;

procedure TFrameTickets.eHastaKeyPress(Sender: TObject; var Key: Char);
begin
  if CharInSet(Key, [#8, '0' .. '9']) then
  else
    Key := #0;
end;

procedure TFrameTickets.eLetraKeyPress(Sender: TObject; var Key: Char);
begin
   if CharInSet(Key, ['A'..'Z', 'a'..'z', #46, #8]) then
  else
    Key := #0;
end;

procedure TFrameTickets.rbHamacasClick(Sender: TObject);
begin
  eLetra.Text := DataModuleTalonarios.Letra(1);
  DataModuleTalonarios.talonario.tipos_id := 1;
  DataModuleTalonarios.ticket.precio := DataModuleTalonarios.Precio(1);
  eDesde.Clear;
  eHasta.Clear;
end;

procedure TFrameTickets.rbPatGraClick(Sender: TObject);
begin
  eLetra.Text := DataModuleTalonarios.Letra(4);
  DataModuleTalonarios.talonario.tipos_id := 4;
  DataModuleTalonarios.ticket.precio := DataModuleTalonarios.Precio(4);
  eDesde.Clear;
  eHasta.Clear;
end;

procedure TFrameTickets.rbPatPeqClick(Sender: TObject);
begin
  eLetra.Text := DataModuleTalonarios.Letra(5);
  DataModuleTalonarios.talonario.tipos_id := 5;
  DataModuleTalonarios.ticket.precio := DataModuleTalonarios.Precio(5);
  eDesde.Clear;
  eHasta.Clear;
end;

procedure TFrameTickets.rbSombrillasClick(Sender: TObject);
begin
  eLetra.Text := DataModuleTalonarios.Letra(2);
  DataModuleTalonarios.talonario.tipos_id := 2;
  DataModuleTalonarios.ticket.precio := DataModuleTalonarios.Precio(2);
  eDesde.Clear;
  eHasta.Clear;
end;

procedure TFrameTickets.rbTicket3Click(Sender: TObject);
begin
 eLetra.Text := DataModuleTalonarios.Letra(7);
  DataModuleTalonarios.talonario.tipos_id := 7;
  DataModuleTalonarios.ticket.precio := DataModuleTalonarios.Precio(7);
  eDesde.Clear;
  eHasta.Clear;
end;

procedure TFrameTickets.rbTicket6Click(Sender: TObject);
begin
  eLetra.Text := DataModuleTalonarios.Letra(6);
  DataModuleTalonarios.talonario.tipos_id := 6;
  DataModuleTalonarios.ticket.precio := DataModuleTalonarios.Precio(6);
  eDesde.Clear;
  eHasta.Clear;
end;

procedure TFrameTickets.rbTicketOtroClick(Sender: TObject);
begin
  eLetra.Text := DataModuleTalonarios.Letra(8);
  DataModuleTalonarios.talonario.tipos_id := 8;
  DataModuleTalonarios.ticket.precio := DataModuleTalonarios.Precio(8);
  eDesde.Clear;
  eHasta.Clear;
end;

procedure TFrameTickets.rbToldosClick(Sender: TObject);
begin
  eLetra.Text := DataModuleTalonarios.Letra(3);
  DataModuleTalonarios.talonario.tipos_id := 3;
  DataModuleTalonarios.ticket.precio := DataModuleTalonarios.Precio(3);
  eDesde.Clear;
  eHasta.Clear;
end;

procedure TFrameTickets.bInsertarTicketsClick(Sender: TObject);
var
  dd1: integer;
  hh1: integer;
  ddd: integer;
  hhh: integer;
begin
  if eLetra.Text = '' then
  begin
    MessageDlg('FALTA LETRA', mtError, [mbOK], 0);
    Exit;
  end;

  if eDesde.Text = '' then
  begin
    MessageDlg('FALTA INICIO DE NUMERACION', mtError, [mbOK], 0);
    Exit;
  end;

  if eHasta.Text = '' then
  begin
    MessageDlg('FALTA FINAL DE NUMERACION', mtError, [mbOK], 0);
    Exit;
  end;

  ddd := StrToInt(eDesde.Text);
  hhh := StrToInt(eHasta.Text);

  if ddd >= hhh then
  begin
    if MessageDlg('Numeracion inicial mayor que la final, continuar', mtConfirmation, mbYesNo, 0) = mrNo then
      Exit;
  end;

  dd1 := ddd div 100;
  hh1 := hhh div 100;

  if (hh1 - dd1) > 10 then
  begin
    MessageDlg('MAS DE 10 TALONARIOS', mtError, [mbOK], 0);
    Exit;
  end;

  if cbSectoresA.ItemIndex = -1 then
  begin
    MessageDlg('FALTA SELECCIONAR SECTOR', mtError, [mbOK], 0);
    Exit;
  end;

  DataModuleTalonarios.talonario.sectores_id := LongInt(cbSectoresA.Items.Objects[cbSectoresA.ItemIndex]);
  with DataModuleTalonarios do
  begin
    ticket.empleados_id := talonario.empleados_id;
    ticket.sectores_id := talonario.sectores_id;
    ticket.tipos_id := talonario.tipos_id;
    ticket.letra := eLetra.Text;
    ticket.desde := StrToInt(eDesde.Text);
    ticket.hasta := StrToInt(eHasta.Text);

    ticket.precio := Precio(talonario.tipos_id);
  end;



  if DataModuleTalonarios.CheckNumeracion = True then
  begin
    if MessageDlg('ERROR DE NUMERACION, CONTINUAR ?', mtWarning, mbYesNo, 0) = mrNo then
      Exit;
  end;

  DataModuleTalonarios.CreaTalonario;
end;

procedure TFrameTickets.sbUpTalonarioClick(Sender: TObject);
begin
  DataModuleTalonarios.UpTalonario;
  cbSectoresA.ItemIndex := DataModuleTalonarios.base.sectores_id - 1;
end;

procedure TFrameTickets.sbDownTalonarioClick(Sender: TObject);
begin
  DataModuleTalonarios.DownTalonario;
  cbSectoresA.ItemIndex := DataModuleTalonarios.base.sectores_id - 1;
end;

procedure TFrameTickets.CargarSectores;
var
  nsector: string;
  sector: integer;
begin
  DataModuleTalonarios.fdqSectores.First;
  while Not DataModuleTalonarios.fdqSectores.Eof do
  begin
    nsector :=  DataModuleTalonarios.fdqSectores.FieldByName('sector').AsString; // + ' - ' + DataModuleTalonarios.fdqSectores.FieldByName('playa').AsString;
    sector :=  DataModuleTalonarios.fdqSectores.FieldByName('id').AsInteger;
    cbSectoresA.Items.AddObject(nsector, TObject(sector));
    DataModuleTalonarios.fdqSectores.Next;
  end;

  (*
  DataModuleTalonarios.fdqSectores.First;
  while Not DataModuleTalonarios.fdqSectores.Eof do
  begin
    nsector :=  DataModuleTalonarios.fdqSectores.FieldByName('sector').AsString + ' - ' + DataModuleTalonarios.fdqSectores.FieldByName('playa').AsString;
    sector :=  DataModuleTalonarios.fdqSectores.FieldByName('id').AsInteger;
    ssector := IntToStr(DataModuleTalonarios.fdqSectores.FieldByName('id').AsInteger);
    rxcbSectores.AddItemValue(nsector, ssector);
    DataModuleTalonarios.fdqSectores.Next;
  end;
  *)
end;

procedure TFrameTickets.sbUpClick(Sender: TObject);
begin
  DataModuleTalonarios.LineUp;
end;

procedure TFrameTickets.sbDownClick(Sender: TObject);
begin
  DataModuleTalonarios.LineDown;
end;

procedure TFrameTickets.ActualizaSector;
begin
  lNombre.Caption := DataModuleTalonarios.base.nombre;
  lID.Caption := IntToStr(DataModuleTalonarios.base.empleados_id);

  if DataModuleTalonarios.base.facturado = False then
  begin
    lFecha.Caption := 'ENTREGADOS';
  end else
  begin
    lFecha.Caption := DateToStr(DataModuleTalonarios.base.fecha_ant);
  end;

  cbSectoresA.ItemIndex := DataModuleTalonarios.base.sectores_id - 1;
  if DataModuleTalonarios.base.facturado = True then
  begin
    DBGridEh1.Color := $00D7D7D7;
    //DBGridEh2.Color := $00D7D7D7;
    Label8.Caption := 'YA LIQUIDADO';

    //DBGridEh1.Columns[3].Color := clRed;
    DBGridEh1.Columns[4].Color := clWhite;
  end else
  begin
    DBGridEh1.Color := clWindow;
    //DBGridEh2.Color := clWindow;
    DBGridEh1.Columns[4].Color := clYellow;
    Label8.Caption := '';
  end;

  if DataModuleTalonarios.base.ultimo = False then
  //if DataModuleTalonarios.base.facturado = True then
  begin
    btLiquidar.Caption := 'YA LIQUIDADO';
    btLiquidar.Font.Style := [fsBold, fsUnderline];
    btLiquidar.ImageIndex := 1;
  end else
  begin
    btLiquidar.Caption := 'LIQUIDAR';
        btLiquidar.Font.Style := [];
    btLiquidar.ImageIndex := 2;
  end;

  rbTicket6.Checked := True;

  eDesde.Clear;
  eHasta.Clear;
end;

procedure TFrameTickets.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  if DBGridEh1.DataSource.DataSet.FieldByName('tipos_id').AsInteger = 1 then
    AFont.Color := clBlack;
  if DBGridEh1.DataSource.DataSet.FieldByName('tipos_id').AsInteger = 2 then
    AFont.Color := clBlue;
  if DBGridEh1.DataSource.DataSet.FieldByName('tipos_id').AsInteger = 3 then
    AFont.Color := clPurple;
  if DBGridEh1.DataSource.DataSet.FieldByName('tipos_id').AsInteger = 6 then
    AFont.Color := clGreen;
  if DBGridEh1.DataSource.DataSet.FieldByName('tipos_id').AsInteger = 7 then
    AFont.Color := clMaroon;
end;

procedure TFrameTickets.DBGridEh1KeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    if DBGridEh1.DataSource.DataSet.State <> dsBrowse then
    begin
      DBGridEh1.DataSource.DataSet.Post;
      DBGridEh1.DataSource.DataSet.Next;
    end;
  end;
end;

procedure TFrameTickets.cbSectoresACloseUp(Sender: TObject);
begin
  if cbSectoresA.ItemIndex = -1 then
    Exit;

  DataModuleTalonarios.talonario.sectores_id := LongInt(cbSectoresA.Items.Objects[cbSectoresA.ItemIndex]);
  DataModuleTalonarios.ActualizaSector;
end;

procedure TFrameTickets.miBorrarTalonarioClick(Sender: TObject);
begin
  if MessageDlg('Borrar talonario', mtConfirmation, mbYesNo, 0) = mrYes then
  begin
    DataModuleTalonarios.BorrarTalonario;
  end;
end;

procedure TFrameTickets.miBorrarTodoClick(Sender: TObject);
begin
  if MessageDlg('Borrar TODOS los talonario', mtConfirmation, mbYesNo, 0) = mrYes then
  begin
    DataModuleTalonarios.BorrarTodo;
  end;
end;

procedure TFrameTickets.DBGridEh2GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  if DBGridEh2.DataSource.DataSet.FieldByName('tipos_id').AsInteger = 1 then
    AFont.Color := clBlack;
  if DBGridEh2.DataSource.DataSet.FieldByName('tipos_id').AsInteger = 2 then
    AFont.Color := clBlue;
  if DBGridEh2.DataSource.DataSet.FieldByName('tipos_id').AsInteger = 3 then
    AFont.Color := clPurple;
  if DBGridEh2.DataSource.DataSet.FieldByName('tipos_id').AsInteger = 6 then
    AFont.Color := clGreen;
  if DBGridEh2.DataSource.DataSet.FieldByName('tipos_id').AsInteger = 7 then
    AFont.Color := clMaroon;
end;

procedure TFrameTickets.DBGridEh1DblClick(Sender: TObject);
begin
  if DataModuleTalonarios.fdqTickets.IsEmpty then
  begin
    Exit;
  end;

  //if DataModuleTalonarios.fdqTickets.FieldByName('facturado').AsBoolean = True then
  //begin
    //Exit;
  //end;

  FormNumeracion := TFormNumeracion.Create(Application);
  FormNumeracion.ShowModal;
  FormNumeracion.FreeOnRelease;
end;

procedure TFrameTickets.sbMasTalonarioClick(Sender: TObject);
begin
  DataModuleTalonarios.MasTalonario;
end;

procedure TFrameTickets.sbAnadeTalonarioClick(Sender: TObject);
var
  dd1: integer;
  hh1: integer;
  ddd: integer;
  hhh: integer;
begin
  if MessageDlg('Añadir talonario a cobrador ya facturado?', mtConfirmation, mbYesNo, 0) = mrNo then
  begin
    Exit;
  end;
  if eLetra.Text = '' then
  begin
    MessageDlg('FALTA LETRA', mtError, [mbOK], 0);
    Exit;
  end;

  if eDesde.Text = '' then
  begin
    MessageDlg('FALTA INICIO DE NUMERACION', mtError, [mbOK], 0);
    Exit;
  end;

  if eHasta.Text = '' then
  begin
    MessageDlg('FALTA FINAL DE NUMERACION', mtError, [mbOK], 0);
    Exit;
  end;

  ddd := StrToInt(eDesde.Text);
  hhh := StrToInt(eHasta.Text);

  if ddd >= hhh then
  begin
    if MessageDlg('Numeracion inicial mayor que la final, continuar', mtConfirmation, mbYesNo, 0) = mrNo then
      Exit;
  end;

  dd1 := ddd div 100;
  hh1 := hhh div 100;

  if (hh1 - dd1) > 10 then
  begin
    MessageDlg('MAS DE 10 TALONARIOS', mtError, [mbOK], 0);
    Exit;
  end;

  if cbSectoresA.ItemIndex = -1 then
  begin
    MessageDlg('FALTA SELECCIONAR SECTOR', mtError, [mbOK], 0);
    Exit;
  end;

  DataModuleTalonarios.talonario.sectores_id := LongInt(cbSectoresA.Items.Objects[cbSectoresA.ItemIndex]);
  with DataModuleTalonarios do
  begin
    ticket.empleados_id := talonario.empleados_id;
    ticket.sectores_id := talonario.sectores_id;
    ticket.tipos_id := talonario.tipos_id;
    ticket.letra := eLetra.Text;
    ticket.desde := StrToInt(eDesde.Text);
    ticket.hasta := StrToInt(eHasta.Text);
  end;

  if DataModuleTalonarios.CheckNumeracion = True then
  begin
    MessageDlg('ERROR DE NUMERACION', mtWarning, mbOKCancel, 0);
    Exit;
  end;

  DataModuleTalonarios.AnadeTalonario;

  MessageDlg('Modifica facturacion y vuelve a grabar', mtInformation, [mbOk], 0);
end;

procedure TFrameTickets.Button1Click(Sender: TObject);
var
  pnt: TPoint;
begin
  if GetCursorPos(pnt) then
    pmBorrado.Popup(pnt.X, pnt.Y);

end;

procedure TFrameTickets.btLiquidarClick(Sender: TObject);
begin
  // if DataModuleTalonarios.base.facturado = True then
  if DataModuleTalonarios.base.ultimo = False then
  begin
    MessageDlg('TALONARIO YA LIQUIDADO', mtError, [mbOK], 0);
    Exit;
  end;


  if cbSectoresA.ItemIndex = -1 then
  begin
    MessageDlg('FALTA SELECCIONAR SECTOR', mtError, [mbOK], 0);
    Exit;
  end;

  DataModuleTalonarios.ticket.fecha := DataModuleTalonarios.base.fecha;
  DataModuleTalonarios.ticket.sectores_id := LongInt(cbSectoresA.Items.Objects[cbSectoresA.ItemIndex]);
  DataModuleTalonarios.Liquidacion;

  MessageDlg('LIQUIDACION REALIZADA', mtInformation, [mbOk], 0);

  btLiquidar.Caption := 'YA LIQUIDADO';
  btLiquidar.Font.Style := [fsBold, fsUnderline];
  btLiquidar.ImageIndex := 1;
end;

procedure TFrameTickets.sbMasClick(Sender: TObject);
begin
  if sbMas.Down = True then
  begin
    DataModuleTalonarios.base.todo := True;
    DataModuleTalonarios.Refresca();
  end else
  begin
    DataModuleTalonarios.base.todo := False;
    DataModuleTalonarios.Refresca();
  end;
end;

procedure TFrameTickets.ActualizaMas;
begin
  ActualizaSector;
  sbMas.Down := False;
  DataModuleTalonarios.base.todo := False;
end;

procedure TFrameTickets.AumentaLetra;
var
  i: integer;
begin
  i := DBGridEh1.Font.Size;
  Inc(i);
  DBGridEh1.Font.Size := i;
  DBGridEh1.Columns[6].Font.Size := i;

end;

procedure TFrameTickets.ReduceLetra;
var
  i: integer;
begin
  i := DBGridEh1.Font.Size;
  Dec(i);
  DBGridEh1.Font.Size := i;
  DBGridEh1.Columns[6].Font.Size := i;

end;

Initialization
  RegisterClass(TFrameTickets);

end.
