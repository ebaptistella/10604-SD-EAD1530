unit UPizzariaControllerImpl;

interface

{$I dmvcframework.inc}

uses MVCFramework, MVCFramework.Logger, MVCFramework.Commons,
  Web.HTTPApp, UPizzaTamanhoEnum, UPizzaSaborEnum, UEfetuarPedidoDTOImpl;

type

  [MVCDoc('Pizzaria backend')]
  [MVCPath('/')]
  TPizzariaBackendController = class(TMVCController)
  public
    [MVCDoc('Criar novo pedido "201: Created"')]
    [MVCPath('/PedidoRealiza')]
    [MVCHTTPMethod([httpPOST])]
    procedure PedidoRealiza(const AContext: TWebContext);
  end;

implementation

uses
  System.SysUtils, Rest.json, MVCFramework.SystemJSONUtils, UPedidoServiceIntf,
  UPedidoServiceImpl, UPedidoRetornoDTOImpl;

{ TApp1MainController }

procedure TPizzariaBackendController.PedidoRealiza(const AContext: TWebContext);
var
  oPedidoRealizaDTO: TPedidoRealizaDTO;
  oPedidoRetornoDTO: TPedidoRetornoDTO;
begin
  oPedidoRealizaDTO := AContext.Request.BodyAs<TPedidoRealizaDTO>;
  try
    with TPedidoService.Create do
    try
      oPedidoRetornoDTO := efetuarPedido(oPedidoRealizaDTO.PizzaTamanho, oPedidoRealizaDTO.PizzaSabor, oPedidoRealizaDTO.DocumentoCliente);
      Render(TJson.ObjectToJsonString(oPedidoRetornoDTO));
    finally
      oPedidoRetornoDTO.Free
    end;
  finally
    oPedidoRealizaDTO.Free;
  end;
  Log.Info('==>Executou o método ', 'PedidoRealiza');
end;

end.
