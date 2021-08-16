unit UFormBaseTipo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.DBCtrls,
  DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, Vcl.StdCtrls,
  GridsEh, DBAxisGridsEh, DBGridEh;

type
  TFormBaseTipos = class(TForm)
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
  FormBaseTipos: TFormBaseTipos;

implementation

uses
  UDataModuleTalonarios;

{$R *.dfm}

procedure TFormBaseTipos.Button1Click(Sender: TObject);
begin
  FormBaseTipos.Close;
end;

end.
