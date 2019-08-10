unit UFrmPrincipalImpl;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

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
    Button2: TButton;
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
  UPizzaSaborEnum, System.JSON;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  oPizzariaBackendController: IPizzariaBackendController;
begin
  oPizzariaBackendController := WSDLPizzariaBackendControllerImpl.GetIPizzariaBackendController(edtEnderecoBackend.Text);
  mmRetornoWebService.Text := TJson.ObjectToJsonString(oPizzariaBackendController.efetuarPedido(
    TRttiEnumerationType.GetValue<TPizzaTamanhoEnum>(cmbTamanhoPizza.Text),
    TRttiEnumerationType.GetValue<TPizzaSaborEnum>(cmbSaborPizza.Text), edtDocumentoCliente.Text));
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  LPizzariaBackendController: IPizzariaBackendController;
  LRetorno: TJSONValue;
begin
  LPizzariaBackendController := WSDLPizzariaBackendControllerImpl.
    GetIPizzariaBackendController(edtEnderecoBackend.Text);
  LRetorno := TJSONObject.ParseJSONValue(TJson.ObjectToJsonString(LPizzariaBackendController.BuscarPedido(
    edtDocumentoCliente.Text)));
  mmRetornoWebService.Lines.Add(StringOfChar('-', 10));
  mmRetornoWebService.Lines.Add('Sabor=' + LRetorno.GetValue<string>('pizzaSabor'));
  mmRetornoWebService.Lines.Add('Tamanho=' + LRetorno.GetValue<string>('pizzaTamanho'));
  mmRetornoWebService.Lines.Add('Valor=' + LRetorno.GetValue<Double>('valorTotalPedido').ToString());
  mmRetornoWebService.Lines.Add('Tempo Preparo=' + LRetorno.GetValue<Integer>('tempoPreparo').ToString());
  mmRetornoWebService.Lines.Add(StringOfChar('-', 10));
end;

end.
