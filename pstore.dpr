program pstore;

uses
  SysUtils,
  Forms,
  RC6 in 'src\RC6.pas',
  utils in 'src\utils.pas',
  AES in 'src\AES.pas',
  ask in 'src\ask.pas' {FAsk},
  card in 'src\card.pas' {FCard},
  connectdlg in 'src\connectdlg.pas' {FConnectDlg},
  CryptUtils in 'src\CryptUtils.pas',
  csvopen in 'src\csvopen.pas' {FOpenCSV},
  DES in 'src\DES.pas',
  filter in 'src\filter.pas' {fFilter},
  find in 'src\find.pas' {frmFind},
  findResult in 'src\findResult.pas' {FFindResult},
  gridsettings in 'src\gridsettings.pas' {FGridSettings},
  groupedit in 'src\groupedit.pas' {FGroupEdit},
  import in 'src\import.pas' {FImportParams},
  inputpass in 'src\inputpass.pas' {FInputPass},
  main in 'src\main.pas' {FMain},
  MD5 in 'src\MD5.pas',
  params in 'src\params.pas' {FParams};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Хранилище паролей';
  Application.CreateForm(TFMain, FMain);
  if AnsiLowerCase(ParamStr(1)) = 'old' then ShowOldControls := true;
  Application.Run;
end.
