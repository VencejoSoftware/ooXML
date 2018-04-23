{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  XML text parser object
  @created(22/04/2018)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooXML.Parser;

interface

uses
  ooXML.Tag, ooXML.Item;

type
{$REGION 'documentation'}
{
  @abstract(XML text parser object interface)
  Parse text based in @link(IXMLTag XML tag)
  @member(
    CurrentItem Return current parser @link(IXMLItem XML item information)
  )
  @member(
    SubItem Based in CurrentItem resolve @link(IXMLItem XML sub item)
  )
  @member(
    EOF Checks end of parse
    @return(@true if parser ended, @false if not)
  )
  @member(
    Next Try to go to the next parser occurrence
  )
  @member(
    Reset Reset parser to start in position 1
  )
}
{$ENDREGION}
  IXMLParser = interface
    ['{8F8C29B4-7B5D-496C-B557-C37DFCFA97D1}']
    function CurrentItem: IXMLItem;
    function SubItem(const Tag: IXMLTag): IXMLItem;
    function EOF: Boolean;
    procedure Next;
    procedure Reset;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IXMLParser))
  @member(CurrentItem @seealso(IXMLParser.CurrentItem))
  @member(SubItem @seealso(IXMLParser.SubItem))
  @member(EOF @seealso(IXMLParser.EOF))
  @member(Next @seealso(IXMLParser.Next))
  @member(Reset @seealso(IXMLParser.Reset))
  @member(
    Create Object constructor
    @param(Text Text to parse)
    @param(Tag @link(IXMLTag XML tag) name)
  )
  @member(
    New Create a new @classname as interface
    @param(Text Text to parse)
    @param(Tag @link(IXMLTag XML tag) name)
  )
}
{$ENDREGION}

  TXMLParser = class sealed(TInterfacedObject, IXMLParser)
  strict private
    _Position: Cardinal;
    _Tag: IXMLTag;
    _Text: String;
  public
    function CurrentItem: IXMLItem;
    function SubItem(const Tag: IXMLTag): IXMLItem;
    function EOF: Boolean;
    procedure Next;
    procedure Reset;
    constructor Create(const Text: String; const Tag: IXMLTag);
    class function New(const Text: String; const Tag: IXMLTag): IXMLParser;
  end;

implementation

function TXMLParser.CurrentItem: IXMLItem;
begin
  Result := TXMLItem.New(_Text, _Tag, _Position);
end;

function TXMLParser.SubItem(const Tag: IXMLTag): IXMLItem;
begin
  Result := TXMLItem.New(CurrentItem.Value, Tag, 1)
end;

function TXMLParser.EOF: Boolean;
begin
  Result := not CurrentItem.Founded;
end;

procedure TXMLParser.Next;
begin
  if not EOF then
    _Position := CurrentItem.EndAt;
end;

procedure TXMLParser.Reset;
begin
  _Position := 1;
end;

constructor TXMLParser.Create(const Text: String; const Tag: IXMLTag);
begin
  _Text := Text;
  _Tag := Tag;
  Reset;
end;

class function TXMLParser.New(const Text: String; const Tag: IXMLTag): IXMLParser;
begin
  Result := TXMLParser.Create(Text, Tag);
end;

end.
