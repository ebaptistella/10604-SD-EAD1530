program PizzariaFrontend;

uses
  Vcl.Forms,
  UFrmPrincipalImpl in '..\pas\ui\UFrmPrincipalImpl.pas' {FrmClientPrinc},
  WSDLPizzariaBackendControllerImpl in '..\pas\wm\WSDLPizzariaBackendControllerImpl.pas',
  UPedidoRetornoDTOImpl in '..\..\shared\pas\dto\UPedidoRetornoDTOImpl.pas',
  UPizzaSaborEnum in '..\..\shared\pas\enum\UPizzaSaborEnum.pas',
  UPizzaTamanhoEnum in '..\..\shared\pas\enum\UPizzaTamanhoEnum.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmClientPrinc, FrmClientPrinc);
  Application.Run;
end.
