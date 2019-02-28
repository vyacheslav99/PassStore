unit RC6;

interface

uses
  SysUtils, Classes;

procedure InvolveKeyRC6;
procedure InitializeRC6(AKey: string);
procedure CalculateSubKeysRC6;
function EncipherBlockRC6(var Block): Boolean;
function DecipherBlockRC6(var Block): Boolean;

// Зашифровать данные из одного потока в другой
function EncryptCopyRC6(Dest, Source: TStream; Count: Int64; Key: string): Boolean;
// Расшифровать данные из одного потока в другой
function DecryptCopyRC6(Dest, Source: TStream; Count: Int64; Key: string): Boolean;
// Зашифровать содержимое потока
function EncryptStreamRC6(Data: TStream; Count: Int64; Key: string): Boolean;
// Расшифровать содержимое потока
function DecryptStreamRC6(Data: TStream; Count: Int64; Key: string): Boolean;
// Шифровать / расшифровать строку
function CryptRC6(Data, Key: string; EncFlag: boolean): string;

implementation

const
  BlockSizeRC6 = 16;
  RoundsRC6 = 20;
  KeyLengthRC6 = 2 * (RoundsRC6 + 2);
  KeySizeRC6 = 16 * 4;
  P32 = $b7e15163;
  Q32 = $9e3779b9;
  lgw = 5;

type
  TRC6Block = array[1..4] of LongWord;

var
  RC6_S: array[0..KeyLengthRC6 - 1] of LongWord;
  RC6_Key: string;
  RC6_KeyPtr: PChar;

// общие
function ROL(a, s: LongWord): LongWord;
asm
  mov  ecx, s
  rol  eax, cl
end;

function ROR(a, s: LongWord): LongWord;
asm
  mov  ecx, s
  ror  eax, cl
end;

// RC6 routines
procedure InvolveKeyRC6;
var
  TempKey: string;
  i, j: Integer;
  K1, K2: LongWord;

begin
  // Разворачивание ключа до длинны KeySize = 64
  TempKey := RC6_Key;
  i := 1;
  while ((Length(TempKey) mod KeySizeRC6) <> 0) do
  begin
    TempKey := TempKey + TempKey[i];
    Inc(i);
  end;

  i := 1;
  j := 0;
  while (i < Length(TempKey)) do
  begin
    Move((RC6_KeyPtr + j)^, K1, 4);
    Move(TempKey[i], K2, 4);
    K1 := ROL(K1, K2) xor K2;
    Move(K1, (RC6_KeyPtr + j)^, 4);
    j := (j + 4) mod KeySizeRC6;
    Inc(i, 4);
  end;
end;

procedure InitializeRC6(AKey: string);
begin
  GetMem(RC6_KeyPtr, KeySizeRC6);
  FillChar(RC6_KeyPtr^, KeySizeRC6, #0);
  RC6_Key := AKey;

  InvolveKeyRC6;
end;

procedure CalculateSubKeysRC6;
var
  i, j, k: Integer;
  L: array[0..15] of LongWord;
  A, B: LongWord;

begin
  // Копирование ключа в L
  Move(RC6_KeyPtr^, L, KeySizeRC6);

  // Инициализация подключа S
  RC6_S[0] := P32;
  for i := 1 to KeyLengthRC6 - 1 do
    RC6_S[i] := RC6_S[i - 1] + Q32;

  // Смешивание S с ключом
  i := 0;
  j := 0;
  A := 0;
  B := 0;
  for k := 1 to 3 * KeyLengthRC6 do
  begin
    A := ROL((RC6_S[i] + A + B), 3);
    RC6_S[i] := A;
    B := ROL((L[j] + A + B), (A + B));
    L[j] := B;
    i := (i + 1) mod KeyLengthRC6;
    j := (j + 1) mod 16;
  end;
end;

function EncipherBlockRC6(var Block): Boolean;
var
  RC6Block: TRC6Block absolute Block;
  i: Integer;
  t, u: LongWord;
  Temp: LongWord;

begin
  // Инициализация блока
  Inc(RC6Block[2], RC6_S[0]);
  Inc(RC6Block[4], RC6_S[1]);

  for i := 1 to RoundsRC6 do
  begin
    t := ROL((RC6Block[2] * (2 * RC6Block[2] + 1)), lgw);
    u := ROL((RC6Block[4] * (2 * RC6Block[4] + 1)), lgw);
    RC6Block[1] := ROL((RC6Block[1] xor t), u) + RC6_S[2 * i];
    RC6Block[3] := ROL((RC6Block[3] xor u), t) + RC6_S[2 * i + 1];

    Temp := RC6Block[1];
    RC6Block[1] := RC6Block[2];
    RC6Block[2] := RC6Block[3];
    RC6Block[3] := RC6Block[4];
    RC6Block[4] := Temp;
  end;

  RC6Block[1] := RC6Block[1] + RC6_S[2 * RoundsRC6 + 2];
  RC6Block[3] := RC6Block[3] + RC6_S[2 * RoundsRC6 + 3];

  Result := TRUE;
end;

function DecipherBlockRC6(var Block): Boolean;
var
  RC6Block: TRC6Block absolute Block;
  i: Integer;
  t, u: LongWord;
  Temp: LongWord;

begin
  // Инициализация блока
  RC6Block[3] := RC6Block[3] - RC6_S[2 * RoundsRC6 + 3];
  RC6Block[1] := RC6Block[1] - RC6_S[2 * RoundsRC6 + 2];

  for i := RoundsRC6 downto 1 do
  begin
    Temp := RC6Block[4];
    RC6Block[4] := RC6Block[3];
    RC6Block[3] := RC6Block[2];
    RC6Block[2] := RC6Block[1];
    RC6Block[1] := Temp;

    u := ROL((RC6Block[4] * (2 * RC6Block[4] + 1)), lgw);
    t := ROL((RC6Block[2] * (2 * RC6Block[2] + 1)), lgw);
    RC6Block[3] := ROR((RC6Block[3] - RC6_S[2 * i + 1]), t) xor u;
    RC6Block[1] := ROR((RC6Block[1] - RC6_S[2 * i]), u) xor t;
  end;

  Dec(RC6Block[4], RC6_S[1]);
  Dec(RC6Block[2], RC6_S[0]);

  Result := TRUE;
end;

// RC6 шифрование (из потока в поток)
function EncryptCopyRC6(Dest, Source: TStream; Count: Int64; Key: string): Boolean;
var
  Buffer: TRC6Block;
  PrCount: Int64;
  AddCount: Byte;

begin
  Result := True;
  try
    if Key = '' then
    begin
      Dest.CopyFrom(Source, Count);
      Exit;
    end;
    InitializeRC6(Key);
    CalculateSubKeysRC6;
    PrCount := 0;
    while Count - PrCount >= BlockSizeRC6 do
    begin
      Source.Read(Buffer, BlockSizeRC6);
      EncipherBlockRC6(Buffer);
      Dest.Write(Buffer, BlockSizeRC6);
      Inc(PrCount, BlockSizeRC6);
    end;

    AddCount := Count - PrCount;
    if Count - PrCount <> 0 then
    begin
      Source.Read(Buffer, AddCount);
      Dest.Write(Buffer, AddCount);
    end;
  except
    Result := False;
  end;
end;

// RC6 расшифровка (из потока в поток)
function DecryptCopyRC6(Dest, Source: TStream; Count: Int64; Key: string): Boolean;
var
  Buffer: TRC6Block;
  PrCount: Int64;
  AddCount: Byte;

begin
  Result := True;
  try
    if Key = '' then
    begin
      Dest.CopyFrom(Source, Count);
      Exit;
    end;
    InitializeRC6(Key);
    CalculateSubKeysRC6;
    PrCount := 0;
    while Count - PrCount >= BlockSizeRC6 do
    begin
      Source.Read(Buffer, BlockSizeRC6);
      DecipherBlockRC6(Buffer);
      Dest.Write(Buffer, BlockSizeRC6);
      Inc(PrCount, BlockSizeRC6);
    end;

    AddCount := Count - PrCount;
    if Count - PrCount <> 0 then
    begin
      Source.Read(Buffer, AddCount);
      Dest.Write(Buffer, AddCount);
    end;
  except
    Result := False;
  end;
end;

// RC6 шифрование потока
function EncryptStreamRC6(Data: TStream; Count: Int64; Key: string): Boolean;
var
  Buffer: TRC6Block;
  PrCount: Int64;

begin
  Result := True;
  try
    if Key = '' then
    begin
      Data.Seek(Count, soFromCurrent);
      Exit;
    end;
    InitializeRC6(Key);
    CalculateSubKeysRC6;
    PrCount := 0;
    while Count - PrCount >= BlockSizeRC6 do
    begin
      Data.Read(Buffer, BlockSizeRC6);
      EncipherBlockRC6(Buffer);
      Data.Seek(-BlockSizeRC6, soFromCurrent);
      Data.Write(Buffer, BlockSizeRC6);
      Inc(PrCount, BlockSizeRC6);
    end;
  except
    Result := False;
  end;
end;

// RC6 расшифровка потока
function DecryptStreamRC6(Data: TStream; Count: Int64; Key: string): Boolean;
var
  Buffer: TRC6Block;
  PrCount: Int64;

begin
  Result := True;
  try
    if Key = '' then
    begin
      Data.Seek(Count, soFromCurrent);
      Exit;
    end;
    InitializeRC6(Key);
    CalculateSubKeysRC6;
    PrCount := 0;
    while Count - PrCount >= BlockSizeRC6 do
    begin
      Data.Read(Buffer, BlockSizeRC6);
      DecipherBlockRC6(Buffer);
      Data.Seek(-BlockSizeRC6, soFromCurrent);
      Data.Write(Buffer, BlockSizeRC6);
      Inc(PrCount, BlockSizeRC6);
    end;
  except
    Result := False;
  end;
end;

// RC6 шифрование / расшифровка
function CryptRC6(Data, Key: string; EncFlag: boolean): string;
var
  Src, Dest: TStringStream;
  s1, s2: string;
  sz: integer;

begin
  if EncFlag then
  begin
    sz := Length(Data);
    Data := '0'#3 + Data;
    Randomize;
    while (Length(Data) mod BlockSizeRC6) <> 0 do Data := Data + Chr(Random(256));
    Data := StringReplace(Data, '0', IntToStr(Length(Data) - sz), []);
  end;

  Src := TStringStream.Create(s1);
  Dest := TStringStream.Create(s2);
  Src.WriteString(Data);
  Src.Seek(0, soFromBeginning);

  if EncFlag then
    EncryptCopyRC6(Dest, Src, Src.Size, Key)
  else
    DecryptCopyRC6(Dest, Src, Src.Size, Key);

  Dest.Seek(0, soFromBeginning);
  result := Dest.ReadString(Dest.Size);

  Src.Free;
  Dest.Free;

  if not EncFlag then
  begin
    try
      sz := StrToInt(Copy(result, 1, Pos(#3, result) - 1));
    except
      sz := -1;
    end;
    if sz < 0 then sz := 2
    else
      result := StringReplace(result, IntToStr(sz) + #3, '', []);
    result := Copy(result, 1, Length(result) - (sz - 2));
  end;
end;

end.
