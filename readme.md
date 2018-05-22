[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)
[![Build Status](https://travis-ci.org/VencejoSoftware/ooXML.svg?branch=master)](https://travis-ci.org/VencejoSoftware/ooXML)

# ooXML - XML simple parser object library
Objects to parse XML files as text enclosed tags

### Example
```pascal
const
  XML = //
    '<?xml version="1.0" encoding="UTF-8"?>' + //
    '<countries>' + //
    '<country code="af" handle="afghanistan" continent="asia" iso="4">Afghanistan</country>' + //
    '<country code="al" handle="albania" continent="europe" iso="8">Albania</country>' + //
    '</countries>';
var
  Parser: IXMLParser;
begin
  Parser := TXMLParser.New(txtXML.Text, TXMLTag.New('country', True));
  while not Parser.EOF do
  begin
    Showmessage(Parser.CurrentItem.Value);
    Parser.Next;
  end;
end;
```

### Documentation
If not exists folder "code-documentation" then run the batch "build_doc". The main entry is ./doc/index.html

### Demo
Before all, run the batch "build_demo" to build proyect. Then go to the folder "demo\build\release\" and run the executable.

## Built With
* [Delphi&reg;](https://www.embarcadero.com/products/rad-studio) - Embarcadero&trade; commercial IDE
* [Lazarus](https://www.lazarus-ide.org/) - The Lazarus project

## Contribute
This are an open-source project, and they need your help to go on growing and improving.
You can even fork the project on GitHub, maintain your own version and send us pull requests periodically to merge your work.

## Authors
* **Alejandro Polti** (Vencejo Software team lead) - *Initial work*