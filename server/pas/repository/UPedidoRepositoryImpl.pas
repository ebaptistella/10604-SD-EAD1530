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
    procedure efetuarPedido(const APizzaTamanho: TPizzaTamanhoEnum;
      const APizzaSabor: TPizzaSaborEnum; const AValorPedido: Currency;
      const ATempoPreparo: Integer; const ACodigoCliente: Integer;
      const ADataPedido: TDateTime; const ADataEntrega: TDateTime);
    procedure consultarPedido(const ADocumentoCliente: String;
      out AFDQueryPedido: TFDQuery);

    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation

uses
  UDBConnectionImpl, System.SysUtils, System.Rtti, Data.DB, FireDAC.Stan.Param;

const
  CMD_INSERT_PEDIDO
    : String =
    'INSERT INTO tb_pedido (cd_cliente, dt_pedido, dt_entrega, vl_pedido, nr_tempopedido, tx_tamanho, tx_sabor) ' +
    'VALUES (:pCodigoCliente, :pDataPedido, :pDataEntrega, :pValorPedido, :pTempoPedido, :pTamanho, :pSabor)';

  CMD_CONSULTA_PEDIDO
    : String =
    'select ped.id, ped.dt_pedido, ped.dt_entrega, ped.vl_pedido, ped.nr_tempopedido, ped.tx_tamanho, ped.tx_sabor ' +
      'from tb_pedido ped ' +
     'inner join tb_cliente cli ' +
        'on cli.id = ped.cd_cliente ' +
     'where cli.nr_documento = :pDocumentoCliente ' +
     'order by ped.id desc ' +
     'limit 1';
  { TPedidoRepository }

procedure TPedidoRepository.consultarPedido(const ADocumentoCliente: String;
  out AFDQueryPedido: TFDQuery);
begin
  AFDQueryPedido.Connection := FDBConnection.getDefaultConnection;
  AFDQueryPedido.SQL.Text := CMD_CONSULTA_PEDIDO;
  AFDQueryPedido.ParamByName('pDocumentoCliente').AsString := ADocumentoCliente;
  AFDQueryPedido.Prepare;
  AFDQueryPedido.Open;
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
  const ATempoPreparo: Integer; const ACodigoCliente: Integer;
  const ADataPedido: TDateTime; const ADataEntrega: TDateTime);
begin
  FFDQuery.SQL.Text := CMD_INSERT_PEDIDO;

  FFDQuery.ParamByName('pCodigoCliente').AsInteger := ACodigoCliente;
  FFDQuery.ParamByName('pDataPedido').AsDateTime := ADataPedido;
  FFDQuery.ParamByName('pDataEntrega').AsDateTime := ADataEntrega;
  FFDQuery.ParamByName('pValorPedido').AsCurrency := AValorPedido;
  FFDQuery.ParamByName('pTempoPedido').AsInteger := ATempoPreparo;
  FFDQuery.ParamByName('pTamanho').AsString := TRttiEnumerationType.GetName<TPizzaTamanhoEnum>(APizzaTamanho);
  FFDQuery.ParamByName('pSabor').AsString := TRttiEnumerationType.GetName<TPizzaSaborEnum>(APizzaSabor);

  FFDQuery.Prepare;
  FFDQuery.ExecSQL(True);
end;

end.
