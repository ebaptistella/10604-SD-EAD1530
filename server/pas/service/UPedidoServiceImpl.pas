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
    function ConsultarPedido(const ADocumentoCliente: string): TPedidoRetornoDTO;
      stdcall;

    constructor Create; reintroduce;
  end;

implementation

uses
  UPedidoRepositoryImpl, System.SysUtils, UClienteServiceImpl,
  FireDAC.Comp.Client, System.Rtti;

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

function TPedidoService.ConsultarPedido(
  const ADocumentoCliente: string): TPedidoRetornoDTO;
var  ofdquery : tfdQuery;
begin
  ofdquery := tfdQuery.create(nil);
  try
    FPedidoRepository.consultarPedido(ADocumentoCliente,ofdquery);
    if (ofdquery.IsEmpty) then
      raise Exception.Create('O cliente com nro de docuemnto '+ ADocumentoCliente + ' n�o possui pedido!');
   //persisitir o tamamho da pizza ao fazer o pedido
   //persisitir o sabor da pizza ao fazer o pedido]
   result :=
    TPedidoRetornoDTO.Create
      (
        TRttiEnumerationType.GetValue<TPizzaTamanhoEnum>(ofdquery.FieldByName('tx_tamanhopizza').AsString),
        TRttiEnumerationType.GetValue<TPizzaSaborEnum>(ofdquery.FieldByName('tx_saborpizza').AsString),
        ofdquery.FieldByName('vl_pedido').AsCurrency,
        ofdquery.FieldByName('nr_tempopedido').AsInteger);

  finally
    ofdquery.free;
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
begin
  oValorPedido := calcularValorPedido(APizzaTamanho);
  oTempoPreparo := calcularTempoPreparo(APizzaTamanho, APizzaSabor);
  oCodigoCliente := FClienteService.adquirirCodigoCliente(ADocumentoCliente);

  FPedidoRepository.efetuarPedido(APizzaTamanho, APizzaSabor, oValorPedido, oTempoPreparo, oCodigoCliente);
  Result := TPedidoRetornoDTO.Create(APizzaTamanho, APizzaSabor, oValorPedido, oTempoPreparo);
end;

end.
