unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, GridsEh,
  DBGridEh, ExtCtrls, MemTableDataEh, Db, ToolWin, ComCtrls, MemTableEh, ImgList, utils, connectdlg,
  inputpass, card, ActnList, params, Menus, StdCtrls, groupedit, import, ask, EhLibMTE, DBGridEhGrouping,
  gridsettings, find, filter, ToolCtrlsEh, ShellAPI, JvExExtCtrls, JvNetscapeSplitter, JvExStdCtrls,
  JvRichEdit, JvDBRichEdit, findResult, csvopen, Clipbrd;

type
  TFMain = class(TForm)
    mtStore: TMemTableEh;
    dsStore: TDataSource;
    ToolBar: TToolBar;
    mtStoreNAME: TStringField;
    mtStoreLOGIN: TStringField;
    mtStorePASS: TStringField;
    mtStorePASSPHRASE: TStringField;
    mtStoreANSWER: TStringField;
    mtStoreKEY: TStringField;
    mtStorePASS2: TStringField;
    mtStoreDESCR: TStringField;
    mtStoreURL: TStringField;
    mtStoreMAIL: TStringField;
    StatusBar: TStatusBar;
    btnOpen: TToolButton;
    btnAdd: TToolButton;
    btnDel: TToolButton;
    btnSettings: TToolButton;
    ilToolBar: TImageList;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    btnEdit: TToolButton;
    btnChangePass: TToolButton;
    btnSave: TToolButton;
    ActionList: TActionList;
    AOpen: TAction;
    AChangePass: TAction;
    ASave: TAction;
    AAdd: TAction;
    AEdit: TAction;
    ADel: TAction;
    ASettings: TAction;
    AOptimizeColWidths: TAction;
    AUndo: TAction;
    btnUndo: TToolButton;
    mtLabels: TMemTableEh;
    dsoLabels: TDataSource;
    mtLabelsID: TIntegerField;
    mtLabelsNAME: TStringField;
    mtStoreLABEL_ID: TIntegerField;
    mtStoreLABEL: TStringField;
    mtLabelsBGCOLOR: TIntegerField;
    ATableSettings: TAction;
    ToolButton4: TToolButton;
    pmGrid: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    miSetLabel: TMenuItem;
    mtStoreGUID: TStringField;
    AGroupEdit: TAction;
    ToolButton3: TToolButton;
    N6: TMenuItem;
    ACheckAll: TAction;
    AUnCheckAll: TAction;
    AInvertChecked: TAction;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    AImport: TAction;
    AFind: TAction;
    AFindNext: TAction;
    AFilter: TAction;
    AResetFilter: TAction;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    mtLabelsFONTCOLOR: TIntegerField;
    mtLabelsFONTNAME: TStringField;
    mtLabelsFONTSIZE: TIntegerField;
    mtLabelsFONTSTYLE: TStringField;
    AExpandGroups: TAction;
    ACollapseGroups: TAction;
    MainMenu1: TMainMenu;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    AExit: TAction;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    mmSetLabel: TMenuItem;
    N30: TMenuItem;
    N31: TMenuItem;
    N32: TMenuItem;
    N33: TMenuItem;
    N34: TMenuItem;
    N35: TMenuItem;
    N36: TMenuItem;
    N37: TMenuItem;
    N38: TMenuItem;
    N39: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N40: TMenuItem;
    ASwitchGroupping: TAction;
    N41: TMenuItem;
    AGotoLink: TAction;
    N46: TMenuItem;
    N47: TMenuItem;
    AMoveRecordUp: TAction;
    AMoveRecordDown: TAction;
    ToolButton5: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton18: TToolButton;
    Panel1: TPanel;
    Panel2: TPanel;
    ToolBar1: TToolBar;
    tbFont: TToolButton;
    tbColor: TToolButton;
    tbSave: TToolButton;
    JvNetscapeSplitter1: TJvNetscapeSplitter;
    dbgStore: TDBGridEh;
    FontDialog: TFontDialog;
    ColorDialog: TColorDialog;
    tbClear: TToolButton;
    ToolButton19: TToolButton;
    reDescr: TJvDBRichEdit;
    ASendMail: TAction;
    N42: TMenuItem;
    N43: TMenuItem;
    mteFindResults: TMemTableEh;
    AClose: TAction;
    N44: TMenuItem;
    ToolButton13: TToolButton;
    ADropDb: TAction;
    N45: TMenuItem;
    N48: TMenuItem;
    ToolButton20: TToolButton;
    N49: TMenuItem;
    N50: TMenuItem;
    N51: TMenuItem;
    AExportToCSV: TAction;
    CSV1: TMenuItem;
    AImportFromCSV: TAction;
    CSV2: TMenuItem;
    ARestoreDB: TAction;
    N52: TMenuItem;
    N53: TMenuItem;
    ABackupDB: TAction;
    N54: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    ACopyPassToClip: TAction;
    ACopyLoginPassToClip: TAction;
    ToolButton17: TToolButton;
    ToolButton21: TToolButton;
    ToolButton22: TToolButton;
    N55: TMenuItem;
    N56: TMenuItem;
    N57: TMenuItem;
    N58: TMenuItem;
    N59: TMenuItem;
    N60: TMenuItem;
    procedure dbgStoreDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mtStoreAfterPost(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mtStoreAfterDelete(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure AOpenExecute(Sender: TObject);
    procedure AChangePassExecute(Sender: TObject);
    procedure AChangePassUpdate(Sender: TObject);
    procedure ASaveExecute(Sender: TObject);
    procedure AAddExecute(Sender: TObject);
    procedure AEditExecute(Sender: TObject);
    procedure ADelExecute(Sender: TObject);
    procedure AOptimizeColWidthsExecute(Sender: TObject);
    procedure ASettingsExecute(Sender: TObject);
    procedure AUndoUpdate(Sender: TObject);
    procedure AUndoExecute(Sender: TObject);
    procedure dbgStoreGetCellParams(Sender: TObject; Column: TColumnEh; AFont: TFont; var Background: TColor;
      State: TGridDrawState);
    procedure ATableSettingsExecute(Sender: TObject);
    procedure miSetLabelClick(Sender: TObject);
    procedure mtStoreAfterScroll(DataSet: TDataSet);
    procedure AGroupEditUpdate(Sender: TObject);
    procedure AGroupEditExecute(Sender: TObject);
    procedure ACheckAllExecute(Sender: TObject);
    procedure AUnCheckAllExecute(Sender: TObject);
    procedure AInvertCheckedExecute(Sender: TObject);
    procedure AImportExecute(Sender: TObject);
    procedure AFindExecute(Sender: TObject);
    procedure AFilterExecute(Sender: TObject);
    procedure AFilterUpdate(Sender: TObject);
    procedure AResetFilterExecute(Sender: TObject);
    procedure AExpandGroupsExecute(Sender: TObject);
    procedure ACollapseGroupsExecute(Sender: TObject);
    procedure AExitExecute(Sender: TObject);
    procedure ASwitchGrouppingExecute(Sender: TObject);
    procedure ASwitchGrouppingUpdate(Sender: TObject);
    procedure AExpandGroupsUpdate(Sender: TObject);
    procedure AGotoLinkExecute(Sender: TObject);
    procedure AMoveRecordUpExecute(Sender: TObject);
    procedure AMoveRecordDownExecute(Sender: TObject);
    procedure AMoveRecordUpUpdate(Sender: TObject);
    procedure tbFontClick(Sender: TObject);
    procedure tbColorClick(Sender: TObject);
    procedure reDescrChange(Sender: TObject);
    procedure tbSaveClick(Sender: TObject);
    procedure tbClearClick(Sender: TObject);
    procedure StatusBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; const Rect: TRect);
    procedure ASendMailExecute(Sender: TObject);
    procedure dbgStoreApplyFilter(Sender: TObject);
    procedure mtStoreAfterClose(DataSet: TDataSet);
    procedure ACloseExecute(Sender: TObject);
    procedure ADropDbExecute(Sender: TObject);
    procedure AExportToCSVExecute(Sender: TObject);
    procedure AImportFromCSVExecute(Sender: TObject);
    procedure ARestoreDBExecute(Sender: TObject);
    procedure ABackupDBExecute(Sender: TObject);
    procedure ACopyPassToClipExecute(Sender: TObject);
  private
    DefaultGridParams: TStringList;
    FName: string;
    FPass: string;
    fChanged: boolean;
    FExFinder: TExtendFind;
    FFilter: TfFilter;
    OldFormat: boolean;
    LastFindField: string;
    LastSearchStr: string;
    procedure SetCardLabels(FCard: TFCard; DBGrid: TDBGridEh);
    procedure CopyMenuItem(Source, Dest: TMenuItem);
    procedure OpenStore(AName, APass: string);
    procedure SaveData(Silent: boolean = false);
    procedure CreateStore(AName, APass: string);
    procedure CloseStore;
    procedure SaveWndState;
    procedure LoadWndState;
    function IsActive: boolean;
    procedure CreateLabelsMenu;
    procedure GroupEdit;
    procedure KeepCurrentGridParams;
    procedure RestoreGridParams;
    procedure GridParamsDialog(DBGrid: TDBGridEh; FileName, Section: string);
    procedure Find(ANext: boolean; CurrField: string);
    procedure FilterDialog(Expression: string; ShowExPage: boolean = false);
    procedure SetChanged(Value: boolean);
    function DropDataBase(var ErrorMessage: string): boolean;
    function CreateBackup(var Err: string): boolean;
    function RestoreBackup(var Err: string): boolean;
    property DataChanged: boolean read fChanged write SetChanged;
  public
  end;

var
  FMain: TFMain;

implementation

{$R *.dfm}

procedure TFMain.AAddExecute(Sender: TObject);
var
  FCard: TFCard;

begin
  if not IsActive then exit;
           
  FCard := TFCard.Create(self);
  try
    SetCardLabels(FCard, dbgStore);
    if FCard.ShowModal = mrOk then
    begin
      mtStore.Append;
      mtStoreGUID.AsString := GenId('');
      mtStoreNAME.AsString := FCard.edName.Text;
      mtStoreLOGIN.AsString := Trim(FCard.edLogin.Text);
      mtStorePASS.AsString := Trim(FCard.edPass.Text);
      mtStorePASSPHRASE.AsString := FCard.edPassPhrase.Text;
      mtStoreANSWER.AsString := FCard.edAnswer.Text;
      mtStoreKEY.AsString := Trim(FCard.edKey.Text);
      mtStorePASS2.AsString := Trim(FCard.edPass2.Text);
      mtStoreDESCR.AsString := FCard.reDescr.Text;
      mtStoreURL.AsString := FCard.edUrl.Text;
      mtStoreMAIL.AsString := FCard.edMail.Text;
      if VarIsNull(FCard.lcbLabel.KeyValue) then mtStoreLABEL_ID.Clear
      else mtStoreLABEL_ID.AsInteger := FCard.lcbLabel.KeyValue;
      mtStore.Post;
    end;
  finally
    FCard.Free;
  end;
end;

procedure TFMain.ABackupDBExecute(Sender: TObject);
var
  err: string;

begin
  if not CreateBackup(err) then
    Application.MessageBox(pchar('Ошибка создания резервной копии!'#13#10 + err), pchar(Application.Title), MB_OK + MB_ICONERROR);
end;

procedure TFMain.AChangePassExecute(Sender: TObject);
var
  InpPass: TFInputPass;

begin
  if not IsActive then exit;

  if Application.MessageBox(pchar('Внимание! При смене пароля текущее состояние данных будет сохранено! ' +
    'Вы уверены, что нужно продолжить?'), pchar('Смена пароля'), MB_YESNO + MB_ICONWARNING) <> ID_YES then exit;

  InpPass := TFInputPass.Create(self);
  try
    if InpPass.ShowModal = mrOk then
    begin
      if Trim(InpPass.edPass.Text) <> FPass then
        raise Exception.Create('Неверный пароль!');

      if Trim(InpPass.edNewPass.Text) <> Trim(InpPass.edPass2.Text) then
        raise Exception.Create('Новый пароль и повтор пароля не совпадают!');

      FPass := Trim(InpPass.edNewPass.Text);
      SaveData(true);
      Application.MessageBox('Пароль изменен!', 'Сообщение', MB_OK + MB_ICONINFORMATION);
    end;
  finally
    InpPass.Free;
  end;
end;

procedure TFMain.AChangePassUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := IsActive;
end;

procedure TFMain.ACheckAllExecute(Sender: TObject);
begin
  dbgStore.SelectedRows.SelectAll;
end;

procedure TFMain.ACloseExecute(Sender: TObject);
begin
  if not IsActive then exit;
  if Application.MessageBox('Закрыть базу данных?', 'Подтверждение', MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

  if DataChanged then
    case Application.MessageBox('Данные были изменены! Сохранить изменения?', 'Предупреждение',
      MB_YESNOCANCEL + MB_ICONQUESTION) of
      ID_YES: SaveData(true);
      ID_NO: ;
      ID_CANCEL: exit;
    end;

  CloseStore;
end;

procedure TFMain.ACollapseGroupsExecute(Sender: TObject);
var
  i: integer;

begin
  for i := 0 to dbgStore.DataGrouping.ActiveGroupLevelsCount - 1 do
    dbgStore.DataGrouping.ActiveGroupLevels[i].CollapseNodes;
end;

procedure TFMain.ACopyPassToClipExecute(Sender: TObject);
var
  Clip: TClipboard;
  delim: string;
  
begin
  if (not IsActive) or mtStore.IsEmpty then exit;

  Clip := TClipboard.Create;
  try
    if TAction(Sender) = ACopyPassToClip then
      Clip.SetTextBuf(pchar(mtStorePASS.AsString))
    else
    begin
      if ClipCopyDelim = ENTERSEP then delim := #13#10
      else if ClipCopyDelim = TABSEP then delim := #9
      else delim := ClipCopyDelim;
      Clip.SetTextBuf(pchar(mtStoreLOGIN.AsString + delim + mtStorePASS.AsString));
    end;
  finally
    Clip.Free;
  end;
end;

procedure TFMain.ADelExecute(Sender: TObject);
var
  i: integer;
  id: string;
  id_list: TStringList;

begin
  if (not IsActive) or mtStore.IsEmpty then exit;

  if dbgStore.SelectedRows.Count <= 1 then
  begin
    if Application.MessageBox(pchar('Удалить запись "' + mtStoreNAME.AsString + '"?'), 'Подтверждение',
      MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

    mtStore.Delete;
  end else
  begin
    //if dbgStore.Selection.SelectionType <> gstRecordBookmarks then exit;
    if Application.MessageBox(pchar('Удалить ' + IntToStr(dbgStore.SelectedRows.Count) + ' отмеченных записей?'),
      'Подтверждение', MB_YESNO + MB_ICONQUESTION) <> ID_YES then exit;

    id_list := TStringList.Create;
    id := mtStoreGUID.AsString;
    mtStore.DisableControls;
    try
      for i := 0 to dbgStore.SelectedRows.Count - 1 do
        if mtStore.BookmarkValid(TBookmark(dbgStore.SelectedRows.Items[i])) then
        begin
          mtStore.GotoBookmark(TBookmark(dbgStore.SelectedRows.Items[i]));
          id_list.Add(mtStoreGUID.AsString);
        end;

      for i := 0 to id_list.Count - 1 do
        if mtStore.Locate('GUID', id_list.Strings[i], []) then mtStore.Delete;
    finally
      dbgStore.SelectedRows.Clear;
      //mtStore.Refresh;
      if not mtStore.Locate('GUID', id, []) then mtStore.First;
      mtStore.EnableControls;
    end;
  end;
end;

procedure TFMain.ADropDbExecute(Sender: TObject);
var
  s, msg, err: string;
  i: integer;

begin
  if Application.MessageBox(pchar('Вы собираетесь удалить текущую базу данных (' + FName + ')! ' +
    'Обратите внимание, что в результате этого действия будут БЕЗВОЗВРАТНО УНИЧТОЖЕНЫ ВСЕ ВАШИ ДАННЫЕ! ' +
    'Вы действительно хотите удалить текущую базу данных???'),
    'Подтверждение', MB_YESNO + MB_ICONWARNING) <> ID_YES then exit;

  if Application.MessageBox(pchar('Удаление базы данных НЕОБРАТИМО!!! Точно удалить?'),
    'Подтверждение', MB_YESNO + MB_ICONWARNING) <> ID_YES then exit;

  s := FName;
  if DropDataBase(err) then
  begin
    i := MB_ICONINFORMATION;
    if err = '' then
      msg := 'База данных <' + s + '> удалена успешно, с чем вас и поздравляю!'
    else
      msg := 'База данных <' + s + '> удалена успешно, но в процессе возникла ошибка:'#13 + err;
  end else
  begin
    i := MB_ICONERROR;
    msg := 'Не удалось удалить базу данных <' + s + '>! Произошла ошибка:'#13 + err;
  end;

  Application.MessageBox(pchar(msg), 'Сообщение', MB_OK + i);
end;

procedure TFMain.AEditExecute(Sender: TObject);
var
  FCard: TFCard;

begin
  if (not IsActive) or mtStore.IsEmpty then exit;

  FCard := TFCard.Create(self);
  FCard.edName.Text := mtStoreNAME.AsString;
  FCard.edLogin.Text := mtStoreLOGIN.AsString;
  FCard.edPass.Text := mtStorePASS.AsString;
  FCard.edPassPhrase.Text := mtStorePASSPHRASE.AsString;
  FCard.edAnswer.Text := mtStoreANSWER.AsString;
  FCard.edKey.Text := mtStoreKEY.AsString;
  FCard.edPass2.Text := mtStorePASS2.AsString;
  FCard.reDescr.Text := mtStoreDESCR.AsString;
  FCard.edUrl.Text := mtStoreURL.AsString;
  FCard.edMail.Text := mtStoreMAIL.AsString;
  if mtStoreLABEL_ID.IsNull then FCard.lcbLabel.KeyValue := Null
  else FCard.lcbLabel.KeyValue := mtStoreLABEL_ID.AsInteger;
  SetCardLabels(FCard, dbgStore);
  if FCard.ShowModal = mrOk then
  begin
    mtStore.Edit;
    mtStoreNAME.AsString := FCard.edName.Text;
    mtStoreLOGIN.AsString := Trim(FCard.edLogin.Text);
    mtStorePASS.AsString := Trim(FCard.edPass.Text);
    mtStorePASSPHRASE.AsString := FCard.edPassPhrase.Text;
    mtStoreANSWER.AsString := FCard.edAnswer.Text;
    mtStoreKEY.AsString := Trim(FCard.edKey.Text);
    mtStorePASS2.AsString := Trim(FCard.edPass2.Text);
    mtStoreDESCR.AsString := FCard.reDescr.Text;
    mtStoreURL.AsString := FCard.edUrl.Text;
    mtStoreMAIL.AsString := FCard.edMail.Text;
    if VarIsNull(FCard.lcbLabel.KeyValue) then mtStoreLABEL_ID.Clear
    else mtStoreLABEL_ID.AsInteger := FCard.lcbLabel.KeyValue;
    mtStore.Post;
  end;
end;

procedure TFMain.AExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TFMain.AExpandGroupsExecute(Sender: TObject);
var
  i: integer;

begin
  for i := 0 to dbgStore.DataGrouping.ActiveGroupLevelsCount - 1 do
    dbgStore.DataGrouping.ActiveGroupLevels[i].ExpandNodes;
end;

procedure TFMain.AExpandGroupsUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := IsActive and dbgStore.DataGrouping.Active;
end;

procedure TFMain.AExportToCSVExecute(Sender: TObject);
var
  fcsv: TFOpenCSV;
  sl: TStringList;
  i: integer;
  id, s, cs: string;

begin
  fcsv := TFOpenCSV.Create(self);
  try
    sl := TStringList.Create;

    fcsv.Caption := 'Экспорт в текст (CSV)';
    if fcsv.ShowModal = mrOk then
    begin
      CSVQuoted := fcsv.chbQuote.Checked;
      CSVSep := fcsv.cbSep.Text;
      CSVIncColumns := fcsv.chbIncColumns.Checked;
      cs := iif(CSVSep = TABSEP, #9, CSVSep);
      if FileExists(fcsv.edFile.FileName) and
        (Application.MessageBox(pchar('Файл "' + fcsv.edFile.FileName + '" уже существует. Перезаписать его?'),
          'Подтверждение', MB_YESNO + MB_ICONQUESTION) <> ID_YES) then exit;

      if CSVIncColumns then
      begin
        for i := 0 to mtStore.Fields.Count - 1 do
        begin
          if s = '' then
            s := iif(CSVQuoted, '"', '') + mtStore.Fields.Fields[i].FieldName + iif(CSVQuoted, '"', '')
          else
            s := s + cs + iif(CSVQuoted, '"', '') + mtStore.Fields.Fields[i].FieldName + iif(CSVQuoted, '"', '');
        end;
        sl.Add(s);
      end;

      id := mtStoreGUID.AsString;
      mtStore.DisableControls;
      try
        mtStore.First;
        while not mtStore.Eof do
        begin
          s := '';
          for i := 0 to mtStore.Fields.Count - 1 do
          begin
            if s = '' then
              s := iif(CSVQuoted, '"', '') + StringReplace(StringReplace(mtStore.Fields.Fields[i].AsString,
                #13#10, DELIM_SHIELD, [rfReplaceAll]), cs, LIST_DELIM, [rfReplaceAll]) +
                iif(CSVQuoted, '"', '')
            else
              s := s + cs + iif(CSVQuoted, '"', '') + StringReplace(StringReplace(mtStore.Fields.Fields[i].AsString,
                #13#10, DELIM_SHIELD, [rfReplaceAll]), cs, LIST_DELIM, [rfReplaceAll]) + iif(CSVQuoted, '"', '');
          end;

          sl.Add(s);
          mtStore.Next;
        end;
      finally
        mtStore.EnableControls;
        mtStore.Locate('GUID', mtStoreGUID.AsString, []);
      end;

      sl.SaveToFile(fcsv.edFile.FileName);
    end;
  finally
    sl.Free;
    fcsv.Free;
  end;
end;

procedure TFMain.AFilterExecute(Sender: TObject);
var
  s: string;
  f: TField;

begin
  if (not IsActive) or mtStore.IsEmpty then exit;
  f := dbgStore.SelectedField;
  if mtStore.FieldByName(f.FieldName).IsNull then
    s := f.FieldName + ' is NULL'
  else
    s := f.FieldName + ' = ''' + mtStore.FieldByName(f.FieldName).AsString + '''';

  FilterDialog(s);
end;

procedure TFMain.AFilterUpdate(Sender: TObject);
begin
  if (TAction(Sender) = AResetFilter) then
    TAction(Sender).Enabled := IsActive and mtStore.Filtered
  else
    TAction(Sender).Enabled := IsActive;

  if TAction(Sender).Enabled and (TAction(Sender) = AFilter) then
    AFilter.Checked := mtStore.Filtered;
end;

procedure TFMain.AFindExecute(Sender: TObject);
begin
  Find(TAction(Sender) = AFindNext, dbgStore.SelectedField.FieldName);
  FindMode := Ord(FExFinder.FindMode);
end;

procedure TFMain.AGotoLinkExecute(Sender: TObject);
{var
  s: string;}

begin
  if IsActive and (not mtStore.IsEmpty) and (Trim(mtStoreURL.AsString) <> '') then
  begin
    {if (Pos('http://', AnsiLowerCase(mtStoreURL.AsString)) = 0) and
      (Pos('https://', AnsiLowerCase(mtStoreURL.AsString)) = 0) and
      (Pos('ftp://', AnsiLowerCase(mtStoreURL.AsString)) = 0) then
      s := 'http://' + mtStoreURL.AsString
    else
      s := mtStoreURL.AsString;}

    ShellExecute(Handle, 'open', pchar(mtStoreURL.AsString), nil, nil, SW_SHOWNORMAL);
  end;
end;

procedure TFMain.AGroupEditExecute(Sender: TObject);
begin
  GroupEdit;
end;

procedure TFMain.AGroupEditUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := IsActive and (dbgStore.SelectedRows.Count > 1);
end;

procedure TFMain.ASwitchGrouppingExecute(Sender: TObject);
begin
  dbgStore.DataGrouping.Active := not dbgStore.DataGrouping.Active;
  dbgStore.DataGrouping.GroupPanelVisible := dbgStore.DataGrouping.Active;
end;

procedure TFMain.ASwitchGrouppingUpdate(Sender: TObject);
begin
  if dbgStore.DataGrouping.Active then
    TAction(Sender).Caption := 'Отключить группировки'
  else
    TAction(Sender).Caption := 'Включить группировки';

  TAction(Sender).Hint := TAction(Sender).Caption;
end;

procedure TFMain.AImportExecute(Sender: TObject);
var
  d: TFConnectDlg;
  ip: TFImportParams;
  iStore, iPass: string;
  iAction, iMode: integer;
  data: TMemTableEh;
  labels: TMemTableEh;
  fask: TFAsk;
  id, lid: string;
  check, keepGroup: boolean;
  sl, lbHash: TStringList;
  i, lbId: integer;

begin
  if not IsActive then exit;
  d := TFConnectDlg.Create(self);
  try
    d.Caption := 'Открыть базу данных';
    d.Label2.Caption := 'База данных';
    d.cbUser.Style := csDropDownList;
    d.SetHint := false;
    d.ImportMode := true;
    d.chbOldFormat.Checked := false;
    d.chbOldFormat.Enabled := false;
    d.lbHint.Caption := 'Укажите базу данных, из которй нужно выполнить импорт';
    if d.ShowModal = mrOk then
    begin
      iStore := d.cbUser.Text;
      if d.DefaultLocation then iStore := ParamFolder + iStore + DATAFILEEXT;
      iPass := Trim(d.edPass.Text);
    end else
      exit;
  finally
    d.Free;
  end;

  if Trim(AnsiLowerCase(iStore)) = Trim(AnsiLowerCase(FName)) then
    raise Exception.Create('Нельзя выполнять импорт базы данных в саму себя!');
  if not FileExists(iStore) then
    raise Exception.Create('Базы данных <' + iStore + '> не существует!');
  if (iPass = '') then raise Exception.Create('Пароль пустой!');

  sl := TStringList.Create;
  lbHash := TStringList.Create;
  fask := TFAsk.Create(self);
  fask.Caption := 'Предупреждение';
  ip := TFImportParams.Create(self);
  try
    if not mtStore.IsEmpty then
    begin
      mtStore.Last;
      id := mtStoreGUID.AsString;
    end;
    ip.Load(iStore, iPass);
    if ip.ShowModal = mrOk then
    begin
      check := ip.chbCheckChanged.Checked;
      keepGroup := ip.chbSaveGroup.Checked;
      iAction := ip.cbActionOnExists.ItemIndex;
      iMode := ip.cbImportMode.ItemIndex;
      data := ip.GetData;
      labels := ip.mtLabels;

      // импорт групп
      if keepGroup then
      begin
        labels.First;
        while not labels.Eof do
        begin
          // запишем соответствие id группы в старой базе и id в новой: старый id=новый id
          if mtLabels.Locate('NAME', labels.FieldByName('NAME').AsString, [loCaseInsensitive]) then
          begin
            case iAction of
              0:
              begin
                // спросить
                fask.lbMessage.Caption := 'Группа "' + labels.FieldByName('NAME').AsString + '" уже есть в ' +
                  'базе данных. Выберите, что с ней нужно сделать?';
                case fask.ShowModal of
                  mrRetry:
                  begin
                    // добавить (сделать копию)
                    if fask.chbNoAsk.Checked then iAction := 1;
                    labels.Edit;
                    labels.FieldByName('NAME').AsString := labels.FieldByName('NAME').AsString + '_' +
                      GenRandString(4, 4);
                    labels.Post;
                    lbId := GetMaxId(mtLabels, 'ID');
                    lbHash.Add(labels.FieldByName('ID').AsString + '=' + IntToStr(lbId));
                    mtLabels.Append;
                  end;
                  mrAbort:
                  begin
                    // заменить
                    if fask.chbNoAsk.Checked then iAction := 2;
                    lbId := mtLabelsID.AsInteger;
                    lbHash.Add(labels.FieldByName('ID').AsString + '=' + IntToStr(lbId));
                    mtLabels.Edit;
                  end;
                  mrIgnore:
                  begin
                    // оставить старую (пропустить)
                    if fask.chbNoAsk.Checked then iAction := 3;
                    lbHash.Add(labels.FieldByName('ID').AsString + '=' + mtLabelsID.AsString);
                    labels.Next;
                    Continue;
                  end;
                  mrCancel: exit;
                end;
              end;
              1:
              begin
                // добавить (сделать копию)
                labels.Edit;
                labels.FieldByName('NAME').AsString := labels.FieldByName('NAME').AsString + '_' +
                  GenRandString(4, 4);
                labels.Post;
                lbId := GetMaxId(mtLabels, 'ID');
                lbHash.Add(labels.FieldByName('ID').AsString + '=' + IntToStr(lbId));
                mtLabels.Append;
              end;
              2:
              begin
                // заменить
                lbId := mtLabelsID.AsInteger;
                lbHash.Add(labels.FieldByName('ID').AsString + '=' + IntToStr(lbId));
                mtLabels.Edit;
              end;
              3:
              begin
                // оставить старую (пропустить)
                lbHash.Add(labels.FieldByName('ID').AsString + '=' + mtLabelsID.AsString);
                labels.Next;
                Continue;
              end;
            end;
          end else
          begin
            lbId := GetMaxId(mtLabels, 'ID');
            lbHash.Add(labels.FieldByName('ID').AsString + '=' + IntToStr(lbId));
            mtLabels.Append;
          end;

          mtLabelsID.AsInteger := lbId;
          mtLabelsNAME.AsString := labels.FieldByName('NAME').AsString;
          mtLabelsBGCOLOR.AsInteger := labels.FieldByName('BGCOLOR').AsInteger;
          mtLabelsFONTCOLOR.AsInteger := labels.FieldByName('FONTCOLOR').AsInteger;
          mtLabelsFONTNAME.AsString := labels.FieldByName('FONTNAME').AsString;
          mtLabelsFONTSIZE.AsInteger := labels.FieldByName('FONTSIZE').AsInteger;
          mtLabelsFONTSTYLE.AsString := labels.FieldByName('FONTSTYLE').AsString;
          mtLabels.Post;
          labels.Next;
        end;
        CreateLabelsMenu;
      end;

      // импорт данных
      if (not data.Active) or data.IsEmpty then exit;
      Screen.Cursor := crHourGlass;
      data.First;
      while not data.Eof do
      begin
        if ((iMode = 1) and (data.FieldByName('CHB').AsInteger = 1)) or (iMode = 0) then
        begin
          if mtStore.Locate('GUID', data.FieldByName('GUID').AsString, []) or
            mtStore.Locate('NAME', data.FieldByName('NAME').AsString, [loCaseInsensitive]) then
          begin
            case iAction of
              0:
              begin
                // спросить
                fask.lbMessage.Caption := 'Запись "' + data.FieldByName('NAME').AsString + '" уже есть в ' +
                  'базе данных (под названием "' + mtStoreNAME.AsString + '"). Выберите, что с ней нужно сделать?';
                case fask.ShowModal of
                  mrRetry:
                  begin
                    // добавить (сделать копию)
                    if fask.chbNoAsk.Checked then iAction := 1;
                    data.Edit;
                    data.FieldByName('GUID').AsString := GenId('');
                    data.Post;
                    mtStore.Append;
                  end;
                  mrAbort:
                  begin
                    // заменить
                    if fask.chbNoAsk.Checked then iAction := 2;
                    mtStore.Edit;
                  end;
                  mrIgnore:
                  begin
                    // оставить старую (пропустить)
                    if fask.chbNoAsk.Checked then iAction := 3;
                    data.Next;
                    Continue;
                  end;
                  mrCancel: exit;
                end;
              end;
              1:
              begin
                // добавить (сделать копию)
                data.Edit;
                data.FieldByName('GUID').AsString := GenId('');
                data.Post;
                mtStore.Append;
              end;
              2: mtStore.Edit; // заменить
              3:
              begin
                // оставить старую (пропустить)
                data.Next;
                Continue;
              end;
            end;
          end else
            mtStore.Append;

          mtStoreGUID.AsString := data.FieldByName('GUID').AsString;
          mtStoreNAME.AsString := data.FieldByName('NAME').AsString;
          mtStoreLOGIN.AsString := data.FieldByName('LOGIN').AsString;
          mtStorePASS.AsString := data.FieldByName('PASS').AsString;
          mtStorePASSPHRASE.AsString := data.FieldByName('PASSPHRASE').AsString;
          mtStoreANSWER.AsString := data.FieldByName('ANSWER').AsString;
          mtStoreKEY.AsString := data.FieldByName('KEY').AsString;
          mtStorePASS2.AsString := data.FieldByName('PASS2').AsString;
          mtStoreDESCR.AsString := data.FieldByName('DESCR').AsString;
          mtStoreURL.AsString := data.FieldByName('URL').AsString;
          mtStoreMAIL.AsString := data.FieldByName('MAIL').AsString;
          if keepGroup then
          begin
            lid := lbHash.Values[data.FieldByName('LABEL_ID').AsString];
            if lid <> '' then mtStoreLABEL_ID.AsInteger := StrToInt(lid);
          end else
            mtStoreLABEL_ID.Clear;
          mtStore.Post;
          DataChanged := true;
          if check then sl.Add(mtStoreGUID.AsString);
        end;
        data.Next;
      end;

      // теперь надо выделить импортированные (сразу не получается, т.к. при выделении
      // не работает Append у датасета)
      if check then
        for i := 0 to sl.Count - 1 do
          if mtStore.Locate('GUID', sl.Strings[i], []) then
            dbgStore.SelectedRows.AppendItem(mtStore.Bookmark);
    end;
  finally
    if (not mtStore.IsEmpty) then
      if mtStore.Locate('GUID', id, []) then mtStore.Next
      else mtStore.First;

    Screen.Cursor := crDefault;
    ip.Free;
    fask.Free;
    sl.Free;
    lbHash.Free;
  end;
end;

procedure TFMain.AImportFromCSVExecute(Sender: TObject);
var
  fcsv: TFOpenCSV;
  sl, cols, str, guids: TStringList;
  i, j: integer;
  cs, s, id: string;
  fld: TField;

begin
  fcsv := TFOpenCSV.Create(self);
  try
    sl := TStringList.Create;
    cols := TStringList.Create;
    str := TStringList.Create;
    guids := TStringList.Create;

    mtStore.DisableControls;
    id := mtStoreGUID.AsString;

    fcsv.Caption := 'Имопрт из текста (CSV)';
    if fcsv.ShowModal = mrOk then
    begin
      CSVQuoted := fcsv.chbQuote.Checked;
      CSVSep := fcsv.cbSep.Text;
      CSVIncColumns := fcsv.chbIncColumns.Checked;
      cs := iif(CSVSep = TABSEP, #9, CSVSep);

      if not FileExists(fcsv.edFile.FileName) then
      begin
        Application.MessageBox(pchar('Нет такого файла "' + fcsv.edFile.FileName + '"!'), 'Ошибка',
          MB_OK + MB_ICONERROR);
        exit;
      end;

      mtStore.First;
      while not mtStore.Eof do
      begin
        guids.Add(mtStoreGUID.AsString);
        mtStore.Next;
      end;

      sl.LoadFromFile(fcsv.edFile.FileName);
      for i := 0 to sl.Count - 1 do
      begin
        if (i = 0) and CSVIncColumns then
        begin
          // колонки
          cols.Text := StringReplace(sl.Strings[i], cs, #13#10, [rfReplaceAll]);
          if CSVQuoted then
            for j := 0 to cols.Count - 1 do
              cols.Strings[j] := Copy(cols.Strings[j], 2, Length(cols.Strings[j]) - 2);

          continue;
        end;

        mtStore.Append;
        str.Text := StringReplace(sl.Strings[i], cs, #13#10, [rfReplaceAll]);
        for j := 0 to str.Count - 1 do
        begin
          fld := nil;
          if CSVQuoted then s := Copy(str.Strings[j], 2, Length(str.Strings[j]) - 2)
          else s := str.Strings[j];

          s := StringReplace(StringReplace(s, DELIM_SHIELD, #13#10, [rfReplaceAll]), LIST_DELIM, cs, [rfReplaceAll]);
          try
            if CSVIncColumns then fld := mtStore.FindField(cols.Strings[j])
            else fld := mtStore.Fields.Fields[j];
          except
            continue;
          end;

          if (not Assigned(fld)) or (fld.FieldName = 'LABEL_ID') then continue;

          if fld.FieldName = 'GUID' then
            if (Trim(s) = '') or (guids.IndexOf(s) > -1) then s := GenId('');

          if fld.FieldName = 'LABEL' then
          begin
            fld := mtStore.FieldByName('LABEL_ID');
            if mtLabels.Locate('NAME', s, []) then s := mtLabelsID.AsString
            else continue;
          end;

          fld.AsString := s;
        end;

        mtStore.Post;
      end;
    end;
  finally
    mtStore.EnableControls;
    mtStore.Locate('GUID', id, []);
    sl.Free;
    cols.Free;
    str.Free;
    guids.Free;
    fcsv.Free;
  end;
end;

procedure TFMain.AInvertCheckedExecute(Sender: TObject);
var
  id: string;
  i: integer;
  sl: TStringList;

begin
  if (not IsActive) or mtStore.IsEmpty then exit;

  sl := TStringList.Create;
  id := mtStoreGUID.AsString;
  mtStore.DisableControls;
  try
    for i := 0 to dbgStore.SelectedRows.Count - 1 do
      if mtStore.BookmarkValid(TBookmark(dbgStore.SelectedRows.Items[i])) then
      begin
        mtStore.GotoBookmark(TBookmark(dbgStore.SelectedRows.Items[i]));
        sl.Add(mtStoreGUID.AsString);
      end;

    dbgStore.SelectedRows.Clear;
    mtStore.First;
    while not mtStore.Eof do
    begin
      if sl.IndexOf(mtStoreGUID.AsString) = -1 then
        dbgStore.SelectedRows.AppendItem(mtStore.Bookmark);
      mtStore.Next;
    end;
  finally
    if not mtStore.Locate('GUID', id, []) then mtStore.First;
    mtStore.EnableControls;
    sl.Free;
  end;
end;

procedure TFMain.AMoveRecordDownExecute(Sender: TObject);
begin
  if (not IsActive) or mtStore.IsEmpty or dbgStore.DataGrouping.Active then exit;

  if mtStore.RecNo >= mtStore.RecordCount then exit;
  DataChanged := mtStore.MoveRecord(mtStore.RecNo - 1, mtStore.RecNo, 0, false);
end;

procedure TFMain.AMoveRecordUpExecute(Sender: TObject);
begin
  if (not IsActive) or mtStore.IsEmpty or dbgStore.DataGrouping.Active then exit;

  if mtStore.RecNo <= 1 then exit;
  DataChanged := mtStore.MoveRecord(mtStore.RecNo - 1, mtStore.RecNo - 2, 0, false);
end;

procedure TFMain.AMoveRecordUpUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := IsActive and (not dbgStore.DataGrouping.Active);
end;

procedure TFMain.AOpenExecute(Sender: TObject);
var
  d: TFConnectDlg;

begin
  if IsActive and DataChanged then
    case Application.MessageBox('Данные были изменены! Сохранить изменения?', 'Предупреждение',
      MB_YESNOCANCEL + MB_ICONQUESTION) of
      ID_YES: SaveData(true);
      ID_NO: ;
      ID_CANCEL: exit;
    end;

  d := TFConnectDlg.Create(self);
  if d.ShowModal = mrOk then
  begin
    LastUser := d.cbUser.Text;
    if FileExists(ParamFolder + d.cbUser.Text + DATAFILEEXT) then
    begin
      OldFormat := d.chbOldFormat.Checked;
      OpenStore(d.cbUser.Text, d.edPass.Text);
    end else
      CreateStore(d.cbUser.Text, d.edPass.Text);
  end;
  d.Free;
end;

procedure TFMain.AOptimizeColWidthsExecute(Sender: TObject);
begin
  dbgStore.OptimizeColsWidth(dbgStore.VisibleColumns);
end;

procedure TFMain.AResetFilterExecute(Sender: TObject);
begin
  mtStore.Filtered := false;
  dbgStore.ClearFilter;
  if Assigned(mtStore.AfterScroll) then mtStore.AfterScroll(mtStore);
end;

procedure TFMain.ARestoreDBExecute(Sender: TObject);
var
  err: string;

begin
  if (Application.MessageBox(pchar('Восстановить данные из резервной копии? Учтите, что все изменения, сделанные с момента последнего ' +
    'создания резервной копии будут потеряны!'), 'Подтверждение', MB_YESNO + MB_ICONWARNING) <> ID_YES) then exit;

  if RestoreBackup(err) then
    Application.MessageBox('Данные восстановлены успешно.', pchar(Application.Title), MB_OK + MB_ICONINFORMATION)
  else
  begin
    if err <> '' then
      Application.MessageBox(pchar('Ошибка восстановления данных!'#13#10 + err), pchar(Application.Title), MB_OK + MB_ICONERROR);
  end;
end;

procedure TFMain.ASaveExecute(Sender: TObject);
begin
  if not IsActive then exit;
  SaveData(true);
end;

procedure TFMain.ASendMailExecute(Sender: TObject);
begin
  if IsActive and (not mtStore.IsEmpty) and (Trim(mtStoreMAIL.AsString) <> '') then
    ShellExecute(Handle, 'open', pchar('mailto:' + mtStoreMAIL.AsString), nil, nil, SW_SHOWNORMAL);
end;

procedure TFMain.ASettingsExecute(Sender: TObject);
var
  FParams: TFParams;
  oldCrMetod: TCryptMetod;
  evt: TDataSetNotifyEvent;

begin
  FParams := TFParams.Create(self);
  oldCrMetod := CryptMetod;

  evt := FParams.mtLabels.AfterPost;
  FParams.mtLabels.AfterPost := nil;
  CopyDataSet(mtLabels, FParams.mtLabels, 'ID');
  if Assigned(evt) then FParams.mtLabels.AfterPost := evt;

  if not mtLabels.Active then
  begin
    FParams.GroupBox2.Enabled := false;
    FParams.Label2.Enabled := false;
    FParams.lcbLabels.Enabled := false;
    FParams.btnAdd.Enabled := false;
    FParams.btnRename.Enabled := false;
    FParams.btnDel.Enabled := false;
    FParams.Label5.Enabled := false;
    FParams.cbBGColor.Enabled := false;
    FParams.Label20.Enabled := false;
    FParams.lbLabelFontExample.Enabled := false;
    FParams.btnFont.Enabled := false;
  end;

  if FParams.ShowModal = mrOk then
  begin
    SaveParams{(mtLabels)};
    DataChanged := FParams.LabelsChanged;
    if (oldCrMetod <> CryptMetod) then
      case Application.MessageBox(pchar('Для изменения метода шифрования потребуется сохранить все данные! ' +
        'Продолжить?'), pchar('Предупреждение'), MB_YESNO + MB_ICONWARNING) of
        ID_YES: SaveData(true);
        //ID_NO:
        else CryptMetod := oldCrMetod;
      end;

    dbgStore.DataGrouping.Active := TableGroupping;
    dbgStore.DataGrouping.GroupPanelVisible := dbgStore.DataGrouping.Active;
    dbgStore.DataGrouping.DefaultStateExpanded := DefGroupExpanded;
    if FParams.LabelsChanged then
    begin
      CopyDataSet(FParams.mtLabels, mtLabels, 'ID');
      mtStore.Refresh;
      CreateLabelsMenu;
    end;

    // Параметр DataChanged меняется в SaveData(), так что если сохраняли перед этим, то уже сохранять не придется
    if DataChanged then
      case Application.MessageBox(pchar('Для сохранения изменений в группах потребуется сохранить все данные! ' +
        'Продолжить?'), pchar('Предупреждение'), MB_YESNO + MB_ICONWARNING) of
        ID_YES: SaveData(true);
        //ID_NO: ничего, сохранят потом. А может отменят... уже не мои проблемы
      end;
  end;
  FParams.Free;
end;

procedure TFMain.ATableSettingsExecute(Sender: TObject);
begin
  GridParamsDialog(dbgStore, ParamFolder + PARAMFILE, dbgStore.Name);
end;

procedure TFMain.AUnCheckAllExecute(Sender: TObject);
begin
  dbgStore.SelectedRows.Clear;
end;

procedure TFMain.AUndoExecute(Sender: TObject);
begin
  if Application.MessageBox('Отменить все сделанные с момента последнего сохранения изменения?', 'Подтверждение',
    MB_YESNO + MB_ICONQUESTION) = ID_YES then
    OpenStore(FName, FPass);
end;

procedure TFMain.AUndoUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := IsActive and DataChanged;
end;

procedure TFMain.CloseStore;
begin
  mtStore.EmptyTable;
  mtStore.Close;
  mtLabels.EmptyTable;
  mtLabels.Close;
  DataChanged := false;
  FName := '';
  FPass := '';
  StatusBar.Panels[0].Text := '';
  StatusBar.Panels[1].Text := '';
  StatusBar.Panels[3].Text := '';
  StatusBar.Invalidate;
  tbSave.Enabled := false;
  tbClear.Enabled := false;
  CreateLabelsMenu;
end;

procedure TFMain.CopyMenuItem(Source, Dest: TMenuItem);
begin
  if (not Assigned(Source)) or (not Assigned(Dest)) then exit;
  Dest.Caption := Source.Caption;
  Dest.Hint := Source.Hint;
  Dest.Tag := Source.Tag;
  Dest.Visible := Source.Visible;
  Dest.OnClick := Source.OnClick;
end;

function TFMain.CreateBackup(var Err: string): boolean;
var
  f, b: string;
  dtFormat: TFormatSettings;

begin
  Err := '';
  result := true;

  dtFormat.LongTimeFormat := 'HH:mm:ss';
  dtFormat.TimeSeparator := '_';
  dtFormat.ShortDateFormat := 'yyyy-MM-dd';

  f := ParamFolder + FName + DATAFILEEXT;
  b := f + '-' + DateTimeToStr(Now, dtFormat) + '.bak';

  SaveDialog.FileName := b;
  if SaveDialog.Execute then
  begin
    if FileExists(SaveDialog.FileName) and (Application.MessageBox(pchar('Файл "' + SaveDialog.FileName + '" существует! Заменить?'),
      'Подтверждение', MB_YESNO + MB_ICONQUESTION) <> ID_YES) then exit;

    result := CopyFile(f, SaveDialog.FileName, Err);
  end;
end;

procedure TFMain.CreateLabelsMenu;
var
  m, mm: TMenuItem;

begin
  miSetLabel.Clear;
  mmSetLabel.Clear;
  if not mtLabels.Active then exit;
  mtLabels.First;
  while not mtLabels.Eof do
  begin
    m := TMenuItem.Create(Self);
    mm := TMenuItem.Create(Self);
    m.Caption := mtLabelsNAME.AsString;
    m.Hint := mtLabelsNAME.AsString;
    m.Tag := mtLabelsID.AsInteger;
    m.Visible := true;
    m.OnClick := miSetLabelClick;
    CopyMenuItem(m, mm);
    miSetLabel.Add(m);
    mmSetLabel.Add(mm);
    mtLabels.Next;
  end;

  // теперь меню для удаления метки
  m := TMenuItem.Create(Self);
  mm := TMenuItem.Create(Self);
  m.Caption := 'Убрать из группы';
  m.Hint := 'Убрать из группы';
  m.Tag := -1;
  m.Visible := true;
  m.OnClick := miSetLabelClick;
  CopyMenuItem(m, mm);
  miSetLabel.Add(m);
  miSetLabel.InsertNewLineBefore(m);
  mmSetLabel.Add(mm);
  mmSetLabel.InsertNewLineBefore(mm);
end;

procedure TFMain.CreateStore(AName, APass: string);
begin
  CloseStore;
  if (AName = '') or (APass = '') then raise Exception.Create('Имя пользователя или пароль пустые!');
  FName := AName;
  FPass := APass;
  StatusBar.Panels[0].Text := FName;
  mtLabels.CreateDataSet;
  mtStore.CreateDataSet;
  tbClear.Enabled := true;
  DataChanged := true;
  SaveData(true);
end;

procedure TFMain.dbgStoreApplyFilter(Sender: TObject);
begin
  dbgStore.DefaultApplyFilter;
  if mtStore.Filter = '' then
  begin
    mtStore.Filtered := false;
    dbgStore.ClearFilter;
  end;
end;

procedure TFMain.dbgStoreDblClick(Sender: TObject);
begin
//  AEditExecute(AEdit);
end;

procedure TFMain.dbgStoreGetCellParams(Sender: TObject; Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  if not mtStoreLABEL_ID.IsNull then
    if mtLabels.Locate('ID', mtStoreLABEL_ID.Value, []) then
    begin
      Background := mtLabelsBGCOLOR.AsInteger;
      AFont.Color := mtLabelsFONTCOLOR.AsInteger;
      AFont.Name := mtLabelsFONTNAME.AsString;
      AFont.Size := mtLabelsFONTSIZE.AsInteger;
      AFont.Style := GetFontStyle(mtLabelsFONTSTYLE.AsString);
    end;
end;

function TFMain.DropDataBase(var ErrorMessage: string): boolean;
var
  fn1, fn2: string;

begin
  fn1 := ParamFolder + FName + DATAFILEEXT;
  fn2 := fn1 + '.bak';

  CloseStore;
  if IsActive then
  begin
    ErrorMessage := 'Не удалось закрыть базу данных. Попробуйте еще раз позже.';
    exit;
  end;

  try
    result := DeleteFile(fn1);
    if not result then
      ErrorMessage := SysErrorMessage(GetLastError)
    else
      if FileExists(fn2) then
        if not DeleteFile(fn2) then ErrorMessage := 'Ошибка удаления бэкапа: ' + SysErrorMessage(GetLastError);
  except
    on e: Exception do ErrorMessage := e.Message;
  end;
end;

procedure TFMain.FilterDialog(Expression: string; ShowExPage: boolean);
begin
  if (not IsActive) or mtStore.IsEmpty then exit;

  CopyFieldParams(dbgStore);
  if FFilter.Execute(mtStore, ShowExPage, Expression) then
  begin
    FilterCaseSens := FFilter.chbCaseSensitive.Checked;
    if Assigned(mtStore.AfterScroll) then mtStore.AfterScroll(mtStore);
  end;
end;

procedure TFMain.Find(ANext: boolean; CurrField: string);
var
  fr: TFFindResult;
  sl: TStringList;
  bm: TBookmark;
  asc: TDataSetNotifyEvent;
  i, j: integer;
  r: boolean;

begin
  if (not IsActive) or mtStore.IsEmpty then exit;

  CopyFieldParams(dbgStore);
  FExFinder.SDataSet := mtStore;
  if FExFinder.SaveQuery then
  begin
    FExFinder.DefFieldName := LastFindField;
    if FExFinder.DefFieldIndex = -1 then
    begin
      FExFinder.DefFieldName := CurrField;
      FExFinder.DefSearchStr := mtStore.FieldByName(CurrField).AsString;
    end else
      FExFinder.DefSearchStr := LastSearchStr;
  end else
  begin
    FExFinder.DefFieldName := CurrField;
    FExFinder.DefSearchStr := mtStore.FieldByName(CurrField).AsString;
  end;
  FExFinder.Next := ANext;
  FExFinder.KeyFieldName := 'GUID';

  if not FExFinder.GoFind then exit;
  LastFindField := FExFinder.DefFieldName;
  LastSearchStr := FExFinder.DefSearchStr;

  if (not ANext) and (FExFinder.FindMode <> fmRegular) then
  begin
    if (FExFinder.FindMode = fmShowResult) then
    begin
      sl := FExFinder.CheckList;
      if sl.Count = 0 then exit;
      fr := TFFindResult.Create(self);
      try
        Screen.Cursor := crHourGlass;
        CopyDataSetFields(mtStore, mteFindResults);
        bm := mtStore.GetBookmark;
        mtStore.DisableControls;
        asc := mtStore.AfterScroll;
        mtStore.AfterScroll := nil;
        mteFindResults.CreateDataSet;

        for i := 0 to sl.Count - 1 do
          if mtStore.Locate('GUID', sl.Strings[i], []) then
          begin
            mteFindResults.Append;
            for j := 0 to mteFindResults.Fields.Count - 1 do
              mteFindResults.Fields.Fields[j].Value :=
                mtStore.FieldByName(mteFindResults.Fields.Fields[j].FieldName).Value;
            mteFindResults.Post;
          end;

        mteFindResults.First;
        fr.Caption := 'Найдено';
        r := fr.ShowResult(TDataSet(mteFindResults));
      finally
        sl.Clear;
        fr.Free;
        mtStore.AfterScroll := asc;
        if r then mtStore.Locate('GUID', mteFindResults.FieldByName('GUID').Value, [])
        else if mtStore.BookmarkValid(bm) then mtStore.GotoBookmark(bm);
        mteFindResults.Close;
        mtStore.EnableControls;
        Screen.Cursor := crDefault;
      end;
    end;

    if (FExFinder.FindMode = fmCheck) then
    begin
      sl := FExFinder.CheckList;
      if sl.Count = 0 then exit;
      mtStore.DisableControls;
      asc := mtStore.AfterScroll;
      mtStore.AfterScroll := nil;
      Screen.Cursor := crHourGlass;
      try
        for i := 0 to sl.Count - 1 do
          if mtStore.Locate('GUID', sl.Strings[i], []) then
            dbgStore.SelectedRows.AppendItem(mtStore.Bookmark);
      finally
        sl.Clear;
        mtStore.AfterScroll := asc;
        mtStore.EnableControls;
        Screen.Cursor := crDefault;
      end;
    end;
  end;
end;

procedure TFMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveWndState;
  SaveGridParams(dbgStore, ParamFolder + PARAMFILE, dbgStore.Name);
  if DataChanged and mtStore.Active then
    case Application.MessageBox('Данные были изменены! Сохранить изменения?', 'Предупреждение',
      MB_YESNOCANCEL + MB_ICONQUESTION) of
      ID_YES: SaveData(true);
      ID_NO: ;
      ID_CANCEL: Action := caNone;
    end;
end;

procedure TFMain.FormCreate(Sender: TObject);
begin
  DefaultGridParams := TStringList.Create;
  //mtLabels.CreateDataSet;
  LoadParams{(mtLabels)};
  reDescr.Font.Assign(reDescrFont);
  reDescr.Color := reDescrBgColor;
  FExFinder := TExtendFind.Create;
  FExFinder.FindMode := TFindMode(FindMode);
  FFilter := TfFilter.Create(self);
  FFilter.chbCaseSensitive.Checked := FilterCaseSens;
end;

procedure TFMain.FormDestroy(Sender: TObject);
begin
  reDescrFont.Assign(reDescr.Font);
  reDescrBgColor := reDescr.Color;
  SaveParams{(mtLabels)};
  DefaultGridParams.Free;
  FExFinder.Free;
  FFilter.Free;
end;

procedure TFMain.FormShow(Sender: TObject);
begin
  LoadWndState;
  KeepCurrentGridParams;
  LoadGridParams(dbgStore, ParamFolder + PARAMFILE, dbgStore.Name);
  dbgStore.DataGrouping.Active := TableGroupping;
  dbgStore.DataGrouping.GroupPanelVisible := dbgStore.DataGrouping.Active;
  dbgStore.DataGrouping.DefaultStateExpanded := DefGroupExpanded;
  dbgStore.DefaultApplySorting;
  AOpenExecute(AOpen);
end;

procedure TFMain.GridParamsDialog(DBGrid: TDBGridEh; FileName, Section: string);
var
  FGridSettings: TFGridSettings;

begin
  FGridSettings := TFGridSettings.Create(Self);
  try
    case FGridSettings.ShowSettingsDialog(DBGrid) of
      rSave: SaveGridParams(DBGrid, FileName, Section);
      rCancel: FGridSettings.CancelChanges;
      rReset: RestoreGridParams;
    end;
  finally
    FGridSettings.Free;
  end;
end;

procedure TFMain.GroupEdit;
var
  fGrEdit: TFGroupEdit;
  i, j: integer;
  data: TStringList;
  id: string;

begin
  if (not IsActive) or mtStore.IsEmpty then exit;
  if dbgStore.SelectedRows.Count <= 1 then exit;

  fGrEdit := TFGroupEdit.Create(self);
  id := mtStoreGUID.AsString;
  mtStore.DisableControls;
  try
    if fGrEdit.Execute(dbgStore.DataSource.DataSet) then
    begin
      data := fGrEdit.GetData;
      for i := 0 to dbgStore.SelectedRows.Count - 1 do
        if mtStore.BookmarkValid(TBookmark(dbgStore.SelectedRows.Items[i])) then
        begin
          mtStore.GotoBookmark(TBookmark(dbgStore.SelectedRows.Items[i]));
          mtStore.Edit;
          for j := 0 to data.Count - 1 do
            mtStore.FieldByName(data.Names[j]).AsString := data.Values[data.Names[j]];
          mtStore.Post;
        end;
    end;
  finally
    fGrEdit.Free;
    dbgStore.SelectedRows.Clear;
    //mtStore.Refresh;
    if not mtStore.Locate('GUID', id, []) then mtStore.First;
    mtStore.EnableControls;
  end;
end;

function TFMain.IsActive: boolean;
begin
  result := mtStore.Active;
end;

procedure TFMain.KeepCurrentGridParams;
var
  i: integer;

begin
  // сначала сохраним свойства грида
  DefaultGridParams.Values['FrozenCols'] := IntToStr(dbgStore.FrozenCols);
  DefaultGridParams.Values['Color'] := IntToStr(dbgStore.Color);
  DefaultGridParams.Values['EvenRowColor'] := IntToStr(dbgStore.EvenRowColor);
  DefaultGridParams.Values['FontName'] := dbgStore.Font.Name;
  DefaultGridParams.Values['FontColor'] := IntToStr(dbgStore.Font.Color);
  DefaultGridParams.Values['FontSize'] := IntToStr(dbgStore.Font.Size);
  DefaultGridParams.Values['FontStyle'] := FontStyleAsString(dbgStore.Font.Style);
  // теперь поехали колонки
  for i := 0 to dbgStore.Columns.Count - 1 do
    DefaultGridParams.Values[DEFPARAM_PREFIX + dbgStore.Columns[i].FieldName] :=
      ColumnParamsAsString(dbgStore.Columns[i]);
end;

procedure TFMain.LoadWndState;
begin
  Width := WWidth;
  Height := WHeight;
  Left := WLeft;
  Top := WTop;
  Panel2.Height := iif(reDescrHeight > 1, reDescrHeight, 150);
  JvNetscapeSplitter1.Maximized := reDescrMinimized;
  if WMaximized then
    WindowState := wsMaximized
  else
    WindowState := wsNormal;
end;

procedure TFMain.miSetLabelClick(Sender: TObject);
var
  i: integer;
  id: string;

begin
  if (not IsActive) or mtStore.IsEmpty then exit;
  if dbgStore.SelectedRows.Count <= 1 then
  begin
    mtStore.Edit;
    if TMenuItem(Sender).Tag = -1 then mtStoreLABEL_ID.Clear
    else mtStoreLABEL_ID.AsInteger := TMenuItem(Sender).Tag;
    mtStore.Post;
  end else
  begin
    //if dbgStore.Selection.SelectionType <> gstRecordBookmarks then exit;
    id := mtStoreGUID.AsString;
    mtStore.DisableControls;
    try
      for i := 0 to dbgStore.SelectedRows.Count - 1 do
        if mtStore.BookmarkValid(TBookmark(dbgStore.SelectedRows.Items[i])) then
        begin
          mtStore.GotoBookmark(TBookmark(dbgStore.SelectedRows.Items[i]));
          mtStore.Edit;
          if TMenuItem(Sender).Tag = -1 then mtStoreLABEL_ID.Clear
          else mtStoreLABEL_ID.AsInteger := TMenuItem(Sender).Tag;
          mtStore.Post;
        end;
    finally
      mtStore.Refresh;
      dbgStore.SelectedRows.Clear;
      if not mtStore.Locate('GUID', id, []) then mtStore.First;
      mtStore.EnableControls;
    end;
  end;
end;

procedure TFMain.mtStoreAfterClose(DataSet: TDataSet);
begin
  mtStore.Filter := '';
  mtStore.Filtered := false;
  dbgStore.ClearFilter;
end;

procedure TFMain.mtStoreAfterDelete(DataSet: TDataSet);
begin
  DataChanged := true;
end;

procedure TFMain.mtStoreAfterPost(DataSet: TDataSet);
begin
  DataChanged := true;
end;

procedure TFMain.mtStoreAfterScroll(DataSet: TDataSet);
begin
  StatusBar.Panels[1].Text := IntToStr(mtStore.RecNo) + ' / ' + IntToStr(mtStore.RecordCount);
  if IsActive and (not mtStore.IsEmpty) then
  begin
    StatusBar.Panels[3].Text := mtStoreLABEL.AsString;
  end;
  tbSave.Enabled := false;
end;

procedure TFMain.OpenStore(AName, APass: string);
begin
  CloseStore;
  if (AName = '') or (APass = '') then raise Exception.Create('Имя пользователя или пароль пустые!');
  try
    if OldFormat and (not mtLabels.Active) then mtLabels.CreateDataSet;
    if (OldFormat and LoadStoreOld(mtStore, AName, APass)) or
      ((not OldFormat) and LoadStore(mtStore, mtLabels, AName, APass)) then
    begin
      mtStore.First;
      //DataChanged := false;
      DataChanged := OldFormat;
      FName := AName;
      FPass := APass;
      tbClear.Enabled := true;
      StatusBar.Panels[0].Text := FName;
      CreateLabelsMenu;
    end else
      if OldFormat then mtLabels.Close;
  except
    on e: Exception do
      Application.MessageBox(pchar('Ошибка при открытии базы данных <' + AName + '>'#13#10 + e.Message),
        'Ошибка', MB_OK + MB_ICONERROR);
  end;
end;

procedure TFMain.reDescrChange(Sender: TObject);
begin
  tbSave.Enabled := true;
end;

function TFMain.RestoreBackup(var Err: string): boolean;
var
  f, r: string;

begin
  Err := '';
  result := false;
  f := ParamFolder + FName + DATAFILEEXT;

  OpenDialog.FileName := f + '.bak';
  if OpenDialog.Execute then
  begin
    try
      TryStore(OpenDialog.FileName, FPass);
      result := CopyFile(OpenDialog.FileName, f, Err);
      if result then OpenStore(FName, FPass);
    except
      on e: Exception do
        Err := 'Файл <' + OpenDialog.FileName + '> не является файлом бэкапа вашей базы данных! Ошибка:'#13#10 + e.Message;
    end;
  end;
end;

procedure TFMain.RestoreGridParams;
var
  i: integer;
  col: TColumnEh;
  
begin
  // сначала грузим настройки грида
  dbgStore.FrozenCols := ReadDefParam(DefaultGridParams, 'FrozenCols', dbgStore.FrozenCols);
  dbgStore.Color := ReadDefParam(DefaultGridParams, 'Color', dbgStore.Color);
  dbgStore.EvenRowColor := ReadDefParam(DefaultGridParams, 'EvenRowColor', dbgStore.EvenRowColor);
  dbgStore.Font.Name := ReadDefParam(DefaultGridParams, 'FontName', dbgStore.Font.Name);
  dbgStore.Font.Color := ReadDefParam(DefaultGridParams, 'FontColor', dbgStore.Font.Color);
  dbgStore.Font.Size := ReadDefParam(DefaultGridParams, 'FontSize', dbgStore.Font.Size);
  dbgStore.Font.Style := GetFontStyle(ReadDefParam(DefaultGridParams, 'FontStyle',
    FontStyleAsString(dbgStore.Font.Style)));

  // теперь пошли колонки
  for i := 0 to DefaultGridParams.Count - 1 do
    if Pos(DEFPARAM_PREFIX, DefaultGridParams.Strings[i]) = 1 then
    begin
      col := FindColumnByFieldName(dbgStore, StringReplace(DefaultGridParams.Names[i], DEFPARAM_PREFIX, '', []));
      if not Assigned(col) then continue;
      SetColumnParamsFromString(col, ReadDefParam(DefaultGridParams, DEFPARAM_PREFIX + col.FieldName, ''));
    end;
end;

procedure TFMain.SaveData(Silent: boolean);
begin
  try
    if SaveStore(mtStore, mtLabels, FName, FPass, 'GUID', CryptMetod) then
    begin
      DataChanged := false;
      if not Silent then
        Application.MessageBox(pchar('Сохранено успешно!'), 'Сообщение', MB_OK + MB_ICONINFORMATION);
    end;
  except
    on e: Exception do
      Application.MessageBox(pchar('Ошибка при сохранении данных!'#13#10 + e.Message), 'Ошибка',
        MB_OK + MB_ICONERROR);
  end;
end;

procedure TFMain.SaveWndState;
begin
  WMaximized := WindowState = wsMaximized;
  if not WMaximized then
  begin
    WWidth := Width;
    WHeight := Height;
    WLeft := Left;
    WTop := Top;
  end;
  reDescrMinimized := JvNetscapeSplitter1.Maximized;
  if not reDescrMinimized then reDescrHeight := Panel2.Height;
end;

procedure TFMain.SetCardLabels(FCard: TFCard; DBGrid: TDBGridEh);
begin
  if (not Assigned(FCard)) or (not Assigned(DBGrid)) then exit;
  try
    FCard.lbName.Caption := FindColumnByFieldName(DBGrid, 'NAME').Title.Caption;
    FCard.lbLogin.Caption := FindColumnByFieldName(DBGrid, 'LOGIN').Title.Caption;
    FCard.lbPass.Caption := FindColumnByFieldName(DBGrid, 'PASS').Title.Caption;
    FCard.lbPassPhrase.Caption := FindColumnByFieldName(DBGrid, 'PASSPHRASE').Title.Caption;
    FCard.lbAnswer.Caption := FindColumnByFieldName(DBGrid, 'ANSWER').Title.Caption;
    FCard.lbKey.Caption := FindColumnByFieldName(DBGrid, 'KEY').Title.Caption;
    FCard.lbPass2.Caption := FindColumnByFieldName(DBGrid, 'PASS2').Title.Caption;
    FCard.lbDescr.Caption := FindColumnByFieldName(DBGrid, 'DESCR').Title.Caption;
    FCard.lbUrl.Caption := FindColumnByFieldName(DBGrid, 'URL').Title.Caption;
    FCard.lbMail.Caption := FindColumnByFieldName(DBGrid, 'MAIL').Title.Caption;
    FCard.lbLabelId.Caption := FindColumnByFieldName(DBGrid, 'LABEL').Title.Caption;
  except
  end;
end;

procedure TFMain.SetChanged(Value: boolean);
begin
  fChanged := Value;
  StatusBar.Invalidate;
end;

procedure TFMain.StatusBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; const Rect: TRect);
var
  ico: TIcon;

begin
  if Panel.Index <> 2 then exit;
  StatusBar.Canvas.FillRect(Rect);
  if DataChanged then
    ilToolBar.Draw(StatusBar.Canvas, Rect.Left, Rect.Top, 26)
  else
  begin
    ico := TIcon.Create;
    DrawIcon(StatusBar.Canvas.Handle, Rect.Left, Rect.Top, ico.Handle);
  end;
end;

procedure TFMain.tbClearClick(Sender: TObject);
begin
  mtStore.Edit;
  mtStoreDESCR.Clear;
  mtStore.Post;
end;

procedure TFMain.tbColorClick(Sender: TObject);
begin
  ColorDialog.Color := reDescr.Color;
  if ColorDialog.Execute then reDescr.Color := ColorDialog.Color;
end;

procedure TFMain.tbFontClick(Sender: TObject);
begin
  FontDialog.Font.Assign(reDescr.Font);
  if FontDialog.Execute then
  begin
    reDescr.Font.Assign(FontDialog.Font);
  end;
end;

procedure TFMain.tbSaveClick(Sender: TObject);
begin
  if (not IsActive) or mtStore.IsEmpty then exit;
  if not (mtStore.State in [dsEdit, dsInsert]) then exit;
  mtStore.Post;
  tbSave.Enabled := false;
end;

end.
