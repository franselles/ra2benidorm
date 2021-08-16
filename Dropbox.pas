// Dropbox component unit
// (c) Astonsoft Ltd. 2012
unit Dropbox;

{.$DEFINE DEMO} // Compiler define for demo version of component

interface

uses
  Classes,
  Contnrs,
  IdHTTP,
  IdLogFile,
  IdComponent,
  IdSSLOpenSSL;

type
  // Type of event for waiting while user is allowing access to account
  TDAuthorizationContinueQueryEvent = procedure(Sender: TObject; var ResultOk: Boolean) of object;
  TDTransferProgressEvent = procedure(Sender: TObject; Position, Total: Int64; var Cancel: Boolean) of object;

  TDFileInfo = class
  private
    FIconID: String;
    FHasThumbnail: Boolean;
    FIsDeleted: Boolean;
    FIsDir: Boolean;
    FModified: TDateTime;
    FPath: String;
    FRevision: String;
    FSize: String;
    FRoot: String;
    FBytes: UInt64;
    FClientModified: TDateTime;
    FList: TObjectList;
  public
    // creates new TDFileInfo object and adds it to List by parsing JSON string
    class function FromJSON(const JSONString: String; List: TObjectList): TDFileInfo;
    // parse JSON string
    procedure ParseJSON(const JSONString: String);
    // file size display string
    property Size: String Read FSize;
    // file size in bytes
    property Bytes: UInt64 Read FBytes;
    // path (and name) of file
    property Path: String Read FPath;
    // file is folder flag
    property IsDir: Boolean Read FIsDir;
    // file is deleted flag
    property IsDeleted: Boolean Read FIsDeleted;
    // revision of file
    property Revision: String Read FRevision;
    // file has thumbnail flag
    property HasThumbnail: Boolean Read FHasThumbnail;
    // file icon ID in Dropbox icons library
    property IconID: String Read FIconID;
    // File modification time on service
    property Modified: TDateTime Read FModified;
    // File modification time set by uploading client
    property ClientModified: TDateTime Read FClientModified;
    // The root or top-level folder depending on application access level (dropbox or app folder)
    property Root: String Read FRoot;
  end;

  // Dropbox component class
  TDropbox = class
  private
    FHTTP: TIdHTTP;
    FSSLIO: TIdSSLIOHandlerSocketOpenSSL;
    FLogFile: TIdLogFile;
    FLogFileName: String;
    FAppKey: String;
    FAppSecret: String;
    FToken: String;
    FTokenSecret: String;
    FOnAuthorizationContinueQuery: TDAuthorizationContinueQueryEvent;
    FRefLink: String;
    FUserDispName: String;
    FUID: String;
    FCountry: String;
    FQuota: UInt64;
    FUsedNormal: UInt64;
    FUsedShared: UInt64;
    FEMail: String;
    FFindCache: TObjectList;
    FDeltaList: TObjectList;
    FUploadCount: Int64;
    FUploadTotal: Int64;
    FDownloadCount: Int64;
    FDownloadTotal: Int64;
    FOnUploadProgress: TDTransferProgressEvent;
    FOnDownloadProgress: TDTransferProgressEvent;
    FDeltaReset: Boolean;
    FAppFolderAccess: Boolean;
    procedure SetLogFileName(const Value: String);
    function GetProxyPort: integer;
    function GetProxyServer: String;
    procedure SetProxyPort(const Value: integer);
    procedure SetProxyServer(const Value: String);
    procedure GetTokens;
    procedure GetAccountInfo;
    procedure OnWorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
    procedure OnWork(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure OnWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    function GetDeltaItem(Index: Integer): TDFileInfo;
  public
    // Constructor
    constructor Create;
    // Destructor
    destructor Destroy; override;
    // Returns the user's two-letter country code, if available
    function GetCountry: String;
    // Returns the user's e-mail
    function GetEMail: String;
    // Returns the user's total quota allocation (bytes)
    function GetQuota: UInt64;
    // Returns the user's used quota outside of shared folders (bytes)
    function GetUsedQuotaNormal: UInt64;
    // Returns the user's used quota in shared folders (bytes)
    function GetUsedQuotaShared: UInt64;
    // Returns the user's referral link
    function GetReferralLink: String;
    // Returns the user's unique Dropbox ID
    function GetUID: String;
    // Returns the user's display name
    function GetUserDisplayName: String;
    // Returns the info about first file in directory with path Path (default is '/') or nil if no files in directory
    function FindFirst(var FileInfo: TDFileInfo; const Path: String = '/'): Integer;
    // Returns the info about next file after FindFirst request
    function FindNext(var FileInfo: TDFileInfo): Integer;
    // Closes find sequence that returned FileInfo (optional use)
    procedure FindClose(var FileInfo: TDFileInfo);
    // Clears all find cache
    procedure ClearFindCache;
    // Requests delta information
    function GetDelta(const Cursor: String = ''): String;
    // Count of items in delta
    function DeltaCount: Integer;
    // Creates new folder with path
    function CreateFolder(const Path: String): TDFileInfo;
    // Rename file or folder Obj to NewName
    procedure Rename(Obj: TDFileInfo; const NewName: String);
    // Move file or folder Obj to FolderPath
    procedure Move(Obj: TDFileInfo; FolderPath: String);
    // Copy file or folder Obj to FolderPath
    function Copy(Obj: TDFileInfo; FolderPath: String): TDFileInfo;
    // Delete file or folder Obj
    procedure Delete(Obj: TDFileInfo);
    // Uploads stream to PathName (including filename)
    function Upload(Stream: TStream; PathName: String): TDFileInfo;
    // Downloads file DFile to stream
    procedure Download(DFile: TDFileInfo; Stream: TStream);
    // Proxy server IP or DNS name (optional)
    property ProxyServer: String read GetProxyServer write SetProxyServer;
    // Proxy server port number (required when ProxySever is not empty)
    property ProxyPort: integer read GetProxyPort write SetProxyPort;
    // Log file name (optional)
    property LogFileName: String read FLogFileName write SetLogFileName;
    // Dropbox App key (required)
    property AppKey: String read FAppKey write FAppKey;
    // Dropbox App secret key (required)
    property AppSecret: String read FAppSecret write FAppSecret;
    // Dropbox access type is App folder access
    property AppFolderAccess: Boolean read FAppFolderAccess write FAppFolderAccess;
    // Token for access to user's account (optional)
    property Token: String read FToken write FToken;
    // Token secret for access to user's account (optional)
    property TokenSecret: String read FTokenSecret write FTokenSecret;
    // Indicates resetting local store (delete all items) for using delta
    property DeltaReset: Boolean read FDeltaReset;
    // Delta items
    property DeltaItems[Index: Integer]: TDFileInfo read GetDeltaItem;
    // Event for waiting while user is allowing access to account (optional)
    property OnAuthorizationContinueQuery: TDAuthorizationContinueQueryEvent read FOnAuthorizationContinueQuery write FOnAuthorizationContinueQuery;
    // Upload progress event
    property OnUploadProgress: TDTransferProgressEvent read FOnUploadProgress write FOnUploadProgress;
    // Download progress event
    property OnDownloadProgress: TDTransferProgressEvent read FOnDownloadProgress write FOnDownloadProgress;
  end;

// Extracting file/folder name from pathname
function ExtractDName(PathName: String): String;

// Extracting file/folder path from pathname
function ExtractDPath(PathName: String): String;

implementation

uses
  SysUtils,
  DateUtils,
  IdGlobal,
  IdCoderMIME,
  IdHMACSHA1,
{$IFDEF MACOS}
  FMX.Dialogs,
  System.UITypes,
{$ELSE}
  Dialogs,
  Windows,
  Forms,
{$ENDIF}
{$IFDEF POSIX}
  Posix.Stdlib,
{$ELSE}
  ShellAPI,
{$ENDIF}
  superobject,
  IdHashMessageDigest,
  IdGlobalProtocols;

const
  DROPBOX_BASE_URL = 'https://api.dropbox.com/1';
  DROPBOX_CONTENT_URL = 'https://api-content.dropbox.com/1';
  MonthNames: Array[1..12] of String = (
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  );

function ExtractDName(PathName: String): String;
var
  SlPos, I: Integer;
begin
  SlPos := -1;
  for I := 1 to Length(PathName) do
    if PathName[I] = '/' then
      SlPos := I;
  if SlPos = -1 then
    Result := PathName
  else if SlPos < Length(PathName) then
    Result := Copy(PathName, SlPos + 1, MaxInt)
  else
    Result := '';
end;

function ExtractDPath(PathName: String): String;
var
  SlPos, I: Integer;
begin
  SlPos := -1;
  for I := 1 to Length(PathName) do
    if PathName[I] = '/' then
      SlPos := I;
  if SlPos = -1 then
    Result := ''
  else
    Result := Copy(PathName, 1, SLPos);
end;

// Parsing of Dropbox date/time string
function DropboxTimeToDateTime(const DropboxTime: String): TDateTime;
var
  year, month, day, hour, minute, second, offset, I: Integer;
  S1, S2: TStringList;
begin
  S1 := TStringList.Create;
  with S1 do
  try
    Delimiter := ' ';
    DelimitedText := DropboxTime;
    Year := StrToIntDef(Strings[3], 1900);
    Month := 1;
    for I := 1 to 12 do
      if MonthNames[I] = Strings[2] then
        Month := I;
    Day := StrToIntDef(Strings[1], 1);
    S2 := TStringList.Create;
    with S2 do
    try
      Delimiter := ':';
      DelimitedText := S1.Strings[4];
      Hour := StrToIntDef(Strings[0], 0);
      Minute := StrToIntDef(Strings[1], 0);
      Second := StrToIntDef(Strings[2], 0);
    finally
      Free;
    end;
    Offset := 0;
    if Count > 5 then
      Offset := 60 * StrToIntDef(Copy(Strings[5], 1, 3), 0) + StrToIntDef(Copy(Strings[5], 4, 2), 0);
    Result := EncodeDateTime(year, month, day, hour, minute, second, 0);
    Result := IncMinute(Result, Offset);
  finally
    Free;
  end;
end;

function Utf8Encode_(const WS: WideString): AnsiString;
var
  L: Integer;
  Temp: AnsiString;
begin
  Result := '';
  if WS = '' then
    Exit;
  L := Length(WS);
  SetLength(Temp, L * 3); // SetLength includes space for null terminator

  L := UnicodeToUtf8(PAnsiChar(Temp), Length(Temp) + 1, PWideChar(WS), L);
  if L > 0 then
    SetLength(Temp, L - 1)
  else
    Temp := '';
  Result := AnsiString(Temp);
  Result := Result;
end;

function urlEncodeRFC3986(const URL: String): String;

  function UrlEncode(const S: AnsiString): AnsiString;
  var
    I: Integer;
    Ch: AnsiChar;
  begin
    Result := '';
    for I := 1 to Length(S) do
    begin
      Ch := S[I];
      if ((Ch >= '0') and (Ch <= '9')) or
        ((Ch >= 'a') and (Ch <= 'z')) or
        ((Ch >= 'A') and (Ch <= 'Z')) or
        (Ch = '.') or (Ch = '-') or (Ch = '_') or (Ch = '~') then
        Result := Result + Ch
      else
        Result := Result + '%' + AnsiString(SysUtils.IntToHex(Ord(Ch), 2));
    end;
  end;

var
  URL1: String;
begin
  URL1 := String(URLEncode(AnsiString(URL)));
  URL1 := StringReplace(URL1, '+', ' ', [rfReplaceAll, rfIgnoreCase]);
  result := URL1;
end;

function GenerateTimeStamp: String;
{$IFDEF MACOS}
begin
  Result := IntToStr(IdGlobalProtocols.GetClockValue);
{$ELSE}
var CurTime: TSystemTime;
begin
  GetSystemTime(CurTime);
  Result := IntToStr(DateTimeToUnix(SystemTimeToDateTime(CurTime)));
{$ENDIF}
end;

function GenerateNonce: String;
var
  md5: TIdHashMessageDigest;
begin
  md5 := TIdHashMessageDigest5.Create;
  Result := md5.HashStringAsHex(IntToStr(IdGlobal.Ticks));
  md5.Free;
end;

function Base64Encode(const Input: TIdBytes): String;
begin
  Result := TIdEncoderMIME.EncodeString(BytesToString(Input, Indy8BitEncoding()));
end;

function EncryptHMACSha1(const Input, AKey: String): TIdBytes;
begin
  with TIdHMACSHA1.Create do
    try
      Key := ToBytes(AKey, Indy8BitEncoding());
      Result := HashValue(ToBytes(Input, Indy8BitEncoding()));
    finally
      Free;
    end;
end;

{ TDropbox }

// Getting access tokens for user's account when needed
procedure TDropbox.GetTokens;
var
  Request, Resp: String;
  Signature: String;
  OkResult: Boolean;
  InputResult: String;
  FRequestToken, FRequestTokenSecret: String;
  FAuthURL: String;
  SourceStr: TStream;
begin
  if (FAppKey = '') or (FAppSecret = '') then
    // Raising exception if App key or App secret key are empty
    raise Exception.Create('Provide app key and secret key');

  FHTTP.Disconnect;

  // Resetting access tokens
  FToken := '';
  FTokenSecret := '';

  // Requesting the request token
  Request := 'oauth_consumer_key=' + FAppKey +
    '&oauth_nonce=' + GenerateNonce +
    '&oauth_signature_method=HMAC-SHA1' +
    '&oauth_timestamp=' + GenerateTimeStamp +
    '&oauth_version=1.0';
  // Signing the request
  Signature := 'POST&' + urlEncodeRFC3986(DROPBOX_BASE_URL + '/oauth/request_token') +
    '&' + urlEncodeRFC3986(Request);
  Request := DROPBOX_BASE_URL + '/oauth/request_token?' + Request;
  Signature := Base64Encode(EncryptHMACSha1(Signature, FAppSecret + '&'));
  Request := Request + '&oauth_signature=' + urlEncodeRFC3986(Signature);
  // Posting the request
  SourceStr := TStringStream.Create('');
  try
    Resp := FHTTP.Post(Request, SourceStr);
  finally
    SourceStr.Free;
  end;
  if FHTTP.ResponseCode = 200 then
    // Assigning the request token
    with TStringList.Create do
      try
        Delimiter := '&';
        DelimitedText := Resp;
        FRequestToken := Values['oauth_token'];
        FRequestTokenSecret := Values['oauth_token_secret'];
      finally
        Free;
      end
  else
    Exit;

  // Redirecting user to authorizaton page
  FAuthURL := 'https://www.dropbox.com/1/oauth/authorize?oauth_token=' + FRequestToken;
{$IFDEF POSIX}
  Posix.Stdlib._system(PAnsiChar('open ' + AnsiString(FAuthURL)));
{$ELSE}
  ShellExecute(Application.Handle, 'open', PWideChar(FAuthURL), nil, nil, SW_SHOWNORMAL);
{$ENDIF}
  OkResult := false;
  InputResult := '';
  // Waiting while user is allowing access
  if Assigned(FOnAuthorizationContinueQuery) then
    OnAuthorizationContinueQuery(Self, OkResult)
  else
{$IFDEF MACOS}
    OkResult := FMX.Dialogs.MessageDlg('Click OK when ready or Cancel to abort', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbOK, TMsgDlgBtn.mbCancel], 0) = mrOK;
{$ELSE}
    OkResult := MessageBox(Application.Handle, PChar(Application.Title), 'Click OK when ready or Cancel to abort', MB_OKCANCEL) = ID_OK;
{$ENDIF}
  if not OkResult then
    // User has cancelled authorization
    raise Exception.Create('Authorization cancelled by user');

  // Requesting access tokens
  Request := 'oauth_consumer_key=' + FAppKey +
    '&oauth_nonce=' + GenerateNonce +
    '&oauth_signature_method=HMAC-SHA1' +
    '&oauth_timestamp=' + GenerateTimeStamp +
    '&oauth_token=' + FRequestToken +
    '&oauth_version=1.0';
  // Signing the request
  Signature := 'POST&' + urlEncodeRFC3986(DROPBOX_BASE_URL + '/oauth/access_token') +
    '&' + urlEncodeRFC3986(Request);
  Request := DROPBOX_BASE_URL + '/oauth/access_token?' + Request;
  Signature := Base64Encode(EncryptHMACSha1(Signature, FAppSecret + '&' + FRequestTokenSecret));
  Request := Request + '&oauth_signature=' + urlEncodeRFC3986(Signature);
  // Posting the request
  SourceStr := TStringStream.Create('');
  try
    Resp := FHTTP.Post(Request, SourceStr);
  finally
    SourceStr.Free;
  end;
  if FHTTP.ResponseCode = 200 then
  // Assigning access tokens
  with TStringList.Create do
    try
      Delimiter := '&';
      DelimitedText := Resp;
      FRequestToken := '';
      FAuthURL := '';
      FToken := Values['oauth_token'];
      FTokenSecret := Values['oauth_token_secret'];
    finally
      Free;
    end;
end;

function TDropbox.GetUID: String;
begin
  if FUID = '' then
    GetAccountInfo;
  Result := FUID;
end;

function TDropbox.GetUserDisplayName: String;
begin
  if FUID = '' then
    GetAccountInfo;
  Result := FUserDispName;
end;

procedure TDropbox.Move(Obj: TDFileInfo; FolderPath: String);
var
  Request, Signature: String;
  Resp: UTF8String;
  StrResp: TStringStream;
  ErrorHandled: Boolean;
  FJSONObject: ISuperObject;
  SourceStr: TStream;
begin
  ErrorHandled := False;
  if FolderPath[Length(FolderPath)] <> '/' then
    FolderPath := FolderPath + '/';
  repeat // once again if existing access tokens are failed
    if (FToken = '') or (FTokenSecret = '') then
      // Getting tokens if one of them is empty
      GetTokens;
    Request := 'from_path=' + urlEncodeRFC3986(String(UTF8Encode_(obj.Path))) +
      '&oauth_consumer_key=' + FAppKey +
      '&oauth_nonce=' + GenerateNonce +
      '&oauth_signature_method=HMAC-SHA1' +
      '&oauth_timestamp=' + GenerateTimeStamp +
      '&oauth_token=' + FToken +
      '&oauth_version=1.0';
      if FAppFolderAccess then
        Request := Request + '&root=sandbox'
      else
        Request := Request + '&root=dropbox';
      Request := Request + '&to_path=' + urlEncodeRFC3986(String(UTF8Encode_(FolderPath + ExtractDName(obj.Path))));
    // Signing the request
    Signature := 'POST&' + urlEncodeRFC3986(DROPBOX_BASE_URL + '/fileops/move') +
      '&' + urlEncodeRFC3986(Request);
    Request := DROPBOX_BASE_URL + '/fileops/move?' + Request;
    Signature := Base64Encode(EncryptHMACSha1(Signature, FAppSecret + '&' + FTokenSecret));
    Request := Request + '&oauth_signature=' + urlEncodeRFC3986(Signature);
    StrResp := TStringStream.Create('');
    SourceStr := TStringStream.Create('');
    try
      // Requesting
      FHTTP.Post(Request, SourceStr, StrResp);
      if FHTTP.ResponseCode = 200 then
      begin
        FUID := '';
        // Getting fields values from response
        Resp := UTF8String(StrResp.DataString);
        FJSONObject := SO(Resp);
        if FJSONObject <> nil then
          Obj.ParseJSON(FJSONObject.AsString);
      end;
    except
      SourceStr.Free;
      FreeAndNil(StrResp);
      if not ErrorHandled and (FHTTP.ResponseCode = 401) then
      // Resetting access token and repeating the request if failed (401 error)
      begin
        FToken := '';
        ErrorHandled := True;
        Continue;
      end
      else
        // Raising the exception on error or when second attempt is failed on 401 error
        raise;
    end;
    SourceStr.Free;
    FreeAndNil(StrResp);
    Break; // Exiting the repeat loop
  until False;
end;

procedure TDropbox.OnWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
var
  FCancel: Boolean;
begin
  FCancel := false;
  if (AWorkMode = wmWrite) and Assigned(FOnUploadProgress) then
  begin
    FUploadCount := AWorkCount;
    FOnUploadProgress(Self, FUploadCount, FUploadTotal, FCancel);
  end
  else
  if (AWorkMode = wmRead) and Assigned(FOnDownloadProgress) then
  begin
    FDownloadCount := AWorkCount;
    FOnDownloadProgress(Self, FDownloadCount, FDownloadTotal, FCancel);
  end;
  if FCancel then
    FHTTP.Disconnect;
end;

procedure TDropbox.OnWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
var
  FCancel: Boolean;
begin
  FCancel := false;
  if (AWorkMode = wmWrite) and Assigned(FOnUploadProgress) then
  begin
    FUploadTotal := AWorkCountMax;
    FUploadCount := 0;
    FOnUploadProgress(Self, FUploadCount, FUploadTotal, FCancel);
  end
  else
  if (AWorkMode = wmRead) and Assigned(FOnDownloadProgress) then
  begin
    FDownloadTotal := AWorkCountMax;
    FDownloadCount := 0;
    FOnDownloadProgress(Self, FDownloadCount, FDownloadTotal, FCancel);
  end;
  if FCancel then
    FHTTP.Disconnect;
end;

procedure TDropbox.OnWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
var
  FCancel: Boolean;
begin
  FCancel := false;
  if (AWorkMode = wmWrite) and Assigned(FOnUploadProgress) then
    FOnUploadProgress(Self, FUploadTotal, FUploadTotal, FCancel)
  else
  if (AWorkMode = wmRead) and Assigned(FOnDownloadProgress) then
    FOnDownloadProgress(Self, FDownloadTotal, FDownloadTotal, FCancel);
  if FCancel then
    FHTTP.Disconnect;
end;

procedure TDropbox.Rename(Obj: TDFileInfo; const NewName: String);
var
  Request, Signature: String;
  Resp: UTF8String;
  StrResp, SourceStr: TStringStream;
  ErrorHandled: Boolean;
  FJSONObject: ISuperObject;
begin
  ErrorHandled := False;
  repeat // once again if existing access tokens are failed
    if (FToken = '') or (FTokenSecret = '') then
      // Getting tokens if one of them is empty
      GetTokens;
    Request := 'from_path=' + urlEncodeRFC3986(String(UTF8Encode_(obj.Path))) +
      '&oauth_consumer_key=' + FAppKey +
      '&oauth_nonce=' + GenerateNonce +
      '&oauth_signature_method=HMAC-SHA1' +
      '&oauth_timestamp=' + GenerateTimeStamp +
      '&oauth_token=' + FToken +
      '&oauth_version=1.0';
      if FAppFolderAccess then
        Request := Request + '&root=sandbox'
      else
        Request := Request + '&root=dropbox';
      Request := Request + '&to_path=' + urlEncodeRFC3986(String(UTF8Encode_(ExtractDPath(obj.Path) + NewName)));
    // Signing the request
    Signature := 'POST&' + urlEncodeRFC3986(DROPBOX_BASE_URL + '/fileops/move') +
      '&' + urlEncodeRFC3986(Request);
    Request := DROPBOX_BASE_URL + '/fileops/move?' + Request;
    Signature := Base64Encode(EncryptHMACSha1(Signature, FAppSecret + '&' + FTokenSecret));
    Request := Request + '&oauth_signature=' + urlEncodeRFC3986(Signature);
    StrResp := TStringStream.Create('');
    SourceStr := TStringStream.Create('');
    try
      // Requesting
      FHTTP.Post(Request, SourceStr, StrResp);
      if FHTTP.ResponseCode = 200 then
      begin
        // Getting fields values from response
        Resp := UTF8String(StrResp.DataString);
        FJSONObject := SO(Resp);
        if FJSONObject <> nil then
          Obj.ParseJSON(FJSONObject.AsString);
      end;
    except
      SourceStr.Free;
      FreeAndNil(StrResp);
      if not ErrorHandled and (FHTTP.ResponseCode = 401) then
      // Resetting access token and repeating the request if failed (401 error)
      begin
        FToken := '';
        ErrorHandled := True;
        Continue;
      end
      else
        // Raising the exception on error or when second attempt is failed on 401 error
        raise;
    end;
    SourceStr.Free;
    FreeAndNil(StrResp);
    Break; // Exiting the repeat loop
  until False;
end;

// Getting user's account info
procedure TDropbox.GetAccountInfo;
var
  Request, Signature: String;
  Resp: UTF8String;
  StrResp: TStringStream;
  ErrorHandled: Boolean;
  FJSONObject: ISuperObject;
  ItemRec: TSuperObjectIter;
begin
  ErrorHandled := False;
  // Resetting account info fields
  FUID := '';
  FUserDispName := '';
  FRefLink := '';
  FCountry := '';
  FEMail := '';
  FQuota := 0;
  FUsedNormal := 0;
  FUsedShared := 0;
  repeat // once again if existing access tokens are failed
    if (FToken = '') or (FTokenSecret = '') then
      // Getting tokens if one of them is empty
      GetTokens;
    Request := 'oauth_consumer_key=' + FAppKey +
      '&oauth_nonce=' + GenerateNonce +
      '&oauth_signature_method=HMAC-SHA1' +
      '&oauth_timestamp=' + GenerateTimeStamp +
      '&oauth_token=' + FToken +
      '&oauth_version=1.0';
    // Signing the request
    Signature := 'GET&' + urlEncodeRFC3986(DROPBOX_BASE_URL + '/account/info') +
      '&' + urlEncodeRFC3986(Request);
    Request := DROPBOX_BASE_URL + '/account/info?' + Request;
    Signature := Base64Encode(EncryptHMACSha1(Signature, FAppSecret + '&' + FTokenSecret));
    Request := Request + '&oauth_signature=' + urlEncodeRFC3986(Signature);
    StrResp := TStringStream.Create('');
    try
      // Requesting account info
      FHTTP.Get(Request, StrResp);
      if FHTTP.ResponseCode = 200 then
      begin
        // Getting fields values from response
        Resp := UTF8String(StrResp.DataString);
        FJSONObject := SO(Resp);
        if FJSONObject <> nil then
        begin
          ObjectFindFirst(FJSONObject, ItemRec);
          repeat
            with ItemRec do
              if key = 'referral_link' then
                FRefLink := val.AsString
              else
              if key = 'display_name' then
                FUserDispName := val.AsString
              else
              if key = 'uid' then
                FUID := val.AsString
              else
              if key = 'country' then
                FCountry := val.AsString
              else
              if key = 'email' then
                FEMail := val.AsString
              else
              if key = 'quota_info' then
                with val do
                begin
                  FQuota := UInt64(StrToInt64Def(S['quota'], 0));
                  FUsedNormal := UInt64(StrToInt64Def(S['normal'], 0));
                  FUsedShared := UInt64(StrToInt64Def(S['shared'], 0));;
               end;
          until not ObjectFindNext(ItemRec);
        end;
      end;
    except
      FreeAndNil(StrResp);
      if not ErrorHandled and (FHTTP.ResponseCode = 401) then
      // Resetting access token and repeating the request if failed (401 error)
      begin
        FToken := '';
        ErrorHandled := True;
        Continue;
      end
      else
        // Raising the exception on error or when second attempt is failed on 401 error
        raise;
    end;
    FreeAndNil(StrResp);
    Break; // Exiting the repeat loop
  until False;
end;

function TDropbox.GetCountry: String;
begin
  if FUID = '' then
    GetAccountInfo;
  Result := FCountry;
end;

function TDropbox.GetDelta(const Cursor: String): String;
var
  Request, Signature, NextCursor: String;
  Resp, LastResp: UTF8String;
  StrResp, SourceStr: TStringStream;
  ErrorHandled, HasMore: Boolean;
  FJSONObject: ISuperObject;
  FJSONPair: ISuperObject;
  FFileInfo: TDFileInfo;
  J: Integer;
begin
  Result := '';
  LastResp := '';
  FDeltaReset := False;
  FDeltaList.Clear;
  NextCursor := Cursor;
  ErrorHandled := False;
  repeat // once again if existing access tokens are failed
    HasMore := false;
    if (FToken = '') or (FTokenSecret = '') then
      // Getting tokens if one of them is empty
      GetTokens;
    Request := 'oauth_consumer_key=' + FAppKey +
      '&oauth_nonce=' + GenerateNonce +
      '&oauth_signature_method=HMAC-SHA1' +
      '&oauth_timestamp=' + GenerateTimeStamp +
      '&oauth_token=' + FToken +
      '&oauth_version=1.0';
    if Cursor <> '' then
      Request := 'cursor=' + NextCursor + '&' + Request;
    // Signing the request
    Signature := 'POST&' + urlEncodeRFC3986(DROPBOX_BASE_URL + '/delta') + '&' + urlEncodeRFC3986(Request);
    Request := DROPBOX_BASE_URL + '/delta?' + Request;
    Signature := Base64Encode(EncryptHMACSha1(Signature, FAppSecret + '&' + FTokenSecret));
    Request := Request + '&oauth_signature=' + urlEncodeRFC3986(Signature);
    StrResp := TStringStream.Create('');
    SourceStr := TStringStream.Create('');
    try
      // Requesting
      FHTTP.Post(Request, SourceStr, StrResp);
      if FHTTP.ResponseCode = 200 then
      begin
        // Getting delta infos from response
        Resp := UTF8String(StrResp.DataString);
        FreeAndNil(StrResp);
        FJSONObject := SO(Resp);
        if Resp = LastResp then
          Break;
        LastResp := Resp;
        if FJSONObject <> nil then
          FJSONPair := FJSONObject['cursor'];
        if FJSONPair <> nil then
          NextCursor := FJSONPair.AsString;
        FJSONPair := FJSONObject['has_more'];
        if FJSONPair <> nil then
          HasMore := FJSONPair.AsBoolean;
        FJSONPair := FJSONObject['reset'];
        if (FJSONPair <> nil) and not FDeltaReset then
          FDeltaReset := FJSONPair.AsBoolean;
        FJSONPair := FJSONObject['entries'];
        if FJSONPair <> nil then
        with FJSONPair do
        begin
          for J := 0 to AsArray.Length - 1 do
            with AsArray[J] do
            if AsArray[1] = nil then
            begin
              FFileInfo := TDFileInfo.Create;
              FFileInfo.FIsDeleted := True;
              FFileInfo.FPath := AsArray[0].AsString;
              FFileInfo.FList := FDeltaList;
              FDeltaList.Add(FFileInfo);
            end
            else
              TDFileInfo.FromJSON(AsArray[1].AsString, FDeltaList);
        end;
      end;
    except
      SourceStr.Free;
      FreeAndNil(StrResp);
      if not ErrorHandled and (FHTTP.ResponseCode = 401) then
      // Resetting access token and repeating the request if failed (401 error)
      begin
        FToken := '';
        ErrorHandled := True;
        Continue;
      end
      else
        // Raising the exception on error or when second attempt is failed on 401 error
        raise;
    end;
    SourceStr.Free;
    FreeAndNil(StrResp);
    if not HasMore then
      Break; // Exiting the repeat loop
  until False;
  Result := NextCursor;
end;

function TDropbox.GetDeltaItem(Index: Integer): TDFileInfo;
begin
  Result := TDFileInfo(FDeltaList[Index]);
end;

function TDropbox.GetEMail: String;
begin
  if FUID = '' then
    GetAccountInfo;
  Result := FEMail;
end;

procedure TDropbox.ClearFindCache;
begin
  FFindCache.Clear;
end;

function TDropbox.Copy(Obj: TDFileInfo; FolderPath: String): TDFileInfo;
var
  Request, Signature: String;
  Resp: UTF8String;
  StrResp: TStringStream;
  ErrorHandled: Boolean;
  FJSONObject: ISuperObject;
  SourceStr: TStream;
  List: TObjectList;
begin
  ErrorHandled := False;
  if FolderPath[Length(FolderPath)] <> '/' then
    FolderPath := FolderPath + '/';
  repeat // once again if existing access tokens are failed
    if (FToken = '') or (FTokenSecret = '') then
      // Getting tokens if one of them is empty
      GetTokens;
    Request := 'from_path=' + urlEncodeRFC3986(String(UTF8Encode_(obj.Path))) +
      '&oauth_consumer_key=' + FAppKey +
      '&oauth_nonce=' + GenerateNonce +
      '&oauth_signature_method=HMAC-SHA1' +
      '&oauth_timestamp=' + GenerateTimeStamp +
      '&oauth_token=' + FToken +
      '&oauth_version=1.0';
      if FAppFolderAccess then
        Request := Request + '&root=sandbox'
      else
        Request := Request + '&root=dropbox';
      Request := Request + '&to_path=' + urlEncodeRFC3986(String(UTF8Encode_(FolderPath + ExtractDName(obj.Path))));
    // Signing the request
    Signature := 'POST&' + urlEncodeRFC3986(DROPBOX_BASE_URL + '/fileops/copy') +
      '&' + urlEncodeRFC3986(Request);
    Request := DROPBOX_BASE_URL + '/fileops/copy?' + Request;
    Signature := Base64Encode(EncryptHMACSha1(Signature, FAppSecret + '&' + FTokenSecret));
    Request := Request + '&oauth_signature=' + urlEncodeRFC3986(Signature);
    StrResp := TStringStream.Create('');
    SourceStr := TStringStream.Create('');
    try
      // Requesting
      FHTTP.Post(Request, SourceStr, StrResp);
      if FHTTP.ResponseCode = 200 then
      begin
        FUID := '';
        // Getting fields values from response
        Resp := UTF8String(StrResp.DataString);
        FJSONObject := SO(Resp);
        if FJSONObject <> nil then
          begin
            // new file info list to cache
            List := TObjectList.Create;
            List.OwnsObjects := True;
            FFindCache.Add(List);
            Result := TDFileInfo.FromJSON(FJSONObject.AsString, List);
          end;
      end;
    except
      SourceStr.Free;
      FreeAndNil(StrResp);
      if not ErrorHandled and (FHTTP.ResponseCode = 401) then
      // Resetting access token and repeating the request if failed (401 error)
      begin
        FToken := '';
        ErrorHandled := True;
        Continue;
      end
      else
        // Raising the exception on error or when second attempt is failed on 401 error
        raise;
    end;
    SourceStr.Free;
    FreeAndNil(StrResp);
    Break; // Exiting the repeat loop
  until False;
end;

constructor TDropbox.Create;
begin
  inherited Create;
  FHTTP := TIdHTTP.Create(nil);
  FSSLIO := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  FHTTP.IOHandler := FSSLIO;
  FHTTP.AllowCookies := True;
  FHTTP.HandleRedirects := True;
  FHTTP.RedirectMaximum := 2;
  FHTTP.ConnectTimeout := 15000;
  FHTTP.ReadTimeout := 30000;
  FHTTP.IOHandler.RecvBufferSize := 32 * 1024;
  FHTTP.IOHandler.SendBufferSize := 32 * 1024;
  FHTTP.OnWorkBegin := OnWorkBegin;
  FHTTP.OnWork := OnWork;
  FHTTP.OnWorkEnd := OnWorkEnd;
  FHTTP.Request.ContentType := 'application/x-www-form-urlencoded';
  FDeltaList := TObjectList.Create;
  FDeltaList.OwnsObjects := True;
  FFindCache := TObjectList.Create;
  FFindCache.OwnsObjects := True;
end;

function TDropbox.CreateFolder(const Path: String): TDFileInfo;
var
  Request, Signature: String;
  Resp: UTF8String;
  StrResp, SourceStr: TStringStream;
  ErrorHandled: Boolean;
  List: TObjectList;
  FJSONObject: ISuperObject;
begin
  Result := nil;
  ErrorHandled := False;
  repeat // once again if existing access tokens are failed
    if (FToken = '') or (FTokenSecret = '') then
      // Getting tokens if one of them is empty
      GetTokens;
    Request := 'oauth_consumer_key=' + FAppKey +
      '&oauth_nonce=' + GenerateNonce +
      '&oauth_signature_method=HMAC-SHA1' +
      '&oauth_timestamp=' + GenerateTimeStamp +
      '&oauth_token=' + FToken +
      '&oauth_version=1.0' +
      '&path=' + urlEncodeRFC3986(String(UTF8Encode_(Path)));
      if FAppFolderAccess then
        Request := Request + '&root=sandbox'
      else
        Request := Request + '&root=dropbox';
    // Signing the request
    Signature := 'POST&' + urlEncodeRFC3986(DROPBOX_BASE_URL + '/fileops/create_folder') +
      '&' + urlEncodeRFC3986(Request);
    Request := DROPBOX_BASE_URL + '/fileops/create_folder?' + Request;
    Signature := Base64Encode(EncryptHMACSha1(Signature, FAppSecret + '&' + FTokenSecret));
    Request := Request + '&oauth_signature=' + urlEncodeRFC3986(Signature);
    StrResp := TStringStream.Create('');
    SourceStr := TStringStream.Create('');
    try
      // Requesting
      FHTTP.Post(Request, SourceStr, StrResp);
      if FHTTP.ResponseCode = 200 then
      begin
        // Getting fields values from response
        Resp := UTF8String(StrResp.DataString);
        FJSONObject := SO(Resp);
        if FJSONObject <> nil then
          begin
            // new file info list to cache
            List := TObjectList.Create;
            List.OwnsObjects := True;
            FFindCache.Add(List);
            Result := TDFileInfo.FromJSON(FJSONObject.AsString, List);
          end;
      end;
    except
      SourceStr.Free;
      FreeAndNil(StrResp);
      if not ErrorHandled and (FHTTP.ResponseCode = 401) then
      // Resetting access token and repeating the request if failed (401 error)
      begin
        FToken := '';
        ErrorHandled := True;
        Continue;
      end
      else
        // Raising the exception on error or when second attempt is failed on 401 error
        raise;
    end;
    SourceStr.Free;
    FreeAndNil(StrResp);
    Break; // Exiting the repeat loop
  until False;
end;

procedure TDropbox.Delete(Obj: TDFileInfo);
var
  Request, Signature: String;
  Resp: UTF8String;
  StrResp, SourceStr: TStringStream;
  ErrorHandled: Boolean;
  FJSONObject: ISuperObject;
begin
  ErrorHandled := False;
  repeat // once again if existing access tokens are failed
    if (FToken = '') or (FTokenSecret = '') then
      // Getting tokens if one of them is empty
      GetTokens;
    Request := 'oauth_consumer_key=' + FAppKey +
      '&oauth_nonce=' + GenerateNonce +
      '&oauth_signature_method=HMAC-SHA1' +
      '&oauth_timestamp=' + GenerateTimeStamp +
      '&oauth_token=' + FToken +
      '&oauth_version=1.0' +
      '&path=' + urlEncodeRFC3986(String(UTF8Encode_(obj.Path)));
      if FAppFolderAccess then
        Request := Request + '&root=sandbox'
      else
        Request := Request + '&root=dropbox';
    // Signing the request
    Signature := 'POST&' + urlEncodeRFC3986(DROPBOX_BASE_URL + '/fileops/delete') +
      '&' + urlEncodeRFC3986(Request);
    Request := DROPBOX_BASE_URL + '/fileops/delete?' + Request;
    Signature := Base64Encode(EncryptHMACSha1(Signature, FAppSecret + '&' + FTokenSecret));
    Request := Request + '&oauth_signature=' + urlEncodeRFC3986(Signature);
    StrResp := TStringStream.Create('');
    SourceStr := TStringStream.Create('');
    try
      // Requesting
      FHTTP.Post(Request, TStream(nil), StrResp);
      if FHTTP.ResponseCode = 200 then
      begin
        FUID := '';
        // Getting fields values from response
        Resp := UTF8String(StrResp.DataString);
        FJSONObject := SO(Resp);
        if FJSONObject <> nil then
          Obj.ParseJSON(FJSONObject.AsString);
      end;
    except
      SourceStr.Free;
      FreeAndNil(StrResp);
      if not ErrorHandled and (FHTTP.ResponseCode = 401) then
      // Resetting access token and repeating the request if failed (401 error)
      begin
        FToken := '';
        ErrorHandled := True;
        Continue;
      end
      else
        // Raising the exception on error or when second attempt is failed on 401 error
        raise;
    end;
    SourceStr.Free;
    FreeAndNil(StrResp);
    Break; // Exiting the repeat loop
  until False;
end;

function TDropbox.DeltaCount: Integer;
begin
  Result := FDeltaList.Count;
end;

destructor TDropbox.Destroy;
begin
  FFindCache.Free;
  FDeltaList.Free;
  FHTTP.Disconnect;
  FSSLIO.Free;
  FHTTP.Free;
  FLogFile.Free;
  inherited;
end;

procedure TDropbox.Download(DFile: TDFileInfo; Stream: TStream);
var
  Request, Signature: String;
  ErrorHandled: Boolean;
  FPath: String;
begin
  ErrorHandled := False;
  Stream.Size := 0;
  repeat // once again if existing access tokens are failed
    if (FToken = '') or (FTokenSecret = '') then
      // Getting tokens if one of them is empty
      GetTokens;
    Request := 'oauth_consumer_key=' + FAppKey +
      '&oauth_nonce=' + GenerateNonce +
      '&oauth_signature_method=HMAC-SHA1' +
      '&oauth_timestamp=' + GenerateTimeStamp +
      '&oauth_token=' + FToken +
      '&oauth_version=1.0';
    FPath := String(Utf8Encode_(DFile.Path));
    FPath := urlEncodeRFC3986(FPath);
    FPath := StringReplace(FPath, '%2F', '/', [rfReplaceAll]);
    // Signing the request
    if FAppFolderAccess then
    begin
      Signature := 'GET&' + urlEncodeRFC3986(DROPBOX_CONTENT_URL + '/files/sandbox' + FPath) +
      '&' + urlEncodeRFC3986(Request);
      Request := DROPBOX_CONTENT_URL + '/files/sandbox' + FPath + '?' + Request;
    end
    else
    begin
      Signature := 'GET&' + urlEncodeRFC3986(DROPBOX_CONTENT_URL + '/files/dropbox' + FPath) +
      '&' + urlEncodeRFC3986(Request);
      Request := DROPBOX_CONTENT_URL + '/files/dropbox' + FPath + '?' + Request;
    end;
    Signature := Base64Encode(EncryptHMACSha1(Signature, FAppSecret + '&' + FTokenSecret));
    Request := Request + '&oauth_signature=' + urlEncodeRFC3986(Signature);
    try
      // Getting file
      FHTTP.Get(Request, Stream);
    except
      if not ErrorHandled and (FHTTP.ResponseCode = 401) then
      // Resetting access token and repeating the request if failed (401 error)
      begin
        FToken := '';
        ErrorHandled := True;
        Continue;
      end
      else
        // Raising the exception on error or when second attempt is failed on 401 error
        raise;
    end;
    Break; // Exiting the repeat loop
  until False;
end;

procedure TDropbox.FindClose(var FileInfo: TDFileInfo);
begin
  FFindCache.Remove(FileInfo.FList);
end;

// Compare function for initial sorting of file info lists
function FileInfoCompare(Item1, Item2: Pointer): Integer;
var
  FI1, FI2: TDFileInfo;
begin
  FI1 := Item1;
  FI2 := Item2;
  if FI1.IsDir and not FI2.IsDir then
    Result := -1
  else
  if FI2.IsDir and not FI1.IsDir then
    Result := 1
  else
    Result := CompareText(ExtractDName(FI1.Path), ExtractDName(FI2.Path));
end;

function TDropbox.FindFirst(var FileInfo: TDFileInfo; const Path: String = '/'): Integer;
var
  Request, Signature, LPath: String;
  Resp: UTF8String;
  StrResp: TStringStream;
  ErrorHandled: Boolean;
  FJSONObject: ISuperObject;
  FJSONPair: ISuperObject;
  I: Integer;
  List: TObjectList;
begin
  Result := -1;
  FileInfo := nil;
  ErrorHandled := False;
  // Cleaning find cache
  repeat // once again if existing access tokens are failed
    if (FToken = '') or (FTokenSecret = '') then
      // Getting tokens if one of them is empty
      GetTokens;
    Request := 'file_limit=25000' +
      '&oauth_consumer_key=' + FAppKey +
      '&oauth_nonce=' + GenerateNonce +
      '&oauth_signature_method=HMAC-SHA1' +
      '&oauth_timestamp=' + GenerateTimeStamp +
      '&oauth_token=' + FToken +
      '&oauth_version=1.0';
    LPath := String(Utf8Encode_(Path));
    if (Length(LPath) = 0) or (LPath[1] <> '/') then
      LPath := '/' + LPath;
    LPath := urlEncodeRFC3986(LPath);
    LPath := StringReplace(LPath, '%2F', '/', [rfReplaceAll]);
    // Signing the request
    if FAppFolderAccess then
    begin
      Signature := 'GET&' + urlEncodeRFC3986(DROPBOX_BASE_URL + '/metadata/sandbox' + LPath) +
        '&' + urlEncodeRFC3986(Request);
      Request := DROPBOX_BASE_URL + '/metadata/sandbox' + LPath + '?' + Request;
    end
    else
    begin
      Signature := 'GET&' + urlEncodeRFC3986(DROPBOX_BASE_URL + '/metadata/dropbox' + LPath) +
        '&' + urlEncodeRFC3986(Request);
      Request := DROPBOX_BASE_URL + '/metadata/dropbox' + LPath + '?' + Request;
    end;
    Signature := Base64Encode(EncryptHMACSha1(Signature, FAppSecret + '&' + FTokenSecret));
    Request := Request + '&oauth_signature=' + urlEncodeRFC3986(Signature);
    StrResp := TStringStream.Create('');
    try
      // Requesting
      FHTTP.Get(Request, StrResp);
      if FHTTP.ResponseCode = 200 then
      begin
        // Getting file infos from response
        Resp := UTF8String(StrResp.DataString);
        FreeAndNil(StrResp);
        FJSONObject := SO(Resp);
        if FJSONObject <> nil then
        begin
          FJSONPair := FJSONObject['contents'];
          if FJSONPair <> nil then
          begin
            // new file info list to cache
            List := TObjectList.Create;
            List.OwnsObjects := True;
            FFindCache.Add(List);
            for I := 0 to FJSONPair.AsArray.Length - 1 do
              TDFileInfo.FromJSON(FJSONPair.AsArray[I].AsString, List);
            List.Sort(FileInfoCompare);
            if List.Count > 0 then
            begin
              FileInfo := TDFileInfo(List[0]);
              Result := 0;
            end;
          end;
        end;
      end;
    except
      FreeAndNil(StrResp);
      if not ErrorHandled and (FHTTP.ResponseCode = 401) then
      // Resetting access token and repeating the request if failed (401 error)
      begin
        FToken := '';
        ErrorHandled := True;
        Continue;
      end
      else
        // Raising the exception on error or when second attempt is failed on 401 error
        raise;
    end;
    FreeAndNil(StrResp);
    Break; // Exiting the repeat loop
  until False;
end;

function TDropbox.FindNext(var FileInfo: TDFileInfo): Integer;
var
  Index: Integer;
begin
  Result := -1;
  Index := FileInfo.FList.IndexOf(FileInfo);
  if Index = -1 then
    raise Exception.Create('Such FileInfo does not exist');
  if Index < FileInfo.FList.Count - 1 then
  begin
    FileInfo := TDFileInfo(FileInfo.FList[Index + 1]);
    Result := 0;
  end;
end;

function TDropbox.GetProxyPort: integer;
begin
  Result := FHTTP.ProxyParams.ProxyPort;
end;

function TDropbox.GetProxyServer: String;
begin
  Result := FHTTP.ProxyParams.ProxyServer;
end;

function TDropbox.GetQuota: UInt64;
begin
  if FUID = '' then
    GetAccountInfo;
  Result := FQuota;
end;

function TDropbox.GetUsedQuotaNormal: UInt64;
begin
  if FUID = '' then
    GetAccountInfo;
  Result := FUsedNormal;
end;

function TDropbox.GetUsedQuotaShared: UInt64;
begin
  if FUID = '' then
    GetAccountInfo;
  Result := FUsedShared;
end;

function TDropbox.GetReferralLink: String;
begin
  if FUID = '' then
    GetAccountInfo;
  Result := FRefLink;
end;

// Setting file name for log file
procedure TDropbox.SetLogFileName(const Value: String);
begin
  if FLogFileName = Value then
    Exit;
  FLogFileName := Value;
  if Trim(FLogFileName) <> '' then
  begin
    if FLogFile = nil then
    begin
      FLogFile := TIdLogFile.Create;
      FLogFile.ReplaceCRLF := False;
      FHTTP.Intercept := FLogFile;
    end;
    FLogFile.Filename := FLogFileName;
    FLogFile.Active := True;
  end
  else
  begin
    FLogFile.Free;
  end;
end;

procedure TDropbox.SetProxyPort(const Value: integer);
begin
  FHTTP.ProxyParams.ProxyPort := Value;
end;

procedure TDropbox.SetProxyServer(const Value: String);
begin
  FHTTP.ProxyParams.ProxyServer := Value;
end;

function TDropbox.Upload(Stream: TStream; PathName: String): TDFileInfo;
var
  Request, Signature: String;
  Resp: UTF8String;
  StrResp: TStringStream;
  ErrorHandled: Boolean;
  List: TObjectList;
  FJSONObject: ISuperObject;
begin
  Result := nil;
  ErrorHandled := False;
  Stream.Position := 0;
  if Stream.Size >= 150 * 1024 * 1024 then
    raise Exception.Create('Dropbox API does not allow to upload files larger than 150MB');
  repeat // once again if existing access tokens are failed
    if (FToken = '') or (FTokenSecret = '') then
      // Getting tokens if one of them is empty
      GetTokens;
    Request := 'oauth_consumer_key=' + FAppKey +
      '&oauth_nonce=' + GenerateNonce +
      '&oauth_signature_method=HMAC-SHA1' +
      '&oauth_timestamp=' + GenerateTimeStamp +
      '&oauth_token=' + FToken +
      '&oauth_version=1.0' +
      '&path=' + urlEncodeRFC3986(String(UTF8Encode_(PathName)));
      if FAppFolderAccess then
       Request := Request + '&root=sandbox'
      else
       Request := Request + '&root=dropbox';
    // Signing the request
    Signature := 'PUT&' + urlEncodeRFC3986(DROPBOX_CONTENT_URL + '/files_put') +
      '&' + urlEncodeRFC3986(Request);
    Request := DROPBOX_CONTENT_URL + '/files_put?' + Request;
    Signature := Base64Encode(EncryptHMACSha1(Signature, FAppSecret + '&' + FTokenSecret));
    Request := Request + '&oauth_signature=' + urlEncodeRFC3986(Signature);
    StrResp := TStringStream.Create('');
    try
      // Uploading stream
      FHTTP.Request.ContentType := 'application/octet-stream';
      FHTTP.Put(Request, Stream, StrResp);
      if FHTTP.ResponseCode = 200 then
      begin
        FUID := '';
        // Getting fields values from response
        Resp := UTF8String(StrResp.DataString);
        FJSONObject := SO(Resp);
        if FJSONObject <> nil then
          begin
            // new file info list to cache
            List := TObjectList.Create;
            List.OwnsObjects := True;
            FFindCache.Add(List);
            Result := TDFileInfo.FromJSON(FJSONObject.AsString, List);
          end;
      end;
    except
      FHTTP.Request.ContentType := 'application/x-www-form-urlencoded';
      FreeAndNil(StrResp);
      if not ErrorHandled and (FHTTP.ResponseCode = 401) then
      // Resetting access token and repeating the request if failed (401 error)
      begin
        FToken := '';
        ErrorHandled := True;
        Continue;
      end
      else
        // Raising the exception on error or when second attempt is failed on 401 error
        raise;
    end;
    FHTTP.Request.ContentType := 'application/x-www-form-urlencoded';
    FreeAndNil(StrResp);
    Break; // Exiting the repeat loop
  until False;
end;

{ TDFileInfo }

class function TDFileInfo.FromJSON(const JSONString: String; List: TObjectList): TDFileInfo;
begin
  Result := TDFileInfo.Create;
  Result.ParseJSON(JSONString);
  Result.FList := List;
  Result.FList.Add(Result);
end;

procedure TDFileInfo.ParseJSON(const JSONString: String);
var
  FJSONObject: ISuperObject;
  ItemRec: TSuperObjectIter;
begin
  FSize := '';
  FBytes := 0;
  FPath := '';
  FIsDir := false;
  FIsDeleted := false;
  FRevision := '';
  FHasThumbnail := false;
  FIconID := '';
  FModified := 0;
  FClientModified := 0;
  FRoot := '';
  FJSONObject := SO(JSONString);
  if FJSONObject <> nil then
  begin
    ObjectFindFirst(FJSONObject, ItemRec);
    repeat
      with ItemRec do
        if key = 'size' then
          FSize := val.AsString
        else
        if key = 'bytes' then
          FBytes := UInt64(StrToInt64Def(val.AsString, 0))
        else
        if key = 'path' then
          FPath := val.AsString
        else
        if key = 'is_dir' then
          FIsDir := val.AsBoolean
        else
        if key = 'is_deleted' then
          FIsDeleted := val.AsBoolean
        else
        if key = 'rev' then
          FRevision := val.AsString
        else
        if key = 'thumb_exists' then
          FHasThumbnail := val.AsBoolean
        else
        if key = 'icon' then
          FIconID := val.AsString
        else
        if key = 'modified' then
          FModified := DropboxTimeToDateTime(val.AsString)
        else
        if key = 'client_mtime' then
          FClientModified := DropboxTimeToDateTime(val.AsString)
        else
        if key = 'root' then
          FRoot := val.AsString;
    until not ObjectFindNext(ItemRec);
  end;
end;

initialization
{$IFDEF DEMO} // Demo version restrictions functionality
  if DebugHook = 0 then
  begin // Demo version can only be used within Delphi environment
    MessageBox(0, 'Dropbox trial version requires Delphi IDE!', 'Error', 0);
    Halt(1);
  end;
{$ENDIF}
end.
