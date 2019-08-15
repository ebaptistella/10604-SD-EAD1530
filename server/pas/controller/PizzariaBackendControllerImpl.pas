{ Invokable implementation File for TPizzariaBackend which implements IPizzariaBackend }

unit PizzariaBackendControllerImpl;

interface

uses Soap.InvokeRegistry, System.Types, Soap.XSBuiltIns, PizzariaBackendControllerIntf,
  UPizzaSaborEnum, UPizzaTamanhoEnum, UPedidoServiceIntf,
  UPedidoRetornoDTOImpl;

type

  { TPizzariaBackend }
  TPizzariaBackendController = class(TInvokableClass, IPizzariaBackendController)
  private
    FPedidoService: IPedidoService;
  public
    function efetuarPedido(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum; const ADocumentoCliente: String): TPedidoRetornoDTO; stdcall;
    function ConsultarPedido(const ADocumento: String): String; stdcall;
    function ConsultarPed(const ADocumento: string): TPedidoRetornoDTO; stdcall;

    constructor Create; override;
  end;

implementation

uses
  UPedidoServiceImpl;


{ TPizzariaBackendController }

function TPizzariaBackendController.ConsultarPed(
  const ADocumento: string): TPedidoRetornoDTO;
begin
   Result := FPedidoService.ConsultarPed(ADocumento);
end;

function TPizzariaBackendController.ConsultarPedido(
  const ADocumento: String): String;
begin
  Result := FPedidoService.ConsultarPedido(ADocumento);
end;

constructor TPizzariaBackendController.Create;
begin
  inherited;

  FPedidoService := TPedidoService.Create();
end;

function TPizzariaBackendController.efetuarPedido(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum; const ADocumentoCliente: String): TPedidoRetornoDTO; stdcall;
begin
  Result := FPedidoService.efetuarPedido(APizzaTamanho, APizzaSabor, ADocumentoCliente);
end;

initialization

{ Invokable classes must be registered }
InvRegistry.RegisterInvokableClass(TPizzariaBackendController);

end.
