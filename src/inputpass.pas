unit inputpass;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFInputPass = class(TForm)
    GroupBox1: TGroupBox;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    Label2: TLabel;
    Label3: TLabel;
    edPass2: TEdit;
    edNewPass: TEdit;
    Label1: TLabel;
    edPass: TEdit;
    procedure edNewPassChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure CheckControls;
  public
  end;

implementation

{$R *.dfm}

procedure TFInputPass.CheckControls;
begin
  btnOk.Enabled := (edNewPass.Text <> '') and (edNewPass.Text = edPass2.Text);
end;

procedure TFInputPass.edNewPassChange(Sender: TObject);
begin
  CheckControls;
end;

procedure TFInputPass.FormShow(Sender: TObject);
begin
  CheckControls;
end;

end.
