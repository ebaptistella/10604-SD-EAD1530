unit UPedidoServiceImpl;

interface

uses
  UPedidoServiceIntf, UPizzaTamanhoEnum, UPizzaSaborEnum,
  UPedidoRepositoryIntf, UPedidoRetornoDTOImpl, UClienteServiceIntf, Data.DB,
  TypInfo;

type
  TPedidoService = class(TInterfacedObject, IPedidoService)
  private
    FPedidoRepository: IPedidoRepository;
    FClienteService: IClienteService;

    function calcularValorPedido(const APizzaTamanho: TPizzaTamanhoEnum): Currency;
    function calcularTempoPreparo(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum): Integer;
  public
    function efetuarPedido(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum; const ADocumentoCliente: String): TPedidoRetornoDTO;
    function consultarPedidoAndersonFurtilho(const ADocumentoCliente: string): TPedidoRetornoDTO; stdcall;
    constructor Create; reintroduce;
  end;

implementation

uses
  UPedidoRepositoryImpl, System.SysUtils, UClienteServiceImpl,
  FireDAC.Comp.Client;

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

function TPedidoService.consultarPedidoAndersonFurtilho(
  const ADocumentoCliente: string): TPedidoRetornoDTO;
var
  oFDQuery: TFDQuery;
  S: TPizzaSaborEnum;
  T: TPizzaTamanhoEnum;

begin
  oFDQuery := TFDQuery.Create(nil);
  try
    FPedidoRepository.consultarPedidoAndersonFurtilho(ADocumentoCliente, oFDQuery);

    if oFDQuery.IsEmpty then
      raise Exception.Create('O cliente com número do documento '  + ADocumentoCliente + ' não possui pedidos');


    // Tamanho, Sabor,

//    Result := TPedidoRetornoDTO.Create(oFDQuery.FieldByName('TX_TAMANHOPIZZA').AsString,
//    oFDQuery.FieldByName('TX_SABORPIZZA').AsString,
//    oFDQuery.FieldByName('VL_PEDIDO').AsCurrency,
//    oFDQuery.FieldByName('NR_TEMPO_PEDIDO').AsInteger);

    T := TPizzaTamanhoEnum(GetENumValue(TypeInfo(TPizzaTamanhoEnum), oFDQuery.FieldByName('TAMANHO').AsString));
    S := TPizzaSaborEnum(GetENumValue(TypeInfo(TPizzaSaborEnum), oFDQuery.FieldByName('SABOR').AsString));

    Result := TPedidoRetornoDTO.Create(T,S, oFDQuery.FieldByName('VL_PEDIDO').AsCurrency,
    oFDQuery.FieldByName('NR_TEMPOPEDIDO').AsInteger);
  finally
    oFDQuery.Free;
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
