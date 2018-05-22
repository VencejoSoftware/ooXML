{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooXMLItem_test;

interface

uses
  SysUtils,
  ooXMLTag, ooXMLItem,
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
    XML_WITH_ATTRIBUTE = //
      '<?xml version="1.0" encoding="UTF-8"?>' + //
      '<countries>' + //
      '<country code="af" handle="afghanistan" continent="asia" iso="4">Afghanistan</country>' + //
      '<country code="al" handle="albania" continent="europe" iso="8">Albania</country>' + //
      '</countries>';
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
    procedure WithAttributeStartAt50;
    procedure WithAttributeEndAt136;
    procedure WithAttributeValueIsTextAfghanistan;
    procedure WithAttributeFoundedIsTrue;
    procedure WithAttributeNotFoundStartAt0;
    procedure WithAttributeNotFoundEndAt0;
    procedure WithAttributeNotFoundValueIsEmpty;
    procedure WithAttributeNotFoundFoundedIsFalse;
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
  CheckEquals(0, TXMLItem.New(XML, TXMLTag.New('nonetag'), 1).EndAt);
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

procedure TXMLItemTest.WithAttributeStartAt50;
begin
  CheckEquals(50, TXMLItem.New(XML_WITH_ATTRIBUTE, TXMLTag.New('country', True), 1).StartAt);
end;

procedure TXMLItemTest.WithAttributeEndAt136;
begin
  CheckEquals(136, TXMLItem.New(XML_WITH_ATTRIBUTE, TXMLTag.New('country', True), 1).EndAt);
end;

procedure TXMLItemTest.WithAttributeValueIsTextAfghanistan;
begin
  CheckEquals('Afghanistan', TXMLItem.New(XML_WITH_ATTRIBUTE, TXMLTag.New('country', True), 1).Value);
end;

procedure TXMLItemTest.WithAttributeFoundedIsTrue;
begin
  CheckTrue(TXMLItem.New(XML_WITH_ATTRIBUTE, TXMLTag.New('country', True), 1).Founded);
end;

procedure TXMLItemTest.WithAttributeNotFoundStartAt0;
begin
  CheckFalse(TXMLItem.New(XML_WITH_ATTRIBUTE, TXMLTag.New('Country', True), 1).Founded);
end;

procedure TXMLItemTest.WithAttributeNotFoundEndAt0;
begin
  CheckEquals(0, TXMLItem.New(XML_WITH_ATTRIBUTE, TXMLTag.New('Country', True), 1).StartAt);
end;

procedure TXMLItemTest.WithAttributeNotFoundValueIsEmpty;
begin
  CheckEquals(0, TXMLItem.New(XML_WITH_ATTRIBUTE, TXMLTag.New('Country', True), 1).EndAt);
end;

procedure TXMLItemTest.WithAttributeNotFoundFoundedIsFalse;
begin
  CheckFalse(TXMLItem.New(XML_WITH_ATTRIBUTE, TXMLTag.New('Country', True), 1).Founded);
end;

initialization

RegisterTest(TXMLItemTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
