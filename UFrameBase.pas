unit UFrameBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TFrameBase = class(TFrame)
  private
    { Private declarations }
      fOnCreate: TNotifyEvent;
      fOnDestroy: TNotifyEvent;
  public
    { Public declarations }
      constructor Create(AOwner:TComponent); override;
      destructor Destroy; override;
  published
    { Published declarations }
    property OnCreate : TNotifyEvent read fOnCreate write fOnCreate;
    property OnDestroy : TNotifyEvent read fOnCreate write fOnDestroy;
  end;

implementation

{$R *.dfm}

constructor TFrameBase.Create(AOwner: TComponent);
begin
  inherited;
  if Assigned(fOnCreate) then
    fOnCreate(self);
  // codigo
end;

destructor TFrameBase.Destroy;
begin
  if Assigned(fOnDestroy) then
    fOnDestroy(self);
  inherited;
end;

initialization
  RegisterClass(TFrameBase);

end.
