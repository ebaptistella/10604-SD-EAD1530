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
  WSDLPizzariaBackendControllerImpl,
  Rtti, REST.JSON,
  UPizzaTamanhoEnum,
  UPizzaSaborEnum,
  System.JSON;

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
  oPizzariaBackendController1: IPizzariaBackendController;
  obj : TJsonObject;
begin
  if edtDocumentoCliente.Text = EmptyStr then
    raise Exception.Create('Você deve informar o documento para consultar');

  oPizzariaBackendController1 := WSDLPizzariaBackendControllerImpl.GetIPizzariaBackendController(edtEnderecoBackend.Text);
//  mmRetornoWebService.Text := TJson.ObjectToJsonString(oPizzariaBackendController1.consultarPedido(edtDocumentoCliente.Text));
  Obj := TJson.ObjectToJsonObject(oPizzariaBackendController1.consultarPedido(edtDocumentoCliente.Text));
  mmRetornoWebService.Lines.Clear;
  mmRetornoWebService.Lines.Add('----------- Seu pedido ------------');
  mmRetornoWebService.Lines.Add('Tamanho........:'  + Obj.Get('pizzaTamanho').JsonValue.Value);
  mmRetornoWebService.Lines.Add('Sabor..........:'  + Obj.Get('pizzaSabor').JsonValue.Value);
  mmRetornoWebService.Lines.Add('Valor Total....:'  + Obj.Get('valorTotalPedido').JsonValue.Value);
  mmRetornoWebService.Lines.Add('Tempo Prep.....:'  + Obj.Get('tempoPreparo').JsonValue.Value);
  mmRetornoWebService.Lines.Add('-----------------------------------');

 (*

 {"pizzaTamanho":"enPequena","pizzaSabor":"enMarguerita","valorTotalPedido":20,"tempoPreparo":15,"dataContext":null}
 *)
end;


end.
