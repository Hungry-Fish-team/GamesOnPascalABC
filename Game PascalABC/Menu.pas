// Владелец: Владимир Балыш @Запрещено полное либо частичное копирование !!!
// Owner: Mr.Balysh @Forbidden total or partial copy !!!
program MenuGame;

uses graphABC, ABCObjects;

var 
  i, j: integer;
  x1, y1:integer;
  allow: boolean;
  ObjMenu, ObjStart, ObjSetting, ObjAuthors, ObjExit, ObjGoTo, objAuthorsMenu, objSettingMenu: PictureABC;

procedure ObjMenu1(sprite: PictureABC; x1, y1: integer);  // Фон меню
begin
  sprite:= PictureABC.create(x1, y1, 'images/Menu.png');
  objMenu:= sprite;
end; 

procedure ObjStart1(sprite: PictureABC; x1, y1: integer);  // Начало игры
begin
  sprite:= PictureABC.create(x1, y1, 'images/Start.png');
  objStart:= sprite;
end; 

procedure ObjSetting1(sprite: PictureABC; x1, y1: integer);  // Настройки
begin
  sprite:= PictureABC.create(x1, y1, 'images/Setting.png');
  objSetting:= sprite;
end; 

procedure ObjAuthors1(sprite: PictureABC; x1, y1: integer);  // Авторы
begin
  sprite:= PictureABC.create(x1, y1, 'images/Authors.png');
  objAuthors:= sprite;
end; 

procedure ObjExit1(sprite: PictureABC; x1, y1: integer);  // Выход
begin
  sprite:= PictureABC.create(x1, y1, 'images/Exit.png');
  objExit:= sprite;
end;

procedure ObjSettingMenu1(sprite: PictureABC; x1, y1: integer);
begin
  sprite:= PictureABC.Create(x1, y1, 'images/SettingMenu.png');
  objSettingMenu:= sprite;
end;

procedure ObjAuthorsMenu1(sprite: PictureABC; x1, y1, w: integer);
begin
  sprite:= PictureABC.Create(x1, y1, 'images/AuthorsMenu.png');
  objAuthorsMenu:= sprite;
end;

procedure loadObj();
begin
  ObjMenu1(ObjMenu, 0, 0);
  ObjStart1(ObjStart, 100, 200);
  ObjSetting1(ObjSetting, 100, 270);
  ObjAuthors1(ObjAuthors, 100, 340);
  ObjExit1(ObjExit, 100, 410);
end;

procedure SettingGame(xm, ym, mb: integer);
begin
  if objSetting.PtInside(xm, ym) = true then begin
    case mb of
      1: begin allow:= true; ObjSettingMenu1(ObjSettingMenu, 220, 200); end;
    end;
  end
  else if (allow = true)and(objSetting.PtInside(xm, ym) = true) then objSettingMenu.Destroy;
end;

procedure AuthorsGame(xm, ym, mb: integer);
begin
  if objAuthors.PtInside(xm, ym) = true then begin
    case mb of
      1: begin allow:= true; ObjAuthorsMenu1(ObjAuthorsMenu, 220, 200, 400); end;
    end;
  end
  else if (allow = true)and(objAuthors.PtInside(xm, ym) = true) then objAuthorsMenu.Destroy;
end;

procedure ExitGame(xm, ym, mb: integer);
begin
  if objExit.PtInside(xm, ym) = true then begin
    case mb of
      1: begin halt; end;
    end;
  end;
end;

procedure OpenMenu(xm, ym, mb: integer);
var i, j: integer;
begin
  ExitGame(xm, ym, mb);
  SettingGame(xm, ym, mb);
  AuthorsGame(xm, ym, mb);
end;

procedure GoToMove(xm, ym, mb: integer);
begin
  if (objExit.PtInside(xm, ym) = true) then begin
    ObjExit.Scale(0.9);
  end
  else ObjExit.Scale(1);
end;

begin
  SetWindowTop(0);
  setwindowsize(700,700);
  SetWindowTitle('Menu');
  
  loadObj();
  
  OnMouseDown:= OpenMenu;
  //OnMouseMove:= GoToMove;
  
end.