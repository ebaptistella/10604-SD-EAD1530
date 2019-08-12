unit UFrmPrincipalImpl;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
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
    edtConsulta: TLabeledEdit;
    Panel1: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edtTamanho: TEdit;
    edtSabor: TEdit;
    edtTotal: TEdit;
    edtTempo: TEdit;
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
  oPizzariaBackendController := WSDLPizzariaBackendControllerImpl.
    GetIPizzariaBackendController(edtEnderecoBackend.Text);
  mmRetornoWebService.Text := TJson.ObjectToJsonString
    (oPizzariaBackendController.efetuarPedido
    (TRttiEnumerationType.GetValue<TPizzaTamanhoEnum>(cmbTamanhoPizza.Text),
    TRttiEnumerationType.GetValue<TPizzaSaborEnum>(cmbSaborPizza.Text),
    edtDocumentoCliente.Text));
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  oPizzariaBackendController: IPizzariaBackendController;
  Pedido: TPedidoRetornoDTO;
begin
  try
    strtoint(edtConsulta.Text);
  except
    Showmessage('Informe um valor inteiro válido para consulta!');
    exit;
  end;

  oPizzariaBackendController := WSDLPizzariaBackendControllerImpl.
    GetIPizzariaBackendController(edtEnderecoBackend.Text);
  try
    Pedido := oPizzariaBackendController.ConsultarPedido(edtConsulta.Text);
    begin
      edtTamanho.Text := Copy(TRttiEnumerationType.GetName<TPizzaTamanhoEnum>
        (Pedido.PizzaTamanho), 3,
        length(TRttiEnumerationType.GetName<TPizzaTamanhoEnum>
        (Pedido.PizzaTamanho)));
      edtSabor.Text := Copy(TRttiEnumerationType.GetName<TPizzaSaborEnum>
        (Pedido.PizzaSabor), 3,
        length(TRttiEnumerationType.GetName<TPizzaSaborEnum>
        (Pedido.PizzaSabor)));
      edtTotal.Text := FormatCurr('R$ 0.00', Pedido.ValorTotalPedido);
      edtTempo.Text := Pedido.TempoPreparo.ToString + ' minutos';
      freeandnil(Pedido);
    end
  except
    begin
      edtTamanho.Clear;
      edtSabor.Clear;
      edtTotal.Clear;
      edtTempo.Clear;
      Raise Exception.Create
        ('não existem pedidos para este número de documento!');
    end;

  end;

end;

end.
