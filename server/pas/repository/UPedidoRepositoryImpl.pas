(*
alter table tb_cliente add nome varchar(100);

alter table tb_pedido add tamanho varchar(20);
alter table tb_pedido add sabor varchar(20);

drop  view V_pedidos;
create view V_pedidos as
select
	c.nr_documento as documento,
	c.id as cliente_codigo,
	c.nome as cliente_nome,
	p.id as pedido_id,
	p.nr_tempopedido as pedido_tempo,
	p.vl_pedido as pedido_valor,
	p.dt_pedido as pedido_data,
	case p.tamanho
		when '0' then
			'pequena'
		when '1' then
		 'media'
		when '2' then
			'grande'
	else
		'indefinido'
	end as tamanho,
	case p.sabor
		when '0' then
			'enCalabresa'
		when '1' then
			'enMarguerita'
		when '2' then
			'enPortuguesa'
		else
			'Sem sabor definido'
		end as sabor
from
	tb_pedido as p
	left join tb_cliente c on c.id = p.cd_cliente
-- where
-- 	c.nr_documento = 1
order by
	p.dt_pedido asc;



select * from V_pedidos where documento = 1
*)
unit UPedidoRepositoryImpl;

interface

uses
  UPedidoRepositoryIntf,
  UPizzaTamanhoEnum,
  UPizzaSaborEnum,
  UDBConnectionIntf,
  FireDAC.Comp.Client;

type
  TPedidoRepository = class(TInterfacedObject, IPedidoRepository)
  private
    FDBConnection: IDBConnection;
    FFDQuery: TFDQuery;
    function totalizaPedidos(const ADocumento: string): string;
  public
    procedure efetuarPedido(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum; const AValorPedido: Currency;
      const ATempoPreparo: Integer; const ACodigoCliente: Integer);
    procedure consultarPedido(const ADocumentoCliente: string; out AFDQuery: TFDQuery);
    constructor Create; reintroduce;
    destructor Destroy; override;

  end;

implementation

uses
  UDBConnectionImpl, System.SysUtils, Data.DB, FireDAC.Stan.Param;

const
  CMD_INSERT_PEDIDO : String = 'INSERT INTO tb_pedido (cd_cliente, dt_pedido, dt_entrega, vl_pedido, nr_tempopedido, tamanho, sabor) VALUES (:pCodigoCliente, :pDataPedido, :pDataEntrega, :pValorPedido, :pTempoPedido, :pTamanho, :pSabor)';
  CMD_TOTALIZA_PEDIDOS : string = 'select * from V_pedidos where documento = :documento LIMIT 1';

  { TPedidoRepository }

procedure TPedidoRepository.consultarPedido(const ADocumentoCliente: string;
  out AFDQuery: TFDQuery);
begin
  AFDQuery.Connection := FDBConnection.getDefaultConnection;
  AFDQuery.SQL.Clear;
  AFDQuery.SQL.Text := CMD_TOTALIZA_PEDIDOS;
  AFDQuery.ParamByName('documento').AsString := ADocumentoCliente;
  AFDQuery.Prepare;
  AFDQuery.open;
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
  FFDQuery.ParamByName('pTamanho').AsString := Integer(APizzaTamanho).ToString;
  FFDQuery.ParamByName('pSabor').AsString := Integer(APizzaSabor).ToString;
  FFDQuery.Prepare;
  FFDQuery.ExecSQL(True);
end;

function TPedidoRepository.totalizaPedidos(const ADocumento: string): string;
begin
  Result := '';
  FFDQuery.SQL.Clear;
  FFDQuery.SQL.Text := CMD_TOTALIZA_PEDIDOS;

  FFDQuery.ParamByName('documento').AsString := ADocumento;
  FFDQuery.Prepare;
  FFDQuery.Open;
  if not FFDQuery.IsEmpty then
  begin

  end
  else
  begin
    Result := 'Este cliente não possui pedidos!';
  end;
end;

end.
