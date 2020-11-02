program Stc.MigrationAnalysisTool;

uses
  Vcl.Forms,
  UnitMain in 'UnitMain.pas' {frmMain},
  Mat.SupportedDevelopmentTools in 'Classes\Mat.SupportedDevelopmentTools.pas',
  Mat.ProjectGroupParser in 'Classes\Mat.ProjectGroupParser.pas',
  Mat.ProjectParser in 'Classes\Mat.ProjectParser.pas',
  Mat.ProjectUnitParser in 'Classes\Mat.ProjectUnitParser.pas',
  Mat.Constants in 'Classes\Mat.Constants.pas',
  Mat.AnalysisProcessor in 'Helpers\Mat.AnalysisProcessor.pas',
  Mat.Settings in 'Helpers\Mat.Settings.pas',
  UnitAbout in 'UnitAbout.pas' {frmAbout},
  Mat.Export in 'Helpers\Mat.Export.pas',
  Mat.Components in 'Classes\Mat.Components.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;

end.
