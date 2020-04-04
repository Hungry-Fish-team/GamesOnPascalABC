// Владелец: Владимир Балыш @Запрещено полное либо частичное копирование !!!
// Owner: Mr.Balysh @Forbidden total or partial copy !!!
Unit PanelAndButtoms;

uses graphABC, ABCObjects, Inv;

var 
  x1, y1: integer;
  scene1: string;
  objPanelMenu, objPanelLeftUp, objPanelHPandST, objPanelEnemy, objButtonInv, objButtonMenu: PictureABC;
  
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

procedure loadObjPanelAndButtoms();
begin
  PanelHPandST(ObjPanelHPandST, 100, 640);
  PanelLeftUp(ObjPanelLeftUp, 0, 0);
  PanelEnemy(ObjPanelEnemy, 290, 100);
  PanelMenu(ObjPanelMenu, 330, 0);
  ButtonInv(objButtonInv, 595, 5);
  ButtonMenu(objButtonMenu, 645, 5);
end;

procedure SendScene(scene: string);
begin
  scene1:=scene;
end;

procedure MouseDownPABN2(xm, ym: integer);
begin
  if (objButtonInv.PtInside(xm, ym)= true) then begin scene1:= 'inventar'; ImportantPartProgramInv(scene1); scene1:= 'PanelAndButtoms'; end;
end;

procedure MouseDownPAB(xm, ym, mb: integer);
begin
  case mb of
    1: begin 
         MouseDownPABN2(xm, ym);
       end;
  end;
end;

procedure ImportantPartProgramPanelAndButtoms(scene: string);
begin
  if scene='PanelAndButtoms' then begin 
    scene1:= scene;
    OnMouseDown:= MouseDownPAB;
  end;
end;

begin
  setwindowsize(700,700);
  loadObjPanelAndButtoms;
  scene1:='PanelAndButtoms';
  ImportantPartProgramPanelAndButtoms(scene1);
end.