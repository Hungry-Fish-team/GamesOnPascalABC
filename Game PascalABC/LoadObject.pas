// Владелец: Владимир Балыш @Запрещено полное либо частичное копирование !!!
// Owner: Mr.Balysh @Forbidden total or partial copy !!!
unit LoadObject;

uses graphABC, ABCObjects;

var
  xp, yp: integer;
  objPlayer, objEnemy: pictureABC;
  ObjDoor1, objDoor2: array[1..2] of PictureABC;
  objGround: array[1..100] of PictureABC;

procedure Player(sprite: PictureABC; speed, hp{, hp, lvl, dm, pt} : integer);
var i, j: integer;
begin 
  sprite:= PictureABC.create(xp, yp, 'images/player.png');
  objPlayer:= sprite;
  spPlayer:= speed;
end;

procedure Enemy(sprite: PictureABC; xe, ye, speed, hp{, hp, lvl, dm, pt} : integer);
var i, j: integer;
begin 
  sprite:= PictureABC.create(xe, ye, 'images/enemy.png');
  objEnemy:= sprite;
  spEnemy:= speed;
  xe1:= xe;
  ye1:= ye;
end;

// Текстуры для основной игры

procedure Back1(sprite: PictureABC);
var i, j: integer;
begin 
  sprite:= PictureABC.create(xp, yp, 'images/Back.png');
  objBack:= sprite;
end;

procedure Door1(sprite: PictureABC; number, x1, y1: integer);
var i, j: integer;
begin 
  sprite:= PictureABC.create(x1, y1, 'images/Door.png');
  objDoor1[number]:= sprite;
end;

procedure Door2(sprite: PictureABC; number, x1, y1: integer);
var i, j: integer;
begin 
  sprite:= PictureABC.create(x1, y1, 'images/Door2.png');
  objDoor2[number]:= sprite;
end;

procedure MasGraund(sprite: PictureABC; number, x1, y1: integer);
var i, j: integer;
begin 
  sprite:= PictureABC.create(x1, y1, 'images/ground.png');
  objGround[number]:= sprite;
end;

// Кнопки и панели

procedure PanelMenu(sprite: PictureABC; x1, y1: integer);
begin
  sprite:= PictureABC.create(x1, y1, 'images/PanelMenu.png');
  objPanelMenu:= sprite;
end;

procedure PanelHPandST(sprite: PictureABC; x1, y1: integer);
begin
  sprite:= PictureABC.create(x1, y1, 'images/PanelHPandST.png');
  objPanelHPandST:= sprite;
end;

procedure PanelLeftUp(sprite: PictureABC; x1, y1: integer);
begin
  sprite:= PictureABC.create(x1, y1, 'images/PanelLeftUp.png');
  objPanelLeftUp:= sprite;
end;

procedure PanelEnemy(sprite: PictureABC; x1, y1: integer);
begin
  sprite:= PictureABC.create(x1, y1, 'images/PanelEnemy.png');
  objPanelEnemy:= sprite;
end;

procedure ButtonInv(sprite: PictureABC; x1, y1: integer);
begin
  sprite:= PictureABC.create(x1, y1, 'images/ButtonInv.png');
  objButtonInv:= sprite;
end;

procedure ButtonMenu(sprite: PictureABC; x1, y1: integer);
begin
  sprite:= PictureABC.create(x1, y1, 'images/ButtonMenu.png');
  objButtonMenu:= sprite;
end;

// Инвентарь

procedure Inventar(sprite: PictureABC; x1, y1: integer);  // Инвентарь
begin
  sprite:= PictureABC.create(x1, y1, 'images/inventar.png');
  objInventar:= sprite;
end;

procedure Sword(sprite: PictureABC; number, x1, y1: integer);  // Мечи
begin
  sprite:= PictureABC.create(x1, y1, 'images/sword.png');
  masObj[number]:= sprite;
  masObjNumber[number]:=number;
end;

procedure Helmet(sprite: PictureABC; number, x1, y1: integer);  // Шлемы
begin
  sprite:= PictureABC.create(x1, y1, 'images/helmet.png');
  masObj[number]:= sprite;
  masObjNumber[number]:=number;
end;

begin
end.