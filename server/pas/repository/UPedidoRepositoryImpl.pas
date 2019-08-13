unit UPedidoRepositoryImpl;

interface

uses
  UPedidoRepositoryIntf, UPizzaTamanhoEnum, UPizzaSaborEnum, UDBConnectionIntf, FireDAC.Comp.Client;

type
  TPedidoRepository = class(TInterfacedObject, IPedidoRepository)
  private
    FDBConnection: IDBConnection;
    FFDQuery: TFDQuery;
  public
    procedure efetuarPedido(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum; const AValorPedido: Currency;
      const ATempoPreparo: Integer; const ACodigoCliente: Integer);
    procedure consultarPedido(const DocumentoCliente: string; out FdQuery: TFDQuery);

    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation

uses
  UDBConnectionImpl, System.SysUtils, Data.DB, FireDAC.Stan.Param;

const
  CMD_INSERT_PEDIDO
    : String =
    'INSERT INTO tb_pedido (cd_cliente, dt_pedido, dt_entrega, vl_pedido, nr_tempopedido) VALUES (:pCodigoCliente, :pDataPedido, :pDataEntrega, :pValorPedido, :pTempoPedido)';

  CMD_CONSULTA_PEDIDO:
    string =
    'select ''enPequena'' as tamanho_pizza, '+
     ' ''enCalabresa'' as sabor_pizza, '+
     ' P.vl_pedido, '+
     ' P.nr_tempoPedido, '+
     '  P.id '+
    'from tb_pedido P '+
    'join tb_cliente CLI on CLI.id = P.cd_cliente '+
    'where CLI.nr_documento = :Doc '+
    'order by P.id desc '+
    'limit 1 ';

  { TPedidoRepository }

procedure TPedidoRepository.consultarPedido(const DocumentoCliente: string;
  out FdQuery: TFDQuery);
begin
  FdQuery.Connection:= FDBConnection.getDefaultConnection;
  FdQuery.SQL.Text:= CMD_CONSULTA_PEDIDO;
  FdQuery.ParamByName('doc').AsString:= DocumentoCliente;
  FdQuery.Prepare;
  FdQuery.Open;
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

  FFDQuery.Prepare;
  FFDQuery.ExecSQL(True);
end;

end.
