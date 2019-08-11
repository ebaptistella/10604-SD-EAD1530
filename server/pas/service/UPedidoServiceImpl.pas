unit UPedidoServiceImpl;

interface

uses
  UPedidoServiceIntf, UPizzaTamanhoEnum, UPizzaSaborEnum,
  UPedidoRepositoryIntf, UPedidoRetornoDTOImpl, UClienteServiceIntf;

type
  TPedidoService = class(TInterfacedObject, IPedidoService)
  private
    FPedidoRepository: IPedidoRepository;
    FClienteService: IClienteService;

    function calcularValorPedido(const APizzaTamanho: TPizzaTamanhoEnum): Currency;
    function calcularTempoPreparo(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum): Integer;
  public
    function efetuarPedido(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum; const ADocumentoCliente: String): TPedidoRetornoDTO;
    function consultarPedido(const ADocumentoCliente: string): TPedidoRetornoDTO;

    constructor Create; reintroduce;
  end;

implementation

uses
  UPedidoRepositoryImpl, System.SysUtils, System.DateUtils, System.Rtti,
  UClienteServiceImpl, FireDAC.Comp.Client, Data.DB;

{ TPedidoService }

function TPedidoService.calcularTempoPreparo(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum): Integer;
begin
  Result := 15;
  case APizzaTamanho of
    enPequena:
      Result := 15;
    enMedia:
      Result := 20;
    enGrande:
      Result := 25;
  end;

  if (APizzaSabor = enPortuguesa) then
    Result := Result + 5;
end;

function TPedidoService.calcularValorPedido(const APizzaTamanho: TPizzaTamanhoEnum): Currency;
begin
  Result := 20;
  case APizzaTamanho of
    enPequena:
      Result := 20;
    enMedia:
      Result := 30;
    enGrande:
      Result := 40;
  end;
end;

function TPedidoService.consultarPedido(
  const ADocumentoCliente: string): TPedidoRetornoDTO;
var
  oFdQueryPedido: TFDQuery;
begin
  oFdQueryPedido := TFDQuery.Create(nil);
  try
    FPedidoRepository.consultarPedido(ADocumentoCliente, oFdQueryPedido);
    if oFdQueryPedido.IsEmpty then
      raise Exception.CreateFmt('O cliente com nro de documento %s não possui pedidos', [ADocumentoCliente]);

    Result := TPedidoRetornoDTO.Create(
      TRttiEnumerationType.GetValue<TPizzaTamanhoEnum>(oFdQueryPedido.FieldByName('tx_tamanho').AsString),
      TRttiEnumerationType.GetValue<TPizzaSaborEnum>(oFdQueryPedido.FieldByName('tx_sabor').AsString),
      oFdQueryPedido.FieldByName('vl_pedido').AsCurrency,
      oFdQueryPedido.FieldByName('nr_tempopedido').AsInteger,
      oFdQueryPedido.FieldByName('dt_pedido').AsDateTime,
      oFdQueryPedido.FieldByName('dt_entrega').AsDateTime);
  finally
    FreeAndNil(oFdQueryPedido);
  end;
end;

constructor TPedidoService.Create;
begin
  inherited;

  FPedidoRepository := TPedidoRepository.Create;
  FClienteService := TClienteService.Create;
end;

function TPedidoService.efetuarPedido(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum; const ADocumentoCliente: String)
  : TPedidoRetornoDTO;
var
  oValorPedido: Currency;
  oTempoPreparo: Integer;
  oCodigoCliente: Integer;
  oDataPedido: TDateTime;
  oDataEntrega: TDateTime;
begin
  oValorPedido := calcularValorPedido(APizzaTamanho);
  oTempoPreparo := calcularTempoPreparo(APizzaTamanho, APizzaSabor);
  oCodigoCliente := FClienteService.adquirirCodigoCliente(ADocumentoCliente);
  oDataPedido := now;
  oDataEntrega := IncMinute(oDataPedido, oTempoPreparo);

  FPedidoRepository.efetuarPedido(APizzaTamanho, APizzaSabor, oValorPedido,
    oTempoPreparo, oCodigoCliente, oDataPedido, oDataEntrega);
  Result := TPedidoRetornoDTO.Create(APizzaTamanho, APizzaSabor, oValorPedido,
    oTempoPreparo, oDataPedido, oDataEntrega);
end;

end.
