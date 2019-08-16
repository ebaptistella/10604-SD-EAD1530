unit UPedidoRepositoryIntf;

interface

uses
  UPizzaSaborEnum, UPizzaTamanhoEnum;

type
  TInfoPedido = record
    PedDocCliente   : string;
    PedValor        : Currency;
    PedTempoPreparo : Integer;
    PedCodigoCliente: Integer;
    PizzaTamanho    : TPizzaTamanhoEnum;
    PizzaSabor      : TPizzaSaborEnum;
  end;
  IPedidoRepository = interface(IInterface)
    ['{76A94FF6-4634-4C52-91E4-3F969389D917}']

    procedure efetuarPedido(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum; const AValorPedido: Currency;
      const ATempoPreparo: Integer; const ACodigoCliente: Integer);

    procedure ConsultaPedido(const ADocCliente: string; out AInfoPedido: TInfoPedido);
  end;

implementation

end.
