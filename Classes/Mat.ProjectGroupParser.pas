unit Mat.ProjectGroupParser;

interface

uses
    System.Generics.Collections, System.Classes, System.SysUtils,
    System.IOUtils,

    Mat.ProjectParser;

type
    // Class for ProjectGroup file parsing.
    TProjectGroupFile = class
    private
        FFullPath: string;
        FTitle: string;
        FVersion: string;
        FProjects: TProjectsList;
        function GetFileName: string;
    protected
        function ParseItem(const AStr: string): TProjectFile;
    public
        constructor Create;
        destructor Destroy; override;

        property FullPath: string read FFullPath write FFullPath;
        property FileName: string read GetFileName;
        property Title: string read FTitle write FTitle;
        property Projects: TProjectsList read FProjects write FProjects;
        property Version: string read FVersion write FVersion;
        procedure ParseVersion(const ABlock: string);
    end;

    TProjectsGroupList = class(TList<TProjectGroupFile>)
    protected
        function ParseFile(const APath: string): TProjectGroupFile;
    public
        procedure ParseDirectory(const ADirectory: string;
          AIsRecursively: Boolean);
    end;

implementation

uses Mat.Constants, Mat.AnalysisProcessor;

{ TProjectFile }

constructor TProjectGroupFile.Create;
begin
    FProjects := TProjectsList.Create;
end;

destructor TProjectGroupFile.Destroy;
begin
    FProjects.Free;
    inherited;
end;

function TProjectGroupFile.GetFileName: string;
begin
    Result := TPath.GetFileNameWithoutExtension(FFullPath);
end;

function TProjectGroupFile.ParseItem(const AStr: string): TProjectFile;
var
    LData: string;
    P: PChar;
    S: string;
    Index: Integer;
    Pause: Boolean;
    function PathCombine(A, B: string): string;
    var
        Sl1, Sl2: TStringList;
        Drive: string;
        i: Integer;
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
                Result := Result + TPath.DirectorySeparatorChar + Sl2[i];
        finally
            Sl2.Free;
            Sl1.Free;
        end;
    end;

begin
    LData := AStr.Trim + ' ';
    P := PChar(LData);
    Result := TProjectFile.Create;
    Index := 1;
    Pause := False;
    S := '';
    while (P^ <> #0) do
    begin
        if not Pause then
            S := S + P^;
        if ((P^ = ' ') and (S[S.Trim.Length] <> ' ')) or (P^ = #0) then
        begin
            S := S.Trim;
            if S.Equals(':') then
                S := ''
            else
                Pause := True;
        end;
        if Pause and not S.IsEmpty then
        begin
            case index of
                1:
                    Result.Title := S;
                2:
                    begin
                        if S.Trim[1] = '''' then
                            S := S.Substring(1);
                        if S.Trim[S.Trim.Length] = '''' then
                            S := S.Substring(0, S.Trim.Length - 1);
                        if (not S.IsEmpty) and
                          (not((S[1] = '.') and (S[2] = '.'))) then
                        begin
                            S := TPath.Combine
                              (TPath.GetDirectoryName(FFullPath), S);
                        end
                        else if (not S.IsEmpty) and
                          ((S[1] = '.') and (S[2] = '.')) then
                        begin
                            S := PathCombine
                              (TPath.GetDirectoryName(FFullPath), S);
                        end
                        else if TPath.GetFileName(S) <> S then
                            S := TPath.GetDirectoryName(FFullPath) +
                              TPath.DirectorySeparatorChar + S;
                        Result.FullPath := S;
                    end;
            end;
            Pause := False;
            inc(Index);
            S := '';
        end;
        inc(P);
    end;
    FProjects.Add(FAnalysisProcessor.ProjectsList.ParseFile(Result.FullPath));
end;

procedure TProjectGroupFile.ParseVersion(const ABlock: string);
var
    S: string;
begin
    S := ABlock.Substring(Pos(VERSION_CONST, ABlock.ToLower) +
      Mat.Constants.VERSION_CONST.Length).Trim;
    if S[1] = '=' then
        S := S.Substring(2).Trim;
    FVersion := S;
end;

{ TProjectsList }

procedure TProjectsGroupList.ParseDirectory(const ADirectory: string;
  AIsRecursively: Boolean);
var
    LDirectories: TArray<string>;
    LFiles: TArray<string>;
    LCurrentPath: string;
    LPF: TProjectGroupFile;
begin
    if AIsRecursively then
    begin
        LDirectories := TDirectory.GetDirectories(ADirectory);
        for LCurrentPath in LDirectories do
            ParseDirectory(LCurrentPath, True);
    end;
    LFiles := TDirectory.GetFiles(ADirectory, PROJECT_GROUP_EXT_AST);
    for LCurrentPath in LFiles do
    begin
        LPF := ParseFile(LCurrentPath);
        Add(LPF);
    end;
end;

function TProjectsGroupList.ParseFile(const APath: string): TProjectGroupFile;
var
    LRowProjectsList: TStringList;
    LFileData: TStringList;
    i: Integer;
    LBlock: string;
    LIsVersionFound: Boolean;
begin
    Result := TProjectGroupFile.Create;

    LBlock := '';
    LRowProjectsList := nil;
    LFileData := nil;
    try
        LFileData := TStringList.Create;
        LRowProjectsList := TStringList.Create;
        if TFile.Exists(APath) then
        begin
            LFileData.LoadFromFile(APath, TEncoding.ANSI);
            Result.FullPath := APath;
            LIsVersionFound := False;
            for i := 0 to Pred(LFileData.Count) do
            begin
                if (Pos(Mat.Constants.PROJECT_EXT,
                  LFileData[i].Trim.ToLower) > 0) then
                begin
                    LRowProjectsList.Add(LFileData[i].Trim.ToLower);
                    Result.ParseItem(LFileData[i].Trim);
                end;

                if not LIsVersionFound then
                begin
                    if (Pos(Mat.Constants.VERSION_CONST,
                      LFileData[i].Trim.ToLower) > 0) then
                    begin
                        Result.ParseVersion(LFileData[i]);
                        LIsVersionFound := not Result.FVersion.IsEmpty;
                    end;
                end;
            end;
        end;
    finally
        LRowProjectsList.Free;
        LFileData.Free
    end;
end;

end.
