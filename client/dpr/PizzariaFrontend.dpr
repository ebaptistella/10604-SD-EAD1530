program PizzariaFrontend;

uses
  Vcl.Forms,
  UFrmPrincipalImpl in '..\pas\ui\UFrmPrincipalImpl.pas' {Form1},
  WSDLPizzariaBackendControllerImpl in '..\pas\wm\WSDLPizzariaBackendControllerImpl.pas',
  UPedidoRetornoDTOImpl in '..\..\shared\pas\dto\UPedidoRetornoDTOImpl.pas',
  UPizzaSaborEnum in '..\..\shared\pas\enum\UPizzaSaborEnum.pas',
  UPizzaTamanhoEnum in '..\..\shared\pas\enum\UPizzaTamanhoEnum.pas',
  UFrmConsultaPedido in '..\pas\ui\UFrmConsultaPedido.pas' {FrmConsultaPedido};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFrmConsultaPedido, FrmConsultaPedido);
  Application.Run;
end.
