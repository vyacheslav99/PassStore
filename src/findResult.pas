unit findResult;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DB, GridsEh, DBGridEh, EhLibFIB, DBGridEhGrouping, utils;

type
  TFFindResult = class(TForm)
    Panel1: TPanel;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    dsData: TDataSource;
    dbgData: TDBGridEh;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgDataDblClick(Sender: TObject);
    procedure dbgDataApplyFilter(Sender: TObject);
    procedure dbgDataFillSTFilterListValues(Sender: TCustomDBGridEh; Column: TColumnEh;
      Items: TStrings; var Processed: Boolean);
    procedure dbgDataKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    r_ok: boolean;
  public
    function ShowResult(ADataSet: TDataSet): boolean;
  end;

implementation

{$R *.dfm}

{ TFFindResult }

function TFFindResult.ShowResult(ADataSet: TDataSet): boolean;
begin
  result := false;
  dsData.DataSet := ADataSet;
  OptimizeColWidts(dbgData);
  self.ShowModal;
  result := r_ok;
end;

procedure TFFindResult.btnOkClick(Sender: TObject);
begin
  r_ok := true;
  self.Close;
end;

procedure TFFindResult.btnCancelClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFFindResult.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caHide;
end;

procedure TFFindResult.dbgDataApplyFilter(Sender: TObject);
begin
  TDBGridEh(Sender).DefaultApplyFilter;
end;

procedure TFFindResult.dbgDataDblClick(Sender: TObject);
begin
  btnOkClick(btnOk);
end;

procedure TFFindResult.dbgDataFillSTFilterListValues(Sender: TCustomDBGridEh; Column: TColumnEh;
  Items: TStrings; var Processed: Boolean);
begin
  Column.STFilter.DataField := Column.FieldName;
  Column.STFilter.ListSource := TDBGridEh(Sender).DataSource;
end;

procedure TFFindResult.dbgDataKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_RETURN) and btnOk.Visible and btnOk.Enabled then btnOkClick(btnOk);
end;

end.
