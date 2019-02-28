unit utils;

interface

uses
  Windows, Forms, Messages, SysUtils, Classes, IniFiles, Registry, CryptUtils,
  MemTableDataEh, MemTableEh, db, Graphics, GridsEh, DBGridEh, Variants;

type
  TReservePolicy = (rpNone, rpOnOpen, rpOnSave);
  TCryptMetod = (cmDES, cmRC6, cmAES128, cmAES192, cmAES256);

const
  APPDATAREGSEC = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders';
  ALLAPPDATAREGKEY = 'Common AppData';
  APPDATAREGKEY = 'AppData';
  PARAMFILE = 'pstore.conf';
  DEFPARAM_PREFIX = '$$F_';
  PARAMS_DELIM = '|';
  LIST_DELIM = #4;
  DELIM_SHIELD = #3;
  DATAFILEEXT = '.db';
  TABSEP = '</t>';
  ENTERSEP = '</n>';
  // для шифрования/расшифровки
  BlockSizeRC6 = 16;

function iif(Switch: boolean; iftrue: variant; iffalse: variant): variant;
procedure LoadLabels(FromStr: string; Labels: TMemTableEh);
function SaveLabelsToStr(Labels: TMemTableEh): string;
function LoadParams{(Labels: TMemTableEh)}: boolean;
function SaveParams{(Labels: TMemTableEh)}: boolean;
procedure SetDefaultParams;
function ReadRegValue(RootKey: HKEY; Key, Param, default: string): string;
function ExtractWordEx(n: integer; s: string; WordDelims: TSysCharSet; IgnoreBlockChars: TSysCharSet): string;
function WordCountEx(s: string; WordDelims: TSysCharSet; IgnoreBlockChars: TSysCharSet): integer;
function GetAppDataDir(AllUsers: boolean): string;
function GenRandString(genrule, vlength: byte): string;
procedure TryStore(FileName, APass: string);
function LoadStoreOld(MemTable: TMemTableEh; AName, APass: string; DefLocation: boolean = true): boolean;
function LoadStore(MemTable, Labels: TMemTableEh; AName, APass: string; DefLocation: boolean = true): boolean;
function SaveStore(MemTable, Labels: TMemTableEh; AName, APass, KeyFieldName: string; CrAlg: TCryptMetod): boolean;
procedure SaveGridParams(DBGrid: TDBGridEh; FileName, Section: string);
procedure LoadGridParams(DBGrid: TDBGridEh; FileName, Section: string);
function CopyFile(SourceFile, DestFile: string; var ErrMsg: string): boolean;
function CalcCheckSum(ControlStr: string): string;
procedure CopyDataSet(dsFrom, dsTo: TMemTableEh; KeyFieldName: string);
function GetFontStyle(style: string): TFontStyles;
function FontStyleAsString(fstyle: TFontStyles): string;
function ColumnParamsAsString(Column: TColumnEh): string;
procedure SetColumnParamsFromString(Column: TColumnEh; Params: string);
function FindColumnByFieldName(DBGrid: TDBGridEh; FieldName: string): TColumnEh;
function ReadDefParam(ParamList: TStringList; Param, Default: string): string; overload;
function ReadDefParam(ParamList: TStringList; Param: string; Default: integer): integer; overload;
procedure CopyFieldParams(DBGrid: TDBGridEh);
procedure CopyDataSetFields(dsSrc, dsDest: TMemTableEh);
procedure OptimizeColWidts(DBGrid: TDBGridEh);
function GetMaxId(DataSet: TMemTableEh; KeyField: string): integer;
function GenId(CurrId: string): string;

var
  // настройки
  ParamFolder: string;
  LastUser: string;
  WLeft: integer;
  WTop: integer;
  WWidth: integer;
  WHeight: integer;
  WMaximized: boolean;
  reDescrHeight: integer;
  reDescrMinimized: boolean;
  ReservePolicy: TReservePolicy;
  CryptMetod: TCryptMetod;
  TableGroupping: boolean;
  DefGroupExpanded: boolean;
  reDescrFont: TFont;
  reDescrBgColor: TColor;
  FindMode: integer;
  FilterCaseSens: boolean;
  ClipCopyDelim: string;
  // настройки импорта
  ActionOnExists: integer;
  ImportMode: integer;
  CheckChanged: boolean;
  SaveGroup: boolean;
  CSVQuoted: boolean;
  CSVSep: string;
  CSVIncColumns: boolean;
  GuidList: TStringList;
  ShowOldControls: boolean;

implementation

type
  { *** формат базы данных. ***
    БД - это список строк стринглиста
    0 строка - список групп. формат списка:
      Каждая строка (разделитель строк #13#10, т.е. эти строки разворачиваытся в свой стринглист):
        id=NAME(Название группы)|BGCOLOR|FONTCOLOR|FONTNAME|FONTSIZE|FONTSTYLE
    1 строка - список полей базы данных, разделенных символом #4
    последующие строки - список данных, данные каждого поля разделены символом #4.

    При загрузке БД из листа, все это построчно разворачивается в строки датасета
    При сохранении в файл символы #13#10 внутри данных и разделители групп заменяются на #3,
      а при восстановлении, наоборот, восстанавливаются

    Весь этот результирующий стринглист шифруется.
    Потом в файл пишется заголовок с служебной информацией (его структура - тип TDataFileHeader),
    следом за ним пишется блок зашифрованных данных. 
  *** }

  TDataFileHeader = record
    CryptMetod: TCryptMetod;
    szTail: integer;
    RecordCount: integer;
    Checksum: string[32];
  end;

function iif(Switch: boolean; iftrue: variant; iffalse: variant): variant;
begin
  if Switch then
    result := iftrue
  else
    result := iffalse;
end;

procedure LoadLabels(FromStr: string; Labels: TMemTableEh);
var
  i, j: integer;
  sl: TStringList;
  n, s: string;

begin
  if Assigned(Labels) then
  begin
    sl := TStringList.Create;
    Labels.Close;
    Labels.CreateDataSet;
    Labels.DisableControls;
    try
      sl.Text := FromStr;
      for i := 0 to sl.Count - 1 do
      begin
        n := sl.Names[i];
        s := sl.Values[n];
        if s = '' then continue;
        Labels.Append;
        Labels.FieldByName('ID').AsString := n;
        for j := 1 to Labels.Fields.Count - 1 do
          Labels.Fields.Fields[j].AsString := ExtractWordEx(j, s, [PARAMS_DELIM], []);
        Labels.Post;
      end;
    finally
      Labels.EnableControls;
      sl.Free;
    end;
  end;
end;

function SaveLabelsToStr(Labels: TMemTableEh): string;
var
  sl: TStringList;
  s: string;
  i: integer;

begin
  if Assigned(Labels) and Labels.Active and (not Labels.IsEmpty) then
  begin
    sl := TStringList.Create;
    Labels.DisableControls;
    try
      Labels.First;
      while not Labels.Eof do
      begin
        s := '';
        for i := 1 to Labels.Fields.Count - 1 do
          s := s + StringReplace(Labels.Fields.Fields[i].AsString, PARAMS_DELIM, '', [rfReplaceAll]) + PARAMS_DELIM;
        sl.Add(Labels.FieldByName('ID').AsString + '=' + StringReplace(s, #13#10, '', [rfReplaceAll]));
        Labels.Next;
      end;
      result := sl.Text;
    finally
      sl.Free;
      Labels.EnableControls;
    end;
  end;
end;

function LoadParams{(Labels: TMemTableEh)}: boolean;
var
  f: TIniFile;
  {s: string;
  i, j: integer;
  sl: TStringList;}

begin
  result := true;
  f := TIniFile.Create(ParamFolder + PARAMFILE);
  try
    LastUser := f.ReadString('PARAMS', 'LastUser', '');
    WWidth := f.ReadInteger('PARAMS', 'Width', 900);
    WHeight := f.ReadInteger('PARAMS', 'Height', 600);
    WLeft := f.ReadInteger('PARAMS', 'Left', Round(Screen.Width / 2) - Round(WWidth / 2));
    WTop := f.ReadInteger('PARAMS', 'Top', Round(Screen.Height / 2) - Round(WHeight / 2));
    WMaximized := f.ReadBool('PARAMS', 'Maximized', false);
    reDescrHeight := f.ReadInteger('PARAMS', 'reDescrHeight', 150);
    reDescrMinimized := f.ReadBool('PARAMS', 'reDescrMinimized', true);
    ReservePolicy := TReservePolicy(f.ReadInteger('PARAMS', 'ReservePolicy', 1));
    CryptMetod := TCryptMetod(f.ReadInteger('PARAMS', 'CryptMetod', 1));
    TableGroupping := f.ReadBool('PARAMS', 'TableGroupping', true);
    DefGroupExpanded := f.ReadBool('PARAMS', 'DefGroupExpanded', false);
    reDescrFont.Name := f.ReadString('PARAMS', 'reDescrFontName', 'Tahoma');
    reDescrFont.Color := f.ReadInteger('PARAMS', 'reDescrFontColor', clNavy);
    reDescrFont.Size := f.ReadInteger('PARAMS', 'reDescrFontSize', 8);
    reDescrFont.Style := GetFontStyle(f.ReadString('PARAMS', 'reDescrFontStyle', ''));
    reDescrBgColor := f.ReadInteger('PARAMS', 'reDescrBgColor', RGB(255, 255, 165));
    FindMode := f.ReadInteger('PARAMS', 'FindMode', 0);
    FilterCaseSens := f.ReadBool('PARAMS', 'FilterCaseSens', false);
    ClipCopyDelim := f.ReadString('PARAMS', 'ClipCopyDelim', ENTERSEP);
    ActionOnExists := f.ReadInteger('IMPORT', 'ActionOnExists', 0);
    ImportMode := f.ReadInteger('IMPORT', 'ImportMode', 0);
    CheckChanged := f.ReadBool('IMPORT', 'CheckChanged', true);
    SaveGroup := f.ReadBool('IMPORT', 'SaveGroup', true);
    CSVQuoted := f.ReadBool('IMPORT', 'CSVQuoted', false);
    CSVSep := f.ReadString('IMPORT', 'CSVSep', TABSEP);
    CSVIncColumns := f.ReadBool('IMPORT', 'CSVIncColumns', false);
   { if Assigned(Labels) then
    begin
      sl := TStringList.Create;
      Labels.Close;
      Labels.CreateDataSet;
      Labels.DisableControls;
      try
        f.ReadSection('LABELS', sl);
        for i := 0 to sl.Count - 1 do
        begin
          s := f.ReadString('LABELS', sl.Strings[i], '');
          if s = '' then continue;
          Labels.Append;
          Labels.FieldByName('ID').AsString := sl.Strings[i];
          for j := 1 to Labels.Fields.Count - 1 do
            Labels.Fields.Fields[j].AsString := ExtractWordEx(j, s, [LIST_DELIM], []);
          Labels.Post;
        end;
      finally
        Labels.EnableControls;
        sl.Free;
      end;
    end; }
  except
    result := false;
    SetDefaultParams;
  end;
  f.Free;
end;

function SaveParams{(Labels: TMemTableEh)}: boolean;
var
  f: TIniFile;
 // s: string;
 // i: integer;

begin
  result := true;
  f := TIniFile.Create(ParamFolder + PARAMFILE);
  try
    f.WriteString('PARAMS', 'LastUser', LastUser);
    f.WriteInteger('PARAMS', 'Width', WWidth);
    f.WriteInteger('PARAMS', 'Height', WHeight);
    f.WriteInteger('PARAMS', 'Left', WLeft);
    f.WriteInteger('PARAMS', 'Top', WTop);
    f.WriteBool('PARAMS', 'Maximized', WMaximized);
    f.WriteInteger('PARAMS', 'reDescrHeight', reDescrHeight);
    f.WriteBool('PARAMS', 'reDescrMinimized', reDescrMinimized);
    f.WriteInteger('PARAMS', 'ReservePolicy', Ord(ReservePolicy));
    f.WriteInteger('PARAMS', 'CryptMetod', Ord(CryptMetod));
    f.WriteBool('PARAMS', 'TableGroupping', TableGroupping);
    f.WriteBool('PARAMS', 'DefGroupExpanded', DefGroupExpanded);
    f.WriteInteger('PARAMS', 'reDescrBgColor', reDescrBgColor);
    f.WriteString('PARAMS', 'reDescrFontName', reDescrFont.Name);
    f.WriteInteger('PARAMS', 'reDescrFontColor', reDescrFont.Color);
    f.WriteInteger('PARAMS', 'reDescrFontSize', reDescrFont.Size);
    f.WriteString('PARAMS', 'reDescrFontStyle', FontStyleAsString(reDescrFont.Style));
    f.WriteInteger('PARAMS', 'FindMode', FindMode);
    f.WriteBool('PARAMS', 'FilterCaseSens', FilterCaseSens);
    f.WriteString('PARAMS', 'ClipCopyDelim', ClipCopyDelim);
    f.WriteInteger('IMPORT', 'ActionOnExists', ActionOnExists);
    f.WriteInteger('IMPORT', 'ImportMode', ImportMode);
    f.WriteBool('IMPORT', 'CheckChanged', CheckChanged);
    f.WriteBool('IMPORT', 'SaveGroup', SaveGroup);
    f.WriteBool('IMPORT', 'CSVQuoted', CSVQuoted);
    f.WriteString('IMPORT', 'CSVSep', CSVSep);
    f.WriteBool('IMPORT', 'CSVIncColumns', CSVIncColumns);
    //f.EraseSection('LABELS');
   { if Assigned(Labels) and Labels.Active and (not Labels.IsEmpty) then
    begin
      Labels.DisableControls;
      try
        Labels.First;
        while not Labels.Eof do
        begin
          s := '';
          for i := 1 to Labels.Fields.Count - 1 do
            s := s + Labels.Fields.Fields[i].AsString + LIST_DELIM;
          f.WriteString('LABELS', Labels.FieldByName('ID').AsString, s);
          Labels.Next;
        end;
      finally
        Labels.EnableControls;
      end;
    end; }
  except
    result := false;
  end;
  f.Free;
end;

procedure SetDefaultParams;
begin
  LastUser := '';
  WWidth := 900;
  WHeight := 600;
  WLeft := Round(Screen.Width / 2) - Round(WWidth / 2);
  WTop := Round(Screen.Height / 2) - Round(WHeight / 2);
  WMaximized := false;
  ReservePolicy := rpOnOpen;
  CryptMetod := cmRC6;
  TableGroupping := true;
  DefGroupExpanded := false;
  reDescrMinimized := true;
  reDescrHeight := 150;
  reDescrBgColor := RGB(255, 255, 165);
  reDescrFont.Name := 'Tahoma';
  reDescrFont.Color := clNavy;
  reDescrFont.Size := 8;
  reDescrFont.Style := [];
  FindMode := 0;
  FilterCaseSens := false;
  ClipCopyDelim := ENTERSEP;
  ActionOnExists := 0;
  ImportMode := 0;
  CheckChanged := true;
  SaveGroup := true;
  CSVQuoted := false;
  CSVSep := TABSEP;
  CSVIncColumns := false;
end;

function ReadRegValue(RootKey: HKEY; Key, Param, default: string): string;
var
  reg: TRegistry;

begin
  result := default;
  reg := TRegistry.Create(KEY_READ);
  reg.RootKey := RootKey;

  try
    if reg.OpenKey(Key, False) then result := reg.ReadString(Param);
  except
  end;
  
  reg.CloseKey;
  reg.Free;
end;

function ExtractWordEx(n: integer; s: string; WordDelims: TSysCharSet; IgnoreBlockChars: TSysCharSet): string;
var
  CurrBlChar: char;
  iblock: boolean;
  i: integer;
  wn: integer;

begin
  result := '';
  iblock := false;
  CurrBlChar := #0;
  wn := 1;

  for i := 1 to Length(s) do
  begin
    if (iblock) then
    begin
      if (s[i] = CurrBlChar) then
      begin
        iblock := false;
        CurrBlChar := #0;
      end;
      if (wn = n) then result := result + s[i];
      continue;
    end;
    if (s[i] in IgnoreBlockChars) then
    begin
      iblock := true;
      CurrBlChar := s[i];
      if (wn = n) then result := result + s[i];
      continue;
    end;
    if (s[i] in WordDelims) then
    begin
      Inc(wn);
      if (wn > n) then exit;
    end else
      if (wn = n) then result := result + s[i];
  end;
end;

function WordCountEx(s: string; WordDelims: TSysCharSet; IgnoreBlockChars: TSysCharSet): integer;
var
  CurrBlChar: char;
  iblock: boolean;
  i: integer;

begin
  if (s = '') then result := 0
  else result := 1;
  iblock := false;
  CurrBlChar := #0;

  for i := 1 to Length(s) do
  begin
    if (iblock) then
    begin
      if (s[i] = CurrBlChar) then
      begin
        iblock := false;
        CurrBlChar := #0;
      end;
      continue;
    end;
    if (s[i] in IgnoreBlockChars) then
    begin
      iblock := true;
      CurrBlChar := s[i];
      continue;
    end;
    if ((s[i] in WordDelims) and (i < Length(s))) then Inc(result);
  end;
end;

function GetAppDataDir(AllUsers: boolean): string;
begin
  if AllUsers then
    result := ReadRegValue(HKEY_LOCAL_MACHINE, APPDATAREGSEC, ALLAPPDATAREGKEY, '')
  else
    result := ReadRegValue(HKEY_CURRENT_USER, APPDATAREGSEC, APPDATAREGKEY, '');

  if not DirectoryExists(result) then result := ExtractFilePath(ParamStr(0));
  if (Length(result) > 0) and (result[Length(result)] <> '\') then result := result + '\';
end;

function GenRandString(genrule, vlength: byte): string;
var
  i: integer;
  c: byte;
  symbs: set of byte;

begin
  result := '';
  symbs := [];
  if genrule > 6 then genrule := 6;

  case genrule of
    0: symbs := symbs + [48..57];                           //цифры 0..9
    1: symbs := symbs + [65..90, 97..122];                  //буквы A..Z, a..z
    2: symbs := symbs + [65..90];                           //буквы A..Z
    3: symbs := symbs + [97..122];                          //буквы a..z
    4: symbs := symbs + [48..57, 65..90];                   //цифры + буквы A..Z
    5: symbs := symbs + [48..57, 97..122];                  //цифры + буквы a..z
    6: symbs := symbs + [48..57, 65..90, 97..122];          //цифры + буквы A..Z, a..z
  end;
  if symbs = [] then exit;

  Randomize;
  for i := 1 to vlength do
  begin
    c := Random(123);
    while not (c in symbs) do c := Random(123);
    result := result + chr(c);
  end;
end;

procedure TryStore(FileName, APass: string);
var
  f: TFileStream;
  m: TStringStream;
  sl: TStringList;
  dtHeader: TDataFileHeader;

begin
  sl := TStringList.Create;
  m := TStringStream.Create('');
  try
    f := TFileStream.Create(FileName, fmOpenRead);
    try
      f.Seek(0, soFromBeginning);
      f.Read(dtHeader, SizeOf(dtHeader));
      case dtHeader.CryptMetod of
        cmDES: DecDESStream(m, f, APass);
        cmRC6: DecRC6(m, f, f.Size - SizeOf(dtHeader), APass);
        cmAES128: DecAESStream(m, f, APass, 0);
        cmAES192: DecAESStream(m, f, APass, 1);
        cmAES256: DecAESStream(m, f, APass, 2);
        else raise Exception.Create('Неверный формат файла!');
      end;

      if Trim(dtHeader.Checksum) = '' then raise Exception.Create('Неверный формат файла!');
    finally
      f.Free;
    end;
    m.Seek(0, soFromBeginning);
    sl.Text := m.ReadString(m.Size - dtHeader.szTail);

    if (dtHeader.Checksum <> CalcCheckSum(sl.Text)) then
      raise Exception.Create('Не удалось расшифровать базу данных! Неверный пароль!');
  finally
    sl.Free;
    m.Free;
  end;
end;

function LoadStoreOld(MemTable: TMemTableEh; AName, APass: string; DefLocation: boolean): boolean;
var
  f: TFileStream;
  m: TStringStream;
  sl: TStringList;
  i, j, n: integer;
  fld: TField;
  s: string;
  fname: string;
  dtHeader: TDataFileHeader;

begin
  result := false;
  MemTable.Close;
  MemTable.CreateDataSet;
  MemTable.DisableControls;
  sl := TStringList.Create;
  m := TStringStream.Create('');
  if DefLocation then fname := ParamFolder + AName + DATAFILEEXT
  else fname := AName;
  try
    f := TFileStream.Create(fname, fmOpenRead);
    try
      f.Seek(0, soFromBeginning);
      f.Read(dtHeader, SizeOf(dtHeader));
      case dtHeader.CryptMetod of
        cmDES: DecDESStream(m, f, APass);
        cmRC6: DecRC6(m, f, f.Size - SizeOf(dtHeader), APass);
        cmAES128: DecAESStream(m, f, APass, 0);
        cmAES192: DecAESStream(m, f, APass, 1);
        cmAES256: DecAESStream(m, f, APass, 2);
      end;
    finally
      f.Free;
    end;
    m.Seek(0, soFromBeginning);
    sl.Text := m.ReadString(m.Size - dtHeader.szTail);

    if (dtHeader.Checksum <> CalcCheckSum(sl.Text)) then
      raise Exception.Create('Не удалось расшифровать базу данных! Неверный пароль!');

    // загрузка полей и данных базы данных
    n := WordCountEx(sl.Strings[0], [LIST_DELIM], []);
    for i := 1 to sl.Count - 1 do
    begin
      MemTable.Append;
      for j := 1 to n do
      begin
        s := StringReplace(ExtractWordEx(j, sl.Strings[0], [LIST_DELIM], []), DELIM_SHIELD,
          #13#10, [rfReplaceAll]);
        fld := MemTable.FindField(s);
        if not Assigned(fld) then
          raise Exception.Create('Неверная структура базы данных! Поле <' + s + '> не найдено!');

        fld.AsString := StringReplace(ExtractWordEx(j, sl.Strings[i], [LIST_DELIM], []), DELIM_SHIELD,
          #13#10, [rfReplaceAll]);
        if (fld.FieldName = 'GUID') then fld.AsString := GenId(fld.AsString);
      end;
      // ??? зачем это? MemTable.FieldByName('GUID').AsString := GenId(MemTable.FieldByName('GUID').AsString);
      MemTable.Post;
    end;
    if (dtHeader.RecordCount <> MemTable.RecordCount) then
      raise Exception.Create('База данных восстановлена не полностью! Исходное кол-во записей: ' +
        IntToStr(dtHeader.RecordCount) + ', восстановлено: ' + IntToStr(MemTable.RecordCount));
        
    result := true;
  finally
    MemTable.EnableControls;
    if not result then MemTable.Close;
    sl.Free;
    m.Free;

    if result and (ReservePolicy = rpOnOpen) and FileExists(fname) and (not CopyFile(fname, fname + '.bak', s)) then
      Application.MessageBox(pchar('Не удалось создать резервную копию файла базы данных <' + fname +
        '.bak>!'), 'Предупреждение', MB_OK + MB_ICONWARNING);
  end;
end;

function LoadStore(MemTable, Labels: TMemTableEh; AName, APass: string; DefLocation: boolean): boolean;
var
  f: TFileStream;
  m: TStringStream;
  sl: TStringList;
  i, j, n: integer;
  fld: TField;
  s: string;
  fname: string;
  dtHeader: TDataFileHeader;

begin
  result := false;
  Labels.Close;
  Labels.CreateDataSet;
  MemTable.Close;
  MemTable.CreateDataSet;
  MemTable.DisableControls;
  sl := TStringList.Create;
  m := TStringStream.Create('');
  if DefLocation then fname := ParamFolder + AName + DATAFILEEXT
  else fname := AName;
  try
    f := TFileStream.Create(fname, fmOpenRead);
    try
      f.Seek(0, soFromBeginning);
      f.Read(dtHeader, SizeOf(dtHeader));
      case dtHeader.CryptMetod of
        cmDES: DecDESStream(m, f, APass);
        cmRC6: DecRC6(m, f, f.Size - SizeOf(dtHeader), APass);
        cmAES128: DecAESStream(m, f, APass, 0);
        cmAES192: DecAESStream(m, f, APass, 1);
        cmAES256: DecAESStream(m, f, APass, 2);
      end;
    finally
      f.Free;
    end;
    m.Seek(0, soFromBeginning);
    sl.Text := m.ReadString(m.Size - dtHeader.szTail);

    if (dtHeader.Checksum <> CalcCheckSum(sl.Text)) then
      raise Exception.Create('Не удалось расшифровать базу данных! Неверный пароль!');

    // загрузка групп
    LoadLabels(StringReplace(sl.Strings[0], DELIM_SHIELD, #13#10, [rfReplaceAll]), Labels);

    // загрузка полей и данных базы данных
    n := WordCountEx(sl.Strings[1], [LIST_DELIM], []);
    for i := 2 to sl.Count - 1 do
    begin
      MemTable.Append;
      for j := 1 to n do
      begin
        s := StringReplace(ExtractWordEx(j, sl.Strings[1], [LIST_DELIM], []), DELIM_SHIELD,
          #13#10, [rfReplaceAll]);
        fld := MemTable.FindField(s);
        if not Assigned(fld) then
          raise Exception.Create('Неверная структура базы данных! Поле <' + s + '> не найдено!');

        fld.AsString := StringReplace(ExtractWordEx(j, sl.Strings[i], [LIST_DELIM], []), DELIM_SHIELD,
          #13#10, [rfReplaceAll]);
        if (fld.FieldName = 'GUID') then fld.AsString := GenId(fld.AsString);
      end;
      // ??? зачем это? MemTable.FieldByName('GUID').AsString := GenId(MemTable.FieldByName('GUID').AsString);
      MemTable.Post;
    end;
    if (dtHeader.RecordCount <> MemTable.RecordCount) then
      raise Exception.Create('База данных восстановлена не полностью! Исходное кол-во записей: ' +
        IntToStr(dtHeader.RecordCount) + ', восстановлено: ' + IntToStr(MemTable.RecordCount));

    result := true;
  finally
    MemTable.EnableControls;
    if not result then MemTable.Close;
    sl.Free;
    m.Free;

    if result and (ReservePolicy = rpOnOpen) and FileExists(fname) and (not CopyFile(fname, fname + '.bak', s)) then
      Application.MessageBox(pchar('Не удалось создать резервную копию файла базы данных <' + fname +
        '.bak>!'), 'Предупреждение', MB_OK + MB_ICONWARNING);
  end;
end;

function SaveStore(MemTable, Labels: TMemTableEh; AName, APass, KeyFieldName: string; CrAlg: TCryptMetod): boolean;
var
  f: TFileStream;
  m: TMemoryStream;
  sl: TStringList;
  i: integer;
  s: string;
  fname: string;
  dtHeader: TDataFileHeader;
  b: byte;
  id: variant;

begin
  result := false;
  sl := TStringList.Create;
  m := TMemoryStream.Create;
  try
    fname := ParamFolder + AName + DATAFILEEXT;
    if (ReservePolicy = rpOnSave) and FileExists(fname) and (not CopyFile(fname, fname + '.bak', s)) then
      if Application.MessageBox(pchar('Не удалось создать резервную копию файла базы данных <' + fname +
        '.bak>! Всеравно сохранить?'), 'Предупреждение', MB_YESNO + MB_ICONWARNING) <> ID_YES then exit;

    // сначала список групп
    sl.Add(StringReplace(SaveLabelsToStr(Labels), #13#10, DELIM_SHIELD, [rfReplaceAll]));

    // теперь список колонок самой базы данных
    for i := 0 to MemTable.Fields.Count - 1 do
      s := s + StringReplace(MemTable.Fields.Fields[i].FieldName, #13#10, DELIM_SHIELD, [rfReplaceAll]) +
        LIST_DELIM;
    sl.Add(s);

    // теперь данные базы данных
    if Assigned(MemTable.FindField(KeyFieldName)) then id := MemTable.FieldByName(KeyFieldName).Value;
    MemTable.DisableControls;
    MemTable.First;
    while not MemTable.Eof do
    begin
      s := '';
      for i := 0 to MemTable.Fields.Count - 1 do
        s := s + StringReplace(MemTable.Fields.Fields[i].AsString, #13#10, DELIM_SHIELD, [rfReplaceAll]) +
          LIST_DELIM;
      sl.Add(s);
      MemTable.Next;
    end;

    sl.SaveToStream(m);
    dtHeader.Checksum := CalcCheckSum(sl.Text);
    dtHeader.CryptMetod := CrAlg;
    dtHeader.szTail := 0;
    dtHeader.RecordCount := MemTable.RecordCount;
    // надо дописать случайными символами до кратной блоку шифрования длины (RC6)
    if CrAlg = cmRC6 then
    begin
      m.Seek(m.Size, soFromBeginning);
      while (m.Size mod BlockSizeRC6) <> 0 do
      begin
        Inc(dtHeader.szTail);
        b := Random(256);
        m.Write(b, SizeOf(b));
      end;
    end;

    f := TFileStream.Create(fname, fmCreate);
    try
      m.Seek(0, soFromBeginning);
      f.Write(dtHeader, SizeOf(dtHeader));
      case CrAlg of
        cmDES: EncDESStream(f, m, APass);
        cmRC6: EncRC6(f, m, m.Size, APass);
        cmAES128: EncAESStream(f, m, APass, 0);
        cmAES192: EncAESStream(f, m, APass, 1);
        cmAES256: EncAESStream(f, m, APass, 2);
      end;
    finally
      f.Free;
    end;
    result := true;
  finally
    if Assigned(MemTable.FindField(KeyFieldName)) and (not VarIsNull(id)) then
      MemTable.Locate(KeyFieldName, id, []);
    MemTable.EnableControls;
    sl.Free;
    m.Free;
  end;
end;

procedure SaveGridParams(DBGrid: TDBGridEh; FileName, Section: string);
var
  f: TIniFile;
  i: integer;

begin
  f := TIniFile.Create(FileName);

  try
    if Section = '' then raise Exception.Create('Not specified ini section!');
    f.EraseSection(Section);
    // сначала сохраним свойства грида
    f.WriteInteger(Section, 'FrozenCols', DBGrid.FrozenCols);
    f.WriteInteger(Section, 'Color', DBGrid.Color);
    f.WriteInteger(Section, 'EvenRowColor', DBGrid.EvenRowColor);
    f.WriteString(Section, 'FontName', DBGrid.Font.Name);
    f.WriteInteger(Section, 'FontColor', DBGrid.Font.Color);
    f.WriteInteger(Section, 'FontSize', DBGrid.Font.Size);
    f.WriteString(Section, 'FontStyle', FontStyleAsString(DBGrid.Font.Style));
    // теперь поехали колонки
    for i := 0 to DBGrid.Columns.Count - 1 do
      f.WriteString(Section, DBGrid.Columns[i].FieldName, ColumnParamsAsString(DBGrid.Columns[i]));
  finally
    f.Free;
  end;
end;

procedure LoadGridParams(DBGrid: TDBGridEh; FileName, Section: string);
var
  f: TIniFile;
  i: integer;
  sl: TStringList;

begin
  f := TIniFile.Create(FileName);
  sl := TStringList.Create;

  try
    if Section = '' then raise Exception.Create('Not specified ini section!');

    // сначала грузим настройки грида
    DBGrid.FrozenCols := f.ReadInteger(Section, 'FrozenCols', DBGrid.FrozenCols);
    DBGrid.Color := f.ReadInteger(Section, 'Color', DBGrid.Color);
    DBGrid.EvenRowColor := f.ReadInteger(Section, 'EvenRowColor', DBGrid.EvenRowColor);
    DBGrid.Font.Name := f.ReadString(Section, 'FontName', DBGrid.Font.Name);
    DBGrid.Font.Color := f.ReadInteger(Section, 'FontColor', DBGrid.Font.Color);
    DBGrid.Font.Size := f.ReadInteger(Section, 'FontSize', DBGrid.Font.Size);
    DBGrid.Font.Style := GetFontStyle(f.ReadString(Section, 'FontStyle', FontStyleAsString(DBGrid.Font.Style)));

    // теперь пошли колонки
    f.ReadSectionValues(Section, sl);
    for i := 0 to sl.Count - 1 do
      SetColumnParamsFromString(FindColumnByFieldName(DBGrid, sl.Names[i]), sl.Values[sl.Names[i]]);
  finally
    sl.Free;
    f.Free;
  end;
end;

function CopyFile(SourceFile, DestFile: string; var ErrMsg: string): boolean;
var
  fsrc, fdest: TFileStream;

begin
  result := False;
  if not FileExists(SourceFile) then
  begin
    ErrMsg := 'Не найден файл источник "' + SourceFile + '"!';
    exit;
  end;
  if not DirectoryExists(ExtractFileDir(DestFile)) then
  begin
    ErrMsg := 'Папка назначения "' + ExtractFileDir(DestFile) + '" не существует!';
    exit;
  end;

  try
    fsrc := TFileStream.Create(SourceFile, fmOpenRead);
    fdest := TFileStream.Create(DestFile, fmCreate);
    try
      fsrc.Seek(0, soFromBeginning);
      fdest.CopyFrom(fsrc, fsrc.Size);
      result := fdest.Size = fsrc.Size;
    finally
      if Assigned(fsrc) then fsrc.Free;
      if Assigned(fdest) then fdest.Free;
    end;
  except
    on e: Exception do
    begin
      ErrMsg := e.Message;
      result := False;
    end;
  end;
end;

function CalcCheckSum(ControlStr: string): string;
begin
  result := GetMD5HashStr(ControlStr);
end;

procedure CopyDataSet(dsFrom, dsTo: TMemTableEh; KeyFieldName: string);
var
  i: integer;
  id: variant;
  f: TField;

begin
  if (not Assigned(dsFrom)) or (not Assigned(dsTo)) then exit;

  dsTo.Close;
  dsTo.CreateDataSet;
  if (not dsFrom.Active) or dsFrom.IsEmpty then exit;

  try
    if Assigned(dsFrom.FindField(KeyFieldName)) then id := dsFrom.FieldByName(KeyFieldName).Value;
    dsFrom.DisableControls;
    dsTo.DisableControls;

    dsFrom.First;
    while not dsFrom.Eof do
    begin
      dsTo.Append;
      for i := 0 to dsFrom.Fields.Count - 1 do
      begin
        f := dsTo.FindField(dsFrom.Fields.Fields[i].FieldName);
        if not Assigned(f) then continue;
        f.Value := dsFrom.Fields.Fields[i].Value;
      end;
      dsTo.Post;
      dsFrom.Next;
    end;
  finally
    dsTo.First;
    if Assigned(dsFrom.FindField(KeyFieldName)) and (not VarIsNull(id)) then
      dsFrom.Locate(KeyFieldName, id, []);
    dsFrom.EnableControls;
    dsTo.EnableControls;
  end;
end;

function GetFontStyle(style: string): TFontStyles;
var
  i: integer;
  s: string;

begin
  result := [];
  for i := 0 to WordCountEx(style, [','], []) do
  begin
    s := LowerCase(Trim(ExtractWordEx(i, style, [','], [])));
    if (s = 'fsbold') then result := result + [fsBold];
    if (s = 'fsitalic') then result := result + [fsItalic];
    if (s = 'fsunderline') then result := result + [fsUnderline];
    if (s = 'fsstrikeout') then result := result + [fsStrikeOut];
  end;
end;

function FontStyleAsString(fstyle: TFontStyles): string;
begin
  result := '';
  if (fsBold in fstyle) then
    if (result = '') then result := 'fsBold'
    else result := result + ',fsBold';
  if (fsItalic in fstyle) then
    if (result = '') then result := 'fsItalic'
    else result := result + ',fsItalic';
  if (fsUnderline in fstyle) then
    if (result = '') then result := 'fsUnderline'
    else result := result + ',fsUnderline';
  if (fsStrikeOut in fstyle) then
    if (result = '') then result := 'fsStrikeOut'
    else result := result + ',fsStrikeOut';
end;

function ColumnParamsAsString(Column: TColumnEh): string;
begin
  if not Assigned(Column) then exit;
  result := IntToStr(Column.Index) + PARAMS_DELIM;
  result := result + iif(Column.Visible, '1', '0') + PARAMS_DELIM;
  result := result + StringReplace(Column.Title.Caption, PARAMS_DELIM, LIST_DELIM,
    [rfReplaceAll]) + PARAMS_DELIM;
  result := result + IntToStr(Ord(Column.Alignment)) + PARAMS_DELIM;
  result := result + IntToStr(Column.Width) + PARAMS_DELIM;
  result := result + IntToStr(Column.Color) + PARAMS_DELIM;
  result := result + Column.Font.Name + PARAMS_DELIM;
  result := result + IntToStr(Column.Font.Color) + PARAMS_DELIM;
  result := result + IntToStr(Column.Font.Size) + PARAMS_DELIM;
  result := result + FontStyleAsString(Column.Font.Style) + PARAMS_DELIM;
end;

procedure SetColumnParamsFromString(Column: TColumnEh; Params: string);
begin
  if (not Assigned(Column)) or (Params = '') then exit;
  try
    Column.Index := StrToInt(ExtractWordEx(1, Params, [PARAMS_DELIM], []));
    Column.Visible := iif(ExtractWordEx(2, Params, [PARAMS_DELIM], []) = '1', True, False);
    Column.Title.Caption := StringReplace(ExtractWordEx(3, Params, [PARAMS_DELIM], []), LIST_DELIM,
      PARAMS_DELIM, [rfReplaceAll]);
    Column.Alignment := TAlignment(StrToInt(ExtractWordEx(4, Params, [PARAMS_DELIM], [])));
    Column.Width := StrToInt(ExtractWordEx(5, Params, [PARAMS_DELIM], []));
    Column.Color := StrToInt(ExtractWordEx(6, Params, [PARAMS_DELIM], []));
    Column.Font.Name := ExtractWordEx(7, Params, [PARAMS_DELIM], []);
    Column.Font.Color := StrToInt(ExtractWordEx(8, Params, [PARAMS_DELIM], []));
    Column.Font.Size := StrToInt(ExtractWordEx(9, Params, [PARAMS_DELIM], []));
    Column.Font.Style := GetFontStyle(ExtractWordEx(10, Params, [PARAMS_DELIM], []));
  except
    // можно оставить как есть
  end;
end;

function FindColumnByFieldName(DBGrid: TDBGridEh; FieldName: string): TColumnEh;
var
  i: integer;

begin
  for i := 0 to DBGrid.Columns.Count - 1 do
  begin
    result := DBGrid.Columns[i];
    if AnsiUpperCase(result.FieldName) = AnsiUpperCase(FieldName) then exit;
  end;
  result := nil;
end;

function ReadDefParam(ParamList: TStringList; Param, Default: string): string; overload;
begin
  if ParamList.IndexOfName(Param) = -1 then result := Default
  else result := ParamList.Values[Param];
end;

function ReadDefParam(ParamList: TStringList; Param: string; Default: integer): integer; overload;
begin
  if ParamList.IndexOfName(Param) = -1 then result := Default
  else
    try
      result := StrToInt(ParamList.Values[Param]);
    except
      result := Default;
    end;
end;

procedure CopyFieldParams(DBGrid: TDBGridEh);
var
  i: integer;

begin
  for i := 0 to DBGrid.Columns.Count - 1 do
  begin
    DBGrid.Columns[i].Field.DisplayLabel := DBGrid.Columns[i].Title.Caption;
    DBGrid.Columns[i].Field.Visible := DBGrid.Columns[i].Visible;
  end;
end;

procedure CopyDataSetFields(dsSrc, dsDest: TMemTableEh); overload;
var
  i: integer;
  fld: TFieldDef;
  f: TField;

begin
  if (not Assigned(dsSrc)) or (not Assigned(dsDest)) then exit;
  dsDest.Close;
  dsDest.FieldDefs.Clear;
  dsDest.Fields.Clear;
  dsDest.FieldDefs.Update;
  for i := 0 to dsSrc.Fields.Count - 1 do
  begin
    if dsSrc.Fields.Fields[i].Lookup {or (not dsSrc.Fields.Fields[i].Visible)} then continue;
    fld := dsDest.FieldDefs.AddFieldDef;
    //fld.Name := dsSrc.Fields.Fields[i].FieldName;
    fld.DataType := dsSrc.Fields.Fields[i].DataType;
    fld.Size := dsSrc.Fields.Fields[i].Size;
    fld.Required := dsSrc.Fields.Fields[i].Required;
    fld.DisplayName := dsSrc.Fields.Fields[i].DisplayName;
    f := fld.CreateField(dsDest);
    f.FieldName := dsSrc.Fields.Fields[i].FieldName;
    f.DisplayLabel := dsSrc.Fields.Fields[i].DisplayLabel;
    f.Visible := dsSrc.Fields.Fields[i].Visible;
  end;
  dsDest.FieldDefs.Updated := false;
end;

procedure OptimizeColWidts(DBGrid: TDBGridEh);
var
  i: integer;

begin
  if not Assigned(DBGrid) then exit;
  for i := 0 to DBGrid.Columns.Count - 1 do DBGrid.Columns.Items[i].OptimizeWidth;
end;

function GetMaxId(DataSet: TMemTableEh; KeyField: string): integer;
var
  id: integer;

begin
  result := -1;
  if (not Assigned(DataSet)) or (not DataSet.Active) or DataSet.IsEmpty or
    (not Assigned(DataSet.FindField(KeyField))) then exit;
    
  try
    id := DataSet.FieldByName(KeyField).AsInteger;
    DataSet.DisableControls;

    DataSet.First;
    while not DataSet.Eof do
    begin
      if result < DataSet.FieldByName(KeyField).AsInteger then
        result := DataSet.FieldByName(KeyField).AsInteger;
      DataSet.Next;
    end;
    result := result + 1;
  finally
    DataSet.Locate(KeyField, id, []);
    DataSet.EnableControls;
  end;
end;

function GenId(CurrId: string): string;
begin
  result := CurrId;

  if (Trim(result) = '') then
  begin
    result := GenRandString(4, 16);
    while GuidList.IndexOf(result) > -1 do result := GenRandString(4, 16);
  end;

  if GuidList.IndexOf(result) < 0 then GuidList.Add(result);
end;

initialization
  ParamFolder := GetAppDataDir(false) + ChangeFileExt(PARAMFILE, '') + '\';
  ForceDirectories(ParamFolder);
  reDescrFont := TFont.Create;
  GuidList := TStringList.Create;

finalization
  reDescrFont.Free;
  GuidList.Free;

end.
