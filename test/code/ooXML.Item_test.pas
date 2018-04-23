{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooXML.Item_test;

interface

uses
  SysUtils,
  ooXML.Tag, ooXML.Item,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TXMLItemTest = class sealed(TTestCase)
  const
    XML = //
      '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>' + //
      '<note>' + //
      '<to>Tove</to>' + //
      '<from>Jani</from>' + //
      '<heading>Reminder</heading>' + //
      '<body>Don''t forget me this weekend!</body>' + //
      '</note>';
  published
    procedure StartAt100;
    procedure EndAt220;
    procedure ValueIsTextValue;
    procedure FoundedIsTrue;
    procedure NotFoundStartAt0;
    procedure NotFoundEndAt0;
    procedure NotFoundValueIsEmpty;
    procedure NotFoundFoundedIsFalse;
    procedure Position100NotFoundNoteTag;
  end;

implementation

procedure TXMLItemTest.StartAt100;
begin
  CheckEquals(92, TXMLItem.New(XML, TXMLTag.New('heading'), 1).StartAt);
end;

procedure TXMLItemTest.EndAt220;
begin
  CheckEquals(119, TXMLItem.New(XML, TXMLTag.New('heading'), 1).EndAt);
end;

procedure TXMLItemTest.FoundedIsTrue;
begin
  CheckTrue(TXMLItem.New(XML, TXMLTag.New('heading'), 1).Founded);
end;

procedure TXMLItemTest.ValueIsTextValue;
begin
  CheckEquals('Jani', TXMLItem.New(XML, TXMLTag.New('from'), 1).Value);
end;

procedure TXMLItemTest.NotFoundStartAt0;
begin
  CheckEquals(0, TXMLItem.New(XML, TXMLTag.New('nonetag'), 1).StartAt);
end;

procedure TXMLItemTest.NotFoundEndAt0;
begin
  CheckEquals(0, TXMLItem.New(XML, TXMLTag.New('nonetag'), 1).StartAt);
end;

procedure TXMLItemTest.NotFoundFoundedIsFalse;
begin
  CheckFalse(TXMLItem.New(XML, TXMLTag.New('nonetag'), 1).Founded);
end;

procedure TXMLItemTest.NotFoundValueIsEmpty;
begin
  CheckEquals(EmptyStr, TXMLItem.New(XML, TXMLTag.New('nonetag'), 1).Value);
end;

procedure TXMLItemTest.Position100NotFoundNoteTag;
begin
  CheckFalse(TXMLItem.New(XML, TXMLTag.New('note'), 100).Founded);
end;

initialization

RegisterTest(TXMLItemTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
