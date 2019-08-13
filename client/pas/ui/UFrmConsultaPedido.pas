unit UFrmConsultaPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TFrmConsultaPedido = class(TForm)
    mmConsultaPedido: TMemo;
    pnlBotoes: TPanel;
    Button1: TButton;
    Button2: TButton;
    edtDoc: TEdit;
    edtEndereco: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConsultaPedido: TFrmConsultaPedido;

implementation

uses
  WSDLPizzariaBackendControllerImpl, Rtti, REST.JSON, UPizzaTamanhoEnum,
  UPizzaSaborEnum, UPedidoRetornoDTOImpl;

{$R *.dfm}

procedure TFrmConsultaPedido.Button1Click(Sender: TObject);
var
  oPizzariaBackendController: IPizzariaBackendController;
  oRetorno: TPedidoRetornoDTO;
begin
  oPizzariaBackendController := WSDLPizzariaBackendControllerImpl.
    GetIPizzariaBackendController(edtEndereco.Text);
  oRetorno := oPizzariaBackendController.consultarPedido(edtDoc.Text);
  mmConsultaPedido.Lines.Add('Tamanho Pizza:' +
    TRttiEnumerationType.GetName<TPizzaTamanhoEnum>(oRetorno.PizzaTamanho));
    mmConsultaPedido.Lines.Add('Sabor Pizza+' +
    TRttiEnumerationType.GetName<TPizzaSaborEnum>(oRetorno.PizzaSabor));
    mmConsultaPedido.Lines.Add('Valor Pizza: ' + FormatCurr('R$ 0,00',
    oRetorno.ValorTotalPedido));
    mmConsultaPedido.Lines.Add('Tempo de Preparo: ' +
    oRetorno.TempoPreparo.ToString); end;

  end.
