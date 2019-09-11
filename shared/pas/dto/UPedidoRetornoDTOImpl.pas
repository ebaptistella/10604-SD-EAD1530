// Sistema de Pedidos Pizzaria Master
// Programador: *****
// Data de Alteração: 16-08-2019
unit UPedidoRetornoDTOImpl;

interface

uses
  Soap.InvokeRegistry, UPizzaTamanhoEnum, UPizzaSaborEnum,
  MVCFramework.Serializer.Commons;

type

  [MVCNameCase(ncLowerCase)]
  TPedidoRetornoDTO = class(TRemotable)
  private
    FPizzaTamanho : TPizzaTamanhoEnum;
    FPizzaSabor   : TPizzaSaborEnum;
    FValorTotal   : Currency;
    FTempoTotal   : Integer;
  published
    property PizzaTamanho: TPizzaTamanhoEnum read FPizzaTamanho write FPizzaTamanho;
    property PizzaSabor: TPizzaSaborEnum read FPizzaSabor write FPizzaSabor;
    property ValorTotal: Currency read FValorTotal write FValorTotal;
    property TempoPreparo: Integer read FTempoTotal write FTempoTotal;
  public
    constructor Create(const APizzaTamanho: TPizzaTamanhoEnum;
                       const APizzaSabor  : TPizzaSaborEnum;
                       const AValorTotal  : Currency;
                       const ATempoTotal  : Integer); reintroduce;
  end;

implementation

{ TPedidoRetornoDTO }

constructor TPedidoRetornoDTO.Create(const APizzaTamanho: TPizzaTamanhoEnum;
                                     const APizzaSabor: TPizzaSaborEnum;
                                     const AValorTotal: Currency;
                                     const ATempoTotal: Integer);
begin
  FPizzaTamanho := APizzaTamanho;
  FPizzaSabor   := APizzaSabor;
  FValorTotal   := AValorTotal;
  FTempoTotal   := ATempoTotal;
end;

end.
