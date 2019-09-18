unit UFrmConsultaPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons;

type
  TFrmConsultaPedido = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    edtDocumentoCliente: TLabeledEdit;
    btnBuscar: TBitBtn;
    Memo1: TMemo;
    procedure btnBuscarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConsultaPedido: TFrmConsultaPedido;

implementation

uses
  WSDLPizzariaBackendControllerImpl, Rtti, REST.JSON, UPizzaTamanhoEnum,
  UPizzaSaborEnum;


{$R *.dfm}

{ TForm2 }

procedure TFrmConsultaPedido.btnBuscarClick(Sender: TObject);
var
  oPizzariaBackendController: IPizzariaBackendController;
begin
  oPizzariaBackendController := WSDLPizzariaBackendControllerImpl.GetIPizzariaBackendController('http://localhost:8080/soap/IPizzariaBackendController');
  memo1.Text := TJson.ObjectToJsonString(oPizzariaBackendController.obterPedido(edtDocumentoCliente.Text));

end;


end.
