{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  XML tag object
  @created(22/04/2018)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooXML.Tag;

interface

type
{$REGION 'documentation'}
{
  @abstract(XML tag interface)
  @member(Opened Opened tag representation)
  @member(Closed Closed tag representation)
}
{$ENDREGION}
  IXMLTag = interface
    ['{155DAB31-AB99-4FF7-B2C7-93366C7343D3}']
    function Opened: String;
    function Closed: String;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IXMLTag))
  @member(Opened @seealso(IXMLTag.Opened))
  @member(Closed @seealso(IXMLTag.Closed))
  @member(
    Create Object constructor
    @param(Tag XML tag name)
  )
  @member(
    New Create a new @classname as interface
    @param(Tag XML tag name)
  )
}
{$ENDREGION}

  TXMLTag = class sealed(TInterfacedObject, IXMLTag)
  strict private
    _Opened, _Closed: String;
  public
    function Opened: String;
    function Closed: String;
    constructor Create(const Tag: String);
    class function New(const Tag: String): IXMLTag;
  end;

implementation

function TXMLTag.Opened: String;
begin
  Result := _Opened;
end;

function TXMLTag.Closed: String;
begin
  Result := _Closed;
end;

constructor TXMLTag.Create(const Tag: String);
begin
  _Opened := '<' + Tag + '>';
  _Closed := '</' + Tag + '>';
end;

class function TXMLTag.New(const Tag: String): IXMLTag;
begin
  Result := TXMLTag.Create(Tag);
end;

end.
