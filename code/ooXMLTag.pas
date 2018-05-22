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
unit ooXMLTag;

interface

type
{$REGION 'documentation'}
{
  @abstract(XML tag interface)
  @member(Opened Opened tag representation)
  @member(Closed Closed tag representation)
  @member(HasAttributes Specifies if the tag has attributes)
}
{$ENDREGION}
  IXMLTag = interface
    ['{155DAB31-AB99-4FF7-B2C7-93366C7343D3}']
    function Opened: String;
    function Closed: String;
    function HasAttributes: Boolean;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IXMLTag))
  @member(Opened @seealso(IXMLTag.Opened))
  @member(Closed @seealso(IXMLTag.Closed))
  @member(HasAttributes @seealso(IXMLTag.HasAttributes))
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
  const
    START_DELIMITER = '<';
    FINISH_DELIMITER = '>';
    CLOSE_DELIMITER = START_DELIMITER + '/';
  strict private
    _Opened, _Closed: String;
    _HasAttributes: Boolean;
  public
    function Opened: String;
    function Closed: String;
    function HasAttributes: Boolean;
    constructor Create(const Tag: String; const HasAttributes: Boolean);
    class function New(const Tag: String; const HasAttributes: Boolean = False): IXMLTag;
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

function TXMLTag.HasAttributes: Boolean;
begin
  Result := _HasAttributes;
end;

constructor TXMLTag.Create(const Tag: String; const HasAttributes: Boolean);
const
  OPEN_FINISIH_DELIMITER: array [Boolean] of Char = (FINISH_DELIMITER, ' ');
begin
  _HasAttributes := HasAttributes;
  _Opened := START_DELIMITER + Tag + OPEN_FINISIH_DELIMITER[HasAttributes];
  _Closed := CLOSE_DELIMITER + Tag + FINISH_DELIMITER;
end;

class function TXMLTag.New(const Tag: String; const HasAttributes: Boolean): IXMLTag;
begin
  Result := TXMLTag.Create(Tag, HasAttributes);
end;

end.
