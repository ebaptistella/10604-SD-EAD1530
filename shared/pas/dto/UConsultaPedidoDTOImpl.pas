unit UConsultaPedidoDTOImpl;

interface

uses
  Soap.InvokeRegistry, UPizzaTamanhoEnum, UPizzaSaborEnum;

type
  TConsultaPedido = class(TRemotable)
  private
    FTamanhoPizza: TPizzaTamanhoEnum;
    FSaborPizza: TPizzaSaborEnum;
    FValorPizza: currency;
    FTempoPreparo: integer;
  public
  property TamanhoPizza: TPizzaTamanhoEnum read FTamanhoPizza write FTamanhoPizza;
  property SaborPizza: TPizzaSaborEnum read FSaborPizza write FSaborPizza;
  property ValorPizza: currency read FValorPizza write FValorPizza;
  property TempoPreparo: integer read FTempoPreparo write FTempoPreparo;
  end;

implementation

end.
