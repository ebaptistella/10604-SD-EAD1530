unit UPizzaTamanhoEnum;

interface

type
  TPizzaTamanhoEnum = (enPequena, enMedia, enGrande);

  function StrPizzaTamanhoEnum(Value: string): TPizzaTamanhoEnum;
  function getPizzaTamanhoEnum(Value: TPizzaTamanhoEnum): string;

implementation

uses
  System.TypInfo, System.SysUtils;

function StrPizzaTamanhoEnum(Value: string): TPizzaTamanhoEnum;
begin
  Result := TPizzaTamanhoEnum(GetEnumValue(TypeInfo(TPizzaTamanhoEnum), Value));
end;

function getPizzaTamanhoEnum(Value: TPizzaTamanhoEnum): string;
begin
  Result := EmptyStr;
  case Value of
    enPequena : Result := 'Pequena';
    enMedia   : Result := 'Média';
    enGrande  : Result := 'Grande';
  end;
end;

end.
