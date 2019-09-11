unit UPedidoRepositoryImpl;

interface

uses
  UPedidoRepositoryIntf, UPizzaTamanhoEnum, UPizzaSaborEnum,
  UDBConnectionIntf, FireDAC.Comp.Client, TypInfo;

type
  TPedidoRepository = class(TInterfacedObject, IPedidoRepository)
  private
    FDBConnection: IDBConnection;
    FFDQuery: TFDQuery;
  public
    procedure efetuarPedido(const APizzaTamanho: TPizzaTamanhoEnum;
                            const APizzaSabor: TPizzaSaborEnum;
                            const AValorTotal: Currency;
                            const ATempoTotal: Integer;
                            const ACodCliente: Integer);

    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation

uses
  UDBConnectionImpl, System.SysUtils, Data.DB, FireDAC.Stan.Param;

const
  CMD_INSERT_PEDIDO
    : String =
    'INSERT INTO Opr_Pedido (Cod_Cliente, Data_Pedido, Data_Entrega, Valor_Total, Tempo_Total) '+
    '   VALUES (:pCodCliente, :pDataPedido, :pDataEntrega, :pValorTotal, :pTempoTotal)';

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

procedure TPedidoRepository.efetuarPedido(const APizzaTamanho: TPizzaTamanhoEnum;
                                          const APizzaSabor: TPizzaSaborEnum;
                                          const AValorTotal: Currency;
                                          const ATempoTotal: Integer;
                                          const ACodCliente: Integer);
begin
  FFDQuery.SQL.Text := CMD_INSERT_PEDIDO;
  FFDQuery.ParamByName('pCodCliente').AsInteger   := ACodCliente;
  FFDQuery.ParamByName('pDataPedido').AsDateTime  := now();
  FFDQuery.ParamByName('pDataEntrega').AsDateTime := now();
  FFDQuery.ParamByName('pValorTotal').AsCurrency  := AValorTotal;
  FFDQuery.ParamByName('pTempoTotal').AsInteger   := ATempoTotal;
  FFDQuery.Prepare;
  FFDQuery.ExecSQL(True);
end;

end.
