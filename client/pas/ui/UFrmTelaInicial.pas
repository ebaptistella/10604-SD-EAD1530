unit UFrmTelaInicial;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrmTelaInicial = class(TForm)
    pnlBotoes: TPanel;
    btnEfetuarPedido: TButton;
    btnConsultarPedido: TButton;
    procedure btnEfetuarPedidoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTelaInicial: TFrmTelaInicial;

implementation

uses
  UFrmPrincipalImpl, UFrmConsultaPedido;

{$R *.dfm}

procedure TFrmTelaInicial.btnEfetuarPedidoClick(Sender: TObject);
var
  oEfetuarPedido: TForm1;
begin
  oEfetuarPedido:= TForm1.Create(Self);
  try
    oEfetuarPedido.ShowModal;
  finally
    FreeAndNil(oEfetuarPedido);
  end;
end;

end.
