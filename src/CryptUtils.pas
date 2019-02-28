// юнит обертка для различных алгоритмов шифрования данных

unit CryptUtils;

interface

uses
  SysUtils, Classes, DES, RC6, MD5, AES;

// дополнительные методы
function StrToBytesS(s: string; HEX: boolean; Delim: char = #0): string;
function BytesSToStr(sBytes: string; HEX: boolean; Delim: char = #0): string;

// MD5
function GetMD5Hash(Buffer: Pointer; BufSize: Integer): string;
function GetMD5HashStr(Buffer: String): string;

// CS
function ECS_(S: string): string;
function DCS_(S: string): string;

// 224
function E224_(S: string): string;
function D224_(S: string): string;

// DES
procedure EncDESStream(Dest, Source: TStream; Key: string);
procedure DecDESStream(Dest, Source: TStream; Key: string);
function EncDES(Data, Key: string): string;
function DecDES(Data, Key: string): string;

//RC6 шифрование
function EncRC6(Dest, Source: TStream; Count: Int64; Key: string): Boolean;
function DecRC6(Dest, Source: TStream; Count: Int64; Key: string): Boolean;
function EncStreamRC6(Data: TStream; Count: Int64; Key: string): Boolean;
function DecStreamRC6(Data: TStream; Count: Int64; Key: string): Boolean;
function ExecRC6(Data, Key: string; EncFlag: boolean): string;

//AES шифрование
procedure EncAESStream(Dest, Source: TStream; Key: string; KeySizeMode: byte);
procedure DecAESStream(Dest, Source: TStream; Key: string; KeySizeMode: byte);
function EncAES(Source, Key: string; KeySizeMode: byte): string;
function DecAES(Source, Key: string; KeySizeMode: byte): string;

implementation

const
  HEXDIGIT = 2;

function StrToBytesS(s: string; HEX: boolean; Delim: char): string;
var
  i: integer;
  b: byte;

begin
  result := '';
  if s = '' then exit;
  for i := 1 to Length(s) do
  begin
    b := Ord(s[i]);
    if HEX then
      if Delim = #0 then
        result := result + IntToHex(b, HEXDIGIT)
      else
        result := result + Delim + IntToHex(b, HEXDIGIT)
    else
      result := result + Delim + IntToStr(b);
  end;
end;

function BytesSToStr(sBytes: string; HEX: boolean; Delim: char): string;
var
  i: integer;
  s: string;

begin
  result := '';
  if sBytes = '' then exit;
  s := '';
  if HEX and (Delim = #0) then
  begin
    try
      i := 1;
      while i < Length(sBytes) do
      begin
        result := result + Chr(StrToInt('$' + Copy(sBytes, i, HEXDIGIT)));
        Inc(i, HEXDIGIT);
      end;
    except
      result := '';
    end;
  end else
  begin
    for i := 1 to Length(sBytes) do
    try
      if sBytes[i] = Delim then
      begin
        if s <> '' then
        begin
          if HEX then
            result := result + Chr(StrToInt('$' + s))
          else
            result := result + Chr(StrToInt(s));
          s := '';
        end;
        continue;
      end;
      s := s + sBytes[i];
    except
      result := '';
      exit;
    end;
    if s <> '' then
    try
      if HEX then
        result := result + Chr(StrToInt('$' + s))
      else
        result := result + Chr(StrToInt(s));
    except
      result := '';
    end;
  end;
end;

// MD5
function GetMD5Hash(Buffer: Pointer; BufSize: Integer): string;
begin
  result := GetMD5(Buffer, BufSize);
end;

function GetMD5HashStr(Buffer : String): string;
begin
  result := StrMD5(Buffer);
end;

// CS - Encryption
function ECS_(S: string): string;
var
  i, l: integer;

begin
  Result := '';
  l := Length(S);
  for i := 0 to l - 1 do
    if i mod 2 = 0 then Result := Result + Chr(Ord(S[l - i]) - 1);
  for i := 0 to l - 1 do
    if i mod 2 <> 0 then Result := Result + Chr(Ord(S[l - i]) - 2);
end;

// CS - Decryption
function DCS_(S: string): string;
var
  i, l, n: integer;

begin
  Result := '';
  l := Length(S);
  n := l - (l div 2);
  for i := 1 to n do
  begin
    Result := Chr(Ord(S[i]) + 1) + Result;
    if i + n <= l then Result := Chr(Ord(S[i + n]) + 2) + Result;
  end;
end;

// 224 - Encryption
function E224_(S: string): string;
var
  i, l: integer;

begin
  Result := '';
  l := Length(S);
  for i := 0 to l - 1 do
    if i mod 2 = 0 then Result := Result + Chr(287 - Ord(S[l - i]));
  for i := 0 to l - 1 do
    if i mod 2 <> 0 then Result := Result + Chr(287 - Ord(S[l - i]));
end;

// 224 - Decryption
function D224_(S: string): string;
var
  i, l, n, c: Integer;

begin
  Result := '';
  l := Length(S);
  if l = 0 then Exit;
  SetLength(Result, Length(S));
  n := l - (l div 2);
  for i := 1 to l do
  begin
    if Boolean(i mod 2) xor Boolean(l mod 2) then
      c := l + l mod 2
    else
      c := n + (l + 1) mod 2;
    Result[i] := Chr(287 - Ord(S[c - (i div 2)]));
  end;
end;

procedure EncDESStream(Dest, Source: TStream; Key: string);
var
  Dst, Src: TStringStream;
  buff: string;

begin
  Dst := TStringStream.Create('');
  Src := TStringStream.Create('');
  try
    Src.CopyFrom(Source, Source.Size - Source.Position);
    buff := EncryptDES(Src.DataString, Key);
    Dst.WriteString(buff);
    Dst.Seek(0, soFromBeginning);
    Dest.CopyFrom(Dst, Dst.Size);
  finally
    Src.Free;
    Dst.Free;
  end;
end;

procedure DecDESStream(Dest, Source: TStream; Key: string);
var
  Dst, Src: TStringStream;
  buff: string;

begin
  Dst := TStringStream.Create('');
  Src := TStringStream.Create('');
  try
    Src.CopyFrom(Source, Source.Size - Source.Position);
    buff := DecryptDES(Src.DataString, Key);
    Dst.WriteString(buff);
    Dst.Seek(0, soFromBeginning);
    Dest.CopyFrom(Dst, Dst.Size);
  finally
    Src.Free;
    Dst.Free;
  end;
end;

// DES - Encryption
function EncDES(Data, Key: string): string;
begin
  result := EncryptDES(Data, Key);
end;

// DES - Decryption
function DecDES(Data, Key: string): string;
begin
  result := DecryptDES(Data, Key);
end;

// RC6 шифрование (из потока в поток)
function EncRC6(Dest, Source: TStream; Count: Int64; Key: string): Boolean;
begin
  result := EncryptCopyRC6(Dest, Source, Count, Key);
end;

// RC6 расшифровка (из потока в поток)
function DecRC6(Dest, Source: TStream; Count: Int64; Key: string): Boolean;
begin
  result := DecryptCopyRC6(Dest, Source, Count, Key);
end;

// RC6 шифрование потока
function EncStreamRC6(Data: TStream; Count: Int64; Key: string): Boolean;
begin
  result := EncryptStreamRC6(Data, Count, Key);
end;

// RC6 расшифровка потока
function DecStreamRC6(Data: TStream; Count: Int64; Key: string): Boolean;
begin
  result := DecryptStreamRC6(Data, Count, Key);
end;

// RC6 шифрование / расшифровка
function ExecRC6(Data, Key: string; EncFlag: boolean): string;
begin
  result := CryptRC6(Data, Key, EncFlag);
end;

procedure EncAESStream(Dest, Source: TStream; Key: string; KeySizeMode: byte);
begin
  EncryptAESStream(Dest, Source, Key, TAESKeySize(KeySizeMode));
end;

procedure DecAESStream(Dest, Source: TStream; Key: string; KeySizeMode: byte);
begin
  DecryptAESStream(Dest, Source, Key, TAESKeySize(KeySizeMode));
end;

function EncAES(Source, Key: string; KeySizeMode: byte): string;
begin
  result := EncryptAES(Source, Key, TAESKeySize(KeySizeMode));
end;

function DecAES(Source, Key: string; KeySizeMode: byte): string;
begin
  result := DecryptAES(Source, Key, TAESKeySize(KeySizeMode));
end;

end.
