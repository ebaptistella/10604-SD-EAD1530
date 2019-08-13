unit UFrmPrincipalImpl;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label3: TLabel;
    mmRetornoWebService: TMemo;
    edtDocumentoCliente: TLabeledEdit;
    Label1: TLabel;
    cmbTamanhoPizza: TComboBox;
    Label2: TLabel;
    cmbSaborPizza: TComboBox;
    Button1: TButton;
    Panel2: TPanel;
    edtEnderecoBackend: TLabeledEdit;
    edtNumeroDocumento: TLabeledEdit;
    Button2: TButton;
    Panel1: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edtTamanho: TEdit;
    edtSabor: TEdit;
    edtTotal: TEdit;
    edtTempo: TEdit;
    Label8: TLabel;
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
  objPedido: TPedidoRetornoDTO;
  oPizzariaBackendController: IPizzariaBackendController;
begin

  if trim(edtNumeroDocumento.Text) = emptystr then
     begin
      Showmessage('Informe o número do documento!');
      exit;
    end;

  oPizzariaBackendController := WSDLPizzariaBackendControllerImpl.
    GetIPizzariaBackendController(edtEnderecoBackend.Text);
  try
    objPedido := oPizzariaBackendController.buscarPedido(edtNumeroDocumento.Text);
    begin
      edtTamanho.Text := Copy(TRttiEnumerationType.GetName<TPizzaTamanhoEnum>
        (objPedido.PizzaTamanho), 3,
        length(TRttiEnumerationType.GetName<TPizzaTamanhoEnum>
        (objPedido.PizzaTamanho)));
      edtSabor.Text := Copy(TRttiEnumerationType.GetName<TPizzaSaborEnum>
        (objPedido.PizzaSabor), 3,
        length(TRttiEnumerationType.GetName<TPizzaSaborEnum>
        (objPedido.PizzaSabor)));
      edtTotal.Text := FormatCurr('R$ 0.00', objPedido.ValorTotalPedido);
      edtTempo.Text := objPedido.TempoPreparo.ToString + ' minutos';
      freeandnil(objPedido);
    end
  except
    begin
      edtTamanho.Clear;
      edtSabor.Clear;
      edtTotal.Clear;
      edtTempo.Clear;
      Raise Exception.Create
        ('Não existem pedidos para este número de documento!');
    end;

  end;

end;

end.
