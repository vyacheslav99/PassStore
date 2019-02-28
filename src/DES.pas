unit DES;

interface

uses
  SysUtils, Classes;

type
  TRoundKeys = array[0..15, 0..47] of Byte;
  
function GetBit(var Data: array of Byte; BitIndex: Byte): Byte;
procedure SetBit(var Data: array of Byte; BitIndex, BitValue: Byte);
procedure Transpose(var Data: array of Byte; const OrderData: array of Byte);
procedure Rotate(var KeyBits: array of Byte);
procedure GetBoxes(var RoundKey, Bits: array of Byte; LastRound: Boolean);
procedure CryptDES(var Bits: array of Byte; var RoundKeys: TRoundKeys; EncryptFlag: Boolean);
procedure MakeRoundKey(Round: Byte; var RoundKey, KeyBits: array of Byte);
procedure MakeKeys(var KeyStr: string; KeyLen: Integer; var RoundKeys: TRoundKeys);
procedure BytesToBits(var Bytes, Bits: array of Byte);
procedure BitsToBytes(var Bytes, Bits: array of Byte);
function ExecuteDES(EncryptionFlag: Boolean; var KeyStr, InputStr, OutputStr: string;
  KeyLen, InputLen, MaxOutputLen: Integer): Integer;

function EncryptDES(Data, Key: string): string;
function DecryptDES(Data, Key: string): string;

implementation

const
  IP: array [0..63] of Byte =
    (57, 49, 41, 33, 25, 17,  9,  1, 59, 51, 43, 35, 27, 19, 11,  3,
     61, 53, 45, 37, 29, 21, 13,  5, 63, 55, 47, 39, 31, 23, 15,  7,
     56, 48, 40, 32, 24, 16,  8,  0, 58, 50, 42, 34, 26, 18, 10,  2,
     60, 52, 44, 36, 28, 20, 12,  4, 62, 54, 46, 38, 30, 22, 14,  6);

  InvIP: array [0..63] of Byte =
    (39,  7, 47, 15, 55, 23, 63, 31, 38,  6, 46, 14, 54, 22, 62, 30,
     37,  5, 45, 13, 53, 21, 61, 29, 36,  4, 44, 12, 52, 20, 60, 28,
     35,  3, 43, 11, 51, 19, 59, 27, 34,  2, 42, 10, 50, 18, 58, 26,
     33,  1, 41,  9, 49, 17, 57, 25, 32,  0, 40,  8, 48, 16, 56, 24);

  PC_1: array [0..55] of Byte =
    (56, 48, 40, 32, 24, 16,  8,  0, 57, 49, 41, 33, 25, 17,
      9,  1, 58, 50, 42, 34, 26, 18, 10,  2, 59, 51, 43, 35,
     62, 54, 46, 38, 30, 22, 14,  6, 61, 53, 45, 37, 29, 21,
     13,  5, 60, 52, 44, 36, 28, 20, 12,  4, 27, 19, 11,  3);

  PC_2: array[0..47] of Byte =
    (13, 16, 10, 23,  0,  4,  2, 27, 14,  5, 20,  9,
     22, 18, 11,  3, 25,  7, 15,  6, 26, 19, 12,  1,
     40, 51, 30, 36, 46, 54, 29, 39, 50, 44, 32, 47,
     43, 48, 38, 55, 33, 52, 45, 41, 49, 35, 28, 31);

  E: array [0..47] of Byte =
    (31,  0,  1,  2,  3,  4,  3,  4,  5,  6,  7,  8,
      7,  8,  9, 10, 11, 12, 11, 12, 13, 14, 15, 16,
     15, 16, 17, 18, 19, 20, 19, 20, 21, 22, 23, 24,
     23, 24, 25, 26, 27, 28, 27, 28, 29, 30, 31,  0);

  P: array [0..31] of Byte =
    (15, 6, 19, 20, 28, 11, 27, 16, 0, 14, 22, 25,  4, 17, 30, 9,
     1, 7, 23, 13, 31, 26,  2,  8, 18, 12, 29,  5, 21, 10,  3, 24);

  Boxes: array [0..7, 0..63] of Byte =
    ((14,  4, 13,  1,  2, 15, 11,  8,  3, 10,  6, 12,  5,  9,  0,  7,
       0, 15,  7,  4, 14,  2, 13,  1, 10,  6, 12, 11,  9,  5,  3,  8,
       4,  1, 14,  8, 13,  6,  2, 11, 15, 12,  9,  7,  3, 10,  5,  0,
      15, 12,  8,  2,  4,  9,  1,  7,  5, 11,  3, 14, 10,  0,  6, 13),
     (15,  1,  8, 14,  6, 11,  3,  4,  9,  7,  2, 13, 12,  0,  5, 10,
       3, 13,  4,  7, 15,  2,  8, 14, 12,  0,  1, 10,  6,  9, 11,  5,
       0, 14,  7, 11, 10,  4, 13,  1,  5,  8, 12,  6,  9,  3,  2, 15,
      13,  8, 10,  1,  3, 15,  4,  2, 11,  6,  7, 12,  0,  5, 14,  9),
     (10,  0,  9, 14,  6,  3, 15,  5,  1, 13, 12,  7, 11,  4,  2,  8,
      13,  7,  0,  9,  3,  4,  6, 10,  2,  8,  5, 14, 12, 11, 15,  1,
      13,  6,  4,  9,  8, 15,  3,  0, 11,  1,  2, 12,  5, 10, 14,  7,
       1, 10, 13,  0,  6,  9,  8,  7,  4, 15, 14,  3, 11,  5,  2, 12),
     ( 7, 13, 14,  3,  0,  6,  9, 10,  1,  2,  8,  5, 11, 12,  4, 15,
      13,  8, 11,  5,  6, 15,  0,  3,  4,  7,  2, 12,  1, 10, 14,  9,
      10,  6,  9,  0, 12, 11,  7, 13, 15,  1,  3, 14,  5,  2,  8,  4,
       3, 15,  0,  6, 10,  1, 13,  8,  9,  4,  5, 11, 12,  7,  2, 14),
     ( 2, 12,  4,  1,  7, 10, 11,  6,  8,  5,  3, 15, 13,  0, 14,  9,
      14, 11,  2, 12,  4,  7, 13,  1,  5,  0, 15, 10,  3,  9,  8,  6,
       4,  2,  1, 11, 10, 13,  7,  8, 15,  9, 12,  5,  6,  3,  0, 14,
      11,  8, 12,  7,  1, 14,  2, 13,  6, 15,  0,  9, 10,  4,  5,  3),
     (12,  1, 10, 15,  9,  2,  6,  8,  0, 13,  3,  4, 14,  7,  5, 11,
      10, 15,  4,  2,  7, 12,  9,  5,  6,  1, 13, 14,  0, 11,  3,  8,
       9, 14, 15,  5,  2,  8, 12,  3,  7,  0,  4, 10,  1, 13, 11,  6,
       4,  3,  2, 12,  9,  5, 15, 10, 11, 14,  1,  7,  6,  0,  8, 13),
     ( 4, 11,  2, 14, 15,  0,  8, 13,  3, 12,  9,  7,  5, 10,  6,  1,
      13,  0, 11,  7,  4,  9,  1, 10, 14,  3,  5, 12,  2, 15,  8,  6,
       1,  4, 11, 13, 12,  3,  7, 14, 10, 15,  6,  8,  0,  5,  9,  2,
       6, 11, 13,  8,  1,  4, 10,  7,  9,  5,  0, 15, 14,  2,  3, 12),
     (13,  2,  8,  4,  6, 15, 11,  1, 10,  9,  3, 14,  5,  0, 12,  7,
       1, 15, 13,  8, 10,  3,  7,  4, 12,  5,  6, 11,  0, 14,  9,  2,
       7, 11,  4,  1,  9, 12, 14,  2,  0,  6, 10, 13, 15,  3,  5,  8,
       2,  1, 14,  7,  4, 10,  8, 13, 15, 12,  9,  0,  3,  5,  6,  11));

  RotateArray: array[0..15] of Byte = (1, 1, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 1);

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

// DES routines
function GetBit(var Data: array of Byte; BitIndex: Byte): Byte;
begin
  Result := Byte(Data[BitIndex div 8] and ($80 shr (BitIndex mod 8)) > 0);
end;

procedure SetBit(var Data: array of Byte; BitIndex, BitValue: Byte);
var
  BitMask, SaveByte: Byte;

begin
  BitMask := $80 shr (BitIndex mod 8);
  SaveByte := Data[BitIndex div 8];

  if BitValue = 0 then SaveByte := SaveByte and (not BitMask)
  else SaveByte := SaveByte or BitMask;

  Data[BitIndex div 8] := SaveByte;
end;

procedure Transpose(var Data: array of Byte; const OrderData: array of Byte);
var
  TmpData: array[0..63] of Byte;
  i: Byte;

begin
  StrMove(@TmpData, @Data, SizeOf(Data));
  for i := 0 to High(OrderData) do
    Data[i] := TmpData[OrderData[i]];
end;

procedure Rotate(var KeyBits: array of Byte);
var
  BitL, BitH: Byte;

begin
  BitL := KeyBits[0];
  BitH := KeyBits[28];
  StrMove(@KeyBits, @KeyBits[1], SizeOf(KeyBits) - 1);
  KeyBits[27] := BitL;
  KeyBits[55] := BitH;
end;

procedure GetBoxes(var RoundKey, Bits: array of Byte; LastRound: Boolean);
var
  KeyBitsX: array[0..47] of Byte;
  HalfBits: array[0..31] of Byte;
  i, j, b: Byte;

begin
  for i := 0 to High(RoundKey) do
    KeyBitsX[i] := Bits[E[i] + 32] xor RoundKey[i];

  for i := 0 to 7 do
  begin
    j := i * 6;
    j := KeyBitsX[j] * 32 + KeyBitsX[j + 1] * 8 + KeyBitsX[j + 2] * 4 + KeyBitsX[j + 3] *  2 +
      KeyBitsX[j + 4] + KeyBitsX[j + 5] * 16;

    b := Boxes[i][j];
    j := i * 4;
    HalfBits[j] := b shr 3 and 1;
    HalfBits[j + 1] := b shr 2 and 1;
    HalfBits[j + 2] := b shr 1 and 1;
    HalfBits[j + 3] := b and 1;
  end;

  for i := 0 to High(P) do
  begin
    b := HalfBits[P[i]] xor Bits[i];

    if LastRound then
      Bits[i] := b
    else
    begin
      Bits[i] := Bits[i + 32];
      Bits[i + 32] := b;
    end;
  end;
end;

procedure CryptDES(var Bits: array of Byte; var RoundKeys: TRoundKeys; EncryptFlag: Boolean);
var
  i, j: Byte;

begin
  Transpose(Bits, IP);

  for i := 0 to High(RoundKeys) do
  begin
    if EncryptFlag then j := i else j := 15 - i;
    GetBoxes(RoundKeys[j], Bits, i = High(RoundKeys));
  end;

  Transpose(Bits, InvIP);
end;

procedure MakeRoundKey(Round: Byte; var RoundKey, KeyBits: array of Byte);
var
  i: Byte;

begin
  for i := 1 to Round do Rotate(KeyBits);

  for i := 0 to High(PC_2) do
    RoundKey[i] := KeyBits[PC_2[i]];
end;

procedure MakeKeys(var KeyStr: string; KeyLen: Integer; var RoundKeys: TRoundKeys);
var
  KeyBytes: array[0..7] of Byte;
  KeyBits: array[0..55] of Byte;
  Len, i: Byte;

begin
  { Make Key }
  if KeyLen < SizeOf(KeyBytes) then Len := KeyLen else Len := SizeOf(KeyBytes);
  FillChar(KeyBytes, SizeOf(KeyBytes), #0);
  { Make Key bytes array }
  StrMove(@KeyBytes, PChar(KeyStr), Len);

  { Make Key bits array }
  for i := Low(KeyBits) to High(KeyBits) do
    KeyBits[i] := GetBit(KeyBytes, PC_1[i]);

  for i := Low(RoundKeys) to High(RoundKeys) do
    MakeRoundKey(RotateArray[i], RoundKeys[i], KeyBits);
end;

procedure BytesToBits(var Bytes, Bits: array of Byte);
var
  i, j, b: Byte;

begin
  { Split 8 bytes array into 64 bits array }
  for i := 0 to 7 do
  begin
    b := Bytes[i];
    for j := 0 to 7 do
      Bits[i * 8 + j] := b shr (7 - j) and 1;
  end;
end;

procedure BitsToBytes(var Bytes, Bits: array of Byte);
var
  i, j, b: Byte;

begin
  { Construct 8 bytes array from 64 bits array }
  for i := 0 to 7 do
  begin
    for j := 0 to 7 do
      b := Byte(b shl 1) or Bits[i * 8 + j];
    Bytes[i] := b;
  end;
end;

function ExecuteDES(EncryptionFlag: Boolean; var KeyStr, InputStr, OutputStr: string;
  KeyLen, InputLen, MaxOutputLen: Integer): Integer;
var
  Bits: array[0..63] of Byte;
  Bytes: array[0..7] of Byte;
  RoundKeys: TRoundKeys;
  ModLen, DivLen, Len, i: integer;

begin
  Result := 0; { Insufficient space }
  DivLen := ((InputLen + SizeOf(Bytes) - 1) div SizeOf(Bytes)) - 1;
  ModLen := InputLen mod SizeOf(Bytes);

  if MaxOutputLen >= DivLen * SizeOf(Bytes) then
  begin
    MakeKeys(KeyStr, KeyLen, RoundKeys);

    Len := SizeOf(Bytes);
    for i := 0 to DivLen do
    begin
      if (i = DivLen) and (ModLen > 0) then
      begin
        FillChar(Bytes, SizeOf(Bytes), #0);
        Len := ModLen;
      end;

      StrMove(@Bytes, PChar(InputStr) + i * SizeOf(Bytes), Len); { Get next 8 bytes }
      BytesToBits(Bytes, Bits);

      CryptDES(Bits, RoundKeys, EncryptionFlag);

      BitsToBytes(Bytes, Bits);
      StrMove(PChar(OutputStr) + i * SizeOf(Bytes), @Bytes, SizeOf(Bytes)); { Put next 8 bytes }
    end;

    Result := (DivLen + 1) * SizeOf(Bytes);
  end;
end;

function EncryptDES(Data, Key: string): string;
var
  KeyLen, InputLen, MaxOutputLen, RLen: Integer;

begin
  Data := IntToStr(Length(Data)) + #3 + Data;
  KeyLen := Length(Key);
  InputLen := Length(Data);
  MaxOutputLen := InputLen * 4;
  SetLength(Result, MaxOutputLen);
  RLen := ExecuteDES(True, Key, Data, Result, KeyLen, InputLen, MaxOutputLen);
  Result := Copy(Result, 1, RLen);
end;

// DES - Decryption
function DecryptDES(Data, Key: string): string;
var
  KeyLen, InputLen, MaxOutputLen, RLen: Integer;
  i: integer;

begin
  KeyLen := Length(Key);
  InputLen := Length(Data);
  MaxOutputLen := InputLen * 4;
  SetLength(Result, MaxOutputLen);
  RLen := ExecuteDES(False, Key, Data, Result, KeyLen, InputLen, MaxOutputLen);
  try
    i := StrToInt(Copy(Result, 1, Pos(#3, Result) - 1));
  except
    i := -1;
  end;
  if i < 0 then i := RLen
  else
    Result := StringReplace(Result, IntToStr(i) + #3, '', []);
  Result := Copy(Result, 1, i);
end;

end.
