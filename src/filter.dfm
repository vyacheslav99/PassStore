object fFilter: TfFilter
  Left = 483
  Top = 277
  BorderStyle = bsSizeToolWin
  Caption = #1060#1080#1083#1100#1090#1088
  ClientHeight = 524
  ClientWidth = 592
  Color = clBtnFace
  Constraints.MinHeight = 549
  Constraints.MinWidth = 600
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 427
    Width = 592
    Height = 97
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      592
      97)
    object Label1: TLabel
      Left = 4
      Top = 1
      Width = 209
      Height = 13
      Caption = #1055#1088#1077#1076#1074#1072#1088#1080#1090#1077#1083#1100#1085#1099#1081' '#1087#1088#1086#1089#1084#1086#1090#1088' '#1074#1099#1088#1072#1078#1077#1085#1080#1103':'
    end
    object btnApply: TBitBtn
      Left = 499
      Top = 15
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
      Left = 499
      Top = 69
      Width = 90
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = #1047#1072#1082#1088#1099#1090#1100
      TabOrder = 2
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
    object btnOff: TBitBtn
      Left = 499
      Top = 42
      Width = 90
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1057#1085#1103#1090#1100
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnOffClick
    end
    object rePreview: TRichEdit
      Left = 3
      Top = 15
      Width = 490
      Height = 79
      TabStop = False
      Anchors = [akLeft, akTop, akRight, akBottom]
      Color = 12579583
      PlainText = True
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 3
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 28
    Width = 592
    Height = 399
    ActivePage = tsGeneral
    Align = alClient
    TabOrder = 1
    TabStop = False
    OnChange = PageControl1Change
    object tsGeneral: TTabSheet
      Caption = #1054#1089#1085#1086#1074#1085#1086#1081
      ImageIndex = 1
      DesignSize = (
        584
        371)
      object ScrollBox2: TScrollBox
        Left = 0
        Top = 0
        Width = 584
        Height = 352
        HorzScrollBar.Tracking = True
        VertScrollBar.Tracking = True
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 0
      end
      object rbnOr: TRadioButton
        Left = 198
        Top = 354
        Width = 43
        Height = 17
        Anchors = [akLeft, akBottom]
        Caption = #1048#1051#1048
        TabOrder = 1
        OnClick = rbnOrClick
      end
      object rbnAnd: TRadioButton
        Left = 245
        Top = 354
        Width = 30
        Height = 17
        Anchors = [akLeft, akBottom]
        Caption = #1048
        TabOrder = 2
        OnClick = rbnOrClick
      end
      object chbAddOldFilter: TCheckBox
        Left = 1
        Top = 354
        Width = 193
        Height = 17
        Hint = #1044#1086#1073#1072#1074#1083#1103#1077#1090' '#1089#1086#1079#1076#1072#1085#1085#1099#1081' '#1092#1080#1083#1100#1090#1088' '#1082' '#1088#1072#1085#1077#1077' '#1091#1089#1090#1072#1085#1086#1074#1083#1077#1085#1085#1086#1084#1091' '#1092#1080#1083#1100#1090#1088#1091
        Anchors = [akLeft, akBottom]
        Caption = #1054#1073#1098#1077#1076#1080#1085#1103#1090#1100' '#1089' '#1090#1077#1082#1091#1097#1080#1084' '#1092#1080#1083#1100#1090#1088#1086#1084':'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = chbAddOldFilterClick
      end
    end
    object tsExtended: TTabSheet
      Caption = #1056#1072#1089#1096#1080#1088#1077#1085#1085#1099#1081
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 399
      object ToolBar1: TToolBar
        Left = 0
        Top = 0
        Width = 584
        Height = 25
        Caption = 'ToolBar1'
        EdgeBorders = [ebLeft, ebTop, ebRight, ebBottom]
        EdgeInner = esNone
        EdgeOuter = esRaised
        Images = ImageList1
        TabOrder = 0
        object btnAdd: TToolButton
          Left = 0
          Top = 0
          Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1089#1090#1088#1086#1082#1091
          Caption = #1044#1086#1073#1072#1074#1080#1090#1100
          ImageIndex = 1
          ParentShowHint = False
          ShowHint = True
          OnClick = btnAddClick
        end
        object btnDelete: TToolButton
          Left = 23
          Top = 0
          Hint = #1059#1076#1072#1083#1080#1090#1100' '#1089#1090#1088#1086#1082#1091
          Caption = #1059#1076#1072#1083#1080#1090#1100
          Enabled = False
          ImageIndex = 0
          ParentShowHint = False
          ShowHint = True
          OnClick = btnDeleteClick
        end
        object btnClear: TToolButton
          Left = 46
          Top = 0
          Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1092#1080#1083#1100#1090#1088
          Caption = #1054#1095#1080#1089#1090#1080#1090#1100
          ImageIndex = 2
          ParentShowHint = False
          ShowHint = True
          OnClick = btnClearClick
        end
        object ToolButton1: TToolButton
          Left = 69
          Top = 0
          Width = 8
          Caption = 'ToolButton1'
          ImageIndex = 3
          Style = tbsSeparator
          Visible = False
        end
        object btnHelp: TToolButton
          Left = 77
          Top = 0
          Hint = #1055#1086#1076#1089#1082#1072#1079#1082#1072
          Caption = 'btnHelp'
          ImageIndex = 3
          ParentShowHint = False
          ShowHint = True
          Visible = False
          OnClick = btnHelpClick
        end
      end
      object ScrollBox1: TScrollBox
        Left = 0
        Top = 25
        Width = 584
        Height = 346
        HorzScrollBar.Tracking = True
        VertScrollBar.Tracking = True
        Align = alClient
        BorderStyle = bsNone
        TabOrder = 1
        ExplicitHeight = 374
        DesignSize = (
          584
          346)
        object lbCapField: TStaticText
          Left = 52
          Top = 1
          Width = 132
          Height = 17
          Alignment = taCenter
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = #1057#1090#1086#1083#1073#1077#1094
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
        end
        object lbCapExpr: TStaticText
          Left = 185
          Top = 1
          Width = 120
          Height = 17
          Alignment = taCenter
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = #1059#1089#1083#1086#1074#1080#1077
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
        end
        object lbCapValue: TStaticText
          Left = 306
          Top = 1
          Width = 278
          Height = 17
          Alignment = taCenter
          Anchors = [akLeft, akTop, akRight]
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = #1047#1085#1072#1095#1077#1085#1080#1077
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
        end
        object lbCapConcat: TStaticText
          Left = 1
          Top = 1
          Width = 50
          Height = 17
          Hint = #1057#1087#1086#1089#1086#1073' '#1086#1073#1098#1077#1076#1080#1085#1077#1085#1080#1103' '#1089#1090#1086#1083#1073#1094#1086#1074' ('#1080' / '#1080#1083#1080')'
          Alignment = taCenter
          AutoSize = False
          BorderStyle = sbsSingle
          Caption = #1057#1087#1086#1089#1086#1073
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 592
    Height = 28
    Align = alTop
    TabOrder = 2
    object chbCaseSensitive: TCheckBox
      Left = 5
      Top = 6
      Width = 124
      Height = 17
      Hint = #1042#1082#1083#1102#1095#1080#1090#1100' '#1095#1091#1074#1089#1090#1074#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100' '#1092#1080#1083#1100#1090#1088#1072' '#1082' '#1088#1077#1075#1080#1089#1090#1088#1091' '#1089#1080#1084#1074#1086#1083#1086#1074
      Caption = #1059#1095#1080#1090#1099#1074#1072#1090#1100' '#1088#1077#1075#1080#1089#1090#1088
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = chbCaseSensitiveClick
    end
  end
  object ImageList1: TImageList
    Left = 368
    Top = 48
    Bitmap = {
      494C010104000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
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
      00000000000000000000000000000000000000000000FFFFFF0000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000EEEEE9FFEEEEE9FFEEEEE9FFEEEE
      E9FFEEEEE9FFEEEEE9FFEEEEE9FFEEEEE9FFEEEEE9FFEEEEE9FFEEEEE9FFEEEE
      E9FFEEEEE9FFEEEEE9FFEEEEE9FFEEEEE9FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      000000000000000000000000000000000000EEEEE9FFEEEEE9FFEEEEE9FFEEEE
      E9FFDEB58CFFB58C63FFA56B31FF8C5229FF9C6342FFA56B39FFA5845AFFD6AD
      84FFEEEEE9FFEEEEE9FFEEEEE9FFEEEEE9FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009C3100009C3100009C3100009C310000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008484840000009C0000009C0000009C0000000000000000000000
      000000000000000000000000000000000000EEEEE9FFEEEEE9FFEEEEE9FFCE9C
      73FFC68C63FFE7CEB5FFF7F7F7FFFFFFFFFFFFFFFFFFF7F7F7FFE7CEC6FFB58C
      63FFAD8C6BFFEEEEE9FFEEEEE9FFEEEEE9FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009C310000CE630000CE6300009C310000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00848484000000CE0000009C0000009C0000009C0000009C00000000000000
      000000000000000000000000000000000000EEEEE9FFEEEEE9FFD6A573FFE7AD
      84FFFFF7E7FFE7BDA5FFD68452FFC65A21FFC65A21FFD68452FFE7BDA5FFF7EF
      E7FFB59473FFB59473FFEEEEE9FFEEEEE9FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009C310000CE630000CE6300009C310000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000CE000000CE000000CE0000009C0000009C0000009C0000009C000000
      000000000000000000000000000000000000EEEEE9FFEFC69CFFD69C73FFFFF7
      E7FFE7AD94FFC65210FFC65210FFE7AD94FFFFFFFFFFB54A10FFB54A10FFD6A5
      84FFF7F7E7FFAD8463FFD6B594FFEEEEE9FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009C310000CE630000CE6300009C310000000000000000
      000000000000000000000000000000000000FFFFFF0000000000FFFFFF000000
      00000000FF000000CE000000CE000000CE0000009C0000009C0000009C00009C
      9C0000000000000000000000000000000000EEEEE9FFD6A57BFFF7DEC6FFF7CE
      B5FFE75A21FFD65A10FFD65210FFE78452FFE7AD84FFC65210FFB54A10FFB54A
      10FFE7BDA5FFE7CEC6FFA58C63FFEEEEE9FF00000000000000009C3100009C31
      00009C3100009C3100009C3100009C3100009C3100009C3100009C3100009C31
      00009C3100009C310000000000000000000000000000000000009C3100009C31
      00009C3100009C3100009C310000CE630000CE6300009C3100009C3100009C31
      00009C3100009C31000000000000000000000000000000000000000000000000
      00000000FF000000FF000000CE000000CE000000CE0000009C00009C9C0000CE
      CE00009C9C00000000000000000000000000EEEEE9FFD68C52FFFFFFF7FFF79C
      73FFF76321FFE75A21FFE75A21FFF7AD94FFFFFFFFFFD65210FFC65210FFB552
      10FFC67B52FFF7F7F7FF9C634AFFEEEEE9FF00000000000000009C310000CE63
      0000CE630000CE630000CE630000CE630000CE630000CE630000CE630000CE63
      0000CE6300009C310000000000000000000000000000000000009C310000CE63
      0000CE630000CE630000CE630000CE630000CE630000CE630000CE630000CE63
      0000CE6300009C31000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF000000CE000000CE00009C9C0000CECE0000CE
      CE0000CECE00009C9C000000000000000000EEEEE9FFD6844AFFFFFFFFFFFF7B
      42FFFF6B31FFF76B21FFF76321FFF78C52FFFFFFFFFFF7C6B5FFC65A21FFB552
      10FFB55A21FFFFFFFFFF8C5A31FFEEEEE9FF00000000000000009C310000CE63
      0000CE630000CE630000CE630000CE630000CE630000CE630000CE630000CE63
      0000CE6300009C310000000000000000000000000000000000009C310000CE63
      0000CE630000CE630000CE630000CE630000CE630000CE630000CE630000CE63
      0000CE6300009C31000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000840000CECE0000FFFF0000FFFF0000CE
      CE0000CECE0000CECE00009C9C0000000000EEEEE9FFD68C52FFFFFFFFFFFF84
      52FFFF7331FFFF6B31FFFF6B31FFFF6B21FFF79463FFFFFFF7FFF7DEC6FFC652
      21FFC65A21FFFFFFFFFF8C5A31FFEEEEE9FF00000000000000009C3100009C31
      00009C3100009C3100009C3100009C3100009C3100009C3100009C3100009C31
      00009C3100009C310000000000000000000000000000000000009C3100009C31
      00009C3100009C3100009C310000CE630000CE6300009C3100009C3100009C31
      00009C3100009C31000000000000000000000000000000000000000000000000
      000000000000000000000000000000CECE0000FFFF00FFFFFF00C6C6C60000FF
      FF0000CECE0000CECE0000CECE00009C9C00EEEEE9FFDE9C6BFFFFFFF7FFFFAD
      84FFFF7342FFFF8C52FFFFB594FFFF7331FFF76B21FFF79473FFFFFFFFFFF784
      52FFD68C63FFFFF7F7FFA58452FFEEEEE9FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009C310000CE630000CE6300009C310000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000CECE0000FFFF00FFFFFF00C6C6
      C60000FFFF0000CECE00009C9C009C310000EEEEE9FFE7B58CFFF7DEC6FFFFD6
      C6FFFF7B42FFFF9C73FFFFFFFFFFFFCEB5FFFF9463FFFFCEB5FFFFFFF7FFF77B
      42FFF7CEB5FFE7CEB5FFCEAD84FFEEEEE9FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009C310000CE630000CE6300009C310000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000CECE0000FFFF00FFFF
      FF0000FFFF00009C9C00CE6300009C310000EEEEE9FFF7D6B5FFE7A573FFFFFF
      F7FFFFC6A5FFFF7B42FFFFBDA5FFFFFFF7FFFFFFFFFFFFF7E7FFFF9C73FFF7BD
      A5FFFFF7E7FFC6945AFFEFCEADFFEEEEE9FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009C310000CE630000CE6300009C310000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000CECE0000FF
      FF0000CECE00CE630000CE630000CE630000EEEEE9FFEEEEE9FFE7C69CFFE7BD
      A5FFFFFFF7FFFFD6C6FFFFAD84FFFF8C52FFFF8C52FFFFAD84FFF7D6C6FFFFF7
      E7FFD6AD84FFDEB594FFEEEEE9FFEEEEE9FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009C3100009C3100009C3100009C310000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000CE
      CE00FF9C0000FF9C0000CE630000CE630000EEEEE9FFEEEEE9FFEEEEE9FFE7C6
      9CFFE7A573FFF7DEC6FFFFFFF7FFFFFFFFFFFFFFFFFFFFFFF7FFF7DEC6FFC69C
      6BFFDEC69CFFEEEEE9FFEEEEE9FFEEEEE9FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C310000FF9C0000FF9C0000CE630000EEEEE9FFEEEEE9FFEEEEE9FFEEEE
      E9FFF7D6BDFFE7BD94FFE7B58CFFD6A57BFFD69C63FFDEA584FFDEB594FFF7DE
      C6FFEEEEE9FFEEEEE9FFEEEEE9FFEEEEE9FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009C310000FF9C0000FF9C0000EEEEE9FFEEEEE9FFEEEEE9FFEEEE
      E9FFEEEEE9FFEEEEE9FFEEEEE9FFEEEEE9FFEEEEE9FFEEEEE9FFEEEEE9FFEEEE
      E9FFEEEEE9FFEEEEE9FFEEEEE9FFEEEEE9FF424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFA7FF0000FFFFFFFF01FF0000
      FFFFFC3F007F0000FFFFFC3F003F0000FFFFFC3F001F0000FFFFFC3F500F0000
      C003C003F0070000C003C003F8030000C003C003FC010000C003C003FE000000
      FFFFFC3FFF000000FFFFFC3FFF800000FFFFFC3FFFC00000FFFFFC3FFFE00000
      FFFFFFFFFFF00000FFFFFFFFFFF8000000000000000000000000000000000000
      000000000000}
  end
end