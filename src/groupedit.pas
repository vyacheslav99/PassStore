unit groupedit;
{$DEFINE EHLIB}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Mask, DB, ImgList, ComCtrls, ToolWin,
  DBCtrls, {$IFDEF EHLIB} DBCtrlsEh, ToolCtrlsEh, DBLookupEh {$ELSE} RxSpin, RxLookup {$ENDIF};

const
  CTRLHEIGHT = 21;
  CTRLWIDHT = 220;
  CTRLLEFT = 180;
  FILLRECLIMIT = 100;
  LOOKUPFIELDSDELIM = ';';

type
  TObjType = (otVariant, otInt, otFloat, otString, otDateTime, otDate, otTime, otLookup);

  TRecordBase = class
  private
    FObjType: TObjType;
    FField: TField;
    FUsed: TCheckBox;
    ValueObj: TControl;
    FTop: integer;
    FLookupDataSet: TDataSet;
    FLookupSource: TDataSource;
    procedure CheckBoxClick(Sender: TObject);
    procedure SetTop(value: integer);
    procedure SetField(AField: TField);
    procedure ChangeField(AParent: TWinControl; ATop: integer; AField: TField);
    function GetUsed: boolean;
    procedure SetUsed(value: boolean);
  public
    constructor Create(AParent: TWinControl; ATop: integer; AField: TField);
    destructor Destroy; override;
    function GetValue: string;
    property Top: integer read FTop write SetTop;
    property DataField: TField read FField write SetField;
    property Used: boolean read GetUsed write SetUsed;
  end;

  TRecordsBase = array of TRecordBase;

  TFGroupEdit = class(TForm)
    Panel1: TPanel;
    btnApply: TBitBtn;
    btnCancel: TBitBtn;
    ImageList1: TImageList;
    ScrollBox: TScrollBox;
    ToolBar1: TToolBar;
    btnCheck: TToolButton;
    btnUncheck: TToolButton;
    btnInvert: TToolButton;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCheckClick(Sender: TObject);
    procedure btnUncheckClick(Sender: TObject);
    procedure btnInvertClick(Sender: TObject);
  private
    f_ok: boolean;
    RecordsBase: TRecordsBase;
    FDataSet: TDataSet;
    procedure SetDataSet(ADataSet: TDataSet);
    procedure FreeRecordsBase;
    procedure SetChecked(value: boolean; invert: boolean = false);
  public
    function GetData: TStringList;
    function Execute(ADataSet: TDataSet): boolean;
  end;

implementation

{$R *.dfm}

{ TFGroupEdit }

procedure TFGroupEdit.btnApplyClick(Sender: TObject);
begin
  f_ok := true;
  self.Close;
end;

procedure TFGroupEdit.btnCancelClick(Sender: TObject);
begin
  f_ok := false;
  self.Close;
end;

function TFGroupEdit.GetData: TStringList;
var
  i: integer;
  s: string;

begin
  result := TStringList.Create;
  for i := 0 to Length(RecordsBase) - 1 do
    if RecordsBase[i].Used then result.Add(RecordsBase[i].GetValue);

  // из-за составных лукап полей в result-е может оказаться одна строка, содержащая #13#10,
  // которую надо разделить на 2 строки таким вот способом
  s := result.Text;
  result.Text := s;
end;

function TFGroupEdit.Execute(ADataSet: TDataSet): boolean;
var
  i: integer;

begin
  if ADataSet = nil then
    raise Exception.Create('Отсутствует набор данных!');

  SetDataSet(ADataSet);
  for i := 0 to ScrollBox.ComponentCount - 1 do
    case ScrollBox.Components[i].Tag of
      1: TWinControl(ScrollBox.Components[i]).Anchors := [akLeft, akTop, akRight];
      2: TWinControl(ScrollBox.Components[i]).Anchors := [akTop, akRight];
    end;

  self.ShowModal;
  result := f_ok;
end;

procedure TFGroupEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caHide;
end;

procedure TFGroupEdit.FormCreate(Sender: TObject);
begin
  SetLength(RecordsBase, 0);
  f_ok := false;
end;

procedure TFGroupEdit.FormDestroy(Sender: TObject);
begin
  FreeRecordsBase;
end;

procedure TFGroupEdit.SetDataSet(ADataSet: TDataSet);
var
  i: integer;
  _top: integer;

begin
  FreeRecordsBase;
  FDataSet := ADataSet;
  FDataSet.DisableControls;
  _top := 6;
  try
    for i := 0 to FDataSet.Fields.Count - 1 do
    begin
      if FDataSet.Fields.Fields[i].FieldKind = fkCalculated then continue;
      if FDataSet.Fields.Fields[i].Visible and (not FDataSet.Fields.Fields[i].ReadOnly) then
      begin
        SetLength(RecordsBase, Length(RecordsBase) + 1);
        RecordsBase[High(RecordsBase)] := TRecordBase.Create(ScrollBox, _top, FDataSet.Fields.Fields[i]);
        _top := _top + CTRLHEIGHT + 1;
      end;
    end;
  finally
    FDataSet.EnableControls;
  end;
end;

procedure TFGroupEdit.FreeRecordsBase;
var
  i: integer;

begin
  for i := 0 to Length(RecordsBase) - 1 do
    if Assigned(RecordsBase[i]) then FreeAndNil(RecordsBase[i]);
  SetLength(RecordsBase, 0);
end;

procedure TFGroupEdit.SetChecked(value: boolean; invert: boolean);
var
  i: integer;

begin
  for i := 0 to Length(RecordsBase) - 1 do
    if invert then
      RecordsBase[i].Used := not RecordsBase[i].Used
    else
      RecordsBase[i].Used := value;
end;

procedure TFGroupEdit.btnCheckClick(Sender: TObject);
begin
  SetChecked(true);
end;

procedure TFGroupEdit.btnUncheckClick(Sender: TObject);
begin
  SetChecked(false);
end;

procedure TFGroupEdit.btnInvertClick(Sender: TObject);
begin
  SetChecked(true, true);
end;

{ TRecordBase }

procedure TRecordBase.ChangeField(AParent: TWinControl; ATop: integer; AField: TField);
var
  bm: TBookmark;
  asf: TDataSetNotifyEvent;

begin
  asf := nil;
  DataField := AField;

  FUsed := TCheckBox.Create(AParent);
  if FField.DisplayName = '' then
    FUsed.Caption := FField.FieldName
  else
    FUsed.Caption := FField.DisplayName;
  FUsed.Checked := false;
  FUsed.Height := CTRLHEIGHT - 4;
  FUsed.Left := 8;
  FUsed.Visible := true;
  FUsed.Top := ATop + 2;
  FUsed.Width := 180;
  FUsed.Parent := AParent;
  FUsed.Tag := 1;
  FUsed.OnClick := CheckBoxClick;

  case FObjType of
    otVariant, otString:
    begin
      ValueObj := TComboBox.Create(AParent);
      ValueObj.Parent := AParent;
      TComboBox(ValueObj).Style := csDropDown;
      TComboBox(ValueObj).Text := '';

      if TFGroupEdit(AParent.Owner).FDataSet.RecordCount < FILLRECLIMIT then
      begin
        bm := TFGroupEdit(AParent.Owner).FDataSet.GetBookmark;
        if Assigned(TFGroupEdit(AParent.Owner).FDataSet.AfterScroll) then
        begin
          asf := TFGroupEdit(AParent.Owner).FDataSet.AfterScroll;
          TFGroupEdit(AParent.Owner).FDataSet.AfterScroll := nil;
        end;
        TFGroupEdit(AParent.Owner).FDataSet.DisableControls;
        try
          TFGroupEdit(AParent.Owner).FDataSet.First;
          while not TFGroupEdit(AParent.Owner).FDataSet.Eof do
          begin
            if (TFGroupEdit(AParent.Owner).FDataSet.FieldByName(FField.FieldName).AsString <> '') and
              (TComboBox(ValueObj).Items.IndexOf(TFGroupEdit(AParent.Owner).FDataSet.FieldByName(FField.FieldName).AsString) < 0) then
              TComboBox(ValueObj).Items.Add(TFGroupEdit(AParent.Owner).FDataSet.FieldByName(FField.FieldName).AsString);
            TFGroupEdit(AParent.Owner).FDataSet.Next;
          end;
        finally
          if Assigned(bm) and TFGroupEdit(AParent.Owner).FDataSet.BookmarkValid(bm) then
          begin
            TFGroupEdit(AParent.Owner).FDataSet.GotoBookmark(bm);
            TFGroupEdit(AParent.Owner).FDataSet.FreeBookmark(bm);
          end;
          if Assigned(asf) then
          begin
            TFGroupEdit(AParent.Owner).FDataSet.AfterScroll := asf;
            asf := nil;
          end;
          TFGroupEdit(AParent.Owner).FDataSet.EnableControls;
        end;
      end;
    end;
    otInt, otFloat:
    begin
      ValueObj := {$IFDEF EHLIB}TDBNumberEditEh{$ELSE}TRxSpinEdit{$ENDIF}.Create(AParent);
      ValueObj.Parent := AParent;
      {$IFDEF EHLIB}TDBNumberEditEh{$ELSE}TRxSpinEdit{$ENDIF}(ValueObj).AutoSize := false;
      {$IFDEF EHLIB}TDBNumberEditEh{$ELSE}TRxSpinEdit{$ENDIF}(ValueObj).Increment := 1;
      {$IFDEF EHLIB}
      TDBNumberEditEh(ValueObj).EditButton.Style := ebsUpDownEh;
      TDBNumberEditEh(ValueObj).EditButton.Visible := true;
      {$ELSE}
      TRxSpinEdit(ValueObj).ButtonKind := bkClassic;
      {$ENDIF}
      if FObjType = otInt then
      begin
        {$IFDEF EHLIB}
        TDBNumberEditEh(ValueObj).DecimalPlaces := 0;
        {$ELSE}
        TRxSpinEdit(ValueObj).ValueType := vtInteger;
        TRxSpinEdit(ValueObj).Decimal := 0;
        {$ENDIF}
      end else
      begin
        {$IFDEF EHLIB}
        TDBNumberEditEh(ValueObj).DecimalPlaces := 5;
        {$ELSE}
        TRxSpinEdit(ValueObj).ValueType := vtFloat;
        TRxSpinEdit(ValueObj).Decimal := 5;
        {$ENDIF}
      end;
      {$IFDEF EHLIB}TDBNumberEditEh{$ELSE}TRxSpinEdit{$ENDIF}(ValueObj).Value := 0;
      {$IFNDEF EHLIB}
      TRxSpinEdit(ValueObj).EditorEnabled := true;
      {$ENDIF}
    end;
    otDateTime, otDate, otTime:
    begin
      ValueObj := TDateTimePicker.Create(AParent);
      ValueObj.Parent := AParent;
      TDateTimePicker(ValueObj).DateTime := Now;
      TDateTimePicker(ValueObj).DateFormat := dfShort;
      if FObjType = otTime then
      begin
        TDateTimePicker(ValueObj).DateMode := dmUpDown;
        TDateTimePicker(ValueObj).Kind := dtkTime;
      end else
      begin
        TDateTimePicker(ValueObj).DateMode := dmComboBox;
        TDateTimePicker(ValueObj).Kind := dtkDate;
      end;
    end;
    otLookup:
    begin
      {$IFDEF EHLIB}
      ValueObj := TDBLookupComboBoxEh.Create(AParent);
      ValueObj.Parent := AParent;
      TDBLookupComboBoxEh(ValueObj).DropDownBox.Align := daLeft;
      TDBLookupComboBoxEh(ValueObj).DropDownBox.Rows := 7;
      TDBLookupComboBoxEh(ValueObj).ListSource := FLookupSource;
      TDBLookupComboBoxEh(ValueObj).KeyField := FField.LookupKeyFields;
      TDBLookupComboBoxEh(ValueObj).ListField := FField.LookupResultField;
      {$ELSE}
      ValueObj := TRxDBLookupCombo.Create(AParent);
      ValueObj.Parent := AParent;
      TRxDBLookupCombo(ValueObj).DropDownAlign := daLeft;
      TRxDBLookupCombo(ValueObj).DropDownCount := 7;
      TRxDBLookupCombo(ValueObj).FieldsDelimiter := LOOKUPFIELDSDELIM;
      TRxDBLookupCombo(ValueObj).LookupSource := FLookupSource;
      TRxDBLookupCombo(ValueObj).LookupField := FField.LookupKeyFields;
      TRxDBLookupCombo(ValueObj).LookupDisplay := FField.LookupResultField;
      {$ENDIF}
    end;
  end;

  ValueObj.Width := CTRLWIDHT;
  ValueObj.Height := CTRLHEIGHT;
  ValueObj.Top := ATop;
  ValueObj.Left := CTRLLEFT;
  ValueObj.Visible := true;
  ValueObj.Tag := 2;
  ValueObj.Parent := AParent;
  CheckBoxClick(FUsed);
end;

procedure TRecordBase.CheckBoxClick(Sender: TObject);
begin
  if Assigned(ValueObj) then ValueObj.Enabled := TCheckBox(Sender).Checked;
  if TCheckBox(Sender).Checked then
    try
      TWinControl(ValueObj).SetFocus;
    except
    end;
end;

constructor TRecordBase.Create(AParent: TWinControl; ATop: integer; AField: TField);
begin
  inherited Create;
  ChangeField(AParent, ATop, AField);
end;

destructor TRecordBase.Destroy;
begin
  if Assigned(ValueObj) then FreeAndNil(ValueObj);
  if Assigned(FUsed) then FreeAndNil(FUsed);
  if Assigned(FLookupSource) then FreeAndNil(FLookupSource);
  inherited;
end;

function TRecordBase.GetUsed: boolean;
begin
  result := FUsed.Checked;
end;

function TRecordBase.GetValue: string;
var
  i: integer;
  slFields1, slFields2, slValues: TStringList;

begin
  result := '';
  if not Assigned(ValueObj) then exit;
  case FObjType of
    otVariant, otString: result := FField.FieldName + '=' + TComboBox(ValueObj).Text;
    otInt:
      if VarIsNull({$IFDEF EHLIB}TDBNumberEditEh{$ELSE}TRxSpinEdit{$ENDIF}(ValueObj).Value) then
        result := FField.FieldName + '='
      else result := FField.FieldName + '=' +
        IntToStr({$IFDEF EHLIB}TDBNumberEditEh(ValueObj).Value{$ELSE}TRxSpinEdit(ValueObj).AsInteger{$ENDIF});
    otFloat:
      if VarIsNull({$IFDEF EHLIB}TDBNumberEditEh{$ELSE}TRxSpinEdit{$ENDIF}(ValueObj).Value) then
        result := FField.FieldName + '='
      else result := FField.FieldName + '=' +
        FloatToStr({$IFDEF EHLIB}TDBNumberEditEh{$ELSE}TRxSpinEdit{$ENDIF}(ValueObj).Value);
    otDateTime, otDate: result := FField.FieldName + '=' + DateToStr(TDateTimePicker(ValueObj).DateTime);
    otTime: result := FField.FieldName + '=' + TimeToStr(TDateTimePicker(ValueObj).DateTime);
    otLookup:
    begin
      slFields1 := TStringList.Create;
      slFields1.Delimiter := LOOKUPFIELDSDELIM;
      slFields1.DelimitedText := {$IFDEF EHLIB}TDBLookupComboBoxEh(ValueObj).KeyField{$ELSE}
        TRxDBLookupCombo(ValueObj).LookupField{$ENDIF};

      slFields2 := TStringList.Create;
      slFields2.Delimiter := LOOKUPFIELDSDELIM;
      slFields2.DelimitedText := FField.KeyFields;

      slValues := TStringList.Create;

      if slFields1.Count > 1 then
        for i := 0 to slFields1.Count - 1 do
          slValues.Add(VarToStr({$IFDEF EHLIB}TDBLookupComboBoxEh{$ELSE}TRxDBLookupCombo{$ENDIF}
            (ValueObj).KeyValue[i]))
      else
        slValues.Add(VarToStr({$IFDEF EHLIB}TDBLookupComboBoxEh{$ELSE}TRxDBLookupCombo{$ENDIF}
          (ValueObj).KeyValue));

      for i := 0 to slFields1.Count - 1 do
        if result = '' then result := slFields2.Strings[i] + '=' + slValues.Strings[i]
        else result := result + #13#10 + slFields2.Strings[i] + '=' + slValues.Strings[i];

      slFields1.Free;
      slFields2.Free;
      slValues.Free;
    end;
  end;
end;

procedure TRecordBase.SetField(AField: TField);
begin
  FField := AField;
  if FField.FieldKind = fkLookup then
  begin
    FObjType := otLookup;
    FLookupDataSet := TDataSet(FField.LookupDataSet);
    if Assigned(FLookupSource) then FreeAndNil(FLookupSource);
    FLookupSource := TDataSource.Create(nil);
    FLookupSource.DataSet := FLookupDataSet;
  end else
    case FField.DataType of
      ftUnknown, ftString, ftBlob, ftMemo, ftFmtMemo, ftFixedChar, ftWideString, ftOraBlob, ftOraClob, ftVariant, ftGuid:
        FObjType := otString;
      ftSmallint, ftInteger, ftWord, ftBoolean, ftAutoInc, ftLargeint: FObjType := otInt;
      ftFloat, ftCurrency: FObjType := otFloat;
      ftDateTime, ftTimeStamp, ftTime: FObjType := otDateTime;
      ftDate: FObjType := otDate;
      else FObjType := otVariant;
    end;
end;

procedure TRecordBase.SetTop(value: integer);
begin
  if value < 0 then exit;
  FTop := value;
  FUsed.Top := FTop + 2;
  ValueObj.Top := FTop;
end;

procedure TRecordBase.SetUsed(value: boolean);
begin
  FUsed.Checked := value;
  CheckBoxClick(FUsed);
end;

end.
