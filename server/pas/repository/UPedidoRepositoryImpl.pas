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
    procedure consultarPedidoAndersonFurtilho(const ADocumentoCliente: string; out AFDQuery: TFDQuery);
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation

uses
  UDBConnectionImpl, System.SysUtils, Data.DB, FireDAC.Stan.Param;

const
  CMD_INSERT_PEDIDO
    : String =
    'INSERT INTO tb_pedido (cd_cliente, dt_pedido, dt_entrega, vl_pedido, nr_tempopedido, sabor, tamanho) VALUES (:pCodigoCliente, :pDataPedido, :pDataEntrega, :pValorPedido, :pTempoPedido, :pSabor, :pTamanho)';
  CMD_CONSULTAR_PEDIDO_ANDERSON:
    String = 'SELECT tamanho, sabor, vl_pedido, nr_tempopedido from tb_pedido t1 ' +
    ' inner join tb_cliente t2 on (t1.cd_cliente = t2.id) where t2.nr_documento = :pDocumentocliente order by t2.id desc LIMIT 1';

  { TPedidoRepository }

procedure TPedidoRepository.consultarPedidoAndersonFurtilho(
  const ADocumentoCliente: string; out AFDQuery: TFDQuery);
begin
 AFDQuery.Connection := FDBConnection.getDefaultConnection;
 AFDQuery.SQL.Text := CMD_CONSULTAR_PEDIDO_ANDERSON;
 AFDQuery.ParamByName('PDOCUMENTOCLIENTE').AsString := ADocumentoCliente;
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

procedure TPedidoRepository.efetuarPedido(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum; const AValorPedido: Currency;
  const ATempoPreparo: Integer; const ACodigoCliente: Integer);
var
  Sabor, Tamanho: String;
begin
  FFDQuery.SQL.Text := CMD_INSERT_PEDIDO;


  case APizzaSabor of
    enCalabresa:  Sabor := 'enCalabresa';
    enMarguerita: Sabor := 'enMarguerita';
    enPortuguesa: Sabor := 'enPortuguesa';
  end;

  case APizzaTamanho of
    enPequena: Tamanho := 'enPequena' ;
    enMedia:   Tamanho := 'enMedia';
    enGrande:  Tamanho := 'enGrande';
  end;

  FFDQuery.ParamByName('pCodigoCliente').AsInteger := ACodigoCliente;
  FFDQuery.ParamByName('pDataPedido').AsDateTime := now();
  FFDQuery.ParamByName('pDataEntrega').AsDateTime := now();
  FFDQuery.ParamByName('pValorPedido').AsCurrency := AValorPedido;
  FFDQuery.ParamByName('pTempoPedido').AsInteger := ATempoPreparo;
  FFDQuery.ParamByName('pSabor').AsString := Sabor;
  FFDQuery.ParamByName('pTamanho').AsString := Tamanho;

  FFDQuery.Prepare;
  FFDQuery.ExecSQL(True);
end;

end.
