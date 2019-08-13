unit UPedidoRepositoryImpl;

interface

uses
  UPedidoRepositoryIntf, UPizzaTamanhoEnum, UPizzaSaborEnum, UDBConnectionIntf, FireDAC.Comp.Client, TypInfo;

type
  TPedidoRepository = class(TInterfacedObject, IPedidoRepository)
  private
    FDBConnection: IDBConnection;
    FFDQuery: TFDQuery;
  public
   procedure efetuarPedido(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum; const AValorPedido: Currency;
      const ATempoPreparo: Integer; const ACodigoCliente: Integer);
    procedure consultarPedido(const ADocumentoCliente: String; out AFDQuery: TFDQuery );

    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation

uses
  UDBConnectionImpl, System.SysUtils, Data.DB, FireDAC.Stan.Param;

const
  CMD_INSERT_PEDIDO
    : String =
    'INSERT INTO tb_pedido (cd_cliente, dt_pedido, dt_entrega, vl_pedido, nr_tempopedido, tx_sabor, tx_tamanho) VALUES (:pCodigoCliente, :pDataPedido, :pDataEntrega, :pValorPedido, :pTempoPedido, :pSaborPizza, :pTamanhoPizza)';

  CMD_CONSULTA_PEDIDO
    : String =
          ' select p.tx_tamanho, p.tx_sabor, p.vl_pedido, p.nr_tempopedido ' +
          ' from tb_pedido p ' +
          ' inner join tb_cliente c ' +
          ' on (p.cd_cliente = c.id) ' +
          ' where c.nr_documento = :pDocumentoCliente' +
          ' order by p.id desc' +
          ' limit 1';

  { TPedidoRepository }

(*
procedure TPedidoRepository.consultarPedido(const ADocumentoCliente: string; AQuery: );
begin
  FFDQuery.SQL.Text := CMD_CONSULTA_PEDIDO;

  FFDQuery.ParamByName('pDocumentoCliente').AsString := ADocumentoCliente;
  FFDQuery.Prepare;
  FFDQuery.ExecSQL;




end;
*)
procedure TPedidoRepository.consultarPedido(const ADocumentoCliente: String;
  out AFDQuery: TFDQuery);
begin
  AFDQuery.Connection := FDBConnection.getDefaultConnection;
  AFDQuery.SQL.Text := CMD_CONSULTA_PEDIDO;

  AFDQuery.ParamByName('pDocumentoCliente').AsString := ADocumentoCliente;
  AFDQuery.Prepare;
  AFDQuery.Open;

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

procedure TPedidoRepository.efetuarPedido(const APizzaTamanho: TPizzaTamanhoEnum;
  const APizzaSabor: TPizzaSaborEnum; const AValorPedido: Currency;
  const ATempoPreparo: Integer; const ACodigoCliente: Integer);
begin
  FFDQuery.SQL.Text := CMD_INSERT_PEDIDO;

  FFDQuery.ParamByName('pCodigoCliente').AsInteger := ACodigoCliente;
  FFDQuery.ParamByName('pDataPedido').AsDateTime := now();
  FFDQuery.ParamByName('pDataEntrega').AsDateTime := now();
  FFDQuery.ParamByName('pValorPedido').AsCurrency := AValorPedido;
  FFDQuery.ParamByName('pTempoPedido').AsInteger := ATempoPreparo;
  FFDQuery.ParamByName('pSaborPizza').AsString := GetEnumName(TypeInfo(TPizzaSaborEnum), Integer(APizzaSabor));
  FFDQuery.ParamByName('pTamanhoPizza').AsString := GetEnumName(TypeInfo(TPizzaTamanhoEnum), Integer(APizzaTamanho));

  FFDQuery.Prepare;
  FFDQuery.ExecSQL(True);
end;

end.
