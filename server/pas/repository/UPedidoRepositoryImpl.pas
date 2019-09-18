unit UPedidoRepositoryImpl;

interface

uses
  UPedidoRepositoryIntf, UPizzaTamanhoEnum, UPizzaSaborEnum, UDBConnectionIntf,
   FireDAC.Comp.Client,UPedidoRetornoDTOImpl;

type
  TPedidoRepository = class(TInterfacedObject, IPedidoRepository)
  private
    FDBConnection: IDBConnection;
    FFDQuery: TFDQuery;
  public
    procedure efetuarPedido(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum; const AValorPedido: Currency;
      const ATempoPreparo: Integer; const ACodigoCliente: Integer);

    function obterPedido(const ACodigoCliente:integer) : TPedidoRetornoDTO;
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation

uses
  UDBConnectionImpl, System.SysUtils, Data.DB, FireDAC.Stan.Param;

const
  CMD_INSERT_PEDIDO
    : String =
    'INSERT INTO tb_pedido (cd_cliente, dt_pedido, dt_entrega, vl_pedido, nr_tempopedido, tamanho, sabor) '+
    'VALUES (:pCodigoCliente, :pDataPedido, :pDataEntrega, :pValorPedido, :pTempoPedido, :pTamanho, :pSabor)';

  CMD_SELECT_PEDIDO
    : String =
    'SELECT * FROM tb_pedido where cd_cliente = :pCodigoCliente';

  { TPedidoRepository }

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
  FFDQuery.ParamByName('pDataPedido').AsDateTime   := now();
  FFDQuery.ParamByName('pDataEntrega').AsDateTime  := now();
  FFDQuery.ParamByName('pValorPedido').AsCurrency  := AValorPedido;
  FFDQuery.ParamByName('pTempoPedido').AsInteger   := ATempoPreparo;
  FFDQuery.ParamByName('pTamanho').AsInteger       := ord(APizzaTamanho);
  FFDQuery.ParamByName('pSabor').AsInteger         := ord(APizzaSabor);

  FFDQuery.Prepare;
  FFDQuery.ExecSQL(True);
end;

function TPedidoRepository.obterPedido(const ACodigoCliente: Integer): TPedidoRetornoDTO;
var
  FPizzaTamanho: TPizzaTamanhoEnum;
  FPizzaSabor: TPizzaSaborEnum;
begin
  FFDQuery.SQL.Text := CMD_SELECT_PEDIDO;
  FFDQuery.ParamByName('pCodigoCliente').AsInteger := ACodigoCliente;
  FFDQuery.Open;

  FPizzaTamanho := TPizzaTamanhoEnum(FFDQuery.FieldByName('tamanho').asInteger);
  FPizzaSabor   := TPizzaSaborEnum(FFDQuery.FieldByName('sabor').asInteger);

  result :=  TPedidoRetornoDTO.Create(
               FPizzaTamanho,
               FPizzaSabor,
               FFDQuery.FieldByName('vl_pedido').AsCurrency,
               FFDQuery.FieldByName('nr_tempopedido').AsInteger
             );
end;

end.
