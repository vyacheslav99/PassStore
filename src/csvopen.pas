unit csvopen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, JvExMask, JvToolEdit, Buttons, utils;

type
  TFOpenCSV = class(TForm)
    Label1: TLabel;
    edFile: TJvFilenameEdit;
    GroupBox1: TGroupBox;
    chbQuote: TCheckBox;
    Label2: TLabel;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    chbIncColumns: TCheckBox;
    cbSep: TComboBox;
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

implementation

{$R *.dfm}

procedure TFOpenCSV.FormCreate(Sender: TObject);
begin
  chbQuote.Checked := CSVQuoted;
  chbIncColumns.Checked := CSVIncColumns;
  cbSep.Items.Add(TABSEP);
  cbSep.Text := CSVSep;
end;

end.
