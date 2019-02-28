unit connectdlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, utils;

type
  TFConnectDlg = class(TForm)
    GroupBox1: TGroupBox;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    Label2: TLabel;
    Label3: TLabel;
    edPass: TEdit;
    cbUser: TComboBox;
    lbHint: TLabel;
    Bevel1: TBevel;
    OpenDialog: TOpenDialog;
    chbOldFormat: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure edPassChange(Sender: TObject);
    procedure cbUserChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure CheckControls;
    procedure LoadStoreList;
  public
    SetHint: boolean;
    ImportMode: boolean;
    function DefaultLocation: boolean; 
  end;

implementation

{$R *.dfm}

procedure TFConnectDlg.cbUserChange(Sender: TObject);
begin
  CheckControls;

  if ImportMode and (cbUser.ItemIndex = cbUser.Items.Count - 1) then
    if OpenDialog.Execute then
    begin
      cbUser.Items.Strings[cbUser.Items.Count - 1] := OpenDialog.FileName;
      cbUser.ItemIndex := cbUser.Items.Count - 1;
    end;

  if not SetHint then exit;
  if cbUser.Items.IndexOf(cbUser.Text) = -1 then
  begin
    lbHint.Caption := 'Создать базу данных <' + cbUser.Text + '> и задать для нее пароль';
    Label3.Caption := 'Новый пароль';
  end else
  begin
    lbHint.Caption := 'Открыть базу данных <' + cbUser.Text + '>';
    Label3.Caption := 'Пароль';
  end;
end;

procedure TFConnectDlg.CheckControls;
begin
  btnOk.Enabled := (cbUser.Text <> '') and (cbUser.Text <> 'Открыть файл...') and (edPass.Text <> '');
end;

function TFConnectDlg.DefaultLocation: boolean;
begin
  result := cbUser.ItemIndex < cbUser.Items.Count - 1;
end;

procedure TFConnectDlg.edPassChange(Sender: TObject);
begin
  CheckControls;
end;

procedure TFConnectDlg.FormCreate(Sender: TObject);
begin
  SetHint := true;
  ImportMode := false;
  chbOldFormat.Visible := ShowOldControls;
  chbOldFormat.Checked := false;
end;

procedure TFConnectDlg.FormShow(Sender: TObject);
begin
  LoadStoreList;
  if cbUser.Style <> csDropDownList then
  begin
    if cbUser.Items.Count = 0 then cbUser.Style := csSimple
    else cbUser.Style := csDropDown;
  end;
  cbUser.Text := LastUser;
  cbUserChange(cbUser);
  try
    if cbUser.Text <> '' then edPass.SetFocus
    else cbUser.SetFocus;
  except
  end;
  CheckControls;
end;

procedure TFConnectDlg.LoadStoreList;
var
  sr: TSearchRec;
  i: integer;

begin
  cbUser.Items.Clear;
  i := FindFirst(ParamFolder + '*' + DATAFILEEXT, faAnyFile, sr);
  while i = 0 do
  begin
    cbUser.Items.Add(ChangeFileExt(sr.Name, ''));
    i := FindNext(sr);
  end;
  FindClose(sr);
  if ImportMode then cbUser.Items.Add('Открыть файл...');
  //cbUser.Sorted := true;
end;

end.
