// Sistema de Pedidos Pizzaria Master
// Programador: *****
// Data de Alteração: 16-08-2019
unit UPedidoRealizaDTOImpl;

interface

uses
  Soap.InvokeRegistry, UPizzaTamanhoEnum, UPizzaSaborEnum,
  MVCFramework.Serializer.Commons;

type
  [MVCNameCase(ncLowerCase)]
  TEfetuarPedidoDTO = class(TRemotable)
  private
    FPizzaTamanho     : TPizzaTamanhoEnum;
    FPizzaSabor       : TPizzaSaborEnum;
    FDocumentoCliente : String;
  published
    property PizzaTamanho     : TPizzaTamanhoEnum read FPizzaTamanho     write FPizzaTamanho;
    property PizzaSabor       : TPizzaSaborEnum   read FPizzaSabor       write FPizzaSabor;
    property DocumentoCliente : String            read FDocumentoCliente write FDocumentoCliente;
  end;

implementation

end.
