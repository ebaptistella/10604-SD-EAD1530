unit UPizzaSaborEnum;

interface

type
  TPizzaSaborEnum = (enCalabresa, enMarguerita, enPortuguesa);

  function StrPizzaSaborEnum(Value: string): TPizzaSaborEnum;
  function getPizzaSaborEnum(Value: TPizzaSaborEnum): string;

implementation

uses
  System.TypInfo, System.SysUtils;

function StrPizzaSaborEnum(Value: string): TPizzaSaborEnum;
begin
  Result := TPizzaSaborEnum(GetEnumValue(TypeInfo(TPizzaSaborEnum), Value));
end;

function getPizzaSaborEnum(Value: TPizzaSaborEnum): string;
begin
  Result := EmptyStr;
  case Value of
    enCalabresa  :Result:= 'Calabresa';
    enMarguerita :Result:= 'Marguerita';
    enPortuguesa :Result:= 'Portuguesa';
  end;
end;

end.
