unit Mat.ProjectParser;

interface

uses
    System.Generics.Collections, System.Classes, System.SysUtils,
    System.IOUtils, XMLIntf, XMLDoc, Mat.ProjectUnitParser, Vcl.Forms;

type
    // Class for Project file parsing.
    TProjectFile = class
    private
        FFullPath: string;
        FTitle: string;
        FUnits: TUnitStructList;
        Fversion: string;
        FIs64Support: boolean;
        XMLDocument: TXMLDocument;
        function GetFileName: string;
    protected
        function ParseItem(const AStr: string): TUnitStructFile;
    public
        constructor Create;
        destructor Destroy; override;
        property FullPath: string read FFullPath write FFullPath;
        property FileName: string read GetFileName;
        property Title: string read FTitle write FTitle;
        property Units: TUnitStructList read FUnits write FUnits;
        property Version: string read Fversion write Fversion;
        property Is64Support: boolean read FIs64Support write FIs64Support;
        procedure ParseBlock(const ABlock: string);
        procedure ParseTitle(const ABlock: string; TT: string);
        procedure DetectProjectVersion(FileName: string);
    end;

    TProjectsList = class(TList<TProjectFile>)
    protected

    public
        procedure ParseDirectory(const ADirectory: string;
          AIsRecursively: boolean);
        function ParseFile(const APath: string): TProjectFile;
    end;

implementation

uses Mat.Constants, Mat.AnalysisProcessor;

{ TProjectFile }

constructor TProjectFile.Create;
begin
    FUnits := TUnitStructList.Create;
end;

destructor TProjectFile.Destroy;
begin
    FUnits.Free;
    inherited;
end;

function TProjectFile.GetFileName: string;
begin
    Result := TPath.GetFileNameWithoutExtension(FFullPath);
end;

function TProjectFile.ParseItem(const AStr: string): TUnitStructFile;
var
    LData: string;
    P: PChar;
    S: string;
    Index: integer;
    Pause: boolean;
    PauseSpace: boolean;
    LUnitPath: string;
    LClassVar: string;

    function PathCombine(A, B: string): string;
    var
        Sl1, Sl2: TStringList;
        Drive: string;
        i: integer;
    begin
        Drive := '';
        Sl1 := TStringList.Create;
        Sl2 := TStringList.Create;
        try
            if A[2] = ':' then
            begin
                Drive := A[1];
                Sl1.StrictDelimiter := True;
                Sl1.Delimiter := TPath.DirectorySeparatorChar;
                Sl1.DelimitedText := A.Substring(2);
            end
            else
            begin
                Sl1.StrictDelimiter := True;
                Sl1.DelimitedText := A;
            end;
            Sl2.StrictDelimiter := True;
            Sl2.Delimiter := TPath.DirectorySeparatorChar;
            Sl2.DelimitedText := B;

            while (Sl2.Count > 0) and (Sl2[0] = '..') do
            begin
                Sl1.Delete(Sl1.Count - 1);
                Sl2.Delete(0);
            end;
            if not Drive.IsEmpty then
                Result := Drive + ':';
            for i := 0 to Sl1.Count - 1 do
                if not Sl1[i].IsEmpty then
                    Result := Result + TPath.DirectorySeparatorChar + Sl1[i];

            for i := 0 to Sl2.Count - 1 do
                if not Sl2[i].IsEmpty then
                    Result := Result + TPath.DirectorySeparatorChar + Sl2[i];

        finally
            Sl2.Free;
            Sl1.Free;
        end;
    end;

begin

    LData := AStr.Trim + ' ';
    P := PChar(LData);
    Result := TUnitStructFile.Create;
    index := 1;
    Pause := False;
    PauseSpace := False;
    S := '';
    while (P^ <> #0) do
    begin

        if not Pause then
            S := S + P^;

        if P^ = '''' then
            PauseSpace := not PauseSpace;
        if S.IsEmpty = False then
            if (PauseSpace = False) or (P^ = #0) then
                if ((P^ = ' ') and (S[S.Trim.Length] <> ':')) then
                begin
                    S := S.Trim;
                    if S.Equals('in') then
                    begin
                        S := '';
                    end
                    else
                    begin
                        Pause := True;
                    end;
                end;

        if Pause and not S.IsEmpty then
        begin

            case Index of
                // 1:  Result.UnitFileName := s;
                2:
                    begin
                        if S.Trim[1] = '''' then
                            S := S.Substring(1);
                        if S.Trim[S.Trim.Length] = '''' then
                            S := S.Substring(0, S.Trim.Length - 1);
                        if (not S.IsEmpty) and
                          (not((S[1] = '.') and (S[2] = '.'))) then
                            if TPath.HasValidPathChars(S, True) then
                                S := TPath.Combine
                                  (TPath.GetDirectoryName(FFullPath), S);
                        if (not S.IsEmpty) and ((S[1] = '.') and (S[2] = '.'))
                        then
                        begin

                            S := PathCombine
                              (TPath.GetDirectoryName(FFullPath), S);
                        end;

                        LUnitPath := S;
                    end;
                3:
                    LClassVar := S;
            end;
            Pause := False;
            PauseSpace := False;
            inc(Index);
            S := '';
        end;
        inc(P);
    end;

    if (LUnitPath.IsEmpty) or (Pos(PAS_EXT, LUnitPath) = 0) or
      (not TFile.Exists(LUnitPath)) then
        FreeAndNil(Result)
    else
    begin
        Result := (FAnalysisProcessor.UnitStructList.ParseFile(LUnitPath));
        if (not LClassVar.IsEmpty) and (Pos(':', LClassVar) = 0) then
            Result.FormName := LClassVar;
    end;
end;

procedure TProjectFile.ParseTitle(const ABlock: string; TT: string);
var
    S: string;
begin
    S := ABlock.Substring(Pos(TT, ABlock.ToLower) + TT.Length).Trim;
    if (S[1] = ':') and (S[2] = '=') then
        S := S.Substring(2).Trim;
    if S[S.Length] = ';' then
        S := S.Substring(0, S.Length - 1).Trim;
    if (S[1] = '''') then
        S := S.Substring(1, MaxInt);
    if S[S.Length] = '''' then
        S := S.Substring(0, S.Length - 1).Trim;
    FTitle := S;
end;

procedure TProjectFile.ParseBlock(const ABlock: string);
var
    TempStr: string;
    P: PChar;
    LUnitInfo: TUnitStructFile;
    LWaitParsing: boolean;
    LStr: string;
begin
    TempStr := ABlock.Trim;
    if Pos(TempStr, USES_SEARCH_STRING) = 0 then
        TempStr := TempStr.Substring(4).Trim;
    P := PChar(TempStr);
    LStr := '';
    while (P^ <> #0) do
    begin
        LWaitParsing := (P^ = ',') or (P^ = ';');
        if not LWaitParsing then
            LStr := LStr + P^;
        if LWaitParsing and (not LStr.IsEmpty) then
        begin

            LUnitInfo := ParseItem(LStr);
            if Assigned(LUnitInfo) then
            begin
                FUnits.Add(LUnitInfo);
            end;
            LStr := '';
        end;
        inc(P);
    end;
end;

{ TProjectsList }

procedure TProjectsList.ParseDirectory(const ADirectory: string;
  AIsRecursively: boolean);
var
    LDirectories: TArray<string>;
    LFiles: TArray<string>;
    LCurrentPath: string;
    LPF: TProjectFile;
begin
    if AIsRecursively then
    begin
        LDirectories := TDirectory.GetDirectories(ADirectory);
        for LCurrentPath in LDirectories do
            ParseDirectory(LCurrentPath, True);
    end;
    LFiles := TDirectory.GetFiles(ADirectory, PROJECT_EXT_AST);
    for LCurrentPath in LFiles do
    begin
        LPF := ParseFile(LCurrentPath);
        Add(LPF);
    end;
end;

function TProjectsList.ParseFile(const APath: string): TProjectFile;
var
    LRowUsesList: TStringList;
    LFileData: TStringList;
    i: integer;
    LParsingStarted: boolean;
    LBlock: string;
    LIsTitleFound: boolean;

begin
    Result := TProjectFile.Create;
    LParsingStarted := False;
    LBlock := '';
    LRowUsesList := nil;
    LFileData := nil;
    try
        LFileData := TStringList.Create;
        LRowUsesList := TStringList.Create;
        if TFile.Exists(APath) then
        begin
            LFileData.LoadFromFile(APath, TEncoding.ANSI);
            Result.FullPath := APath;
            LIsTitleFound := False;
            for i := 0 to Pred(LFileData.Count) do
            begin
                if (not LParsingStarted) and
                  (Pos(LFileData[i].Trim.ToLower, USES_SEARCH_STRING) > 0) then
                    LParsingStarted := True;
                if LParsingStarted then
                begin
                    LBlock := LBlock + LFileData[i] + CRLF;
                    if LFileData[i].IndexOf(';') > 0 then
                        LParsingStarted := False;
                end;
                if (not LParsingStarted) and (not LBlock.IsEmpty) then
                begin
                    Result.ParseBlock(LBlock);
                    LBlock := '';
                end;

                if not LIsTitleFound then
                begin
                    if (Pos(PROGRAMM_SEARCH_STRING,
                      LFileData[i].Trim.ToLower) > 0) then
                        if LFileData[i].Trim.ToLower[LFileData[i].Trim.Length] = ';'
                        then
                        begin
                            Result.ParseTitle(LFileData[i],
                              PROGRAMM_SEARCH_STRING);
                            LIsTitleFound := not Result.Title.IsEmpty;
                        end
                        else if (Pos(LIBRARY_SEARCH_STRING,
                          LFileData[i].Trim.ToLower) > 0) then
                            if LFileData[i].Trim.ToLower
                              [LFileData[i].Trim.Length] = ';' then
                            begin
                                Result.ParseTitle(LFileData[i],
                                  LIBRARY_SEARCH_STRING);
                                LIsTitleFound := not Result.Title.IsEmpty;
                            end;
                end;
            end;
        end;
    finally
        LRowUsesList.Free;
        LFileData.Free
    end;
end;

procedure TProjectFile.DetectProjectVersion(FileName: string);
var
    RootNode: IXMLNode;
    i: integer;
    Pprojinfo: IXMLNode;
    DpojName: string;
begin
    DpojName := FileName + NEW_FILE_FORMAT_ADDICT;
    if TFile.Exists(DpojName) then
    begin
        XMLDocument := TXMLDocument.Create(application);
        XMLDocument.LoadFromFile(DpojName);
        XMLDocument.Active := True;
        Pprojinfo := XMLDocument.DocumentElement.ChildNodes[PG_NODE];
        RootNode := XMLDocument.DocumentElement.ChildNodes[PE_NODE].ChildNodes
          [BP_NODE].ChildNodes[PF_NODE];

        Fversion := Pprojinfo.ChildNodes[PV_NODE].NodeValue;
        for i := 0 to RootNode.ChildNodes.Count - 1 do
        begin
            Pprojinfo := RootNode.ChildNodes.Nodes[i];
            if RootNode.ChildNodes[i].Attributes[NODE_ATTR] = WIN64_CONST then
                if RootNode.ChildNodes[i].NodeValue = TRUE_VALUE then
                    FIs64Support := True;
        end;
    end;
end;

end.
