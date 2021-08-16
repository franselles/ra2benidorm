unit UFormBaseSectores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.DBCtrls,
  DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, GridsEh,
  DBAxisGridsEh, DBGridEh, Vcl.StdCtrls;

type
  TFormBaseSectores = class(TForm)
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
  FormBaseSectores: TFormBaseSectores;

implementation

uses
  UDataModuleTalonarios;

{$R *.dfm}

procedure TFormBaseSectores.Button1Click(Sender: TObject);
begin
  FormBaseSectores.Close;
end;

end.
