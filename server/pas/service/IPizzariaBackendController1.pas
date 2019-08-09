// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://localhost:8080/wsdl/IPizzariaBackendController
//  >Import : http://localhost:8080/wsdl/IPizzariaBackendController>0
//  >Import : http://localhost:8080/wsdl/IPizzariaBackendController>1
//  >Import : http://localhost:8080/wsdl/IPizzariaBackendController>2
// Version  : 1.0
// (05/08/2019 14:48:38 - - $Rev: 93209 $)
// ************************************************************************ //

unit IPizzariaBackendController1;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:double          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:int             - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[]

  TPedidoRetornoDTO    = class;                 { "urn:UPedidoRetornoDTOImpl"[GblCplx] }

  {$SCOPEDENUMS ON}
  { "urn:UPizzaTamanhoEnum"[GblSmpl] }
  TPizzaTamanhoEnum = (enPequena, enMedia, enGrande);

  { "urn:UPizzaSaborEnum"[GblSmpl] }
  TPizzaSaborEnum = (enCalabresa, enMarguerita, enPortuguesa);

  {$SCOPEDENUMS OFF}



  // ************************************************************************ //
  // XML       : TPedidoRetornoDTO, global, <complexType>
  // Namespace : urn:UPedidoRetornoDTOImpl
  // ************************************************************************ //
  TPedidoRetornoDTO = class(TRemotable)
  private
    FPizzaTamanho: TPizzaTamanhoEnum;
    FPizzaSabor: TPizzaSaborEnum;
    FValorTotalPedido: Double;
    FTempoPreparo: Integer;
  published
    property PizzaTamanho:     TPizzaTamanhoEnum  read FPizzaTamanho write FPizzaTamanho;
    property PizzaSabor:       TPizzaSaborEnum    read FPizzaSabor write FPizzaSabor;
    property ValorTotalPedido: Double             read FValorTotalPedido write FValorTotalPedido;
    property TempoPreparo:     Integer            read FTempoPreparo write FTempoPreparo;
  end;


  // ************************************************************************ //
  // Namespace : urn:PizzariaBackendControllerIntf-IPizzariaBackendController
  // soapAction: urn:PizzariaBackendControllerIntf-IPizzariaBackendController#efetuarPedido
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // use       : encoded
  // binding   : IPizzariaBackendControllerbinding
  // service   : IPizzariaBackendControllerservice
  // port      : IPizzariaBackendControllerPort
  // URL       : http://localhost:8080/soap/IPizzariaBackendController
  // ************************************************************************ //
  IPizzariaBackendController = interface(IInvokable)
  ['{51E66D72-E705-6B07-06A2-EE419B5B1649}']
    function  efetuarPedido(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum; const ADocumentoCliente: string): TPedidoRetornoDTO; stdcall;
  end;

function GetIPizzariaBackendController(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IPizzariaBackendController;


implementation
  uses System.SysUtils;

function GetIPizzariaBackendController(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IPizzariaBackendController;
const
  defWSDL = 'http://localhost:8080/wsdl/IPizzariaBackendController';
  defURL  = 'http://localhost:8080/soap/IPizzariaBackendController';
  defSvc  = 'IPizzariaBackendControllerservice';
  defPrt  = 'IPizzariaBackendControllerPort';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as IPizzariaBackendController);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


initialization
  { IPizzariaBackendController }
  InvRegistry.RegisterInterface(TypeInfo(IPizzariaBackendController), 'urn:PizzariaBackendControllerIntf-IPizzariaBackendController', '');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IPizzariaBackendController), 'urn:PizzariaBackendControllerIntf-IPizzariaBackendController#efetuarPedido');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TPizzaTamanhoEnum), 'urn:UPizzaTamanhoEnum', 'TPizzaTamanhoEnum');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TPizzaSaborEnum), 'urn:UPizzaSaborEnum', 'TPizzaSaborEnum');
  RemClassRegistry.RegisterXSClass(TPedidoRetornoDTO, 'urn:UPedidoRetornoDTOImpl', 'TPedidoRetornoDTO');

end.