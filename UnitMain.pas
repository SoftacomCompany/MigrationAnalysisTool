unit UnitMain;

interface

uses
    Forms, Winapi.Windows, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option,
    FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
    FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
    FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait,
    FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
    FireDAC.Comp.DataSet, FireDAC.Comp.Client, Datasnap.DBClient,
    System.UITypes, ClipBrd, Vcl.Graphics,
    Datasnap.Provider, Vcl.DBGrids, Vcl.Grids, Vcl.Controls, Vcl.StdCtrls,
    Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Imaging.GIFImg, System.Classes,
    System.IOUtils, TypInfo, Dialogs, System.SysUtils, System.Variants,
    ShellApi, StrUtils, Vcl.Menus, Vcl.Imaging.pngimage, CommCtrl,
    System.UIConsts;

type

    TGridCol = record
        Sort: string;
        ColNo: integer;
    end;

    TfrmMain = class(TForm)
        pcMain: TPageControl;
        tsUnits: TTabSheet;
        tsProjects: TTabSheet;
        tsProjectGroups: TTabSheet;
        tsSummary: TTabSheet;
        tsComponents: TTabSheet;
        tsSelectProject: TTabSheet;
        btnSelectFolder: TButton;
        edtRootFolder: TEdit;
        lblSelectRootFolder: TLabel;
        btnNext: TButton;
        cbProjectType: TComboBox;
        lblSelectProjectType: TLabel;
        pbAnalysisProgress: TProgressBar;
        chkIncludeSubFolders: TCheckBox;
        dbgrUnits: TDBGrid;
        dbgrProjects: TDBGrid;
        dbgrProjectGroups: TDBGrid;
        gbBDE: TGroupBox;
        lblBDE1: TLabel;
        lblBDE2: TLabel;
        lblBDE3: TLabel;
        lblCustomerPortal: TLabel;
        lblBDE4: TLabel;
        lblBDE5: TLabel;
        lblBDE6: TLabel;
        lblFireDACMigrationGuide: TLabel;
        gbProjectsStatistic: TGroupBox;
        lblInfo3: TLabel;
        lblProjectGroupsAmount: TLabel;
        lblProjectsAmount: TLabel;
        lblInfo4: TLabel;
        lblInfo5: TLabel;
        lblUnitsAmount: TLabel;
        lblInfo6: TLabel;
        lblProjectVersions: TLabel;
        lblInfo7: TLabel;
        lblLinesAmount: TLabel;
        gbStatistics: TGroupBox;
        lblInfo8: TLabel;
        lblStandardClassesAmount: TLabel;
        lblNonStandardClassesAmount: TLabel;
        lblInfo9: TLabel;
        gbPointers: TGroupBox;
        lblPointerUsage: TLabel;
        lblPointersDescription: TLabel;
        gbPlatforms: TGroupBox;
        lblInfo13: TLabel;
        lbl32Support: TLabel;
        lbl64Support: TLabel;
        lblInfo14: TLabel;
        gbUnicode: TGroupBox;
        lblUnicodeSupport: TLabel;
        lblUnicodeDescription: TLabel;
        lblUnicodeGuide: TLabel;
        lblAssemblerCode: TLabel;
        mmMainMenu: TMainMenu;
        miFile: TMenuItem;
        miNewAnalysis: TMenuItem;
        miSeparatorFile: TMenuItem;
        miClose: TMenuItem;
        miHelp: TMenuItem;
        miAbout: TMenuItem;
        dbgrComponents: TDBGrid;
        Panel2: TPanel;
        Label3: TLabel;
        Label4: TLabel;
        Panel1: TPanel;
        Image1: TImage;
        btnExportToCSV: TButton;
        btnExportToCSV2: TButton;
        btnExportToCS3: TButton;
        btnExportToCSV3: TButton;

        procedure btnSelectFolderClick(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure btnNextClick(Sender: TObject);
        procedure dbgrProjectGroupsDrawColumnCell(Sender: TObject;
          const Rect: TRect; DataCol: integer; Column: TColumn;
          State: TGridDrawState);
        procedure dbgrProjectsDrawColumnCell(Sender: TObject; const Rect: TRect;
          DataCol: integer; Column: TColumn; State: TGridDrawState);
        procedure dbgrUnitsDrawColumnCell(Sender: TObject; const Rect: TRect;
          DataCol: integer; Column: TColumn; State: TGridDrawState);
        procedure FormClose(Sender: TObject; var Action: TCloseAction);
        procedure lblCustomerPortalClick(Sender: TObject);
        procedure lblFireDACMigrationGuideClick(Sender: TObject);
        procedure lblProjectGroupsAmountClick(Sender: TObject);
        procedure lblProjectsAmountClick(Sender: TObject);
        procedure lblUnitsAmountClick(Sender: TObject);
        procedure lblStandardClassesAmountClick(Sender: TObject);
        procedure lblUnicodeGuideClick(Sender: TObject);
        procedure lbl32SupportClick(Sender: TObject);
        procedure miNewAnalysisClick(Sender: TObject);
        procedure miCloseClick(Sender: TObject);
        procedure miAboutClick(Sender: TObject);
        procedure dbgrComponentsDrawColumnCell(Sender: TObject;
          const Rect: TRect; DataCol: integer; Column: TColumn;
          State: TGridDrawState);
        procedure btnExportToCSVClick(Sender: TObject);
        function DetectUnsupportedVersion(Fld: TField): boolean;
        procedure dbgrComponentsTitleClick(Column: TColumn);
        function SortGrid(DBGrid: TDBGrid; Column: TColumn): TGridCol;
        procedure BoldGridTitle(DBGrid: TDBGrid; ColIndex: integer);
        procedure dbgrProjectGroupsTitleClick(Column: TColumn);
        procedure dbgrProjectsTitleClick(Column: TColumn);
        procedure dbgrUnitsTitleClick(Column: TColumn);
        procedure CellCopyToClipboard(Sender: TObject);
        procedure dbgrComponentsKeyPress(Sender: TObject; var Key: Char);
    private
        { Private declarations }
        procedure OnAnalysisProgress(MaxValue, CurrentPosition: integer);
        procedure OnAnalysisFinished(ProjectGroupsAmount, ProjectsAmount,
          UnitsAmount, LinesAmount, StandardClassesAmount,
          NonStandardClassesAmount: integer; IsBDEDetected, IsPointersDetected,
          IsUnicodeDetected, Is32BitSupport, Is64BitSupport, IsAssemblerDetected
          : boolean; ProjectVersions: String);

        // Enable/disable analysis tabs.
        procedure ActivateAnalysisTabs(Value: boolean);
        // Load grids columns settings from .ini file.
        procedure LoadGridColumnsSettings;
    public
        { Public declarations }
    end;

var
    frmMain: TfrmMain;

implementation

{$R *.dfm}

uses Mat.SupportedDevelopmentTools, Mat.Constants, Mat.AnalysisProcessor,
    Mat.Settings, UnitAbout, Mat.Export, Mat.Components;

procedure TfrmMain.dbgrProjectGroupsDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: integer; Column: TColumn; State: TGridDrawState);
begin
    if Assigned(Column) then
    begin
        dbgrProjectGroups.Canvas.FillRect(Rect);
        dbgrProjectGroups.Canvas.TextRect(Rect, Rect.Left, Rect.Top,
          ' ' + Column.Field.AsString);
        If Column.Fieldname = FROW_NO_FIELD_NAME then
            if dbgrProjectGroups.DataSource.DataSet.Recno > 0 then
                dbgrProjectGroups.Canvas.Textout(Rect.Left + FIELD_BORDER_WIDTH,
                  Rect.Top, inttostr
                  (dbgrProjectGroups.DataSource.DataSet.Recno));
    end;
end;

procedure TfrmMain.dbgrProjectGroupsTitleClick(Column: TColumn);
var
    GridCol: TGridCol;
begin
    GridCol := SortGrid(dbgrProjectGroups, Column);
    FAnalysisProcessor.ShowPG(GridCol.Sort);
    BoldGridTitle(dbgrProjectGroups, GridCol.ColNo);
end;

procedure TfrmMain.dbgrProjectsDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: integer; Column: TColumn; State: TGridDrawState);
begin
    if Assigned(Column) then
    begin
        dbgrProjects.Canvas.FillRect(Rect);
        dbgrProjects.Canvas.TextRect(Rect, Rect.Left, Rect.Top,
          ' ' + Column.Field.AsString);
        If Column.Fieldname = FROW_NO_FIELD_NAME then
            if dbgrProjects.DataSource.DataSet.Recno > 0 then
                dbgrProjects.Canvas.Textout(Rect.Left + FIELD_BORDER_WIDTH,
                  Rect.Top, inttostr(dbgrProjects.DataSource.DataSet.Recno));
    end;
end;

procedure TfrmMain.dbgrProjectsTitleClick(Column: TColumn);
var
    GridCol: TGridCol;
begin
    GridCol := SortGrid(dbgrProjects, Column);
    FAnalysisProcessor.ShowPj(GridCol.Sort);
    BoldGridTitle(dbgrProjects, GridCol.ColNo);
end;

procedure TfrmMain.dbgrUnitsDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: integer; Column: TColumn; State: TGridDrawState);
begin
    if Assigned(Column) then
    begin
        dbgrUnits.Canvas.FillRect(Rect);
        dbgrUnits.Canvas.TextRect(Rect, Rect.Left, Rect.Top,
          ' ' + Column.Field.AsString);
        If Column.Fieldname = FROW_NO_FIELD_NAME then
            if dbgrUnits.DataSource.DataSet.Recno > 0 then
                dbgrUnits.Canvas.Textout(Rect.Left + FIELD_BORDER_WIDTH,
                  Rect.Top, inttostr(dbgrUnits.DataSource.DataSet.Recno));
    end;
end;

procedure TfrmMain.dbgrUnitsTitleClick(Column: TColumn);
var
    GridCol: TGridCol;
begin
    GridCol := SortGrid(dbgrUnits, Column);
    FAnalysisProcessor.ShowU(GridCol.Sort);
    BoldGridTitle(dbgrUnits, GridCol.ColNo);
end;

procedure TfrmMain.ActivateAnalysisTabs(Value: boolean);
begin
    tsSummary.TabVisible := Value;
    tsProjectGroups.TabVisible := Value;
    tsProjects.TabVisible := Value;
    tsUnits.TabVisible := Value;
    tsComponents.TabVisible := Value;
end;

procedure TfrmMain.btnExportToCSVClick(Sender: TObject);
begin
    with TSaveDialog.Create(nil) do
    begin
        FileName := pcMain.ActivePage.Caption + CSV_EXT;
        Filter := CSV_FILTER;

        if Execute then
        begin
            if pcMain.ActivePage = tsProjectGroups then
                ExportHelper.ExportToCsv(FileName, dbgrProjectGroups)
            else if pcMain.ActivePage = tsProjects then
                ExportHelper.ExportToCsv(FileName, dbgrProjects)
            else if pcMain.ActivePage = tsUnits then
                ExportHelper.ExportToCsv(FileName, dbgrUnits);
            if pcMain.ActivePage = tsComponents then
                ExportHelper.ExportToCsv(FileName, dbgrComponents);
        end;
    end;
end;

procedure TfrmMain.btnNextClick(Sender: TObject);
begin
    pbAnalysisProgress.Visible := true;
    if FAnalysisProcessor.StartNewAnalysis(edtRootFolder.Text,
      chkIncludeSubFolders.Checked) then
    begin
        FAnalysisProcessor.LastFolder := edtRootFolder.Text;
        pbAnalysisProgress.Visible := true;
        Application.ProcessMessages;

        LoadGridColumnsSettings;

        pcMain.ActivePage := tsSummary;
        ActivateAnalysisTabs(true);

        MessageDlg(ANALYSIS_PROGRESS_FINISHED, TMsgDlgType.mtInformation,
          [TMsgDlgBtn.mbOK], 0);
    end
    else
        MessageDlg(ANALYSIS_PROGRESS_ROOTFOLDERNOTSPECIFIED,
          TMsgDlgType.mtWarning, [TMsgDlgBtn.mbOK], 0);
end;

procedure TfrmMain.btnSelectFolderClick(Sender: TObject);
begin
    with TFileOpenDialog.Create(nil) do
        try
            Options := [fdoPickFolders];
            if Execute then
                edtRootFolder.Text := FileName;
        finally
            free;
        end;
end;

procedure TfrmMain.dbgrComponentsDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: integer; Column: TColumn; State: TGridDrawState);
var
    Fld: TField;
begin
    if Assigned(Column) then
    begin
        Fld := dbgrComponents.DataSource.DataSet.FieldByName
          (SUPPORTED_VERSIONS_FIELD_NAME);
        if DetectUnsupportedVersion(Fld) = true then
            dbgrComponents.Canvas.Brush.Color := WARNING_COLOR;

        dbgrComponents.Canvas.FillRect(Rect);
        dbgrComponents.Canvas.TextRect(Rect, Rect.Left, Rect.Top,
          ' ' + Column.Field.AsString);

        If Column.Fieldname = FROW_NO_FIELD_NAME then
            if dbgrComponents.DataSource.DataSet.Recno > 0 then
                dbgrComponents.Canvas.Textout(Rect.Left + FIELD_BORDER_WIDTH,
                  Rect.Top, inttostr(dbgrComponents.DataSource.DataSet.Recno));
    end;
end;

procedure TfrmMain.dbgrComponentsKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = ^C then
    begin
        CellCopyToClipboard(Sender);
    end;
end;

procedure TfrmMain.dbgrComponentsTitleClick(Column: TColumn);
var
    GridCol: TGridCol;
begin
    GridCol := SortGrid(dbgrComponents, Column);
    FAnalysisProcessor.ShowC(GridCol.Sort);
    BoldGridTitle(dbgrComponents, GridCol.ColNo);
end;

function TfrmMain.DetectUnsupportedVersion(Fld: TField): boolean;
var
    S, S1, S2: string;
    i: double;
begin
    if not Fld.IsNull then
    begin
        Result := true;
        S := Fld.AsString;
        for S1 in StrUtils.SplitString(S, ',') do
        begin
            S2 := S1.Replace(' ', '');
            S2 := S2.Replace('.', FormatSettings.DecimalSeparator);
            S2 := S2.Replace(',', FormatSettings.DecimalSeparator);
            if TryStrTofloat(S2, i) then
                if i >= MAX_VERSION_WARNING then
                    Result := false;
        end;
    end
    else
        Result := false;
end;

function TfrmMain.SortGrid(DBGrid: TDBGrid; Column: TColumn): TGridCol;
begin
    FSettingsFile.SaveSettingsColumns(DBGrid);
    if DBGrid.Tag = abs(Column.Index + 1) then
        DBGrid.Tag := -1 * (Column.Index + 1)
    else if DBGrid.Tag = -(Column.Index + 1) then
        DBGrid.Tag := Column.Index + 1
    else
        DBGrid.Tag := Column.Index + 1;

    if inttostr(DBGrid.Tag)[1] <> '-' then
        Result.Sort := inttostr(Column.Index + 1) + SORT_DESC_STR
    else
        Result.Sort := inttostr(Column.Index + 1) + SORT_ASC_STR;

    Result.ColNo := Column.Index;
end;

procedure TfrmMain.BoldGridTitle(DBGrid: TDBGrid; ColIndex: integer);
var
    i: integer;
begin
    for i := 0 to DBGrid.Columns.Count - 1 do
    begin
        if (ColIndex = i) then
        begin
            DBGrid.Columns[i].Title.Font.Style := DBGrid.Columns[i]
              .Title.Font.Style + [TFontStyle.fsBold];
        end
        else
        begin
            DBGrid.Columns[i].Title.Font.Style := DBGrid.Columns[i]
              .Title.Font.Style - [TFontStyle.fsBold];
        end;
    end;
    FSettingsFile.LoadSettingsColumns(DBGrid);
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    FSettingsFile.SaveSettingsColumns(frmMain.dbgrUnits);
    FSettingsFile.SaveSettingsColumns(frmMain.dbgrProjects);
    FSettingsFile.SaveSettingsColumns(frmMain.dbgrProjectGroups);
    FSettingsFile.SaveSettingsColumns(frmMain.dbgrComponents);
    FSettingsFile.SaveSettingsOther;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
    i: integer;
begin
    // Form and UI initialization.
    pcMain.ActivePage := tsSelectProject;
    FSettingsFile.LoadSettingsOther;
    edtRootFolder.Text := FAnalysisProcessor.LastFolder;
    FAnalysisProcessor.OnAnalysisProgress := OnAnalysisProgress;
    FAnalysisProcessor.OnAnalysisFinished := OnAnalysisFinished;

    pbAnalysisProgress.Brush.Color := PROGRESS_COLOR;
    SendMessage(pbAnalysisProgress.Handle, PBM_SETBARCOLOR, 0,
      pbAnalysisProgress.Brush.Color);

    frmMain.dbgrUnits.DataSource := FAnalysisProcessor.DataSourceU;
    frmMain.dbgrComponents.DataSource := FAnalysisProcessor.DataSourceC;
    frmMain.dbgrProjectGroups.DataSource := FAnalysisProcessor.DataSourcePG;
    frmMain.dbgrProjects.DataSource := FAnalysisProcessor.DataSourcePj;

    for i := Ord(Low(TSupportedDevelopmentTools))
      to Ord(High(TSupportedDevelopmentTools)) do
        cbProjectType.Items.Add(Mat.Constants.DELPHI_VERSIONS[i]);

    cbProjectType.ItemIndex := 0;

    ActivateAnalysisTabs(false);
end;

procedure TfrmMain.lbl32SupportClick(Sender: TObject);
begin
    pcMain.ActivePage := tsProjects;
end;

procedure TfrmMain.lblCustomerPortalClick(Sender: TObject);
begin
    ShellExecute(Handle, SHELL_OPEN_COMMAND, URL_EMBARCADERO_CUSTOMERPORTAL,
      nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmMain.lblFireDACMigrationGuideClick(Sender: TObject);
begin
    ShellExecute(Handle, SHELL_OPEN_COMMAND, URL_EMBARCADERO_FIREDACMIGRATION,
      nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmMain.lblProjectGroupsAmountClick(Sender: TObject);
begin
    pcMain.ActivePage := tsProjectGroups;
end;

procedure TfrmMain.lblProjectsAmountClick(Sender: TObject);
begin
    pcMain.ActivePage := tsProjects;
end;

procedure TfrmMain.lblStandardClassesAmountClick(Sender: TObject);
begin
    pcMain.ActivePage := tsComponents;
end;

procedure TfrmMain.lblUnicodeGuideClick(Sender: TObject);
begin
    ShellExecute(Handle, SHELL_OPEN_COMMAND, URL_EMBARCADERO_UNICODE, nil, nil,
      SW_SHOWNORMAL);
end;

procedure TfrmMain.lblUnitsAmountClick(Sender: TObject);
begin
    pcMain.ActivePage := tsUnits;
end;

procedure TfrmMain.OnAnalysisFinished(ProjectGroupsAmount, ProjectsAmount,
  UnitsAmount, LinesAmount, StandardClassesAmount, NonStandardClassesAmount
  : integer; IsBDEDetected, IsPointersDetected, IsUnicodeDetected,
  Is32BitSupport, Is64BitSupport, IsAssemblerDetected: boolean;
  ProjectVersions: String);
begin
    frmMain.lblProjectGroupsAmount.Caption := inttostr(ProjectGroupsAmount);
    frmMain.lblProjectsAmount.Caption := inttostr(ProjectsAmount);
    frmMain.lblUnitsAmount.Caption := inttostr(UnitsAmount);
    frmMain.lblLinesAmount.Caption := inttostr(LinesAmount);
    frmMain.lblStandardClassesAmount.Caption := inttostr(StandardClassesAmount);
    frmMain.lblNonStandardClassesAmount.Caption :=
      inttostr(NonStandardClassesAmount);

    gbBDE.Visible := IsBDEDetected;
    lblProjectVersions.Caption := IfThen(ProjectVersions <> '', ProjectVersions,
      ANALYSIS_PROJECTVERSION_NOTDETECTED);

    lbl32Support.Caption := IfThen(Is32BitSupport, STRING_YES, STRING_NO);
    lbl64Support.Caption := IfThen(Is64BitSupport, STRING_YES, STRING_NO);

    lblPointerUsage.Caption := IfThen(IsPointersDetected, STRING_YES,
      STRING_NO);
    lblPointersDescription.Visible := IsPointersDetected;

    lblUnicodeSupport.Caption := IfThen(IsUnicodeDetected, STRING_YES,
      STRING_NO);
    lblUnicodeDescription.Visible := not IsUnicodeDetected;
    lblUnicodeGuide.Visible := not IsUnicodeDetected;

    lblAssemblerCode.Visible := IsAssemblerDetected;
end;

procedure TfrmMain.OnAnalysisProgress(MaxValue, CurrentPosition: integer);
begin
    frmMain.pbAnalysisProgress.Max := MaxValue;
    frmMain.pbAnalysisProgress.Position := CurrentPosition;
    Application.ProcessMessages;
end;

procedure TfrmMain.LoadGridColumnsSettings;
begin
    FSettingsFile.LoadSettingsColumns(frmMain.dbgrUnits);
    FSettingsFile.LoadSettingsColumns(frmMain.dbgrProjectGroups);
    FSettingsFile.LoadSettingsColumns(frmMain.dbgrProjects);
    FSettingsFile.LoadSettingsColumns(frmMain.dbgrComponents);
end;

procedure TfrmMain.miAboutClick(Sender: TObject);
var
    frmAbout: TfrmAbout;
begin
    frmAbout := TfrmAbout.Create(Self);
    try
        frmAbout.ShowModal;
    finally
        FreeAndNil(frmAbout);
    end;
end;

procedure TfrmMain.miCloseClick(Sender: TObject);
begin
    Close;
end;

procedure TfrmMain.miNewAnalysisClick(Sender: TObject);
begin
    pcMain.ActivePage := tsSelectProject;
    btnSelectFolder.Click;
end;

procedure TfrmMain.CellCopyToClipboard(Sender: TObject);
begin
    Clipboard.AsText := TDBGrid(Sender).SelectedField.AsString;
end;

end.
