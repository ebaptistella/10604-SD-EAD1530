unit UPedidoRetornoDTOImpl;

interface

uses
  Soap.InvokeRegistry, UPizzaTamanhoEnum, UPizzaSaborEnum;

type
  TPedidoRetornoDTO = class(TRemotable)
  private
    FPizzaTamanho    : TPizzaTamanhoEnum;
    FPizzaSabor      : TPizzaSaborEnum;
    FValorTotalPedido: Currency;
    FTempoPreparo    : Integer;
  published
    property PizzaTamanho    : TPizzaTamanhoEnum read FPizzaTamanho write FPizzaTamanho;
    property PizzaSabor      : TPizzaSaborEnum read FPizzaSabor write FPizzaSabor;
    property ValorTotalPedido: Currency read FValorTotalPedido write FValorTotalPedido;
    property TempoPreparo    : Integer read FTempoPreparo write FTempoPreparo;
  public
    constructor Create(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum; const AValorTotalPed: Currency;
      const ATempoPreparo: Integer); reintroduce;
  end;

implementation

{ TPedidoRetornoDTO }

constructor TPedidoRetornoDTO.Create(const APizzaTamanho: TPizzaTamanhoEnum; const APizzaSabor: TPizzaSaborEnum; const AValorTotalPed: Currency;
  const ATempoPreparo: Integer);
begin
  FPizzaTamanho     := APizzaTamanho;
  FPizzaSabor       := APizzaSabor;
  FValorTotalPedido := AValorTotalPed;
  FTempoPreparo     := ATempoPreparo;
end;

end.
