unit UnitAbout;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, ShellApi,
  Vcl.Imaging.pngimage;

type
  TfrmAbout = class(TForm)
    pPanel: TPanel;
    lblIntro1: TLabel;
    lblLicense: TLabel;
    lblLicenseName: TLabel;
    lblContributors: TLabel;
    mContributors: TMemo;
    btnOK: TButton;
    Image1: TImage;
    procedure lblLicenseNameClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses Mat.Constants;

procedure TfrmAbout.btnOKClick(Sender: TObject);
begin
    ModalResult := mrOk;
end;

procedure TfrmAbout.FormCreate(Sender: TObject);
begin
    mContributors.Lines.Text := CONTRIBUTORS;
end;

procedure TfrmAbout.lblLicenseNameClick(Sender: TObject);
begin
    ShellExecute(Handle, SHELL_OPEN_COMMAND, URL_LICENSE_APACHE20,
      nil, nil, SW_SHOWNORMAL);
end;

end.
