unit Mat.Export;

interface

uses
    Vcl.DBGrids, System.Classes, System.SysUtils;

type
    // Class helps to export to Excel.
    TExportHelper = class
    public
        procedure ExportToCsv(FileName: String; SourceGrid: TDBGrid);
    end;

var
    ExportHelper: TExportHelper;

implementation

{ TExcelExportHelper }

uses Mat.Constants;

procedure TExportHelper.ExportToCsv(FileName: String; SourceGrid: TDBGrid);
var
    Stream: TFileStream;
    i: Integer;
    OutLine: String;
    sTemp, s: String;
begin
    Stream := TFileStream.Create(FileName, fmCreate);
    try
       s := String(SourceGrid.Fields[0].FieldName);

        for i := 1 to SourceGrid.FieldCount - 1 do
        begin
            s := s + ',' + string(SourceGrid.Fields[I].FieldName);
       end;

       s:= s + CRLF;

       Stream.Write(s[1], Length(s) * SizeOf(Char));

        while not SourceGrid.DataSource.DataSet.Eof do
        begin
            // You'll need to add your special handling here where OutLine is built
            s := '';
            OutLine := '';
            for i := 0 to SourceGrid.FieldCount - 1 do
            begin
                sTemp := SourceGrid.Fields[i].AsString;
                // Special handling to sTemp here
                OutLine := OutLine + sTemp +',';
            end;
            // Remove final unnecessary ','
            SetLength(OutLine, Length(OutLine) - 1);
            // Write line to file
            Stream .Write(OutLine[1], Length(OutLine) * SizeOf(Char));
            // Write line ending
            Stream.Write(sLineBreak, Length(sLineBreak));
            SourceGrid.DataSource.DataSet.Next;
        end;

    finally
        Stream.Free;  // Saves the file
    end;
    //showmessage('Records Successfully Exported.') ;
end;

initialization
    ExportHelper := TExportHelper.Create;

finalization
    FreeAndNil(ExportHelper);

end.
