unit UFormEliminaDatos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.ImgList, System.DateUtils, System.UITypes;

type
  TFormEliminaDatos = class(TForm)
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    DBGrid1: TDBGrid;
    MonthCalendar1: TMonthCalendar;
    RadioGroup1: TRadioGroup;
    Button1: TButton;
    ImageList1: TImageList;
    Button2: TButton;
    mOrden: TMemo;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormEliminaDatos: TFormEliminaDatos;

implementation

uses
  UDataModuleTalonarios;

{$R *.dfm}

procedure TFormEliminaDatos.Button1Click(Sender: TObject);
var
  e1: integer;
  e2: integer;
  f1: TDateTime;
  f2: TDateTime;
  m: word;
  y: word;
begin
  f1 := Date();
  f2 := Date();

  if RadioButton1.Checked = True then
  begin
    e1 := 0;
    e2 := 9999;
  end else
  begin
    e1 := DataModuleTalonarios.fdqCobradores.FieldByName('id').AsInteger;
    e2 := DataModuleTalonarios.fdqCobradores.FieldByName('id').AsInteger;
  end;

  if RadioGroup1.ItemIndex = 0 then
  begin
    f1 := MonthCalendar1.Date;
    f2 := MonthCalendar1.Date;
  end;

  if RadioGroup1.ItemIndex = 1 then
  begin
    y := YearOf(MonthCalendar1.Date);
    m := MonthOfTheYear(MonthCalendar1.Date);
    f1 := EncodeDate(y, m , 1);
    f2 := EndOfAMonth(y, m)
  end;

  if RadioGroup1.ItemIndex = 2 then
  begin
    y := YearOf(MonthCalendar1.Date);
    f1 := EncodeDate(y, 1 , 1);
    f2 := EncodeDate(y, 12, 31)
  end;

  if MessageDlg('SEGURO QUE QUIERE BORRAR', mtConfirmation, mbYesNo, 0) = mrNo then
    Exit;

  DataModuleTalonarios.BorraAnticipoDia(e1, e2, f1, f2);

  MessageDlg('DATOS BORRADOS', mtInformation, [mbOk], 0);
end;

procedure TFormEliminaDatos.Button2Click(Sender: TObject);
begin
  FormEliminaDatos.Close;
end;

procedure TFormEliminaDatos.FormCreate(Sender: TObject);
begin
  MonthCalendar1.Date := Date;
end;

procedure TFormEliminaDatos.RadioButton1Click(Sender: TObject);
begin
  if RadioButton1.Checked = True then
  begin
    mOrden.Lines.Clear;
    case RadioGroup1.ItemIndex of
      0: mOrden.Lines.Add('BORRA ANTICIPOS DE TODOS LOS COBRADORES UN DIA DETERMINADO');
      1: mOrden.Lines.Add('BORRA ANTICIPOS DE TODOS LOS COBRADORES UN MES DETERMINADO');
      2: mOrden.Lines.Add('BORRA ANTICIPOS DE TODOS LOS COBRADORES UN AÑO DETERMINADO');
    end;
  end;
end;

procedure TFormEliminaDatos.RadioButton2Click(Sender: TObject);
begin
  if RadioButton2.Checked = True then
  begin
    mOrden.Lines.Clear;
    case RadioGroup1.ItemIndex of
      0: mOrden.Lines.Add('BORRA ANTICIPOS DE UN COBRADOR DETERMINADO UN DIA DETERMINADO');
      1: mOrden.Lines.Add('BORRA ANTICIPOS DE UN COBRADOR DETERMINADO UN MES DETERMINADO');
      2: mOrden.Lines.Add('BORRA ANTICIPOS DE UN COBRADOR DETERMINADO UN AÑO DETERMINADO');
    end;
  end;
end;

procedure TFormEliminaDatos.RadioGroup1Click(Sender: TObject);
begin
  mOrden.Lines.Clear;

  if RadioGroup1.ItemIndex = 0 then
  begin
    if RadioButton1.Checked = True then
    begin
      mOrden.Lines.Add('BORRA ANTICIPOS DE TODOS LOS COBRADORES UN DIA DETERMINADO');
    end else
    begin
      mOrden.Lines.Add('BORRA ANTICIPOS DE UN COBRADOR DETERMINADO UN DIA DETERMINADO');
    end;
  end;

  if RadioGroup1.ItemIndex = 1 then
  begin
    if RadioButton1.Checked = True then
    begin
      mOrden.Lines.Add('BORRA ANTICIPOS DE TODOS LOS COBRADORES UN MES DETERMINADO');
    end else
    begin
      mOrden.Lines.Add('BORRA ANTICIPOS DE UN COBRADOR DETERMINADO UN MES DETERMINADO');
    end;
  end;

  if RadioGroup1.ItemIndex = 2 then
  begin
    if RadioButton1.Checked = True then
    begin
      mOrden.Lines.Add('BORRA ANTICIPOS DE TODOS LOS COBRADORES UN AÑO DETERMINADO');
    end else
    begin
      mOrden.Lines.Add('BORRA ANTICIPOS DE UN COBRADOR DETERMINADO UN AÑO DETERMINADO');
    end;
  end;
end;

end.
