unit UFrmPrincipalImpl;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    PanelFazerPedido: TPanel;
    edtEnderecoBackend: TLabeledEdit;
    edtDocumentoCliente: TLabeledEdit;
    cmbTamanhoPizza: TComboBox;
    cmbSaborPizza: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    mmRetornoWebService: TMemo;
    Label3: TLabel;
    Panel1: TPanel;
    btnGetPedido: TButton;
    Panel2: TPanel;
    Label4: TLabel;
    Panel3: TPanel;
    Label5: TLabel;
    MemoRetornoConsulta: TMemo;
    EditDocumentoPesquisar: TEdit;
    Label6: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure btnGetPedidoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  WSDLPizzariaBackendControllerImpl, Rtti, REST.JSON, UPizzaTamanhoEnum,
  UPizzaSaborEnum;

{$R *.dfm}

procedure TForm1.btnGetPedidoClick(Sender: TObject);
var
  oPizzariaBackendController: IPizzariaBackendController;
begin
  oPizzariaBackendController := WSDLPizzariaBackendControllerImpl.GetIPizzariaBackendController(edtEnderecoBackend.Text);
  MemoRetornoConsulta.Lines.Clear;
  MemoRetornoConsulta.Lines.Add('RESUMO DO PEDIDO');
  MemoRetornoConsulta.Lines.Add('');

  case oPizzariaBackendController.GetPedido(EditDocumentoPesquisar.Text).PizzaTamanho of
   enPequena : MemoRetornoConsulta.Lines.Add('TAMANHO: PEQUENA');
   enMedia :   MemoRetornoConsulta.Lines.Add('TAMANHO: MEDIA');
   enGrande :  MemoRetornoConsulta.Lines.Add('TAMANHO: GRANDE');
  end;

  case oPizzariaBackendController.GetPedido(EditDocumentoPesquisar.Text).PizzaSabor of
   enCalabresa :  MemoRetornoConsulta.Lines.Add('SABOR: CALABRESA');
   enMarguerita : MemoRetornoConsulta.Lines.Add('SABOR: MARGUERITA');
   enPortuguesa : MemoRetornoConsulta.Lines.Add('SABOR: PORTUGUESA');
  end;

  MemoRetornoConsulta.Lines.Add('VALOR TOTAL: '+FormatFloat('R$ ###,##0.00',oPizzariaBackendController.GetPedido(EditDocumentoPesquisar.Text).ValorTotalPedido));

  MemoRetornoConsulta.Lines.Add('TEMPO DE PREPARO: '+INTTOSTR(oPizzariaBackendController.GetPedido(EditDocumentoPesquisar.Text).TempoPreparo)+' MINUTOS');
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  oPizzariaBackendController: IPizzariaBackendController;
begin
  oPizzariaBackendController := WSDLPizzariaBackendControllerImpl.GetIPizzariaBackendController(edtEnderecoBackend.Text);
  mmRetornoWebService.Text := TJson.ObjectToJsonString(oPizzariaBackendController.efetuarPedido(TRttiEnumerationType.GetValue<TPizzaTamanhoEnum>(cmbTamanhoPizza.Text), TRttiEnumerationType.GetValue<TPizzaSaborEnum>(cmbSaborPizza.Text), edtDocumentoCliente.Text));
end;

end.
