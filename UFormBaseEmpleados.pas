unit UFormBaseEmpleados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.DBCtrls,
  DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, GridsEh,
  DBAxisGridsEh, DBGridEh, Vcl.StdCtrls;

type
  TFormBaseEmpleados = class(TForm)
    DBNavigator1: TDBNavigator;
    DBGridEh1: TDBGridEh;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormBaseEmpleados: TFormBaseEmpleados;

implementation

uses
  UDataModuleTalonarios;


{$R *.dfm}

procedure TFormBaseEmpleados.Button1Click(Sender: TObject);
begin
  FormBaseEmpleados.Close;
end;

end.
