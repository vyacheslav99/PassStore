unit card;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBGridEh, Mask, DBCtrlsEh, DBLookupEh, ComCtrls;

type
  TFCard = class(TForm)
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    GroupBox1: TGroupBox;
    lbName: TLabel;
    edName: TEdit;
    lbLogin: TLabel;
    edLogin: TEdit;
    lbPass: TLabel;
    edPass: TEdit;
    lbPassPhrase: TLabel;
    edPassPhrase: TEdit;
    lbAnswer: TLabel;
    edAnswer: TEdit;
    lbKey: TLabel;
    edKey: TEdit;
    lbPass2: TLabel;
    edPass2: TEdit;
    lbDescr: TLabel;
    lbUrl: TLabel;
    edUrl: TEdit;
    lbMail: TLabel;
    edMail: TEdit;
    lbLabelId: TLabel;
    lcbLabel: TDBLookupComboboxEh;
    reDescr: TRichEdit;
  private
  public
  end;

implementation

uses main;

{$R *.dfm}

end.
