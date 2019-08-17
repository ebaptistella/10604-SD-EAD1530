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
  Consulta: TPedidoRetornoDTO;
begin
  oPizzariaBackendController := WSDLPizzariaBackendControllerImpl.
    GetIPizzariaBackendController(edtEndereco.Text);
  Consulta := oPizzariaBackendController.consultar(edtDoc.Text);
  mmConsultaPedido.Lines.Add('Tamanho:' +
    TRttiEnumerationType.GetName<TPizzaTamanhoEnum>(Consulta.PizzaTamanho));
    mmConsultaPedido.Lines.Add('Sabor+' +
    TRttiEnumerationType.GetName<TPizzaSaborEnum>(Consulta.PizzaSabor));
    mmConsultaPedido.Lines.Add('Valor: ' + FormatCurr('R$ 0,00',
    Consulta.ValorTotalPedido));
    mmConsultaPedido.Lines.Add('Tempo: ' +
    Consulta.TempoPreparo.ToString); end;

  end.
