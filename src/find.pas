unit find;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, StdCtrls, ExtCtrls, ComCtrls, Mask;

type
  TFindMode = (fmRegular, fmCheck, fmShowResult);
  TExtendFind = class;

  TfrmFind = class(TForm)
    Panel1: TPanel;
    GroupBox2: TGroupBox;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    btnFind: TButton;
    btnCancel: TButton;
    chbAllowRegister: TCheckBox;
    chbToExistence: TCheckBox;
    chbRegular: TCheckBox;
    pProgress: TPanel;
    ProgressBar1: TProgressBar;
    lblRate: TLabel;
    tmrStartNext: TTimer;
    cbFieldName: TComboBox;
    edsData: TComboBox;
    chbAllWords: TCheckBox;
    chbAnyWord: TCheckBox;
    Label3: TLabel;
    cbFindMode: TComboBox;
    chbSaveQuery: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure cbFieldNameChange(Sender: TObject);
    procedure edSDataChange(Sender: TObject);
    procedure chbAllowRegisterClick(Sender: TObject);
    procedure chbToExistenceClick(Sender: TObject);
    procedure chbRegularClick(Sender: TObject);
    procedure tmrStartNextTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbFieldNameKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbFieldNameKeyPress(Sender: TObject; var Key: Char);
    procedure chbAnyWordClick(Sender: TObject);
    procedure chbAllWordsClick(Sender: TObject);
    procedure cbFindModeChange(Sender: TObject);
    procedure chbSaveQueryClick(Sender: TObject);
  private
    FExFinder: TExtendFind;
    FProcessed: boolean;
    Creating: boolean;
    procedure SetFindState(ToFind: boolean);
    function CheckButtonsState: boolean;
    procedure UpdateFindHistory;
  public
    FindResult: boolean;
    constructor CreateEx(AOwner: TComponent; AExFinder: TExtendFind); virtual;
  end;

  TExtendFind = class(TObject)
  private
    {общие поля}
    FNext: boolean;
    _SdataSet: boolean;
    FSDataSet: TDataSet;
    FSFieldName: string;
    FSData: string;
    FFormFind: TfrmFind;
    FFieldsList: TStringList;
    FDefFieldName: string;
    FDefFieldLabel: string;
    FDefSearchStr: string;
    FFindValues: TStringList;
    FKeyFieldName: string;
    {текущее состояние датасета}
    CurrentBookmark: TBookmark;
//    CurrentFilter: string;
//    CurrFiltered: boolean;
    {опции поиска}
    FAllowRegister: boolean;
    FToExistence: boolean;
    FRegular: boolean;
    FAnyWord: boolean;
    FAllWords: boolean;
    FFindMode: TFindMode;
    FSaveQuery: boolean;
    rNum: integer;
    procedure SetSDataSet(NDataSet: TDataSet);
    procedure SetSFieldName(NValue: string);
    procedure SetSData(NValue: string);
    procedure SetDefField(Value: string);
    procedure SetDefSearchStr(Value: string);
    function GetDefFieldIndex: integer;
    function PrepareFind: boolean;
    function StartFind: boolean;
  public
    constructor Create;
    destructor Destroy; override;
    // процедуры для установки параметров вместе с контролами. НЕ ДЛЯ PROPERTY!!!
    procedure SetFindMode(Value: TFindMode);
    procedure SetAllowRegister(Value: boolean);
    procedure SetToExistence(Value: boolean);
    procedure SetRegular(Value: boolean);
    procedure SetAnyWord(Value: boolean);
    procedure SetAllWords(Value: boolean);
    procedure SetSaveQuery(Value: boolean);
    //
    {методы}
    function GoFind: boolean;
    procedure BreakFind;
    {свойства}
    property Next: boolean read FNext write FNext;
    property SDataSet: TDataSet read FSDataSet write SetSDataSet;
    property SFieldName: string read FSFieldName write SetSFieldName;
    property SData: string read FSData write SetSData;
    property AllowRegister: boolean read FAllowRegister write FAllowRegister;
    property ToExistence: boolean read FToExistence write FToExistence;
    property Regular: boolean read FRegular write FRegular;
    property AnyWord: boolean read FAnyWord write FAnyWord;
    property AllWords: boolean read FAllWords write FAllWords;
    property FindMode: TFindMode read FFindMode write FFindMode;
    property DefFieldName: string read FDefFieldName write SetDefField;
    property DefFieldIndex: integer read GetDefFieldIndex;
    property DefSearchStr: string read FDefSearchStr write SetDefSearchStr;
    property CheckList: TStringList read FFindValues;
    property KeyFieldName: string read FKeyFieldName write FKeyFieldName;
    property SaveQuery: boolean read FSaveQuery write FSaveQuery;
  end;

implementation

{$R *.dfm}

{ TExtendFind }

function TExtendFind.StartFind: boolean;

  function WordsAnaliseAndSearch(finding, src: string; any: boolean): boolean;
  var
    afnd: array of string;
    flg: integer;
    i, idx, oldidx: integer;

  begin
    result := false;
    oldidx := 1;
    flg := 0;
    SetLength(afnd, 0);
    finding := Trim(finding);
    src := Trim(src);

    //разобьем строку поиска на отдельные слова
    for idx := 1 to Length(finding) do
    begin
      if (Copy(finding, idx, 1) = ' ') then
      begin
        SetLength(afnd, Length(afnd) + 1);
        afnd[High(afnd)] := Copy(finding, oldidx, idx - oldidx);
        oldidx := idx + 1;
      end;
      if idx = Length(finding) then
      begin
        SetLength(afnd, Length(afnd) + 1);
        afnd[High(afnd)] := Copy(finding, oldidx, idx - oldidx + 1);
      end;
    end;

    //сам поиск
    for i := 0 to Length(afnd) - 1 do
      if Pos(afnd[i], src) > 0 then
        if any then
        begin
          result := true;
          exit;
        end else
          flg := flg + 1;
    if (flg = Length(afnd)) and (Length(afnd) > 0) then result := true;
  end;

var
  asc: TDataSetNotifyEvent;
  rCount: integer;
  _Fix: integer;
  strSource, strFinding: string;
  b: boolean;
  oldFM: TFindMode;
  
begin
  result := false;
  if not Assigned(FFormFind) then exit;
  b := false;
  FFormFind.FProcessed := true;
  SDataSet.DisableControls;
  asc := SDataSet.AfterScroll;
  SDataSet.AfterScroll := nil;
  CurrentBookmark := SDataSet.GetBookmark;
  if AllowRegister then strFinding := Trim(StringReplace(SData, '*', ' ', [rfReplaceAll]))
  else strFinding := AnsiUpperCase(Trim(StringReplace(SData, '*', ' ', [rfReplaceAll])));
  rCount := SDataSet.RecordCount;
  oldFM := FindMode;
  CheckList.Clear;
  if Next then FindMode := fmRegular;
  if FindMode <> fmRegular then
  begin
    Next := false;
    SDataSet.First;
    if (KeyFieldName = '') or (not Assigned(SDataSet.FieldByName(KeyFieldName))) then
      KeyFieldName := SFieldName;
  end;
  if Next then SDataSet.Next;
  if (SDataSet.Eof) then SDataSet.First;
  _fix := SDataSet.RecNo - 1;
  if _fix < 1 then _Fix := SDataSet.RecordCount;
  try
    while not SDataSet.Eof do
    begin
      rNum := SDataSet.RecNo;
      FFormFind.ProgressBar1.Position := Round((rNum / rCount) * 100);
      FFormFind.lblRate.Caption := IntToStr(FFormFind.ProgressBar1.Position) + '%';
      Application.ProcessMessages;
      if not FFormFind.FProcessed then
      begin
        result := false;
        break;
      end;
      if AllowRegister then strSource := Trim(SDataSet.FieldByName(SFieldName).AsString)
      else strSource := AnsiUpperCase(Trim(SDataSet.FieldByName(SFieldName).AsString));
      if ToExistence then
        if Pos(strFinding, strSource) > 0 then
        begin
          result := true;
          if FindMode = fmRegular then break
          else CheckList.Add(SDataSet.FieldByName(KeyFieldName).AsString);
        end else
        begin
          if AnyWord then
            if WordsAnaliseAndSearch(strFinding, strSource, true) then
            begin
              result := true;
              if FindMode = fmRegular then break
              else CheckList.Add(SDataSet.FieldByName(KeyFieldName).AsString);
            end;
          if AllWords then
            if WordsAnaliseAndSearch(strFinding, strSource, false) then
            begin
              result := true;
              if FindMode = fmRegular then break
              else CheckList.Add(SDataSet.FieldByName(KeyFieldName).AsString);
            end;
        end
      else
        if strSource = strFinding then
        begin
          result := true;
          if FindMode = fmRegular then break
          else CheckList.Add(SDataSet.FieldByName(KeyFieldName).AsString);
        end;
      if rNum = _Fix then
      begin
        result := result or false;
        break;
      end;
      SDataSet.Next;
      if (FindMode = fmRegular) and Regular and (not b) then
        if SDataSet.Eof then
        begin
          b := true;
          SDataSet.First;
        end;
    end;
  finally
    SDataSet.EnableControls;
    SDataSet.AfterScroll := asc;
    if result then
      case FindMode of
        fmRegular: CurrentBookmark := SDataSet.GetBookmark;
        fmCheck, fmShowResult: if SDataSet.BookmarkValid(CurrentBookmark) then SDataSet.GotoBookmark(CurrentBookmark);
      end
    else
    begin
{      if Full then
      begin
        FSDataSet.Filter := CurrentFilter;
        FSDataSet.Filtered := CurrFiltered; }
      if SDataSet.BookmarkValid(CurrentBookmark) then SDataSet.GotoBookmark(CurrentBookmark);
//      end;
    end;
    FindMode := oldFM;
    if Assigned(SDataSet.AfterScroll) then SDataSet.AfterScroll(SDataSet);
    FFormFind.FProcessed := false;
  end;
end;

procedure TExtendFind.BreakFind;
begin
  FFormFind.FProcessed := false;
end;

constructor TExtendFind.Create;
begin
  inherited Create;
  FFindValues := TStringList.Create;
  FNext := false;
  FFormFind := TfrmFind.CreateEx(nil, Self);
  FFormFind.Creating := true;
  FFieldsList := TStringList.Create;
  SetAllowRegister(false);
  SetRegular(true);
  SetAllWords(false);
  SetAnyWord(false);
  SetToExistence(true);
  SetFindMode(fmRegular);
  SetSaveQuery(false);
  FFormFind.Creating := false;
end;

destructor TExtendFind.Destroy;
begin
  FFormFind.Free;
  FFindValues.Free;
  if Assigned(FSDataSet) then
  begin
    //if Assigned(CurrentBookmark) then FSDataSet.FreeBookmark(CurrentBookmark);
    FSDataSet := nil;
  end;
  if Assigned(FFieldsList) then FFieldsList.Free;
  inherited;
end;

function TExtendFind.GoFind: boolean;
begin
  if not Assigned(FSDataSet) then
    raise Exception.Create('Ошибка инициализации процесса поиска: отсутствует набор данных для поиска');
  if not _SdataSet then FNext := false;
  if not Next then
  begin
    if not PrepareFind then
    begin
      Application.MessageBox('Модуль поиска не готов к работе!', 'Ошибка', MB_OK + MB_ICONWARNING);
      exit;
    end;
  end;
  FFormFind.ShowModal;
  result := FFormFind.FindResult;
end;

function TExtendFind.PrepareFind: boolean;
begin
  result := false;
  try
    //обнуляем параметры
    rNum := 0;
    SFieldName := '';
    SData := '';
    FFormFind.edSData.Text := '';
{    CurrentFilter := FSDataSet.Filter;
    CurrFiltered := FSDataSet.Filtered; }
    DefFieldName := FDefFieldName;
    if DefFieldIndex > -1 then
    begin
      FFormFind.cbFieldName.ItemIndex := DefFieldIndex;
      FFormFind.cbFieldNameChange(FFormFind);
    end;
    FFormFind.edsData.Text := DefSearchStr;
    FFormFind.edSDataChange(FFormFind);
  except
    on e: exception do
      raise Exception.Create('Ошибка при подготовке процесса поиска:' + #13 + e.Message);
  end;
  result := true;
end;

procedure TExtendFind.SetSFieldName(NValue: string);
begin
  FSFieldName := trim(AnsiUpperCase(NValue));
end;

procedure TExtendFind.SetToExistence(Value: boolean);
begin
  FToExistence := Value;
  FFormFind.chbToExistence.Checked := FToExistence;
end;

procedure TExtendFind.SetSaveQuery(Value: boolean);
begin
  FSaveQuery := Value;
  FFormFind.chbSaveQuery.Checked := FSaveQuery;
end;

procedure TExtendFind.SetSData(NValue: string);
begin
  FSData := NValue;
end;

procedure TExtendFind.SetSDataSet(NDataSet: TDataSet);
var
  i: integer;

begin
  if not Assigned(FSDataSet) or (NDataSet = FSDataSet) then
    _SdataSet := true
  else
    _SdataSet := false;

  FSDataSet := NDataSet;
  FFormFind.cbFieldName.Items.Clear;

  for i := 0 to SDataSet.FieldCount - 1 do
  begin
    if SDataSet.Fields.Fields[i].Visible then
    begin
      FFieldsList.Add(SDataSet.Fields.Fields[i].DisplayName + '=' +
        AnsiUpperCase(SDataSet.Fields.Fields[i].FieldName));
      FFormFind.cbFieldName.Items.Add(SDataSet.Fields.Fields[i].DisplayName);
    end;
  end;
end;

function TExtendFind.GetDefFieldIndex: integer;
begin
  if FDefFieldLabel = '' then
    result := -1
  else
    result := FFormFind.cbFieldName.Items.IndexOf(FDefFieldLabel);
end;

procedure TExtendFind.SetAllowRegister(Value: boolean);
begin
  FAllowRegister := Value;
  FFormFind.chbAllowRegister.Checked := FAllowRegister;
end;

procedure TExtendFind.SetAllWords(Value: boolean);
begin
  FAllWords := Value;
  FFormFind.chbAllWords.Checked := FAllWords;
end;

procedure TExtendFind.SetAnyWord(Value: boolean);
begin
  FAnyWord := Value;
  FFormFind.chbAnyWord.Checked := FAnyWord;
end;

procedure TExtendFind.SetDefField(Value: string);
var
  i: integer;

begin
  FDefFieldLabel := '';
  for i := 0 to FFieldsList.Count - 1 do
    if UpperCase(FFieldsList.Values[FFieldsList.Names[i]]) = UpperCase(Value) then
    begin
      FDefFieldLabel := FFieldsList.Names[i];
      break;
    end;
  FDefFieldName := Value;
end;

procedure TExtendFind.SetDefSearchStr(Value: string);
begin
  FDefSearchStr := Value;
end;

procedure TExtendFind.SetFindMode(Value: TFindMode);
begin
  FFindMode := Value;
  FFormFind.cbFindMode.ItemIndex := Ord(FFindMode);
end;

procedure TExtendFind.SetRegular(Value: boolean);
begin
  FRegular := Value;
  FFormFind.chbRegular.Checked := FRegular;
end;

{ TfrmFind }

procedure TfrmFind.FormCreate(Sender: TObject);
begin
  FProcessed := false;
  //ClientHeight := 233; //для показа прогресса = 255
  lblRate.Caption := '0%';
end;

procedure TfrmFind.btnFindClick(Sender: TObject);
var
  f: boolean;

begin
  UpdateFindHistory;
  f := edsData.Focused;
  SetFindState(true);

  FindResult := FExFinder.StartFind;
  if FindResult then Self.Close
  else MessageBox(Application.Handle, 'Ничего не найдено!', 'Поиск', MB_OK + MB_ICONINFORMATION);

  SetFindState(false);
  if f then edsData.SetFocus;
end;

procedure TfrmFind.btnCancelClick(Sender: TObject);
begin
  if FProcessed then
    FProcessed := false
  else
    self.Close;
end;

procedure TfrmFind.cbFieldNameChange(Sender: TObject);
begin
  if not Creating then
  begin
    if cbFieldName.ItemIndex > -1 then
      FExFinder.SFieldName := FExFinder.FFieldsList.Values[cbFieldName.Text]
    else FExFinder.SFieldName := '';
    FExFinder.DefFieldName := FExFinder.SFieldName;
    CheckButtonsState;
  end;
end;

procedure TfrmFind.edSDataChange(Sender: TObject);
begin
  if not Creating then
  begin
    FExFinder.SData := edSData.Text;
    FExFinder.DefSearchStr := edSData.Text;
    CheckButtonsState;
  end;
end;

procedure TfrmFind.chbAllowRegisterClick(Sender: TObject);
begin
  if not Creating then
    FExFinder.AllowRegister := chbAllowRegister.Checked;
end;

procedure TfrmFind.chbToExistenceClick(Sender: TObject);
begin
  if not Creating then
    FExFinder.ToExistence := chbToExistence.Checked;
  chbAnyWord.Enabled := chbToExistence.Checked;
  chbAllWords.Enabled := chbToExistence.Checked;
end;

procedure TfrmFind.chbRegularClick(Sender: TObject);
begin
  if not Creating then
    FExFinder.Regular := chbRegular.Checked;
end;

procedure TfrmFind.chbSaveQueryClick(Sender: TObject);
begin
  if not Creating then
    FExFinder.SaveQuery := chbSaveQuery.Checked;
end;

procedure TfrmFind.SetFindState(ToFind: boolean);
begin
  if ToFind then
  begin
    if not FExFinder.Next then
    begin
      lblRate.Caption := '0%';
      ProgressBar1.Position := 0;
    end;
    //ClientHeight := 255;
    pProgress.Visible := true;
    btnFind.Enabled := false;
    btnFind.Caption := 'Продолжить';
    btnCancel.Caption := 'Прервать';
    Label1.Enabled := false;
    cbFieldName.Enabled := false;
    label2.Enabled := false;
    edSData.Enabled := false;
    chbAllowRegister.Enabled := false;
    chbRegular.Enabled := false;
    chbToExistence.Enabled := false;
    chbAllWords.Enabled := false;
    chbAnyWord.Enabled := false;
    cbFindMode.Enabled := false;
    chbSaveQuery.Enabled := false;
  end else
  begin
    pProgress.Visible := false;
    //ClientHeight := 233;
    CheckButtonsState;
    btnCancel.Caption := 'Закрыть';
    Label1.Enabled := true;
    cbFieldName.Enabled := true;
    label2.Enabled := true;
    edSData.Enabled := true;
    chbAllowRegister.Enabled := true;
    chbRegular.Enabled := true;
    chbToExistence.Enabled := true;
    chbAllWords.Enabled := chbToExistence.Checked;
    chbAnyWord.Enabled := chbToExistence.Checked;
    cbFindMode.Enabled := true;
    cbFindMode.ItemIndex := Ord(FExFinder.FindMode);
    chbSaveQuery.Enabled := true;
  end;
end;

procedure TfrmFind.tmrStartNextTimer(Sender: TObject);
begin
  tmrStartNext.Enabled := false;
  if CheckButtonsState then
    if FExFinder.Next then btnFindClick(self);
end;

procedure TfrmFind.FormShow(Sender: TObject);
begin
  FindResult := false;
  if edsData.Items.Count <= 0 then
    edsData.Style := csSimple
  else
    edsData.Style := csDropDown;
  if not FExFinder.Next then
  begin
    btnFind.Caption := 'Найти';
    if cbFieldName.Text <> '' then
      edsData.SetFocus
    else
      cbFieldName.SetFocus;
  end;
  chbRegular.Checked := FExFinder.Regular;
  chbAllowRegister.Checked := FExFinder.AllowRegister;
  chbToExistence.Checked := FExFinder.ToExistence;
  chbAllWords.Checked := FExFinder.AllWords;
  chbAnyWord.Checked := FExFinder.AnyWord;
  cbFindMode.ItemIndex := Ord(FExFinder.FindMode);
  tmrStartNext.Enabled := true;
end;

function TfrmFind.CheckButtonsState: boolean;
begin
  btnFind.Enabled := ((FExFinder.SFieldName <> '') and (FExFinder.SData <> ''));
  result := btnFind.Enabled;
end;

constructor TfrmFind.CreateEx(AOwner: TComponent; AExFinder: TExtendFind);
begin
  inherited Create(AOwner);
  FExFinder := AExFinder;
end;

procedure TfrmFind.cbFieldNameKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if cbFieldName.Text = '' then cbFieldName.ItemIndex := -1;
end;

procedure TfrmFind.cbFindModeChange(Sender: TObject);
begin
  if not Creating then
    FExFinder.FindMode := TFindMode(cbFindMode.ItemIndex);
end;

procedure TfrmFind.UpdateFindHistory;
var
  i: integer;
  str: string;
  exist: boolean;

begin
  exist := false;
  str := edsData.Text;
  for i := 0 to edsData.Items.Count - 1 do
    if edsData.Items.Strings[i] = str then
    begin
      exist := true;
      break;
    end;
  if not exist then edsData.Items.Add(str);
end;

procedure TfrmFind.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FExFinder.KeyFieldName := '';
  ModalResult := mrOK;
  Action := caHide;
end;

procedure TfrmFind.cbFieldNameKeyPress(Sender: TObject; var Key: Char);
begin
  if ord(Key) = vk_Return then
    if btnFind.Enabled then btnFind.Click;
  if ord(Key) = vk_Escape then
    if btnCancel.Enabled then btnCancel.Click;
end;

procedure TfrmFind.chbAnyWordClick(Sender: TObject);
begin
  if not Creating then
    FExFinder.AnyWord := chbAnyWord.Checked;
  if chbAnyWord.Checked and chbAllWords.Checked then
    chbAllWords.Checked := false;
end;

procedure TfrmFind.chbAllWordsClick(Sender: TObject);
begin
  if not Creating then
    FExFinder.AllWords := chbAllWords.Checked;
  if chbAnyWord.Checked and chbAllWords.Checked then
    chbAnyWord.Checked := false;
end;

end.
