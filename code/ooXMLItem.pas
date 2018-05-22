{$REGION 'documentation'}
{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  XML item information object
  @created(22/04/2018)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooXMLItem;

interface

uses
  SysUtils, StrUtils,
  ooXMLTag;

type
{$REGION 'documentation'}
{
  @abstract(XML tag information interface)
  Resolve @link(IXMLTag XML tag) position in text and value enclosed between tags
  @member(
    StartAt @link(IXMLTag XML tag) initial position in text
  )
  @member(
    EndAt @link(IXMLTag XML tag) final position in text
    @return(Integer position if tag founded, 0 if not found)
  )
  @member(
    Value Text value between open and close @link(IXMLTag XML tag)
    @return(Text value if tag founded, empty string if not found)
  )
  @member(
    Founded Checks if open @link(IXMLTag XML tag) is founded in text
    @return(@true if StartAt > 0, @false if not)
  )
}
{$ENDREGION}
  IXMLItem = interface
    ['{93F297C9-C1E5-4E5C-8E66-E24CC843E311}']
    function StartAt: Cardinal;
    function EndAt: Cardinal;
    function Value: String;
    function Founded: Boolean;
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IXMLItem))
  @member(StartAt @seealso(IXMLItem.StartAt))
  @member(EndAt @seealso(IXMLItem.EndAt))
  @member(Value @seealso(IXMLItem.Value))
  @member(Founded @seealso(IXMLItem.Founded))
  @member(
    Parse Parse text searching @link(IXMLTag XML tag) and resolving position and value
    @param(Text Text to parse)
    @param(Tag @link(IXMLTag XML tag) name)
    @param(FromPos Initial position to parse start)
  )
  @member(
    ValueStart Get the offset of value position
    @param(Text Text to parse)
    @param(Tag @link(IXMLTag XML tag) name)
    @return(Initial position of value)
  )
  @member(
    Create Object constructor
    @param(Text Text to parse)
    @param(Tag @link(IXMLTag XML tag) name)
    @param(FromPos Initial position to parse start)
  )
  @member(
    New Create a new @classname as interface
    @param(Text Text to parse)
    @param(Tag @link(IXMLTag XML tag) name)
    @param(FromPos Initial position to parse start)
  )
}
{$ENDREGION}

  TXMLItem = class sealed(TInterfacedObject, IXMLItem)
  strict private
    _StartAt, _EndAt: Cardinal;
    _Value: String;
  private
    procedure Parse(const Text: String; const Tag: IXMLTag; const FromPos: Cardinal);
    function ValueStart(const Text: String; const Tag: IXMLTag): Cardinal;
  public
    function StartAt: Cardinal;
    function EndAt: Cardinal;
    function Value: String;
    function Founded: Boolean;
    constructor Create(const Text: String; const Tag: IXMLTag; const FromPos: Cardinal);
    class function New(const Text: String; const Tag: IXMLTag; const FromPos: Cardinal): IXMLItem;
  end;

implementation

function TXMLItem.StartAt: Cardinal;
begin
  Result := _StartAt;
end;

function TXMLItem.EndAt: Cardinal;
begin
  if Founded then
    Result := _EndAt
  else
    Result := 0;
end;

function TXMLItem.Founded: Boolean;
begin
  Result := _StartAt > 0;
end;

function TXMLItem.Value: String;
begin
  if Founded then
    Result := _Value
  else
    Result := EmptyStr;
end;

function TXMLItem.ValueStart(const Text: String; const Tag: IXMLTag): Cardinal;
begin
  if Tag.HasAttributes then
    Result := Succ(PosEx(TXMLTag.FINISH_DELIMITER, Text, _StartAt))
  else
    Result := _StartAt + Cardinal(Length(Tag.Opened));
end;

procedure TXMLItem.Parse(const Text: String; const Tag: IXMLTag; const FromPos: Cardinal);
var
  ValueStartAt: Cardinal;
begin
  _StartAt := PosEx(Tag.Opened, Text, FromPos);
  if Founded then
  begin
    _EndAt := PosEx(Tag.Closed, Text, _StartAt);
    if EndAt > 0 then
    begin
      ValueStartAt := ValueStart(Text, Tag);
      _Value := Copy(Text, ValueStartAt, _EndAt - ValueStartAt);
      _Value := Trim(_Value);
      _EndAt := _EndAt + Cardinal(Length(Tag.Closed));
    end;
  end;
end;

constructor TXMLItem.Create(const Text: String; const Tag: IXMLTag; const FromPos: Cardinal);
begin
  Parse(Text, Tag, FromPos);
end;

class function TXMLItem.New(const Text: String; const Tag: IXMLTag; const FromPos: Cardinal): IXMLItem;
begin
  Result := TXMLItem.Create(Text, Tag, FromPos);
end;

end.
