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
    function ConsultaPedido(const ADocCliente: String): TPedidoRetornoDTO; stdcall;

    constructor Create; override;
  end;

implementation

uses
  UPedidoServiceImpl;


{ TPizzariaBackendController }

function TPizzariaBackendController.ConsultaPedido(
  const ADocCliente: String): TPedidoRetornoDTO;
begin
  Result := FPedidoService.ConsultaPedido(ADocCliente);
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
