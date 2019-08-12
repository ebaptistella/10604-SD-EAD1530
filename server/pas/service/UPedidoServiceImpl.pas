unit UPedidoServiceImpl;

interface

uses
  Data.DB,
  System.StrUtils,
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
    function consultarPedido(const ADocumentoCliente:string):TPedidoRetornoDTO;stdcall;

    function GetTamanho(const ATamanho : string): TPizzaTamanhoEnum;
    function GetSabor(const ASabor : string):TPizzaSaborEnum;

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

function TPedidoService.consultarPedido(
  const ADocumentoCliente: string): TPedidoRetornoDTO;
var
  oFDQuery : TFDQuery;
begin

  try
    oFDQuery := TFDQuery.Create(nil);
    FPedidoRepository.consultarPedido(ADocumentoCliente, oFDQuery);
    if oFDQuery.IsEmpty then
      raise Exception.Create('O Cliente com o numero de documento ' + ADocumentoCliente + ' não possui pedidos.')
    else
      Result := TPedidoRetornoDTO.Create(GetTamanho(oFDQuery.FieldByName('tamanho').AsString) ,
                                        GetSabor(oFDQuery.FieldByName('sabor').AsString),
                                        oFDQuery.FieldByName('pedido_valor').AsCurrency,
                                        oFDQuery.FieldByName('pedido_tempo').AsInteger);
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

function TPedidoService.GetSabor(const ASabor: string): TPizzaSaborEnum;
begin
  Result := TPizzaSaborEnum(AnsiIndexStr(ASabor,['enCalabresa', 'enMarguerita', 'enPortuguesa']));
end;

function TPedidoService.GetTamanho(const ATamanho: string): TPizzaTamanhoEnum;
begin
  Result := TPizzaTamanhoEnum(AnsiIndexStr(ATamanho,['enPequena', 'enMedia', 'enGrande']));
end;

end.
