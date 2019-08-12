unit UPedidoRepositoryImpl;

interface

uses
  UPedidoRepositoryIntf, UPizzaTamanhoEnum, UPizzaSaborEnum, UDBConnectionIntf, FireDAC.Comp.Client, UPedidoRetornoDTOImpl;

type
  TPedidoRepository = class(TInterfacedObject, IPedidoRepository)
  private
    FDBConnection: IDBConnection;
    FFDQuery: TFDQuery;
  public
    procedure efetuarPedido(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum; const AValorPedido: Currency;
      const ATempoPreparo: Integer; const ACodigoCliente: Integer);
    function consultarPedido(const ADocumentoCliente: String): TPedidoRetornoDTO;

    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation

uses
  UDBConnectionImpl, System.SysUtils, Data.DB, FireDAC.Stan.Param;

const
  CMD_INSERT_PEDIDO
    : String =
    'INSERT INTO tb_pedido (cd_cliente, dt_pedido, dt_entrega, vl_pedido, nr_tempopedido, tamanho, sabor) VALUES (:pCodigoCliente, :pDataPedido, :pDataEntrega, :pValorPedido, :pTempoPedido, :pTamanho, :pSabor)';

  { TPedidoRepository }

function TPedidoRepository.consultarPedido(const ADocumentoCliente: String): TPedidoRetornoDTO;
begin
  FFDQuery.Close;
  FFDQuery.SQL.Clear;
  FFDQuery.SQL.Add('select nr_tempopedido, vl_pedido, tamanho, sabor from tb_pedido where cd_cliente = :pCodigoCliente' );
  FFDQuery.ParamByName('pCodigoCliente').AsInteger := strtoint(ADocumentoCliente);
  FFDQuery.Open;
  if FFDQuery.IsEmpty then
     result := nil
  else
    Result := TPedidoRetornoDTO.Create(TPizzaTamanhoEnum(FFDQuery.FieldByName('tamanho').AsInteger), TPizzaSaborEnum(FFDQuery.FieldByName('sabor').AsInteger), FFDQuery.FieldByName('vl_pedido').AsFloat, FFDQuery.FieldByName('nr_tempopedido').AsInteger);

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
  FFDQuery.ParamByName('pTamanho').AsInteger := Ord(APizzaTamanho);
  FFDQuery.ParamByName('pSabor').AsInteger := Ord(APizzaSabor);
  FFDQuery.Prepare;
  FFDQuery.ExecSQL(True);
end;

end.
