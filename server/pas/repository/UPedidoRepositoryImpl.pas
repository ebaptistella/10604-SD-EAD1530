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
    constructor Create; reintroduce;
    destructor  Destroy; override;

    procedure efetuarPedido(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum; const AValorPedido: Currency;
      const ATempoPreparo: Integer; const ACodigoCliente: Integer);
    procedure ConsultaPedido(const ADocCliente: string; out AInfoPedido: TInfoPedido);

  end;

implementation

uses
  UDBConnectionImpl, System.SysUtils, Data.DB, FireDAC.Stan.Param;

const
  CMD_INSERT_PEDIDO
    : String =
    'INSERT INTO tb_pedido (cd_cliente, dt_pedido, dt_entrega, vl_pedido, nr_tempopedido, pz_pizzatamanho, pz_pizzasabor) VALUES (:pCodigoCliente, :pDataPedido, :pDataEntrega, :pValorPedido, :pTempoPedido, :pPizzaTamanho, :pPizzaSabor)';
  CM_CONSULTA_PEDIDO
    : String =
    ' SELECT ped.pz_pizzatamanho, '+
    '        ped.pz_pizzasabor, '+
    '        ped.vl_pedido, ' +
    '        ped.nr_tempopedido, '+
    '        ped.cd_cliente, ' +
    '        ped.nr_tempopedido'+
    '  FROM tb_cliente cli ' +
    ' INNER JOIN tb_pedido ped '+
    '    ON (ped.cd_cliente = cli.id) '+
    ' WHERE (cli.nr_documento = :pedDocumentoCliente)'+
    ' ORDER BY ped.id DESC '+
    ' LIMIT 1 ';

  { TPedidoRepository }

procedure TPedidoRepository.ConsultaPedido(const ADocCliente: string;
  out AInfoPedido: TInfoPedido);
begin
  FFDQuery.SQL.Clear;
  FFDQuery.SQL.Text := CM_CONSULTA_PEDIDO;
  FFDQuery.ParamByName('pedDocumentoCliente').AsString := ADocCliente;
  FFDQuery.Prepare;
  try
    FFDQuery.Open;
    if not FFDQuery.IsEmpty then
    begin
      AInfoPedido.PedDocCliente    := ADocCliente;
      AInfoPedido.PedValor         := FFDQuery.FieldByName('VL_PEDIDO').AsCurrency;
      AInfoPedido.PedTempoPreparo  := FFDQuery.FieldByName('NR_TEMPOPEDIDO').AsInteger;
      AInfoPedido.PedCodigoCliente := FFDQuery.FieldByName('CD_CLIENTE').AsInteger;
      AInfoPedido.PizzaSabor       := TPizzaSaborEnum(FFDQuery.FieldByName('pz_PIZZASABOR').AsInteger);
      AInfoPedido.PizzaTamanho     := TPizzaTamanhoEnum(FFDQuery.FieldByName('pz_PIZZATAMANHO').AsInteger);
    end;
  finally
    FFDQuery.Close;
  end;
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
  FFDQuery.ParamByName('pDataPedido').AsDateTime   := now();
  FFDQuery.ParamByName('pDataEntrega').AsDateTime  := now();
  FFDQuery.ParamByName('pValorPedido').AsCurrency  := AValorPedido;
  FFDQuery.ParamByName('pTempoPedido').AsInteger   := ATempoPreparo;
  FFDQuery.ParamByName('pPizzaSabor').AsInteger    := Integer(APizzaSabor);
  FFDQuery.ParamByName('pPizzaTamanho').AsInteger  := Integer(APizzaTamanho);

  FFDQuery.Prepare;
  FFDQuery.ExecSQL(True);
end;

end.
