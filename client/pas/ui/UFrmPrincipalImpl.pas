unit UFrmPrincipalImpl;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

type
  TForm1 = class(TForm)
    edtDocumentoCliente: TLabeledEdit;
    cmbTamanhoPizza: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    cmbSaborPizza: TComboBox;
    Button1: TButton;
    mmRetornoWebService: TMemo;
    Label3: TLabel;
    edtEnderecoBackend: TLabeledEdit;
    btn_Consulta: TBitBtn;
    procedure Button1Click(Sender: TObject);
    procedure btn_ConsultaClick(Sender: TObject);
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
  UPizzaSaborEnum, UPedidoRetornoDTOImpl;

{$R *.dfm}

procedure TForm1.btn_ConsultaClick(Sender: TObject);
var
  oPizzariaBackendController: IPizzariaBackendController;
  oDTO : TPedidoRetornoDTO;
begin
  if edtDocumentoCliente.Text = EmptyStr then
    exit;

  oPizzariaBackendController := WSDLPizzariaBackendControllerImpl.GetIPizzariaBackendController(edtEnderecoBackend.Text);

  oDTO := oPizzariaBackendController.consultarPedido(edtDocumentoCliente.Text);
  mmRetornoWebService.Clear;

  mmRetornoWebService.Lines.Add('Tamanho: '+ Copy(TRttiEnumerationType.GetName<TPizzaTamanhoEnum>(oDTO.PizzaTamanho),
                                                           3,length(TRttiEnumerationType.GetName<TPizzaTamanhoEnum>(oDTO.PizzaTamanho))));
  mmRetornoWebService.Lines.Add('Sabor: '+ Copy(TRttiEnumerationType.GetName<TPizzaSaborEnum>(oDTO.PizzaSabor),
                                                           3,length(TRttiEnumerationType.GetName<TPizzaSaborEnum>(oDTO.PizzaSabor))));
  mmRetornoWebService.Lines.Add('Preço: '+ FormatCurr('R$0.00',oDTO.ValorTotalPedido));
  mmRetornoWebService.Lines.Add('Tempo de Preparo: '+ oDTO.TempoPreparo.ToString + ' minutos.');
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  oPizzariaBackendController: IPizzariaBackendController;
begin
  oPizzariaBackendController := WSDLPizzariaBackendControllerImpl.GetIPizzariaBackendController(edtEnderecoBackend.Text);
  mmRetornoWebService.Text := TJson.ObjectToJsonString(oPizzariaBackendController.efetuarPedido(TRttiEnumerationType.GetValue<TPizzaTamanhoEnum>(cmbTamanhoPizza.Text), TRttiEnumerationType.GetValue<TPizzaSaborEnum>(cmbSaborPizza.Text), edtDocumentoCliente.Text));
end;

end.
