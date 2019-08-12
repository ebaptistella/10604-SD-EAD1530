unit UFrmPrincipalImpl;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    mmRetornoWebService: TMemo;
    Label3: TLabel;
    edtEnderecoBackend: TLabeledEdit;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    edtDocumentoCliente: TLabeledEdit;
    cmbTamanhoPizza: TComboBox;
    cmbSaborPizza: TComboBox;
    Button1: TButton;
    Button2: TButton;
    edtDocumentoClienteConsulta: TLabeledEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
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

procedure TForm1.Button1Click(Sender: TObject);
var
  oPizzariaBackendController: IPizzariaBackendController;
begin
  oPizzariaBackendController := WSDLPizzariaBackendControllerImpl.GetIPizzariaBackendController(edtEnderecoBackend.Text);
  mmRetornoWebService.Text := TJson.ObjectToJsonString(oPizzariaBackendController.efetuarPedido(TRttiEnumerationType.GetValue<TPizzaTamanhoEnum>(cmbTamanhoPizza.Text), TRttiEnumerationType.GetValue<TPizzaSaborEnum>(cmbSaborPizza.Text), edtDocumentoCliente.Text));
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  oPizzariaBackendController: IPizzariaBackendController;
  oDTO : TPedidoRetornoDTO;
begin
  if edtDocumentoClienteConsulta.Text = EmptyStr then
    exit;

  oPizzariaBackendController := WSDLPizzariaBackendControllerImpl.GetIPizzariaBackendController(edtEnderecoBackend.Text);

  oDTO := oPizzariaBackendController.consultarPedido(edtDocumentoClienteConsulta.Text);
  mmRetornoWebService.Clear;

  mmRetornoWebService.Lines.Add('Tamanho da Pizza: '+ Copy(
                                                            TRttiEnumerationType.GetName<TPizzaTamanhoEnum>(oDTO.PizzaTamanho),
                                                            3,
                                                            length(TRttiEnumerationType.GetName<TPizzaTamanhoEnum>(oDTO.PizzaTamanho))
                                                          )
                                );
  mmRetornoWebService.Lines.Add('Sabor da Pizza  : '+ Copy(
                                                            TRttiEnumerationType.GetName<TPizzaSaborEnum>(oDTO.PizzaSabor),
                                                            3,
                                                            length(TRttiEnumerationType.GetName<TPizzaSaborEnum>(oDTO.PizzaSabor))
                                                          )
                                );

  mmRetornoWebService.Lines.Add('Preço da Pizza  : '+ FormatCurr('R$0.00',oDTO.ValorTotalPedido));

  mmRetornoWebService.Lines.Add('Tempo de Preparo: '+ oDTO.TempoPreparo.ToString + ' minutos.');
end;

end.
