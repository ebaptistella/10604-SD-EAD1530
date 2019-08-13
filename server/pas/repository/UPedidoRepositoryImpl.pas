unit UPedidoRepositoryImpl;

interface

uses
  UPedidoRepositoryIntf,
  UPizzaTamanhoEnum,
  UPizzaSaborEnum,
  UDBConnectionIntf,

  FireDAC.Comp.Client,

  System.Rtti;

type
  TPedidoRepository = class(TInterfacedObject, IPedidoRepository)
  private
    FDBConnection: IDBConnection;
    FFDQuery: TFDQuery;

    function ConvertPizzaTamanhoEnum(APizzaTamanho: TPizzaTamanhoEnum): String;
    function ConvertPizzaSaborEnum(APizzaSabor: TPizzaSaborEnum): String;
  public
    procedure efetuarPedido(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum; const AValorPedido: Currency;
      const ATempoPreparo: Integer; const ACodigoCliente: Integer);
    procedure  consultarPedido(const ADocumentoCliente: string; out AFDQuery:TFDQuery ); stdcall;
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation

uses
  UDBConnectionImpl, System.SysUtils, Data.DB, FireDAC.Stan.Param;

const
  CMD_INSERT_PEDIDO
    : String =
    'INSERT INTO tb_pedido (cd_cliente, dt_pedido, dt_entrega, vl_pedido, nr_tempopedido, pizzatamanho, pizzasabor) VALUES (:pCodigoCliente, :pDataPedido, :pDataEntrega, :pValorPedido, :pTempoPedido, :pPizzatamanho, :pPizzasabor)';

 CMD_CONSULTAR_PEDIDO
    : String =
    '  SELECT pizzatamanho , pizzasabor, dt_pedido, vl_pedido, nr_tempopedido from tb_pedido INNER JOIN TB_CLIENTE on tb_pedido.cd_cliente=tb_cliente.id where tb_cliente.nr_documento = :pDocumento order by tb_pedido.id desc limit 1 ';

  { TPedidoRepository }

procedure TPedidoRepository.consultarPedido(const ADocumentoCliente: string;
  out AFDQuery: TFDQuery);
begin
  AFDQuery.Connection := FDBConnection.getDefaultConnection;
  AFDQuery.SQL.Text := CMD_CONSULTAR_PEDIDO;

  AFDQuery.ParamByName('pDocumento').asString := ADocumentoCliente;

  AFDQuery.Open;
end;

function TPedidoRepository.ConvertPizzaTamanhoEnum(APizzaTamanho: TPizzaTamanhoEnum): String;
begin
  Result := Copy(TRttiEnumerationType.GetName<TPizzaTamanhoEnum>(APizzaTamanho),
    3, length(TRttiEnumerationType.GetName<TPizzaTamanhoEnum>(APizzaTamanho)));
end;

function TPedidoRepository.ConvertPizzaSaborEnum(APizzaSabor: TPizzaSaborEnum): String;
begin
  Result := Copy(TRttiEnumerationType.GetName<TPizzaSaborEnum>(APizzaSabor),
    3, length(TRttiEnumerationType.GetName<TPizzaSaborEnum>(APizzaSabor)));
end;

constructor TPedidoRepository.Create;
begin
  inherited;

  FDBConnection := TDBConnection.Create;
  FFDQuery := TFDQuery.Create(nil);
  FFDQuery.Connection := FDBConnection.getDefaultConnection;
end;

destructor TPedidoRepository.Destroy;
begin
  FFDQuery.Free;
  inherited;
end;

procedure TPedidoRepository.efetuarPedido(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum; const AValorPedido: Currency;
  const ATempoPreparo: Integer; const ACodigoCliente: Integer);
begin
  FFDQuery.SQL.Text := CMD_INSERT_PEDIDO;

  FFDQuery.ParamByName('pPizzaTamanho').asInteger   := integer(APizzaTamanho);
  FFDQuery.ParamByName('pPizzaSabor').asInteger     := integer(APizzaSabor);
  FFDQuery.ParamByName('pCodigoCliente').AsInteger  := ACodigoCliente;
  FFDQuery.ParamByName('pDataPedido').AsDateTime    := now();
  FFDQuery.ParamByName('pDataEntrega').AsDateTime   := now();
  FFDQuery.ParamByName('pValorPedido').AsCurrency   := AValorPedido;
  FFDQuery.ParamByName('pTempoPedido').AsInteger    := ATempoPreparo;

  FFDQuery.Prepare;
  FFDQuery.ExecSQL(True);
end;

end.
