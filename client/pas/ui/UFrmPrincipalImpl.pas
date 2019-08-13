unit UFrmPrincipalImpl;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, json;

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
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    edtDocumentoClienteConsulta: TLabeledEdit;
    mmRetornoConsultaPedido: TMemo;
    mmResumoPedido: TMemo;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    function getCamposJsonString(json, chave, value: String): String;
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
  valor, tempo: string;

begin
  oPizzariaBackendController := WSDLPizzariaBackendControllerImpl.GetIPizzariaBackendController(edtEnderecoBackend.Text);
  mmRetornoConsultaPedido.Text := TJson.ObjectToJsonString(oPizzariaBackendController.consultarPedido(edtDocumentoClienteConsulta.Text));
  mmResumoPedido.Lines.Clear;
  mmResumoPedido.Lines.Add('Resumo do Pedido:');
  mmResumoPedido.Lines.Add('----------------------------------');
  mmResumoPedido.Lines.Add('Pizza ' + copy(getCamposJsonString(mmRetornoConsultaPedido.Text, '', 'pizzaTamanho'), 3, 8) +
                           ' ' + copy(getCamposJsonString(mmRetornoConsultaPedido.Text, '', 'pizzaSabor'), 3, 12));
  valor := 'R$ ' + getCamposJsonString(mmRetornoConsultaPedido.Text, '', 'valorTotalPedido') + ',00';
  mmResumoPedido.Lines.Add(StringOfChar('.', 34-Length(valor)) + valor);
  mmResumoPedido.Lines.Add('----------------------------------');
  mmResumoPedido.Lines.Add('Total do Pedido:' + StringOfChar('.', 34-Length('Total do Pedido:' + valor)) + valor);
  mmResumoPedido.Lines.Add('');
  tempo := getCamposJsonString(mmRetornoConsultaPedido.Text, '', 'tempoPreparo') + ' minutos';
  mmResumoPedido.Lines.Add('Tempo de Preparo:' + StringOfChar('.', 34-Length('Tempo de Preparo:' + tempo)) + tempo);
  mmResumoPedido.Lines.Add('');
  mmResumoPedido.Lines.Add('');
  mmResumoPedido.Lines.Add('');
  mmResumoPedido.Lines.Add('');
  mmResumoPedido.Lines.Add(StringOfChar(' ', 34-Length('(felipe rodrigues pucci)')) + '(felipe rodrigues pucci)');
end;



function TForm1.getCamposJsonString(json, chave, value: String): String;
var LJSONObject: TJSONObject;
	 chave1: string;

	function TrataObjeto(jObj:TJSONObject):string;
	var i:integer;
		 jPar: TJSONPair;
	begin
		  result := '';
		  for i := 0 to jObj.Size - 1 do
		  begin
				if (Result <> '') then Break;

				jPar := jObj.Get(i);
				if SameText(trim(jPar.JsonString.Value),value) and SameText(chave1,chave) then
				begin
					Result := jPar.JsonValue.Value;
					Break;
				end;
				if SameText(Trim(jPar.JsonString.Value), chave) then
				begin
					chave1 := trim(jPar.JsonString.Value);
					if jPar.JsonValue Is TJSONObject then
						Result := TrataObjeto((jPar.JsonValue As TJSONObject));
				end;
				if jPar.JsonValue Is TJSONObject then
					Result := TrataObjeto((jPar.JsonValue As TJSONObject))
		  end;
	end;

begin
	try
		LJSONObject := nil;
		LJSONObject := TJSONObject.ParseJSONValue(json) as TJSONObject;
		result := TrataObjeto(LJSONObject);
	finally
		LJSONObject.Free;
	end;
end;


end.
