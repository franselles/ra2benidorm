unit UFormAboutBox;

interface

uses WinApi.Windows, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Forms, Vcl.Controls, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Winapi.ShellAPI;

type
  TFormAboutBox = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    OKButton: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure Label2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAboutBox: TFormAboutBox;

implementation

{$R *.dfm}

procedure TFormAboutBox.Label2Click(Sender: TObject);
var
  MyLink: string;
begin
  MyLink := 'mailto:fran.selles@gmail.com';
  ShellExecute(Application.Handle, PChar('open'), PChar(MyLink),
   nil, nil, SW_SHOW);
end;

procedure TFormAboutBox.Label3Click(Sender: TObject);
var
  MyLink: string;
begin
  MyLink := 'mailto:tcodecreate@gmail.com';
  ShellExecute(Application.Handle, PChar('open'), PChar(MyLink),
   nil, nil, SW_SHOW);

end;

end.
 
