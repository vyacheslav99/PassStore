object frmFind: TfrmFind
  Left = 505
  Top = 449
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = #1055#1086#1080#1089#1082
  ClientHeight = 281
  ClientWidth = 334
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    334
    281)
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 3
    Top = 3
    Width = 327
    Height = 228
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvRaised
    TabOrder = 0
    DesignSize = (
      327
      228)
    object GroupBox2: TGroupBox
      Left = 11
      Top = 95
      Width = 305
      Height = 121
      Anchors = [akLeft, akTop, akRight, akBottom]
      Caption = ' '#1054#1087#1094#1080#1080' '#1087#1086#1080#1089#1082#1072' '
      TabOrder = 1
      object Label3: TLabel
        Left = 9
        Top = 23
        Width = 74
        Height = 13
        Caption = #1056#1077#1078#1080#1084' '#1087#1086#1080#1089#1082#1072
      end
      object chbAllowRegister: TCheckBox
        Left = 10
        Top = 48
        Width = 123
        Height = 17
        Hint = #1057' '#1091#1095#1077#1090#1086#1084' '#1088#1077#1075#1080#1089#1090#1088#1072' '#1073#1091#1082#1074' '#1080#1083#1080' '#1073#1077#1079
        TabStop = False
        Caption = #1059#1095#1080#1090#1099#1074#1072#1090#1100' '#1088#1077#1075#1080#1089#1090#1088
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = chbAllowRegisterClick
      end
      object chbToExistence: TCheckBox
        Left = 180
        Top = 71
        Width = 99
        Height = 17
        Hint = 
          #1055#1088#1086#1074#1077#1088#1103#1090#1100' '#1085#1072' '#1074#1093#1086#1078#1076#1077#1085#1080#1077' '#1080#1089#1082#1086#1084#1086#1075#1086' '#1090#1077#1082#1089#1090#1072' '#1074' '#1076#1072#1085#1085#1099#1093' '#1080#1083#1080' '#1085#1072' '#1087#1086#1083#1085#1086#1077' '#1077#1075 +
          #1086' '#1089#1086#1074#1087#1072#1076#1077#1085#1080#1077
        TabStop = False
        Caption = #1055#1086' '#1074#1093#1086#1078#1076#1077#1085#1080#1102
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = chbToExistenceClick
      end
      object chbRegular: TCheckBox
        Left = 180
        Top = 48
        Width = 105
        Height = 17
        Hint = #1053#1072#1095#1080#1085#1072#1090#1100' '#1087#1086#1080#1089#1082' '#1089#1085#1072#1095#1072#1083#1072' '#1087#1088#1080' '#1076#1086#1089#1090#1080#1078#1077#1085#1080#1080' '#1082#1086#1085#1094#1072' '#1080#1083#1080' '#1086#1089#1090#1072#1085#1086#1074#1080#1090#1100#1089#1103
        TabStop = False
        Caption = #1055#1086#1080#1089#1082' '#1087#1086' '#1082#1088#1091#1075#1091
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = chbRegularClick
      end
      object chbAllWords: TCheckBox
        Left = 180
        Top = 96
        Width = 119
        Height = 17
        Hint = 
          #1055#1086#1080#1089#1082' '#1073#1091#1076#1077#1090' '#1091#1089#1087#1077#1096#1085#1099#1084', '#1077#1089#1083#1080' '#1074' '#1089#1088#1072#1074#1085#1080#1074#1072#1077#1084#1086#1081' '#1089#1090#1088#1086#1082#1077' '#1073#1091#1076#1091#1090' '#1074#1089#1090#1088#1077#1095#1072#1090#1100 +
          #1089#1103' '#1074#1089#1077' '#1089#1083#1086#1074#1072' '#1089#1090#1088#1086#1082#1080' '#1087#1086#1080#1089#1082#1072' '#1074' '#1083#1102#1073#1086#1084' '#1087#1086#1088#1103#1076#1082#1077'.'
        TabStop = False
        Caption = #1053#1072#1083#1080#1095#1080#1077' '#1074#1089#1077#1093' '#1089#1083#1086#1074
        Enabled = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = chbAllWordsClick
      end
      object chbAnyWord: TCheckBox
        Left = 10
        Top = 96
        Width = 137
        Height = 17
        Hint = 
          #1055#1086#1080#1089#1082' '#1073#1091#1076#1077#1090' '#1089#1095#1080#1090#1072#1090#1100#1089#1103' '#1091#1076#1072#1095#1085#1099#1084', '#1077#1089#1083#1080' '#1074' '#1089#1088#1072#1074#1085#1080#1074#1072#1077#1084#1086#1081' '#1089#1090#1088#1086#1082#1077' '#1073#1091#1076#1077#1090' ' +
          #1085#1072#1081#1076#1077#1085#1086' '#1093#1086#1090#1103' '#1073#1099' '#1086#1076#1085#1086' '#1080#1079' '#1089#1083#1086#1074' '#1089#1090#1088#1086#1082#1080' '#1087#1086#1080#1089#1082#1072', '#1088#1072#1079#1076#1077#1083#1077#1085#1085#1099#1093' '#1087#1088#1086#1073#1077#1083#1086#1084 +
          '.'
        TabStop = False
        Caption = #1053#1072#1083#1080#1095#1080#1077' '#1083#1102#1073#1086#1075#1086' '#1089#1083#1086#1074#1072
        Enabled = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = chbAnyWordClick
      end
      object cbFindMode: TComboBox
        Left = 89
        Top = 19
        Width = 208
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnChange = cbFindModeChange
        Items.Strings = (
          #1054#1073#1099#1095#1085#1099#1081
          #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1099
          #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1099)
      end
      object chbSaveQuery: TCheckBox
        Left = 10
        Top = 71
        Width = 151
        Height = 17
        Caption = #1055#1086#1084#1085#1080#1090#1100' '#1091#1089#1083#1086#1074#1080#1103' '#1087#1086#1080#1089#1082#1072
        TabOrder = 6
        OnClick = chbSaveQueryClick
      end
    end
    object GroupBox1: TGroupBox
      Left = 10
      Top = 8
      Width = 306
      Height = 81
      Anchors = [akLeft, akTop, akRight]
      Caption = ' '#1055#1086#1080#1089#1082' '
      TabOrder = 0
      object Label1: TLabel
        Left = 10
        Top = 21
        Width = 42
        Height = 13
        Caption = #1057#1090#1086#1083#1073#1077#1094
      end
      object Label2: TLabel
        Left = 10
        Top = 52
        Width = 31
        Height = 13
        Caption = #1053#1072#1081#1090#1080
      end
      object cbFieldName: TComboBox
        Left = 60
        Top = 17
        Width = 238
        Height = 21
        Hint = #1042#1099#1073#1077#1088#1080#1090#1077' '#1089#1090#1086#1083#1073#1077#1094', '#1087#1086' '#1082#1086#1090#1086#1088#1086#1084#1091' '#1073#1091#1076#1077#1090' '#1087#1088#1086#1080#1079#1074#1077#1076#1077#1085' '#1087#1086#1080#1089#1082
        Style = csDropDownList
        ItemHeight = 13
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnChange = cbFieldNameChange
        OnKeyPress = cbFieldNameKeyPress
        OnKeyUp = cbFieldNameKeyUp
      end
      object edsData: TComboBox
        Left = 60
        Top = 48
        Width = 238
        Height = 21
        Hint = #1042#1074#1077#1076#1080#1090#1077' '#1079#1085#1072#1095#1077#1085#1080#1077', '#1082#1086#1090#1086#1088#1086#1077' '#1085#1077#1086#1073#1093#1086#1076#1080#1084#1086' '#1085#1072#1081#1090#1080
        ItemHeight = 13
        ParentShowHint = False
        ShowHint = True
        Sorted = True
        TabOrder = 1
        OnChange = edSDataChange
        OnKeyPress = cbFieldNameKeyPress
      end
    end
  end
  object btnFind: TButton
    Left = 173
    Top = 254
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1053#1072#1081#1090#1080
    Default = True
    TabOrder = 1
    OnClick = btnFindClick
  end
  object btnCancel: TButton
    Left = 255
    Top = 254
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object pProgress: TPanel
    Left = 3
    Top = 230
    Width = 327
    Height = 22
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 3
    Visible = False
    object lblRate: TLabel
      Left = 296
      Top = 4
      Width = 26
      Height = 13
      Alignment = taRightJustify
      Caption = '100%'
    end
    object ProgressBar1: TProgressBar
      Left = 6
      Top = 5
      Width = 288
      Height = 11
      Smooth = True
      TabOrder = 0
    end
  end
  object tmrStartNext: TTimer
    Interval = 1
    OnTimer = tmrStartNextTimer
    Left = 1
    Top = 226
  end
end
