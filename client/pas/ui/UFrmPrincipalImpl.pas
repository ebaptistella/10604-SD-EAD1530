unit UFrmPrincipalImpl;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  UPedidoRetornoDTOImpl, Vcl.Mask;

type
  TFrmClientPrinc = class(TForm)
    pgPrincipal: TPageControl;
    tsFazerPedido: TTabSheet;
    tsConsultarPedido: TTabSheet;
    btnFazerPedido: TButton;
    Label1: TLabel;
    cmbTamanhoPizza: TComboBox;
    Label2: TLabel;
    cmbSaborPizza: TComboBox;
    mmRetornoWebService: TMemo;
    Label3: TLabel;
    pnlTopo: TPanel;
    edtEnderecoBackend: TLabeledEdit;
    btnConsultarpPedido: TButton;
    mmDadosPedido: TMemo;
    Label4: TLabel;
    edtDocumentoCliente: TMaskEdit;
    Label5: TLabel;
    procedure btnFazerPedidoClick(Sender: TObject);
    procedure btnConsultarpPedidoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ValidarDocumento;
  private
    procedure EscreverPedidoFormatado(const aPedido: TPedidoRetornoDTO;
      var aCompMemo: TMemo);
  end;

var
  FrmClientPrinc: TFrmClientPrinc;

implementation

uses
  WSDLPizzariaBackendControllerImpl, Rtti, REST.JSON, UPizzaTamanhoEnum,
  UPizzaSaborEnum, System.UITypes;

{$R *.dfm}

procedure TFrmClientPrinc.btnFazerPedidoClick(Sender: TObject);
var
  oPizzariaBackendController: IPizzariaBackendController;
begin
  mmRetornoWebService.Clear;
  ValidarDocumento;
  oPizzariaBackendController := WSDLPizzariaBackendControllerImpl.GetIPizzariaBackendController(edtEnderecoBackend.Text);
  EscreverPedidoFormatado(
    oPizzariaBackendController.efetuarPedido(
      TRttiEnumerationType.GetValue<TPizzaTamanhoEnum>('en' + cmbTamanhoPizza.Text),
      TRttiEnumerationType.GetValue<TPizzaSaborEnum>('en' + cmbSaborPizza.Text),
      edtDocumentoCliente.Text),
    mmRetornoWebService);
  MessageDlg('Pedido cadastrado com sucesso!', mtInformation, [mbOK], 0);
end;

procedure TFrmClientPrinc.FormCreate(Sender: TObject);
begin
  pgPrincipal.ActivePageIndex := 0;
end;

procedure TFrmClientPrinc.ValidarDocumento;
begin
  if Length(Trim(edtDocumentoCliente.Text)) <> 11 then
  begin
    edtDocumentoCliente.SetFocus;
    raise Exception.Create('Informe o número do documento com 11 caracteres para prosseguir!');
  end;
end;

procedure TFrmClientPrinc.btnConsultarpPedidoClick(Sender: TObject);
var
  oPizzariaBackendController: IPizzariaBackendController;
begin
  mmDadosPedido.Clear;
  ValidarDocumento;
  oPizzariaBackendController := WSDLPizzariaBackendControllerImpl.GetIPizzariaBackendController(edtEnderecoBackend.Text);
  EscreverPedidoFormatado(
    oPizzariaBackendController.consultarPedido(
      edtDocumentoCliente.Text),
    mmDadosPedido);
end;

procedure TFrmClientPrinc.EscreverPedidoFormatado(const aPedido: TPedidoRetornoDTO;
  var aCompMemo: TMemo);
var
  cTamanhoPizza, cSaborPizza: String;
begin
  aCompMemo.Clear;
  cTamanhoPizza := TRttiEnumerationType.GetName<TPizzaTamanhoEnum>(aPedido.PizzaTamanho);
  aCompMemo.Lines.Add('=======================================');
  aCompMemo.Lines.Add('Tamanho da pizza..: ' + cTamanhoPizza.Substring(2));
  cSaborPizza := TRttiEnumerationType.GetName<TPizzaSaborEnum>(aPedido.PizzaSabor);
  aCompMemo.Lines.Add('Sabor da pizza....: ' + cSaborPizza.Substring(2));
  aCompMemo.Lines.Add('Valor total.......: R$ ' + FormatFloat(',0.00', aPedido.ValorTotalPedido));
  aCompMemo.Lines.Add('Data do pedido....: ' + DateTimeToStr(aPedido.DataPedido));
  aCompMemo.Lines.Add('Data de entrega...: ' + DateTimeToStr(aPedido.DataEntrega));
  aCompMemo.Lines.Add('Tempo de preparo..: ' + aPedido.TempoPreparo.ToString + ' minutos');
  aCompMemo.Lines.Add('=======================================');
end;

end.
