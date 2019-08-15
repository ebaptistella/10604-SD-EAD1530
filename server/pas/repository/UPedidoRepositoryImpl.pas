unit UPedidoRepositoryImpl;

interface

uses
  UPedidoRepositoryIntf, UPizzaTamanhoEnum, UPizzaSaborEnum, UDBConnectionIntf, FireDAC.Comp.Client,DateUtils;

type
  TPedidoRepository = class(TInterfacedObject, IPedidoRepository)
  private
    FDBConnection: IDBConnection;
    FFDQuery: TFDQuery;
  public
    procedure efetuarPedido(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum; const AValorPedido: Currency;
      const ATempoPreparo: Integer; const ACodigoCliente: Integer);

    function ConsultarPedido(const ADocumento: String):String;
    procedure ConsultaPed(const ADocumento: string; out AQuery: TFDQuery);


    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation

uses
  UDBConnectionImpl, System.SysUtils, Data.DB, FireDAC.Stan.Param;

const
  CMD_INSERT_PEDIDO
    : String =
    'INSERT INTO tb_pedido (cd_cliente, dt_pedido, dt_entrega, vl_pedido, nr_tempopedido,tamanho,sabor) VALUES (:pCodigoCliente, :pDataPedido, :pDataEntrega, :pValorPedido, :pTempoPedido,:ptamanho,:psabor)';
  CMD_CONSULTA_PEDIDO :String =
    'select count(b.cd_cliente), min(b.dt_pedido),max(b.dt_entrega),sum(b.nr_tempopedido), sum(b.vl_pedido)  from tb_cliente a,  tb_pedido b on a.id = b.cd_cliente  where a.id = b.cd_cliente and  a.nr_documento = :pDocumento';
  CMD_CONSULTA_PED :String =
    'select b.tamanho,b.sabor, b.dt_pedido,b.dt_entrega,b.nr_tempopedido, b.vl_pedido  from tb_cliente a,  tb_pedido b on a.id = b.cd_cliente  where a.id = b.cd_cliente and  a.nr_documento = :pDocumento order by b.id desc limit 1';

  { TPedidoRepository }

procedure TPedidoRepository.ConsultaPed(const ADocumento: string;
  out AQuery: TFDQuery);
begin
  AQuery.SQL.Clear;
  AQuery.Connection := FDBConnection.getDefaultConnection;
  AQuery.SQL.Text := CMD_CONSULTA_PED;

  AQuery.ParamByName('pDocumento').value := ADocumento;

  AQuery.Open();



end;

function TPedidoRepository.ConsultarPedido(
  const ADocumento: String): String;

begin

  FFDQuery.SQL.Clear;
  FFDQuery.SQL.Text := CMD_CONSULTA_PEDIDO;

  FFDQuery.ParamByName('pDocumento').value := ADocumento;

  FFDQuery.Open();

  if FFDQuery.Fields[0].AsString = '0' then
    Result := 'Pedido n�o localizado.'
  else
    Result := 'Quantidade de Pizzas: ' + FFDQuery.Fields[0].AsString +
              ' Data Pedido: ' + FFDQuery.Fields[1].AsString +
              ' Data Prev. Entrega: ' + FFDQuery.Fields[2].AsString +
              ' Tempo total de preparo: ' + FFDQuery.Fields[3].AsString +
              ' Valor total: ' + FFDQuery.Fields[4].AsString;


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

  FFDQuery.ParamByName('pCodigoCliente').AsInteger := ACodigoCliente;
  FFDQuery.ParamByName('pDataPedido').AsDateTime := now();
  FFDQuery.ParamByName('pDataEntrega').AsDateTime := now();
  FFDQuery.ParamByName('pValorPedido').AsCurrency := AValorPedido;
  FFDQuery.ParamByName('pTempoPedido').AsInteger := ATempoPreparo;
  FFDQuery.ParamByName('ptamanho').Value := APizzaTamanho;
  FFDQuery.ParamByName('psabor').Value := APizzaSabor;


  FFDQuery.Prepare;
  FFDQuery.ExecSQL(True);
end;

end.
