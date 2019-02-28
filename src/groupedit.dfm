object FGroupEdit: TFGroupEdit
  Left = 428
  Top = 277
  BorderStyle = bsSizeToolWin
  Caption = #1043#1088#1091#1087#1087#1086#1074#1086#1077' '#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077
  ClientHeight = 393
  ClientWidth = 422
  Color = clBtnFace
  Constraints.MinHeight = 410
  Constraints.MinWidth = 430
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 361
    Width = 422
    Height = 32
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      422
      32)
    object btnApply: TBitBtn
      Left = 234
      Top = 4
      Width = 90
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
      Default = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnApplyClick
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000319610FF52A639FF4A9E29FF318E08FF0000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000319E21FF52A642FFC6F7DEFFB5EFC6FF429E21FF3196
        10FF000000000000000000000000000000000000000000000000000000000000
        00000000000039A631FF4AAE42FFADEFCEFF9CFFEFFF9CFFE7FF9CE7ADFF429E
        21FF000000000000000000000000000000000000000000000000000000000000
        000039AE4AFF4AB652FF94EFB5FF8CFFD6FF7BFFCEFF7BFFC6FF8CFFCEFF84DF
        9CFF399E21FF00000000000000000000000000000000000000000000000042BE
        5AFF4ABE5AFF84E7A5FF7BF7BDFF7BF7BDFF7BEFB5FF7BF7BDFF7BF7B5FF84F7
        BDFF73D784FF399E29FF000000000000000000000000000000000000000042BE
        63FF63DF8CFF6BEF9CFF73EFADFF7BE7ADFF4ABE5AFF5AC76BFF84EFB5FF7BEF
        ADFF73EFA5FF5ACF6BFF39A629FF000000000000000000000000000000004AC7
        6BFF52DF7BFF6BE794FF73E79CFF52C76BFF39AE42FF39AE42FF5ACF73FF84EF
        ADFF73E79CFF63DF8CFF42C752FF39A631FF00000000000000000000000042C7
        6BFF4ACF73FF63DF8CFF52CF73FF42B652FF000000000000000039B64AFF63CF
        7BFF84E79CFF6BDF84FF4AD76BFF39BE42FF39A639FF00000000000000000000
        00004AC773FF4ACF73FF42C76BFF0000000000000000000000000000000042B6
        52FF63CF7BFF73DF8CFF52D76BFF31C742FF39AE39FF00000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000042BE5AFF5ACF73FF5AD76BFF42BE52FF42AE4AFF00000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000042BE63FF4AC763FF42BE5AFF0000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
    end
    object btnCancel: TBitBtn
      Left = 329
      Top = 4
      Width = 90
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = #1047#1072#1082#1088#1099#1090#1100
      TabOrder = 1
      OnClick = btnCancelClick
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF000000B5001821BD000808B500FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF000808B5002129BD000000B500FF00FF00FF00FF00FF00FF00FF00FF000008
        C6003142D6008CADFF005A73E7000008BD00FF00FF00FF00FF00FF00FF000808
        BD005A73E7008CB5FF003142D6000008C600FF00FF00FF00FF00FF00FF002131
        D6007394FF007B9CFF007B9CFF005263EF000818CE00FF00FF000818CE00526B
        EF007B9CFF007B9CFF007B9CFF002931D600FF00FF00FF00FF00FF00FF001021
        DE00425AF700526BFF005263FF005A73FF00425AEF001021DE00425AEF00637B
        FF005263FF005A6BFF004A63F7001021DE00FF00FF00FF00FF00FF00FF00FF00
        FF001021E7003142F7003942FF003142FF003952FF00425AFF004252FF003139
        FF003942FF00314AF7001021E700FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF001829EF002131F7001821FF001818F7001821FF001818F7001821
        FF002131F7001829EF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF001831FF001829FF002121F7002129F7002129F7001821
        F7001831FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF001831FF003142FF004A5AFF005263FF005A6BFF005A6BFF005263
        FF00394AFF001831FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF001831FF00394AFF005263FF006373FF00637BFF006373FF006B7BFF00637B
        FF005A6BFF003952FF001831FF00FF00FF00FF00FF00FF00FF00FF00FF002131
        FF00394AFF005A63FF006373FF00738CFF00526BFF002139FF00526BFF007B94
        FF006B84FF006373FF004252FF002131FF00FF00FF00FF00FF00FF00FF002139
        FF00525AFF006373FF00738CFF00526BFF001831FF00FF00FF001831FF005A73
        FF008494FF007384FF005A6BFF002939FF00FF00FF00FF00FF00FF00FF001831
        FF00314AFF006B7BFF00526BFF001831FF00FF00FF00FF00FF00FF00FF001831
        FF005A73FF00738CFF00394AFF001831FF00FF00FF00FF00FF00FF00FF00FF00
        FF001831FF00314AFF002139FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF002139FF00314AFF001831FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
    end
  end
  object ScrollBox: TScrollBox
    Left = 0
    Top = 25
    Width = 422
    Height = 336
    HorzScrollBar.Tracking = True
    VertScrollBar.Tracking = True
    Align = alClient
    TabOrder = 0
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 422
    Height = 25
    Caption = 'ToolBar1'
    EdgeBorders = [ebLeft, ebTop, ebRight]
    Images = ImageList1
    TabOrder = 2
    object btnCheck: TToolButton
      Left = 0
      Top = 0
      Hint = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1089#1077
      Caption = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1089#1077
      ImageIndex = 0
      ParentShowHint = False
      ShowHint = True
      OnClick = btnCheckClick
    end
    object btnUncheck: TToolButton
      Left = 23
      Top = 0
      Hint = #1057#1085#1103#1090#1100' '#1074#1089#1077' '#1086#1090#1084#1077#1090#1082#1080
      Caption = #1057#1085#1103#1090#1100' '#1074#1089#1077' '#1086#1090#1084#1077#1090#1082#1080
      ImageIndex = 1
      ParentShowHint = False
      ShowHint = True
      OnClick = btnUncheckClick
    end
    object btnInvert: TToolButton
      Left = 46
      Top = 0
      Hint = #1048#1085#1074#1077#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1086#1090#1084#1077#1090#1082#1080
      Caption = #1048#1085#1074#1077#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1086#1090#1084#1077#1090#1082#1080
      ImageIndex = 2
      ParentShowHint = False
      ShowHint = True
      OnClick = btnInvertClick
    end
  end
  object ImageList1: TImageList
    Left = 368
    Top = 48
    Bitmap = {
      494C010103000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080000000000000000000000000000000000000000000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000CE9A63FF9C3000FF9C3000FFCE9A63FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080000000000000000000000000000000000000000000000000009C30
      00FF9C3000FFCE6500FFCE6500FF9C3000FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008080800000000000000000000000000000000000000000009C3000FFCE65
      00FFCE6500FF9C3000FF9C3000FFCE9A63FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008080800000000000000000000000000000000000CE9A63FF9C3000FFCE65
      00FF9C3000FFCE9A63FF00000000000000009C3000FF9C3000FF9C3000FF9C30
      00FF9C3000FF9C3000FF9C3000FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080808000000000000000000000000000000000009C3000FFCE6500FF9C30
      00FFCE9A63FF0000000000000000000000009C3000FFCE6500FFCE6500FFCE65
      00FFCE6500FFCE6500FF9C3000FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080808000000000000000000000000000000000009C3000FFCE6500FF9C30
      00FF00000000000000000000000000000000000000009C3000FFCE6500FFCE65
      00FFCE6500FFCE6500FF9C3000FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      000080808000000000000000000000000000000000009C3000FFCE6500FF9C30
      00FFCE9A63FF00000000000000000000000000000000CE9A63FF9C3000FFCE65
      00FFCE6500FFCE6500FF9C3000FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008080800000000000000000000000000000000000CE9A63FF9C3000FFCE65
      00FF9C3000FFCE9A63FF00000000CE9A63FF9C3000FF9C3000FFCE6500FF9C30
      00FFCE6500FFCE6500FF9C3000FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008080800000000000000000000000000000000000000000009C3000FFCE65
      00FFCE6500FF9C3000FF9C3000FF9C3000FFCE6500FFCE6500FF9C3000FFCE9A
      63FF9C3000FFCE6500FF9C3000FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080000000000000000000000000000000000000000000808080000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000808080000000000000000000000000000000000000000000000000009C30
      00FF9C3000FFCE6500FFCE6500FFCE6500FF9C3000FF9C3000FF000000000000
      0000000000009C3000FF9C3000FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080000000000000000000000000000000000000000000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000CE9A63FF9C3000FF9C3000FF9C3000FFCE9A63FF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFF0000FFFFFFFFFFFF0000
      FFFFFFFFFFFF0000C007C007F0FF0000DFF7DFF7E0FF0000DDF7DFF7C0FF0000
      D8F7DFF783010000D077DFF787010000D237DFF78F810000D717DFF787810000
      DF97DFF782010000DFD7DFF7C0010000DFF7DFF7E0390000C007C007F07F0000
      FFFFFFFFFFFF0000FFFFFFFFFFFF000000000000000000000000000000000000
      000000000000}
  end
end
