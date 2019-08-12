unit UFrmPrincipalImpl;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

type
  TCliente = record
    Codigo : Integer;
    Nome : string;
  end;
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
    Label4: TLabel;
    lblCliente: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    mTotais: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    FCliente : TCliente;
    procedure AtenderCliente;
    procedure ConsultarTotais;
    procedure AddItemTotal(const AValue : string);
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

procedure TForm1.AddItemTotal(const AValue: string);
begin
  mTotais.Lines.Add(AValue);
end;

procedure TForm1.AtenderCliente;
begin
  FCliente.Nome := InputBox('Identifique-se','Informe seu nome:','');
  FCliente.Codigo := 0;
  edtDocumentoCliente.Text := FCliente.Codigo.ToString;
  lblCliente.Caption := FCliente.Codigo.ToString + ' - ' + FCliente.Nome;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  AtenderCliente;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  ConsultarTotais;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  oPizzariaBackendController: IPizzariaBackendController;
begin
  oPizzariaBackendController := WSDLPizzariaBackendControllerImpl.GetIPizzariaBackendController(edtEnderecoBackend.Text);
  mmRetornoWebService.Text := TJson.ObjectToJsonString(oPizzariaBackendController.efetuarPedido(TRttiEnumerationType.GetValue<TPizzaTamanhoEnum>(cmbTamanhoPizza.Text), TRttiEnumerationType.GetValue<TPizzaSaborEnum>(cmbSaborPizza.Text), edtDocumentoCliente.Text));
end;

procedure TForm1.ConsultarTotais;
begin
  mTotais.Lines.Clear;
  //chamada backend

  AddItemTotal('Cliente...: ' + lblCliente.Caption);
  AddItemTotal('');

end;

procedure TForm1.FormShow(Sender: TObject);
begin
  if (FCliente.Codigo = 0)  and (FCliente.Nome = EmptyStr) then
    AtenderCliente;

end;

end.
