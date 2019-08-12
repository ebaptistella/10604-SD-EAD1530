unit UFrmPrincipalImpl;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  UPedidoRetornoDTOImpl;

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
    Retorno : TPedidoRetornoDTO;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  WSDLPizzariaBackendControllerImpl,
  Rtti,
  REST.JSON,
  UPizzaTamanhoEnum,
  UPizzaSaborEnum;

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
  strRetorno : string;
  tamanhoPizza, saborPizza : string;
begin
  mmRetornoWebService.Lines.Clear;
  oPizzariaBackendController :=
     WSDLPizzariaBackendControllerImpl.GetIPizzariaBackendController(edtEnderecoBackend.Text);
  strRetorno := TJson.ObjectToJsonString(
     oPizzariaBackendController.consultarPedido(edtDocumentoCliente.Text));

  try
    Retorno := TJson.JsonToObject<TPedidoRetornoDTO>(strRetorno);
    mmRetornoWebService.Lines.Add('Resumo do pedido');
    case Retorno.PizzaTamanho of
      enPequena : tamanhoPizza := 'Pequena';
      enMedia   : tamanhoPizza := 'Media';
      enGrande  : tamanhoPizza := 'Grande';
    end;
    case Retorno.PizzaSabor of
      enCalabresa  : saborPizza := 'Calabresa';
      enMarguerita : saborPizza := 'Marguerita';
      enPortuguesa : saborPizza := 'Portuguesa';
    end;
    mmRetornoWebService.Lines.Add('Pizza : '+tamanhoPizza +' '+saborPizza+' '+
      formatfloat('R$ #.#0', Retorno.ValorTotalPedido));
    mmRetornoWebService.Lines.Add('Tempo: '+Format('%d', [Retorno.TempoPreparo])+ ' minutos');
    mmRetornoWebService.Lines.Add('Valor total pedido: '+
      formatfloat('R$ #.#0', Retorno.ValorTotalPedido));

  finally
    Retorno.Free;
  end;

end;

end.
