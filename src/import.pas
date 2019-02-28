unit import;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, MemTableDataEh, Db, GridsEh, DBGridEh, MemTableEh, utils,
  DBGridEhGrouping, EhLibMTE, Mask, DBCtrlsEh, DBLookupEh;

type
  TFImportParams = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    cbActionOnExists: TComboBox;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    Label2: TLabel;
    cbImportMode: TComboBox;
    mtStore: TMemTableEh;
    mtStoreGUID: TStringField;
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
    mtStoreLABEL_ID: TIntegerField;
    dsStore: TDataSource;
    dbgStore: TDBGridEh;
    mtStoreLABEL: TStringField;
    chbCheckChanged: TCheckBox;
    mtStoreCHB: TIntegerField;
    chbSaveGroup: TCheckBox;
    mtLabels: TMemTableEh;
    mtLabelsID: TIntegerField;
    mtLabelsNAME: TStringField;
    mtLabelsBGCOLOR: TIntegerField;
    mtLabelsFONTCOLOR: TIntegerField;
    mtLabelsFONTNAME: TStringField;
    mtLabelsFONTSIZE: TIntegerField;
    mtLabelsFONTSTYLE: TStringField;
    dsoLabels: TDataSource;
    lcbLabels: TDBLookupComboboxEh;
    procedure FormCreate(Sender: TObject);
    procedure cbImportModeChange(Sender: TObject);
    procedure dbgStoreKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure chbSaveGroupClick(Sender: TObject);
  private
    procedure CheckAll;
    procedure UnCheckAll;
  public
    procedure Load(AStore, APass: string);
    procedure Clear;
    function GetData: TMemTableEh;
  end;

implementation

{$R *.dfm}

procedure TFImportParams.cbImportModeChange(Sender: TObject);
begin
  case cbImportMode.ItemIndex of
    0:
    begin
      dbgStore.Enabled := false;
      dbgStore.Color := clInactiveCaptionText;
    end;
    1:
    begin
      dbgStore.Enabled := true;
      dbgStore.Color := clWindow;
    end;
  end;
end;

procedure TFImportParams.chbSaveGroupClick(Sender: TObject);
begin
  lcbLabels.Enabled := chbSaveGroup.Checked;
end;

procedure TFImportParams.CheckAll;
begin
  dbgStore.SelectedRows.SelectAll;
end;

procedure TFImportParams.Clear;
begin
  mtStore.Close;
end;

procedure TFImportParams.dbgStoreKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    Ord('A'), Ord('a'), Ord('Ô'), Ord('ô'): if (ssCtrl in Shift) then CheckAll;
    Ord('B'), Ord('b'), Ord('È'), Ord('è'): if (ssCtrl in Shift) then UnCheckAll;
  end;
end;

procedure TFImportParams.FormCreate(Sender: TObject);
begin
  cbActionOnExists.ItemIndex := ActionOnExists;
  cbImportMode.ItemIndex := ImportMode;
  chbCheckChanged.Checked := CheckChanged;
  chbSaveGroup.Checked := SaveGroup;
  lcbLabels.Enabled := chbSaveGroup.Checked;
  cbImportModeChange(cbImportMode);
end;

procedure TFImportParams.FormDestroy(Sender: TObject);
begin
  ActionOnExists := cbActionOnExists.ItemIndex;
  ImportMode := cbImportMode.ItemIndex;
  CheckChanged := chbCheckChanged.Checked;
  SaveGroup := chbSaveGroup.Checked;
end;

function TFImportParams.GetData: TMemTableEh;
var
  i: integer;

begin
  result := mtStore;
  if cbImportMode.ItemIndex <> 1 then exit;

  mtStore.ReadOnly := false;
  for i := 0 to dbgStore.SelectedRows.Count - 1 do
  begin
    if mtStore.BookmarkValid(TBookmark(dbgStore.SelectedRows.Items[i])) then
      mtStore.GotoBookmark(TBookmark(dbgStore.SelectedRows.Items[i]));
    mtStore.Edit;
    mtStoreCHB.AsInteger := 1;
    mtStore.Post;
  end;
end;

procedure TFImportParams.Load(AStore, APass: string);
var
  oldRP: TReservePolicy;

begin
  oldRP := ReservePolicy;
  ReservePolicy := rpNone;
  try
    mtStore.ReadOnly := false;
    if LoadStore(mtStore, mtLabels, AStore, APass, false) then mtStore.First;
  finally
    mtStore.ReadOnly := true;
    ReservePolicy := oldRP;
  end;
end;

procedure TFImportParams.UnCheckAll;
begin
  dbgStore.SelectedRows.Clear;
end;

end.
