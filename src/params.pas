unit params;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  Buttons, utils, DBGridEh, Mask, DBCtrlsEh, DBLookupEh, MemTableDataEh, Db, MemTableEh, ExtCtrls;

type
  TFParams = class(TForm)
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    cbReservePolicy: TComboBox;
    GroupBox2: TGroupBox;
    lcbLabels: TDBLookupComboboxEh;
    Label2: TLabel;
    btnAdd: TBitBtn;
    btnDel: TBitBtn;
    dsoLabels: TDataSource;
    Label5: TLabel;
    cbBGColor: TColorBox;
    mtLabels: TMemTableEh;
    mtLabelsID: TIntegerField;
    mtLabelsNAME: TStringField;
    mtLabelsBGCOLOR: TIntegerField;
    FontDialog: TFontDialog;
    Label20: TLabel;
    lbLabelFontExample: TLabel;
    btnFont: TBitBtn;
    mtLabelsFONTCOLOR: TIntegerField;
    mtLabelsFONTNAME: TStringField;
    mtLabelsFONTSIZE: TIntegerField;
    mtLabelsFONTSTYLE: TStringField;
    Label3: TLabel;
    cbCryptMetod: TComboBox;
    chbTableGroupping: TCheckBox;
    chbDefGroupExpanded: TCheckBox;
    btnRename: TBitBtn;
    Label4: TLabel;
    cbClipCopyDelim: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure lcbLabelsChange(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure cbBGColorChange(Sender: TObject);
    procedure btnFontClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure chbTableGrouppingClick(Sender: TObject);
    procedure btnRenameClick(Sender: TObject);
    procedure mtLabelsAfterDelete(DataSet: TDataSet);
    procedure mtLabelsAfterPost(DataSet: TDataSet);
  private
    FLabelFont: TFont;
    procedure SetFontToDataSet;
    procedure GetFontFromDataSet;
  public
    LabelsChanged: boolean;
  end;

implementation

{$R *.dfm}

procedure TFParams.btnAddClick(Sender: TObject);
var
  name: string;
  newid: integer;
  defFont: TFont;

begin
  name := InputBox('Новая группа', 'Введите название группы', '');
  if Trim(name) = '' then exit;

  if mtLabels.Locate('NAME', name, [loCaseInsensitive]) then
  begin
    Application.MessageBox(pchar('Группа <' + name + '> уже существует!'), pchar('Новая группа'),
      MB_OK + MB_ICONERROR);
    exit;
  end;

  defFont := TFont.Create;
  newid := GetMaxID(mtLabels, 'ID');
  mtLabels.Append;
  mtLabelsID.AsInteger := newid;
  mtLabelsNAME.AsString := name;
  mtLabelsBGCOLOR.AsInteger := clWindow;
  mtLabelsFONTCOLOR.AsInteger := defFont.Color;
  mtLabelsFONTNAME.AsString := defFont.Name;
  mtLabelsFONTSIZE.AsInteger := defFont.Size;
  mtLabelsFONTSTYLE.AsString := FontStyleAsString(defFont.Style);
  mtLabels.Post;
  defFont.Free;
  lcbLabels.KeyValue := mtLabelsID.AsInteger;
end;

procedure TFParams.btnDelClick(Sender: TObject);
begin
  if Application.MessageBox(pchar('Удалить группу "' + mtLabelsNAME.AsString + '"?'), 'Подтверждение',
    MB_YESNO + MB_ICONQUESTION) = ID_YES then
  begin
    mtLabels.Delete;
    lcbLabels.KeyValue := mtLabelsID.AsInteger;
  end;
end;

procedure TFParams.btnFontClick(Sender: TObject);
begin
  FontDialog.Font.Assign(FLabelFont);
  if FontDialog.Execute then
  begin
    FLabelFont.Assign(FontDialog.Font);
    SetFontToDataSet;
    lbLabelFontExample.Font.Assign(FLabelFont);
  end;
end;

procedure TFParams.btnRenameClick(Sender: TObject);
var
  name: string;

begin
  name := InputBox('Переименовать', 'Введите новое название группы', lcbLabels.Text);
  if (Trim(name) = '') or (Trim(name) = lcbLabels.Text) then exit;

  if mtLabels.Locate('NAME', name, [loCaseInsensitive]) then
  begin
    Application.MessageBox(pchar('Группа <' + name + '> уже существует!'), pchar('Переименование'),
      MB_OK + MB_ICONERROR);
    exit;
  end;

  if mtLabels.Locate('NAME', lcbLabels.Text, [loCaseInsensitive]) then
  begin
    mtLabels.Edit;
    mtLabelsNAME.AsString := name;
    mtLabels.Post;
    lcbLabels.Text := name;
  end;
end;

procedure TFParams.cbBGColorChange(Sender: TObject);
begin
  if (not VarIsNull(lcbLabels.KeyValue)) and mtLabels.Locate('ID', lcbLabels.KeyValue, []) then
  begin
    mtLabels.Edit;
    mtLabelsBGCOLOR.AsInteger := cbBGColor.Selected;
    mtLabels.Post;
  end;
end;

procedure TFParams.chbTableGrouppingClick(Sender: TObject);
begin
  chbDefGroupExpanded.Enabled := chbTableGroupping.Checked;
end;

procedure TFParams.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult = mrOk then
  begin
    ReservePolicy := TReservePolicy(cbReservePolicy.ItemIndex);
    CryptMetod := TCryptMetod(cbCryptMetod.ItemIndex);
    TableGroupping := chbTableGroupping.Checked;
    DefGroupExpanded := chbDefGroupExpanded.Checked;
    ClipCopyDelim := cbClipCopyDelim.Text;
  end;
end;

procedure TFParams.FormCreate(Sender: TObject);
begin
  mtLabels.CreateDataSet;
  cbBGColor.Selected := clWindow;
  FLabelFont := TFont.Create;
  cbClipCopyDelim.Items.Add(ENTERSEP);
  cbClipCopyDelim.Items.Add(TABSEP);
end;

procedure TFParams.FormDestroy(Sender: TObject);
begin
  FLabelFont.Free;
end;

procedure TFParams.FormShow(Sender: TObject);
begin
  cbCryptMetod.ItemIndex := Ord(CryptMetod);
  cbReservePolicy.ItemIndex := Ord(ReservePolicy);
  lcbLabels.KeyValue := mtLabelsID.AsInteger;
  chbTableGroupping.Checked := TableGroupping;
  chbDefGroupExpanded.Checked := DefGroupExpanded;
  chbTableGrouppingClick(chbTableGroupping);
  cbClipCopyDelim.Text := ClipCopyDelim;
end;

procedure TFParams.GetFontFromDataSet;
begin
  if (not VarIsNull(lcbLabels.KeyValue)) and mtLabels.Locate('ID', lcbLabels.KeyValue, []) then
  begin
    FLabelFont.Color := mtLabelsFONTCOLOR.AsInteger;
    FLabelFont.Name := mtLabelsFONTNAME.AsString;
    FLabelFont.Size := mtLabelsFONTSIZE.AsInteger;
    FLabelFont.Style := GetFontStyle(mtLabelsFONTSTYLE.AsString);
  end;
end;

procedure TFParams.lcbLabelsChange(Sender: TObject);
begin
  if mtLabels.IsEmpty then exit;
  cbBGColor.Selected := mtLabelsBGCOLOR.AsInteger;
  GetFontFromDataSet;
  lbLabelFontExample.Font.Assign(FLabelFont);
end;

procedure TFParams.mtLabelsAfterDelete(DataSet: TDataSet);
begin
  LabelsChanged := true;
end;

procedure TFParams.mtLabelsAfterPost(DataSet: TDataSet);
begin
  LabelsChanged := true;
end;

procedure TFParams.SetFontToDataSet;
begin
  if (not VarIsNull(lcbLabels.KeyValue)) and mtLabels.Locate('ID', lcbLabels.KeyValue, []) then
  begin
    mtLabels.Edit;
    mtLabelsFONTCOLOR.AsInteger := FLabelFont.Color;
    mtLabelsFONTNAME.AsString := FLabelFont.Name;
    mtLabelsFONTSIZE.AsInteger := FLabelFont.Size;
    mtLabelsFONTSTYLE.AsString := FontStyleAsString(FLabelFont.Style);
    mtLabels.Post;
  end;
end;

end.
