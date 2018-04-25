{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooXML.Tag_test;

interface

uses
  SysUtils,
  ooXML.Tag,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TXMLTagTest = class sealed(TTestCase)
  published
    procedure OpenedIsXMLTag;
    procedure ClosedIsXMLTag;
    procedure CaseSensitiveInvalidIsFalse;
  end;

implementation

procedure TXMLTagTest.CaseSensitiveInvalidIsFalse;
begin
  CheckNotEquals('<tag>', TXMLTag.New('TaG').Opened);
end;

procedure TXMLTagTest.ClosedIsXMLTag;
begin
  CheckEquals('</tag>', TXMLTag.New('tag').Closed);
end;

procedure TXMLTagTest.OpenedIsXMLTag;
begin
  CheckEquals('<tag>', TXMLTag.New('tag').Opened);
end;

initialization

RegisterTest(TXMLTagTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
