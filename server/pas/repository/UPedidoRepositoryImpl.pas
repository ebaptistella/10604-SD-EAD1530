unit UPedidoRepositoryImpl;

interface

uses
  UPedidoRepositoryIntf, UPizzaTamanhoEnum, UPizzaSaborEnum, UDBConnectionIntf, FireDAC.Comp.Client,TypInfo;

type
  TPedidoRepository = class(TInterfacedObject, IPedidoRepository)
  private
    FDBConnection: IDBConnection;
    FFDQuery: TFDQuery;
  public
    procedure efetuarPedido(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum; const AValorPedido: Currency;
      const ATempoPreparo: Integer; const ACodigoCliente: Integer);
    procedure GetPedido(const ADocumentoCliente: string;
      out AFDQuery: TFDQuery);
    constructor Create; reintroduce;
    destructor Destroy; override;

  end;

implementation

uses
  UDBConnectionImpl, System.SysUtils, Data.DB, FireDAC.Stan.Param;

const
  CMD_INSERT_PEDIDO
    : String =
    'INSERT INTO tb_pedido (cd_cliente, dt_pedido, dt_entrega, vl_pedido, nr_tempopedido,tx_tamanhopizza,tx_saborpizza) VALUES (:pCodigoCliente, :pDataPedido, :pDataEntrega, :pValorPedido, :pTempoPedido,:ptamanhoPizza,:pSaborPizza)';
  CMD_GETPEDIDO
    :String =
    'SELECT  tx_tamanhopizza, tx_saborpizza, vl_pedido, nr_tempopedido from tb_pedido P inner join tb_cliente C on (P.cd_cliente = C.id) where C.nr_documento = :pDocumentoCliente  order by P.id desc limit 1';
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
  FFDQuery.ParamByName('pTamanhoPizza').AsString   := GetEnumName(TypeInfo(TPizzaTamanhoEnum), integer(APizzaTamanho));
  FFDQuery.ParamByName('pSaborPizza').AsString     := GetEnumName(TypeInfo(TPizzaSaborEnum), integer(APizzaSabor));
  FFDQuery.Prepare;
  FFDQuery.ExecSQL(True);
end;

procedure TPedidoRepository.GetPedido(const ADocumentoCliente: string;
  out AFDQuery: TFDQuery);
begin
  AFDQuery.Connection := FDBConnection.getDefaultConnection;
  AFDQuery.SQL.Text:= CMD_GETPEDIDO;
  AFDQuery.ParamByName('pDocumentoCliente').AsString :=  ADocumentoCliente;
  AFDQuery.Prepare;
  AFDQuery.Open;
end;

end.
