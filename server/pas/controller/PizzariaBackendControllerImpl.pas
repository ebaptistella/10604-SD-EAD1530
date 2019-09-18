{ Invokable implementation File for TPizzariaBackend which implements IPizzariaBackend }

unit PizzariaBackendControllerImpl;

interface

uses Soap.InvokeRegistry, System.Types, Soap.XSBuiltIns, PizzariaBackendControllerIntf,
  UPizzaSaborEnum, UPizzaTamanhoEnum, UPedidoServiceIntf,
  UPedidoRetornoDTOImpl, UClienteRepositoryImpl;

type

  { TPizzariaBackend }
  TPizzariaBackendController = class(TInvokableClass, IPizzariaBackendController)
  private
    FPedidoService: IPedidoService;
    FClienteService : TClienteRepository;
  public
    function efetuarPedido(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum; const ADocumentoCliente: String): TPedidoRetornoDTO; stdcall;
    function obterPedido(const ADocumentoCliente : String): TPedidoRetornoDTO; stdcall;

    constructor Create; override;
  end;

implementation

uses
  UPedidoServiceImpl;


{ TPizzariaBackendController }

constructor TPizzariaBackendController.Create;
begin
  inherited;

  FPedidoService   := TPedidoService.Create();
  FClienteService  := TClienteRepository.Create();
end;

function TPizzariaBackendController.efetuarPedido(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum; const ADocumentoCliente: String): TPedidoRetornoDTO; stdcall;
begin
  Result := FPedidoService.efetuarPedido(APizzaTamanho, APizzaSabor, ADocumentoCliente);
end;

function TPizzariaBackendController.obterPedido(
  const ADocumentoCliente: String): TPedidoRetornoDTO; stdcall;
var
  oCodigoCliente: Integer;
begin
   oCodigoCliente := FClienteService.adquirirCodigoCliente(ADocumentoCliente);
   Result := FPedidoService.obterPedido(oCodigoCliente);
end;

initialization

{ Invokable classes must be registered }
InvRegistry.RegisterInvokableClass(TPizzariaBackendController);

end.
