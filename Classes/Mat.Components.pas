unit Mat.Components;

interface

uses System.SysUtils, System.JSON, System.IOUtils, WinApi.Windows, Dialogs, FireDAC.Stan.Param;

type
    TComponentParser = class
    private
        FTitle: string;
        FPackage: string;
        FVendor: string;
        FProjectHomeUrl: string;
        FLicenseName: string;
        FLicenseType: string;
        FClasses: string;
        FPlatformsSupport: string;
        FRADStudioVersionsSupport: string;
        FVersionsCompatibility: string;
        FAnalogues: string;
        FConvertTo: string;
        FComment: string;
    public
        procedure ParseFields(UnitName: string);
        procedure JSONToSQL;
        property Title: string read FTitle write FTitle;
        property Package: string read FPackage write FPackage;
        property Vendor: string read FVendor write FVendor;
        property ProjectHomeUrl: string read FProjectHomeUrl
          write FProjectHomeUrl;
        property LicenseName: string read FLicenseName write FLicenseName;
        property LicenseType: string read FLicenseType write FLicenseType;
        property Classes: string read FClasses write FClasses;
        property PlatformsSupport: string read FPlatformsSupport
          write FPlatformsSupport;
        property RADStudioVersionsSupport: string read FRADStudioVersionsSupport
          write FRADStudioVersionsSupport;
        property VersionsCompatibility: string read FVersionsCompatibility
          write FVersionsCompatibility;
        property Analogues: string read FAnalogues write FAnalogues;
        property Comment: string read FComment write FComment;
        property ConvertTo: string read FConvertTo write FConvertTo;
    end;

var
    FComponentParser: TComponentParser;

implementation

uses Mat.Constants, Mat.AnalysisProcessor;

procedure TComponentParser.JSONToSQL;
var
    JsonString: string;
    LFilename: string;
    JSONEnum: TJSONObject.TEnumerator;
    Tempjson: TJSONObject;
    i: integer;
begin
    LFilename := (ExtractFilePath(ParamStr(0)) + DATABASE_FOLDER +
      JSON_FILE_NAME);
    if FileExists(LFilename) then
    begin
        JsonString := TFile.ReadAllText(LFilename);
        Tempjson := TJSONObject.ParseJSONValue
          (TEncoding.UTF8.GetBytes(JsonString), 0) as TJSONObject;
    end
    else
    begin
        Tempjson := nil;
        FileClose(FileCreate(LFilename));
    end;

    JSONEnum := Tempjson.GetEnumerator;
    if Tempjson <> nil then
    begin
        for i := 0 to Tempjson.Count - 1 do
        begin
            JSONEnum.MoveNext;
            Tempjson := TJSONObject.ParseJSONValue
              (TEncoding.UTF8.GetBytes(JSONEnum.Current.JsonValue.ToString), 0)
              as TJSONObject;

            with Tempjson do
            begin
                FTitle := JSONEnum.Current.JsonString.ToString;
                FTitle := StringReplace(FTitle, '"', '', [rfReplaceAll]);
                TryGetValue(PACKAGE_JSON_PAIR, FPackage);
                TryGetValue(VENDOR_JSON_PAIR, FVendor);
                TryGetValue(PROJECTHOMEURL_JSON_PAIR, FProjectHomeUrl);
                TryGetValue(LICENSENAME_JSON_PAIR, FLicenseName);
                TryGetValue(LICENSETYPE_JSON_PAIR, FLicenseType);
                TryGetValue(CLASSES_JSON_PAIR, FClasses);
                TryGetValue(PLATFORMSSUPPORT_JSON_PAIR, FPlatformsSupport);
                TryGetValue(RADSTUDIOVERSIONSSUPPORT_JSON_PAIR,
                  FRADStudioVersionsSupport);
                TryGetValue(VERSIONSCOMPATIBILITY_JSON_PAIR, FVersionsCompatibility);
                TryGetValue(ANALOGUES_JSON_PAIR, FAnalogues);
                TryGetValue(COMMENT_JSON_PAIR, FComment);
                TryGetValue(CONVERTTO_JSON_PAIR, FConvertTo);
            end;
            FAnalysisProcessor.InsertToTable(COMPONENTS_DATABASE_TABLE_NAME);
        end;
    end
    else
        showmessage(COMPONENTS_DATABASE_MISSING_ERR);
end;

procedure TComponentParser.ParseFields(UnitName: string);
begin
    if not UnitName.IsEmpty then
    begin
        FAnalysisProcessor.stFDQuery_Update.Sql.Text :=
          (COMPONENTS_PARSE_FIELDS_SELECT_SQL +
          UnitName.ToLower + '''');
        FAnalysisProcessor.stFDQuery_Update.Open;

        if FAnalysisProcessor.stFDQuery_Update.RecordCount > 0 then
        begin
            FAnalysisProcessor.stFDQuery_Update.Sql.Text :=
              (COMPONENTS_PARSE_FIELDS_INSERT_SQL +
              UnitName.ToLower + '''');
            FAnalysisProcessor.stFDQuery_Update.ExecSQL;
        end
        else
        begin
            FAnalysisProcessor.stFDQuery_Update.Sql.Text :=
              (INSERT_USES_SQL);
            FAnalysisProcessor.stFDQuery_Update.Params.ParamByName(FTITLE_FIELD_NAME)
              .Value := UnitName;
            FAnalysisProcessor.stFDQuery_Update.Params.ParamByName
              (FLOWER_TITLE_FIELD_NAME).Value := UnitName.ToLower;
            FAnalysisProcessor.stFDQuery_Update.ExecSQL;
        end;
    end;
end;

initialization

FComponentParser := TComponentParser.Create;

end.
