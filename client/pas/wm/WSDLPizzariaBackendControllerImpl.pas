unit WSDLPizzariaBackendControllerImpl;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns,
  UPizzaTamanhoEnum, UPizzaSaborEnum, UPedidoRetornoDTOImpl;

type

  IPizzariaBackendController = interface(IInvokable)
  ['{51E66D72-E705-6B07-06A2-EE419B5B1649}']
    function  efetuarPedido(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum; const ADocumentoCliente: string): TPedidoRetornoDTO; stdcall;
    function  ConsultarPedido(const ADocumentoCliente: string): TPedidoRetornoDTO; stdcall;
  end;

function GetIPizzariaBackendController(Addr: string=''): IPizzariaBackendController;


implementation
  uses System.SysUtils;

function GetIPizzariaBackendController(Addr: string): IPizzariaBackendController;
const
  defSvc  = 'IPizzariaBackendControllerservice';
  defPrt  = 'IPizzariaBackendControllerPort';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  RIO := THTTPRIO.Create(nil);

  try
    Result := (RIO as IPizzariaBackendController);
    RIO.URL := Addr;
  finally
    if (Result = nil) then
      RIO.Free;
  end;
end;


initialization
  { IPizzariaBackendController }
  InvRegistry.RegisterInterface(TypeInfo(IPizzariaBackendController), 'urn:PizzariaBackendControllerIntf-IPizzariaBackendController', '');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IPizzariaBackendController), 'urn:PizzariaBackendControllerIntf-IPizzariaBackendController#%operationName%');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TPizzaTamanhoEnum), 'urn:UPizzaTamanhoEnum', 'TPizzaTamanhoEnum');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TPizzaSaborEnum), 'urn:UPizzaSaborEnum', 'TPizzaSaborEnum');
  RemClassRegistry.RegisterXSClass(TPedidoRetornoDTO, 'urn:UPedidoRetornoDTOImpl', 'TPedidoRetornoDTO');

end.
