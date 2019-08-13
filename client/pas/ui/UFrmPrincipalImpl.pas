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
  UPizzaSaborEnum;

{$R *.dfm}

procedure TForm1.btn_ConsultaClick(Sender: TObject);
var
  oPizzariaBackendController: IPizzariaBackendController;
begin
  if edtDocumentoCliente.Text = '' then
  begin
    ShowMessage('Informe o Documento para a Consulta.');
    Exit;
  end;

//  oPizzariaBackendController := WSDLPizzariaBackendControllerImpl.GetIPizzariaBackendController(edtEnderecoBackend.Text);
//  mmRetornoWebService.Text   := TJson.ObjectToJsonString(oPizzariaBackendController.consultarPedido(edtDocumentoCliente.Text));
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  oPizzariaBackendController: IPizzariaBackendController;
begin
  oPizzariaBackendController := WSDLPizzariaBackendControllerImpl.GetIPizzariaBackendController(edtEnderecoBackend.Text);
  mmRetornoWebService.Text := TJson.ObjectToJsonString(oPizzariaBackendController.efetuarPedido(TRttiEnumerationType.GetValue<TPizzaTamanhoEnum>(cmbTamanhoPizza.Text), TRttiEnumerationType.GetValue<TPizzaSaborEnum>(cmbSaborPizza.Text), edtDocumentoCliente.Text));
end;

end.
