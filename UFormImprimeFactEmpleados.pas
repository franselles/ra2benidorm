unit UFormImprimeFactEmpleados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.ImgList, frxClass, frxDBSet, System.DateUtils,
  frxExportCSV, Data.DB, frxExportBaseDialog, System.ImageList;

type
  TFormImprimeFactEmpleados = class(TForm)
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    DBGrid1: TDBGrid;
    MonthCalendar1: TMonthCalendar;
    RadioGroup1: TRadioGroup;
    Button1: TButton;
    ImageList1: TImageList;
    Button2: TButton;
    frxReportEmp: TfrxReport;
    frxDBDatasetEmp: TfrxDBDataset;
    frxCSVExport1: TfrxCSVExport;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormImprimeFactEmpleados: TFormImprimeFactEmpleados;

implementation

uses
  UDataModuleTalonarios;

{$R *.dfm}

procedure TFormImprimeFactEmpleados.Button1Click(Sender: TObject);
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

  DataModuleTalonarios.ImprimeEmpleadoDia(e1, e2, f1, f2);

  if frxReportEmp.LoadFromFile('.\reporte_empleado.fr3') then
    if frxReportEmp.PrepareReport(True) then
        frxReportEmp.ShowPreparedReport;
end;

procedure TFormImprimeFactEmpleados.Button2Click(Sender: TObject);
begin
  FormImprimeFactEmpleados.Close;
end;

procedure TFormImprimeFactEmpleados.FormCreate(Sender: TObject);
begin
  MonthCalendar1.Date := Date;
end;

end.
