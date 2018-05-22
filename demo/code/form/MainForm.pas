{
  Copyright (c) 2018, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit MainForm;

interface

uses
  SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls,
  ooXMLItem, ooXMLParser, ooXMLTag;

type
  TMainForm = class(TForm)
    txtXML: TMemo;
    Button2: TButton;
    ListBox1: TListBox;
    procedure Button2Click(Sender: TObject);
  private
    Parser: IXMLParser;
  end;

var
  NewMainForm: TMainForm;

implementation

{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure TMainForm.Button2Click(Sender: TObject);
var
  Count: Cardinal;
begin
  ListBox1.Clear;
  Parser := TXMLParser.New(txtXML.Text, TXMLTag.New('country', True));
  Count := 0;
  while not Parser.EOF do
  begin
    ListBox1.Items.Add(Parser.CurrentItem.Value);
    Inc(Count);
    Parser.Next;
  end;
  Button2.Caption := IntToStr(Count);
end;

end.
