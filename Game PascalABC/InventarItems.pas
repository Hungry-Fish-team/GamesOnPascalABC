// ��������: �������� ����� @��������� ������ ���� ��������� ����������� !!!
// Owner: Mr.Balysh @Forbidden total or partial copy !!!
Unit InventarItems;

uses graphABC, ABCObjects;

var a, a1: integer;
    
procedure Sword(sprite: PictureABC; number, x1, y1: integer);  // ����
begin
  sprite:= PictureABC.create(x1, y1, 'images/sword.png');
  masObj[number]:= sprite;
  masObjNumber[number]:=number;
end;

procedure Helmet(sprite: PictureABC; number, x1, y1: integer);  // �����
begin
  sprite:= PictureABC.create(x1, y1, 'images/helmet.png');
  masObj[number]:= sprite;
  masObjNumber[number]:=number;
end;

begin 
end.