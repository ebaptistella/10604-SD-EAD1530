unit UFrmPrincipalImpl;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    pgc1: TPageControl;
    ts1: TTabSheet;
    ts2: TTabSheet;
    lbl1: TLabel;
    lbl2: TLabel;
    EdtDocumentoCliente: TLabeledEdit;
    CmbTamanhoPizza: TComboBox;
    CmbSaborPizza: TComboBox;
    btn1: TButton;
    ts3: TTabSheet;
    EdtEnderecoBackend: TLabeledEdit;
    Pnl1: TPanel;
    Pnl2: TPanel;
    grp1: TGroupBox;
    EdtDocumentoConsulta: TLabeledEdit;
    grp2: TGroupBox;
    EdtValorConsulta: TLabeledEdit;
    EdtTempoConsulta: TLabeledEdit;
    btnConsultar: TButton;
    Pnl3: TPanel;
    mmoRetornoWebService: TMemo;
    lbl3: TLabel;
    CmbSaborConsulta: TComboBox;
    lbl4: TLabel;
    CmbTamanhoConsulta: TComboBox;
    lbl5: TLabel;
    procedure btn1Click(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);

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

procedure TForm1.btn1Click(Sender: TObject);
var
  oPizzariaBackendController: IPizzariaBackendController;
begin
  oPizzariaBackendController := WSDLPizzariaBackendControllerImpl.GetIPizzariaBackendController(edtEnderecoBackend.Text);
  mmoRetornoWebService.Text := TJson.ObjectToJsonString(oPizzariaBackendController.efetuarPedido(TRttiEnumerationType.GetValue<TPizzaTamanhoEnum>(cmbTamanhoPizza.Text), TRttiEnumerationType.GetValue<TPizzaSaborEnum>(cmbSaborPizza.Text), edtDocumentoCliente.Text));
end;

procedure TForm1.btnConsultarClick(Sender: TObject);
var
  oPedidoRetornoDTO : TPedidoRetornoDTO;
  oPizzariaBackendController: IPizzariaBackendController;
begin

  oPizzariaBackendController := WSDLPizzariaBackendControllerImpl.GetIPizzariaBackendController(edtEnderecoBackend.Text);

  oPedidoRetornoDTO := oPizzariaBackendController.ConsultarPedido(EdtDocumentoConsulta.Text);

  mmoRetornoWebService.Text := TJson.ObjectToJsonString(oPedidoRetornoDTO);

  EdtValorConsulta.Text := FormatFloat('##,##0.00', oPedidoRetornoDTO.ValorTotalPedido);
  EdtTempoConsulta.Text := oPedidoRetornoDTO.TempoPreparo.ToString;

  CmbTamanhoConsulta.ItemIndex :=  Ord(oPedidoRetornoDTO.PizzaTamanho);
  CmbSaborConsulta.ItemIndex := Ord(oPedidoRetornoDTO.PizzaSabor)


end;


end.
