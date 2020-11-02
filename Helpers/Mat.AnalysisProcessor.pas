unit Mat.AnalysisProcessor;

interface

uses
    SysUtils, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
    FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
    FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait,
    FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
    FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.DB, System.IOUtils,
    System.Classes, Vcl.DBGrids, FireDAC.Stan.Option, System.Character,
    Mat.ProjectGroupParser, Mat.ProjectParser, Mat.ProjectUnitParser;

type
    TAnalysisProgressEvent = procedure(MaxValue, CurrentPosition: Integer)
      of object;
    TAnalysisFinishedEvent = procedure(ProjectGroupsAmount, ProjectsAmount,
      UnitsAmount, LinesAmount, StandardClassesAmount, NonStandardClassesAmount
      : Integer; IsBDEDetected, IsPointersDetected, IsUniconeDetected,
      Is32BitSupport, Is64BitSupport, IsAssemblerDetected: Boolean;
      ProjectVersions: String) of object;

    TAnalysisProcessor = class
    private
        // Current process progress event handler.
        FOnAnalysisProgress: TAnalysisProgressEvent;
        // Analysis completion event handler.
        FAnalysisFinishedEvent: TAnalysisFinishedEvent;

        FSettingsFolder: string;

        stFDQuery_Show: TFDQuery;
        stFDQuery_ShowPG: TFDQuery;
        stFDQuery_ShowPJ: TFDQuery;
        stFDQuery_ShowU: TFDQuery;
        stFDQuery_ShowC: TFDQuery;

        stFDConnection: TFDConnection;

        FProjectsGroupList: TProjectsGroupList;
        FProjectsList: TProjectsList;

        FUnitStructFile: TUnitStructFile;
        FUnitStructList: TUnitStructList;

        FProjectUnitsList: TStringList;
        FTypesList: TStringList;
        FUsesList: TStringList;
        FLastFolder: string;

        // Initialize class instance.
        procedure Inititalize;
        // Inititlize internal instances for new analysis.
        procedure InitializeNewAnalysis;

        procedure RemoveProjectUnits(var AUsesList, AProjectUnits: TStringList);
    public
        DataSourcePG: TDataSource;
        DataSourcePj: TDataSource;
        DataSourceU: TDataSource;
        DataSourceC: TDataSource;
        stFDQuery_Update: TFDQuery;
        function StartNewAnalysis(RootPath: String;
          IncludeSubfolders: Boolean): Boolean;
        function CheckStringPresent(FoundString: string;
          LineString: string): Boolean;
        function CheckPointerPresent(LineString: string): Boolean;
        function DetectStandartClasses: Integer;
        procedure ShowPG(Sort: string);
        procedure ShowPJ(Sort: string);
        procedure ShowU(Sort: string);
        procedure ShowC(Sort: string);
        procedure InsertToTable(Tablename: string);
        property OnAnalysisProgress: TAnalysisProgressEvent
          read FOnAnalysisProgress write FOnAnalysisProgress;
        property OnAnalysisFinished: TAnalysisFinishedEvent
          read FAnalysisFinishedEvent write FAnalysisFinishedEvent;
        property SettingsFolder: string read FSettingsFolder
          write FSettingsFolder;
        property LastFolder: string read FLastFolder write FLastFolder;
        property ProjectsList: TProjectsList read FProjectsList
          write FProjectsList;
        property UnitStructFile: TUnitStructFile read FUnitStructFile
          write FUnitStructFile;
        property UnitStructList: TUnitStructList read FUnitStructList
          write FUnitStructList;
        property ProjectUnitsList: TStringList read FProjectUnitsList
          write FProjectUnitsList;
        property UsesList: TStringList read FUsesList write FUsesList;
        property TypesList: TStringList read FTypesList write FTypesList;

        // Class constructor.
        constructor Create; overload;

        // Destrutor.
        destructor Destroy; override;
    end;

var
    FAnalysisProcessor: TAnalysisProcessor;

implementation

{ TAnalysisProcessor }

uses Mat.Components, Mat.Constants;

constructor TAnalysisProcessor.Create;
begin
    inherited Create;

    Inititalize;
end;

destructor TAnalysisProcessor.Destroy;
begin
    FreeAndNil(FProjectsList);
    FreeAndNil(FProjectsGroupList);
    inherited;
end;

procedure TAnalysisProcessor.InitializeNewAnalysis;
begin
    stFDQuery_Update.Sql.Text := CLEAR_PG_TABLE_SQL;
    stFDQuery_Update.ExecSQL;
    stFDQuery_Update.Sql.Text := CLEAR_PJ_TABLE_SQL;
    stFDQuery_Update.ExecSQL;
    stFDQuery_Update.Sql.Text := CLEAR_UNITS_TABLE_SQL;
    stFDQuery_Update.ExecSQL;
    stFDQuery_Update.Sql.Text := CLEAR_USES_TABLE_SQL;
    stFDQuery_Update.ExecSQL;
    stFDQuery_Update.Sql.Text := CLEAR_TYPES_TABLE_SQL;
    stFDQuery_Update.ExecSQL;
    stFDQuery_Update.Sql.Text := CLEAR_CD_TABLE_SQL;
    stFDQuery_Update.ExecSQL;
    stFDQuery_Update.Sql.Clear;
    FProjectUnitsList.Clear;
    FUsesList.Clear;
    FTypesList.Clear;
end;

procedure TAnalysisProcessor.Inititalize;
var
    DFilename: string;
begin
    FProjectsGroupList := TProjectsGroupList.Create;
    FProjectsList := TProjectsList.Create;
    FUnitStructList := TUnitStructList.Create;

    FProjectUnitsList := TStringList.Create;
    FProjectUnitsList.Duplicates := dupIgnore;
    FProjectUnitsList.Sorted := True;
    FUsesList := TStringList.Create;
    FUsesList.Duplicates := dupIgnore;
    FUsesList.Sorted := True;
    FTypesList := TStringList.Create;
    FTypesList.Sorted := True;
    FTypesList.Duplicates := dupIgnore;

    stFDConnection := TFDConnection.Create(nil);
    stFDConnection.DriverName := SQL_DRIVER_NAME;
    DFilename := (ExtractFilePath(ParamStr(0)) + DATABASE_FOLDER +
      SQL_DATABASE_FILENAME);
    stFDConnection.Params.Database := DFilename;
    stFDConnection.LoginPrompt := false;
    stFDConnection.Connected := True;

    stFDQuery_Update := TFDQuery.Create(nil);
    stFDQuery_Update.Connection := stFDConnection;

    stFDQuery_ShowPG := TFDQuery.Create(nil);
    stFDQuery_ShowPG.Connection := stFDConnection;
    stFDQuery_ShowPJ := TFDQuery.Create(nil);
    stFDQuery_ShowPJ.Connection := stFDConnection;
    stFDQuery_ShowU := TFDQuery.Create(nil);
    stFDQuery_ShowU.Connection := stFDConnection;
    stFDQuery_ShowC := TFDQuery.Create(nil);
    stFDQuery_ShowC.Connection := stFDConnection;
    stFDQuery_Show := TFDQuery.Create(nil);
    stFDQuery_Show.Connection := stFDConnection;

    stFDQuery_Update.Sql.Text := CREATE_TABLES_SQL;
    stFDQuery_Update.ExecSQL;

    DataSourceU := TDataSource.Create(nil);
    DataSourceU.DataSet := stFDQuery_ShowU;

    DataSourceC := TDataSource.Create(nil);
    DataSourceC.DataSet := stFDQuery_ShowC;

    DataSourcePG := TDataSource.Create(nil);
    DataSourcePG.DataSet := stFDQuery_ShowPG;

    DataSourcePj := TDataSource.Create(nil);
    DataSourcePj.DataSet := stFDQuery_ShowPJ;
end;

function TAnalysisProcessor.StartNewAnalysis(RootPath: String;
  IncludeSubfolders: Boolean): Boolean;
var
    ProgGrFile: TProjectGroupFile;
    Project: TProjectFile;
    UnitFile: TUnitStructFile;
    Title, UUses, UTypes: string;

    ProjectGroupCounter, ProjectGroupInc, StandardClassesAmount,
      NonStandardClassesAmount, ProjectGroupsAmount, ProjectsAmount,
      UnitsAmount, LinesAmount: Integer;
    IsBDEDetected, IsPointersDetected, isUnicodeDetected, Is32BitSupport,
      Is64BitSupport, IsAssemblerDetected: Boolean;
    ProjectVersions: String;
    i: Integer;
begin
    InitializeNewAnalysis;

    FComponentParser.JSONToSQL;

    if TDirectory.Exists(RootPath) then
    begin

        SettingsFolder := RootPath;
        FProjectsGroupList.Clear;

        FProjectsList.Clear;
        UnitStructList.Clear;
        FProjectsGroupList.ParseDirectory(RootPath, IncludeSubfolders);
        ProjectGroupCounter := FProjectsGroupList.Count;
        ProjectGroupInc := 0;

        if Assigned(FOnAnalysisProgress) then
            FOnAnalysisProgress(ProjectGroupCounter, ProjectGroupInc);

        stFDQuery_Update.Sql.Text := '';
        for ProgGrFile in FProjectsGroupList do
        begin
            ProjectGroupInc := ProjectGroupInc + 1;

            if Assigned(FOnAnalysisProgress) then
                FOnAnalysisProgress(ProjectGroupCounter, ProjectGroupInc);

            stFDQuery_Update.Sql.Text := (INSERT_PG_SQL);

            if ProgGrFile.Title.IsEmpty then
                Title := ProgGrFile.FileName
            else
                Title := ProgGrFile.Title;
            stFDQuery_Update.Params.ParamByName(FTITLE_FIELD_NAME)
              .Value := Title;
            stFDQuery_Update.Params.ParamByName(FPATH_FIELD_NAME).Value :=
              ProgGrFile.FullPath;
            stFDQuery_Update.Params.ParamByName(FVERSION_FIELD_NAME).Value :=
              ProgGrFile.Version;
            stFDQuery_Update.ExecSQL;

            for Project in ProgGrFile.Projects do
            begin
                if not Project.FullPath.IsEmpty then
                begin
                    Project.DetectProjectVersion(Project.FullPath);
                    if Project.Is64Support then
                        Is64BitSupport := True;
                    stFDQuery_Update.Sql.Text := (INSERT_PJ_SQL);
                    if Project.Title.IsEmpty then
                        Title := Project.FileName
                    else
                        Title := Project.Title;
                    stFDQuery_Update.Params.ParamByName(FTITLE_FIELD_NAME)
                      .Value := Title;
                    stFDQuery_Update.Params.ParamByName(FPATH_FIELD_NAME).Value
                      := Project.FullPath;
                    stFDQuery_Update.Params.ParamByName(FPGPATH_FIELD_NAME)
                      .Value := ProgGrFile.FullPath;
                    stFDQuery_Update.Params.ParamByName(FVERSION_FIELD_NAME)
                      .Value := Project.Version;
                    stFDQuery_Update.ExecSQL;

                    for UnitFile in Project.Units do
                    begin
                        try
                            stFDQuery_Update.Sql.Text := INSERT_UNITS_SQL;
                            Title := UnitFile.UnitFileName;
                            stFDQuery_Update.Params.ParamByName
                              (FTITLE_FIELD_NAME).Value := Title;
                            stFDQuery_Update.Params.ParamByName
                              (FPATH_FIELD_NAME).Value := UnitFile.UnitPath;
                            stFDQuery_Update.Params.ParamByName
                              (FPPATH_FIELD_NAME).Value := Project.FullPath;
                            stFDQuery_Update.Params.ParamByName
                              (FLINESCOUNT_FIELD_NAME).Value :=
                              UnitFile.LinesCount;
                            stFDQuery_Update.Params.ParamByName
                              (FFORMNAME_FIELD_NAME).Value := UnitFile.FormName;
                            stFDQuery_Update.ExecSQL;
                        finally
                            UnitFile.free;
                        end;
                    end;
                end;
            end;
        end;

        FProjectsList.Clear;
        UnitStructList.Clear;

        FProjectsList.ParseDirectory(RootPath, IncludeSubfolders);
        ProjectGroupCounter := FProjectsList.Count;
        ProjectGroupInc := 0;

        if Assigned(FOnAnalysisProgress) then
            FOnAnalysisProgress(ProjectGroupCounter, ProjectGroupInc);

        for Project in FProjectsList do
        begin
            if not Project.FullPath.IsEmpty then
            begin
                Project.DetectProjectVersion(Project.FullPath);
                if Project.Is64Support then
                    Is64BitSupport := True;

                stFDQuery_Update.Sql.Text := INSERT_PJ_SQL;
                if Project.Title.IsEmpty then
                    Title := Project.FileName
                else
                    Title := Project.Title;
                stFDQuery_Update.Params.ParamByName(FTITLE_FIELD_NAME)
                  .Value := Title;
                stFDQuery_Update.Params.ParamByName(FPATH_FIELD_NAME).Value :=
                  Project.FullPath;
                stFDQuery_Update.Params.ParamByName(FPGPATH_FIELD_NAME)
                  .Value := '';
                stFDQuery_Update.Params.ParamByName(FVERSION_FIELD_NAME).Value
                  := Project.Version;
                stFDQuery_Update.ExecSQL;
                ProjectGroupInc := ProjectGroupInc + 1;

                if Assigned(FOnAnalysisProgress) then
                    FOnAnalysisProgress(ProjectGroupCounter, ProjectGroupInc);

                for UnitFile in Project.Units do
                begin
                    try
                        stFDQuery_Update.Sql.Text := INSERT_UNITS_SQL;
                        Title := UnitFile.UnitFileName;
                        stFDQuery_Update.Params.ParamByName(FTITLE_FIELD_NAME)
                          .Value := Title;
                        stFDQuery_Update.Params.ParamByName(FPATH_FIELD_NAME)
                          .Value := UnitFile.UnitPath;
                        stFDQuery_Update.Params.ParamByName(FPPATH_FIELD_NAME)
                          .Value := Project.FullPath;
                        stFDQuery_Update.Params.ParamByName
                          (FLINESCOUNT_FIELD_NAME).Value := UnitFile.LinesCount;
                        stFDQuery_Update.Params.ParamByName
                          (FFORMNAME_FIELD_NAME).Value := UnitFile.FormName;
                        stFDQuery_Update.ExecSQL;
                    finally
                        UnitFile.free;
                    end;
                end;
            end;
        end;

        UnitStructList.Clear;

        UnitStructList.ParseDirectory(RootPath, IncludeSubfolders);

        ProjectGroupCounter := UnitStructList.Count;
        ProjectGroupInc := 0;

        if Assigned(FOnAnalysisProgress) then
            FOnAnalysisProgress(ProjectGroupCounter, ProjectGroupInc);

        for UnitFile in UnitStructList do
        begin
            try
                if UnitFile.IsAssemblerDetected then
                    IsAssemblerDetected := True;
                if UnitFile.IsPointersDetected then
                    IsPointersDetected := True;

                stFDQuery_Update.Sql.Text := INSERT_UNITS_SQL;
                Title := UnitFile.UnitFileName;
                stFDQuery_Update.Params.ParamByName(FTITLE_FIELD_NAME)
                  .Value := Title;
                stFDQuery_Update.Params.ParamByName(FPATH_FIELD_NAME).Value :=
                  UnitFile.UnitPath;
                stFDQuery_Update.Params.ParamByName(FPPATH_FIELD_NAME)
                  .Value := '';
                stFDQuery_Update.Params.ParamByName(FLINESCOUNT_FIELD_NAME)
                  .Value := UnitFile.LinesCount;
                stFDQuery_Update.Params.ParamByName(FFORMNAME_FIELD_NAME).Value
                  := UnitFile.FormName;
                stFDQuery_Update.ExecSQL;
                ProjectGroupInc := ProjectGroupInc + 1;

                if Assigned(FOnAnalysisProgress) then
                    FOnAnalysisProgress(ProjectGroupCounter, ProjectGroupInc);
            finally
                UnitFile.free;
            end;
        end;

        RemoveProjectUnits(FUsesList, FProjectUnitsList);

        for UUses in FUsesList do
        begin
            FComponentParser.ParseFields(UUses);
            if (LowerCase(UUses) = LowerCase(BDE_USES)) then
                IsBDEDetected := True;
        end;

        for UTypes in FTypesList do
        begin
            stFDQuery_Update.Sql.Text := INSERT_USES_SQL;
            stFDQuery_Update.Params.ParamByName(FTITLE_FIELD_NAME).Value
              := UTypes;
            stFDQuery_Update.Params.ParamByName(FLOWER_TITLE_FIELD_NAME).Value
              := UTypes.ToLower;
            stFDQuery_Update.ExecSQL;
        end;

        ShowPG(DEFAULT_SORT);
        ShowPJ(DEFAULT_SORT);
        ShowU(DEFAULT_SORT);
        ShowC(DEFAULT_SORT);

        stFDQuery_Show.Sql.Text := SELECT_PG_COUNT;
        stFDQuery_Show.Open;
        if not stFDQuery_Show.fields[0].AsString.IsEmpty then
            ProjectGroupsAmount := StrToInt(stFDQuery_Show.fields[0].AsString);

        stFDQuery_Show.Sql.Text := SELECT_PJ_COUNT;
        stFDQuery_Show.Open;
        if not stFDQuery_Show.fields[0].AsString.IsEmpty then
            ProjectsAmount := StrToInt(stFDQuery_Show.fields[0].AsString);

        stFDQuery_Show.Sql.Text := SELECT_UNITS_COUNT;
        stFDQuery_Show.Open;
        if not stFDQuery_Show.fields[0].AsString.IsEmpty then
            UnitsAmount := StrToInt(stFDQuery_Show.fields[0].AsString);

        stFDQuery_Show.Sql.Text := SELECT_ULINESCOUNT_COUNT;
        stFDQuery_Show.Open;
        if not stFDQuery_Show.fields[0].AsString.IsEmpty then
            LinesAmount := StrToInt(stFDQuery_Show.fields[0].AsString);

        // By default, all legacy Delphi versions doesn't support Unicode.
        isUnicodeDetected := false;

        stFDQuery_Show.Sql.Text := SELECT_PJVERSION;

        ProjectVersions := '';
        stFDQuery_Show.Open;

        for i := 0 to stFDQuery_Show.RecordCount - 1 do
        begin
            ProjectVersions := ProjectVersions + stFDQuery_Show.fields[0]
              .AsString + ', ';
            stFDQuery_Show.Next;
            if i = stFDQuery_Show.RecordCount - 1 then
                Delete(ProjectVersions, Length(ProjectVersions) - 1,
                  Length(ProjectVersions));
        end;

        // TODO: Determine standard Embarcadero's classes.
        StandardClassesAmount := DetectStandartClasses;

        // TODO: Determone non-standard classes.
        NonStandardClassesAmount := stFDQuery_ShowC.RecordCount -
          DetectStandartClasses;

        // By default we have 32-bit support.
        Is32BitSupport := True;

        if Assigned(FAnalysisFinishedEvent) then
            FAnalysisFinishedEvent(ProjectGroupsAmount, ProjectsAmount,
              UnitsAmount, LinesAmount, StandardClassesAmount,
              NonStandardClassesAmount, IsBDEDetected, IsPointersDetected,
              isUnicodeDetected, Is32BitSupport, Is64BitSupport,
              IsAssemblerDetected, ProjectVersions);

        Result := True;
    end
    else
        Result := false;
end;

procedure TAnalysisProcessor.RemoveProjectUnits(var AUsesList,
  AProjectUnits: TStringList);
var
    LRow: string;
begin
    for LRow in AProjectUnits do
        if AUsesList.IndexOf(LRow.ToLower) >= 0 then
            AUsesList.Delete(AUsesList.IndexOf(LRow));
end;

procedure TAnalysisProcessor.ShowPG(Sort: string);
begin
    stFDQuery_ShowPG.Sql.Text := SHOW_PG_SQL + Sort;
    stFDQuery_ShowPG.Open;
end;

procedure TAnalysisProcessor.ShowPJ(Sort: string);
begin
    stFDQuery_ShowPJ.Sql.Text := SHOW_PJ_SQL + Sort;
    stFDQuery_ShowPJ.Open;
end;

procedure TAnalysisProcessor.ShowU(Sort: string);
begin
    stFDQuery_ShowU.Sql.Text := SHOW_U_SQL + Sort;
    stFDQuery_ShowU.Open;
end;

procedure TAnalysisProcessor.ShowC(Sort: string);
begin
    stFDQuery_ShowC.Sql.Text :=SHOW_C_SQL +Sort;
    stFDQuery_ShowC.Open;
end;

procedure TAnalysisProcessor.InsertToTable(Tablename: string);
begin
    stFDQuery_Update.Sql.Text :=
      (INSERT_INTO_TABLE_SQL_P + Tablename + INSERT_INTO_TABLE_SQL);
    stFDQuery_Update.Params.ParamByName(FTITLE_FIELD_NAME).Value :=
      FComponentParser.Title;
    stFDQuery_Update.Params.ParamByName(FLOWER_TITLE_FIELD_NAME).Value :=
      FComponentParser.Title.ToLower;
    stFDQuery_Update.Params.ParamByName(FPACKAGE_FIELD_NAME).Value :=
      FComponentParser.Package;
    stFDQuery_Update.Params.ParamByName(FVENDOR_FIELD_NAME).Value :=
      FComponentParser.Vendor;
    stFDQuery_Update.Params.ParamByName(FPJ_HOME_URL_FIELD_NAME).Value :=
      FComponentParser.ProjectHomeURL;
    stFDQuery_Update.Params.ParamByName(FLICELCSE_NAME_FIELD_NAME).Value :=
      FComponentParser.LicenseName;
    stFDQuery_Update.Params.ParamByName(FLICELCSE_TYPE_FIELD_NAME).Value :=
      FComponentParser.LicenseType;
    stFDQuery_Update.Params.ParamByName(FCLASSES_FIELD_NAME).Value :=
      FComponentParser.Classes;
    stFDQuery_Update.Params.ParamByName(FPLATFORM_SUPPORT_NAME).Value :=
      FComponentParser.PlatformsSupport;
    stFDQuery_Update.Params.ParamByName(FRADVERSION_SUPPORT_NAME).Value :=
      FComponentParser.RADStudioVersionsSupport;
    stFDQuery_Update.Params.ParamByName(FVERSION_COMPATIBILITY_NAME).Value :=
      FComponentParser.VersionsCompatibility;
    stFDQuery_Update.Params.ParamByName(FANALOGUES_FIELD_NAME).Value :=
      FComponentParser.Analogues;
    stFDQuery_Update.Params.ParamByName(FCONVERTTO_FIELD_NAME).Value :=
      FComponentParser.ConvertTo;
    stFDQuery_Update.Params.ParamByName(FCOMMENT_FIELD_NAME).Value :=
      FComponentParser.Comment;
    stFDQuery_Update.ExecSQL;
end;

function TAnalysisProcessor.CheckStringPresent(FoundString: string;
  LineString: string): Boolean;
var
    Position, FoundStringLenght, LineStringLenght: Integer;
    FFlag, LFlag: Boolean;
begin
    FFlag := false;
    LFlag := false;
    LineStringLenght := LineString.Length;
    FoundStringLenght := FoundString.Length;
    Position := Pos(FoundString, LineString);

    if Position > 0 then
    begin
        if Position = 1 then
            FFlag := True
        else if (Char(LineString[Position - 1]).IsWhiteSpace) or
          (LineString[Position - 1] = ';') then
            FFlag := True;

        if (Char(LineString[Position + FoundStringLenght]).IsWhiteSpace) or
          (Char(LineString[Position + FoundStringLenght]).IsPunctuation) or
          ((Position + FoundStringLenght) = LineStringLenght + 1) then
            LFlag := True;

        if (FFlag = True) and (LFlag = True) then
            Result := True
        else
            Result := false;
    end
    else
        Result := false;
end;

function TAnalysisProcessor.CheckPointerPresent(LineString: string): Boolean;
var
    Position, FoundStringLenght: Integer;
    FFlag, LFlag: Boolean;
begin
    FFlag := false;
    LFlag := false;
    FoundStringLenght := 1;
    Position := Pos('^', LineString);

    if Position > 0 then
    begin
        if (Char(LineString[Position - 1]).IsLetter) then
            FFlag := True;

        if (Char(LineString[Position + FoundStringLenght]).IsWhiteSpace) then
            LFlag := True;
        if ((LineString[Position + FoundStringLenght] = '.')) then
            LFlag := True;
        if ((LineString[Position + FoundStringLenght] = '=')) then
            LFlag := True;

        if (FFlag = True) and (LFlag = True) then
            Result := True
        else
            Result := false;

    end
    else
        Result := false;
end;

function TAnalysisProcessor.DetectStandartClasses: Integer;
begin
    stFDQuery_Show.Sql.Text :=
      (DETECT_STANDART_CLASSES_COUNT_SQL + STANDART_VENDOR_NAME + '''');
    stFDQuery_Show.Open;
    Result := (stFDQuery_Show.fields[0].AsInteger);
end;

initialization

FAnalysisProcessor := TAnalysisProcessor.Create;

finalization

FreeAndNil(FAnalysisProcessor);

end.
