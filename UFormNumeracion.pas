unit UFormNumeracion;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormNumeracion = class(TForm)
    Label1: TLabel;
    eDesde: TEdit;
    Label2: TLabel;
    eHasta: TEdit;
    Label3: TLabel;
    eLetra: TEdit;
    Button1: TButton;
    Button2: TButton;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    ePrecio: TEdit;
    procedure eLetraKeyPress(Sender: TObject; var Key: Char);
    procedure eDesdeKeyPress(Sender: TObject; var Key: Char);
    procedure eHastaKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ePrecioKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    letra: string;
    desde: integer;
    hasta: integer;
    precio: Currency;
  public
    { Public declarations }
  end;

var
  FormNumeracion: TFormNumeracion;

implementation

uses
  UDataModuleTalonarios;

{$R *.dfm}

procedure TFormNumeracion.eLetraKeyPress(Sender: TObject; var Key: Char);
begin
   if CharInSet(Key, ['A'..'Z', 'a'..'z', #46, #8]) then
  else
    Key := #0;
end;

procedure TFormNumeracion.ePrecioKeyPress(Sender: TObject; var Key: Char);
begin
  if CharInSet(Key, [',', #8, '0' .. '9']) then
  else
    Key := #0;
end;

procedure TFormNumeracion.eDesdeKeyPress(Sender: TObject; var Key: Char);
begin
  if CharInSet(Key, [#8, '0' .. '9']) then
  else
    Key := #0;
end;

procedure TFormNumeracion.eHastaKeyPress(Sender: TObject; var Key: Char);
begin
  if CharInSet(Key, [#8, '0' .. '9']) then
  else
    Key := #0;
end;

procedure TFormNumeracion.FormCreate(Sender: TObject);
begin
  letra := DataModuleTalonarios.fdqTickets.FieldByName('letra').AsString;
  desde := DataModuleTalonarios.fdqTickets.FieldByName('desde').AsInteger;
  hasta := DataModuleTalonarios.fdqTickets.FieldByName('hasta').AsInteger;
  precio := DataModuleTalonarios.fdqTickets.FieldByName('precio').AsCurrency;

  //FormNumeracion.Caption := 'Letra: ' + letra + ', Desde: ' + IntToStr(desde) + ', Hasta: ' + IntToStr(hasta);

  eLetra.Text := letra;
  eDesde.Text := IntToStr(desde);
  eHasta.Text := IntToStr(hasta);
  ePrecio.Text := FloatToStr(precio);

  Label4.Caption := eLetra.Text;
  label5.Caption := eDesde.Text;
  label6.Caption := eHasta.Text;
end;

procedure TFormNumeracion.Button2Click(Sender: TObject);
begin
  //a := StrToInt(eDesde.Text);
  //mind := (a div 100) + 100;

  DataModuleTalonarios.fdqTickets.Edit;
  DataModuleTalonarios.fdqTickets.FieldByName('letra').AsString := eLetra.Text;
  DataModuleTalonarios.fdqTickets.FieldByName('desde').AsInteger := StrToInt(eDesde.Text);
  DataModuleTalonarios.fdqTickets.FieldByName('hasta').AsInteger := StrToInt(eHasta.Text);
  DataModuleTalonarios.fdqTickets.FieldByName('real').AsInteger := StrToInt(eHasta.Text);
 DataModuleTalonarios.fdqTickets.FieldByName('precio').AsCurrency := StrToFloat(ePrecio.Text);
  DataModuleTalonarios.fdqTickets.Post;

  ModalResult := mrOk;
  FormNumeracion.CloseModal;
end;

procedure TFormNumeracion.Button1Click(Sender: TObject);
begin
  ModalResult := mrCancel;
  FormNumeracion.CloseModal;
end;

end.
