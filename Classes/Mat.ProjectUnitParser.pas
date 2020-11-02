unit Mat.ProjectUnitParser;

interface

uses
    System.Classes, System.SysUtils, System.IOUtils,
    System.Generics.Collections;

type
    // Class for Unit file parsing.
    TUnitStructFile = class
    private
        FUnitFileName: string;
        FUnitPath: string;
        FFormName: string;
        FUsesList: TStringList;
        FTypesList: TStringList;
        FLinesCount: integer;

        FIsPointersDetected: boolean;
        FisUnicodeDetected: boolean;
        FIs32BitSupport: boolean;
        FIs64BitSupport: boolean;
        FIsAssemblerDetected: boolean;

    public
        property IsPointersDetected: boolean read FIsPointersDetected
          write FIsPointersDetected;
        property IsUnicodeDetected: boolean read FisUnicodeDetected
          write FisUnicodeDetected;
        property Is32BitSupport: boolean read FIs32BitSupport
          write FIs32BitSupport;
        property Is64BitSupport: boolean read FIs64BitSupport
          write FIs64BitSupport;
        property IsAssemblerDetected: boolean read FIsAssemblerDetected
          write FIsAssemblerDetected;

        constructor Create;
        destructor Destroy; override;
        property UnitFileName: string read FUnitFileName write FUnitFileName;
        property UnitPath: string read FUnitPath write FUnitPath;
        property FormName: string read FFormName write FFormName;
        property LinesCount: integer read FLinesCount write FLinesCount;
        procedure ParseBlockUses(const ABlock: string;
          var ARowUsesList: TStringList);
        procedure ParseBlockType(const ABlock: string;
          var ARowTypesList: TStringList);

    public

        procedure ParseTypes(const AFilePath: string;
          var ATypesList: TStringList);
    end;

    TUnitStructList = class(TList<TUnitStructFile>)
    public
        function ParseFile(const AFilePath: string): TUnitStructFile;
        procedure ParseDirectory(const ADirectory: string;
          AIsRecursively: boolean);
    end;


implementation

uses Mat.Constants, Mat.AnalysisProcessor;

constructor TUnitStructFile.Create;
begin
    FUsesList := TStringList.Create;
    FTypesList := TStringList.Create;

    FIsPointersDetected := false;
    FisUnicodeDetected := false;
    FIs32BitSupport := false;
    FIs64BitSupport := false;
    FIsAssemblerDetected := false;
end;

destructor TUnitStructFile.Destroy;
begin
    FUsesList.Free;
    inherited;
end;

function TUnitStructList.ParseFile(const AFilePath: string): TUnitStructFile;
var
    LFileData: TStringList;
    i: integer;
    LParsingStarted: boolean;
    LBlock, LRow: string;
    LRowUsesList, LRowTypesList: TStringList;
begin
    LParsingStarted := false;
    LBlock := '';
    LRowUsesList := nil;
    LFileData := nil;
    Result := nil;
    try
        LFileData := TStringList.Create;
        LRowUsesList := TStringList.Create;
        LRowTypesList := TStringList.Create;
        if TFile.Exists(AFilePath) then
        begin
            LFileData.LoadFromFile(AFilePath, TEncoding.ANSI);
            Result := TUnitStructFile.Create;
            Result.UnitPath := AFilePath;
            Result.UnitFileName := TPath.GetFileNameWithoutExtension(AFilePath);
            Result.FLinesCount := LFileData.Count;

            for i := 0 to Pred(LFileData.Count) do
            begin

                if Result.FIsAssemblerDetected = false then
                    Result.FIsAssemblerDetected :=
                      FAnalysisProcessor.CheckStringPresent(ASM_SEARCH_STRING,
                      LFileData[i].ToLower);

                        if Result.FIsPointersDetected = false then
                    Result.FIsPointersDetected  :=
                      FAnalysisProcessor.CheckPointerPresent(LFileData[i].ToLower);

                if Pos(LFileData[i].ToLower, USES_SEARCH_STRING) > 0 then
                    LParsingStarted := True;
                if LParsingStarted then
                begin
                    LBlock := LBlock + LFileData[i] + Mat.Constants.CRLF;
                    if LFileData[i].IndexOf(';') > 0 then
                        LParsingStarted := false;
                end;
                if (not LParsingStarted) and (not LBlock.IsEmpty) then
                begin
                    Result.ParseBlockUses(LBlock, LRowUsesList);
                    for LRow in LRowUsesList do
                        FAnalysisProcessor.UsesList.Add(LRow);
                    LBlock := '';
                end;
            end;

            for i := 0 to Pred(LFileData.Count) do
            begin
                if Pos(LFileData[i].ToLower, TYPE_SEARCH_STRING) = 1 then
                    LParsingStarted := True;
                if LParsingStarted then
                begin
                    LBlock := LBlock + LFileData[i] + Mat.Constants.CRLF;
                    if Pos(IMPLEMENTATION_SEARCH_STRING, LFileData[i]) > 0 then
                        LParsingStarted := false;
                end;
                if (not LParsingStarted) and (not LBlock.IsEmpty) then
                begin

                    Result.ParseBlockType(LBlock, LRowTypesList);
                    for LRow in LRowTypesList do
                        FAnalysisProcessor.TypesList.Add(LRow);
                    LBlock := '';
                end;
            end;
            // Result.ParseTypes(AFilePath, LTypeInfo);
        end;
    finally
        LRowUsesList.Free;
        LRowTypesList.Free;
        LFileData.Free
    end;
end;

procedure TUnitStructFile.ParseBlockType(const ABlock: string;
  var ARowTypesList: TStringList);
begin
    // ShowMessage(ABlock);
end;

procedure TUnitStructList.ParseDirectory(const ADirectory: string;
  AIsRecursively: boolean);
var
    LFiles: TArray<String>;
    LDirectories: TArray<String>;
    LCurrentPath: string;
    LUsf: TUnitStructFile;
begin
    if AIsRecursively then
    begin
        LDirectories := TDirectory.GetDirectories(ADirectory);
        for LCurrentPath in LDirectories do
            ParseDirectory(LCurrentPath, AIsRecursively);
    end;
    LFiles := TDirectory.GetFiles(ADirectory, PAS_EXT_AST);
    for LCurrentPath in LFiles do
    begin
        FAnalysisProcessor.ProjectUnitsList.Add
          (TPath.GetFileNameWithoutExtension(LCurrentPath).ToLower);
        LUsf := ParseFile(LCurrentPath);
        Add(LUsf);
    end;
end;

procedure TUnitStructFile.ParseBlockUses(const ABlock: string;
  var ARowUsesList: TStringList);
var
    TempStr: string;
    P: PChar;
    NewStr: string;
    Removing: boolean;
    RemovingReasonIndex: integer;
begin
    RemovingReasonIndex := 0;
    ARowUsesList.Clear;
    Removing := false;
    NewStr := '';
    TempStr := ABlock.Trim;
    if Pos(TempStr, USES_SEARCH_STRING) = 0 then
        TempStr := TempStr.Substring(4).Trim;
    P := PChar(TempStr);
    while (P^ <> #0) do
    begin
        if (not Removing) and (P^ = '{') then
        begin
            RemovingReasonIndex := 1;
            Removing := True;
        end;
        if (not Removing) and (P^ = ';') then
        begin
            RemovingReasonIndex := 2;
            Removing := True;
        end;
        if (not Removing) and (P^ = '/') and ((P + 1)^ = '/') then
        begin
            RemovingReasonIndex := 3;
            Removing := True;
        end;
        if (not Removing) and (P^ = '(') and ((P + 1)^ = '*') then
        begin
            RemovingReasonIndex := 4;
            Removing := True;
        end;
        if not Removing then
            NewStr := NewStr + P^;
        if (P^ = '}') and (RemovingReasonIndex = 1) then
            Removing := false;
        if (P^ = ';') and (RemovingReasonIndex = 2) then
            Removing := false;
        if ((P^ = #10) or (P^ = #13)) and (RemovingReasonIndex = 3) then
            Removing := false;
        if ((P^ = ')') and ((P - 1)^ = '*')) and (RemovingReasonIndex = 4) then
            Removing := false;
        Inc(P)
    end;

    TempStr := StringReplace(NewStr, ' ', '', [rfReplaceAll]);
    ARowUsesList.DelimitedText := TempStr;
end;

procedure TUnitStructFile.ParseTypes(const AFilePath: string;
  var ATypesList: TStringList);
var
    LRowTypesList: TStringList;
    LFileData: TStringList;
    i: integer;
    LParsingStarted: boolean;
    LBlock, LRow: string;
begin
    LParsingStarted := false;
    LBlock := '';
    LRowTypesList := nil;
    LFileData := nil;
    try
        LFileData := TStringList.Create;
        LRowTypesList := TStringList.Create;
        if TFile.Exists(AFilePath) then
        begin
            LFileData.LoadFromFile(AFilePath, TEncoding.ANSI);

            for i := 0 to Pred(LFileData.Count) do
            begin
                if Pos(LFileData[i].ToLower, TYPE_SEARCH_STRING) = 1 then
                    LParsingStarted := True;
                if LParsingStarted then
                begin
                    LBlock := LBlock + LFileData[i] + Mat.Constants.CRLF;
                    if Pos(IMPLEMENTATION_SEARCH_STRING, LFileData[i]) > 0 then
                        LParsingStarted := false;
                end;
                if (not LParsingStarted) and (not LBlock.IsEmpty) then
                begin
                    LBlock := '';
                    for LRow in LRowTypesList do
                        ATypesList.Add(LRow.ToLower);
                end;
            end;
        end;

    finally
        LRowTypesList.Free;
        LFileData.Free
    end;
end;

end.
