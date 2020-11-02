unit Mat.Settings;

interface

uses IniFiles, SysUtils, DBGrids, UnitMain, System.Classes;

type
    TSettingsFile = class(Tinifile)

    public
        procedure LoadSettingsColumns(DBGrid: TDBGrid);
        procedure SaveSettingsColumns(DBGrid: TDBGrid);
        procedure LoadSettingsOther;
        procedure SaveSettingsOther;
    end;

var
    FSettingsFile: TSettingsFile;

implementation

uses Mat.Constants, Mat.AnalysisProcessor;

procedure TSettingsFile.LoadSettingsColumns(DBGrid: TDBGrid);
var
    i: integer;
begin
    if SectionExists(DBGrid.Name) then
    begin
        for i := 0 to DBGrid.Columns.Count - 1 do
            DBGrid.Columns[i].Width := ReadInteger(DBGrid.Name,
              COLUMN_SECTION_NAME + inttostr(i), 100);
    end;
end;

procedure TSettingsFile.SaveSettingsColumns(DBGrid: TDBGrid);
var
    i: integer;
begin
    for i := 0 to DBGrid.Columns.Count - 1 do
        WriteInteger(DBGrid.Name, COLUMN_SECTION_NAME + inttostr(i),
          DBGrid.Columns[i].Width);
end;

procedure TSettingsFile.LoadSettingsOther;
begin
    if SectionExists(FOLDER_SECTION_NAME) then
    begin
        FAnalysisProcessor.LastFolder := ReadString(FOLDER_SECTION_NAME, LAST_FOLDER_SECTION_NAME,
          ExtractFilePath(ParamStr(0)));
    end;
end;

procedure TSettingsFile.SaveSettingsOther;
begin
    WriteString(FOLDER_SECTION_NAME, LAST_FOLDER_SECTION_NAME, FAnalysisProcessor.LastFolder);
end;

initialization

FSettingsFile := TSettingsFile.Create(ExtractFilePath(ParamStr(0)) +
  SETTINGS_FOLDER + SETTINGS_FILE_NAME);

finalization

FreeAndNil(FSettingsFile);

end.
