unit ask;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons;

type
  TFAsk = class(TForm)
    Image1: TImage;
    lbMessage: TLabel;
    btnCopy: TBitBtn;
    btnReplace: TBitBtn;
    btnSkip: TBitBtn;
    btnBreak: TBitBtn;
    chbNoAsk: TCheckBox;
    procedure FormShow(Sender: TObject);
  private
  public
  end;

implementation

{$R *.dfm}

procedure TFAsk.FormShow(Sender: TObject);
begin
  ModalResult := mrRetry;
end;

end.
