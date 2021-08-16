unit UDMPrincipal;

interface

uses
  System.SysUtils, System.Classes,

  FireDAC.Comp.Client,

  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSAcc,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Data.DB, Vcl.Forms, FireDAC.Phys.MSAccDef;

type
  TDataModulePrincipal = class(TDataModule)
    FDConnection1: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysMSAccessDriverLink1: TFDPhysMSAccessDriverLink;procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    basedatos: string;
    nombasedatos: string;
  end;

var
  DataModulePrincipal: TDataModulePrincipal;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDataModulePrincipal.DataModuleCreate(Sender: TObject);
var
  ConfgProm: TextFile;
  Scfg: string;
begin
{ Leemos fichero de configuración de la promotora }
  AssignFile(ConfgProm,'.\ra_ba.ini');
  Reset(ConfgProm);

  { Configuramos ruta de acceso a la base de datos }
    while Not eof(ConfgProm) do
      begin
        Readln(ConfgProm, Scfg);
      end;
      CloseFile(ConfgProm);
  basedatos := Scfg;
  nombasedatos := ExtractFileName(basedatos);
  FDConnection1.Close;
  FDConnection1.Params.Clear;
  FDConnection1.Params.Add('Database=' + Scfg);
  FDConnection1.Params.Add('User_Name=admin');
  FDConnection1.Params.Add('DriverID=MSAcc');
  FDConnection1.Open;
end;

procedure TDataModulePrincipal.DataModuleDestroy(Sender: TObject);
begin
  FDConnection1.Close;
end;

end.
