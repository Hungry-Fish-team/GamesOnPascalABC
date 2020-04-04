// Владелец: Владимир Балыш @Запрещено полное либо частичное копирование !!!
// Owner: Mr.Balysh @Forbidden total or partial copy !!!
program game;

uses graphABC, ABCObjects;

var
  a1, a2, i, j, key1, lastkey, scena, nomer, code, ld, varXY, enter, schet, ProcessNumber, SaveNumber: integer;
  sum: integer;
  scene1, NamePlayer: string;
  ground, wall, back, room: picture;
  iEnemy, x, y, x1, y1, xvar1, yvar1, xr, yr, spPlayer, xp, yp, xm, ym, xm1, ym1, spEnemy, xe1, ye1, mb1, time, Frame, InfoEnemyButtom, lastXM, lastYM, LxP, LyP, LastNumberDoor, xg, yg, xNPC, yNPC, lastXr, lastYr, lastXP, lastYP: integer;
  accept, borders, RoomCreate, workMap, GameReadyToPlay, WorkEscape, AllPictureLoaded: boolean;
  str1, str2, scene: string;
  objPlayer, Objback, objBorderOne, objBorderTwo, objBorderThree, objBorderFour, objXPYPPlayer, objLoadingMenu, objLogo1, objLogo2, objLogo3, objLogo4, objchestWithItem, objWellForResurrection: pictureABC;
  t1: text;
 
  xe, ye: array[1..5]of integer;
  objEnemy: array[1..5] of PictureABC;
  ObjDoor1, objDoor2: array[1..2] of PictureABC;
  infoEnemyTxt: array[1..11]  of TextABC;
  objGround: array[1..100] of PictureABC;
  mas:array[-1..46,1..1000] of integer;
  objMasNPC:array[1..20]of PictureABC;
  masTradeInv:array[1..3,0..48,1..13]of string;
  objMapRoom:array[1..1000]of PictureABC;
   
  objFightEffect:array[1..6]of PictureABC;
  
  playerInfo:array[1..13]of string;
  playerInfoGame:array[1..8]of string;
  
  objHPPlayer:array[1..810]of PictureABC;
  objSTPlayer:array[1..810]of PictureABC;
  objEXPlayer:array[1..1044]of PictureABC;
  
  InfoPanelPlayerTxt:array[1..5]of TextABC;
  InfoPanelPlayerMenuTxt:array[1..13]of TextABC;
  
  EnemysInventar:array[1..12,1..20,1..5]of string;
  EnemysInfo:array[1..10,1..5]of string;
  
  SaveInfo:array[1..10]of string;
 
  allowAuthors, allowSetting: boolean;
  ObjMenu, ObjStart, ObjSetting, ObjAuthors, ObjExit, ObjGoTo, objAuthorsMenu, objSettingMenu: PictureABC;
  
//Работа с кнопками
procedure readkey(key:integer);   // Если кнопка повторяется, то уже не нужно записывать. Нужно приравнивать к 0
begin
  if key1 = key then key := 0;
  key1:=key; 
end;

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

procedure Back1(sprite: PictureABC);
var i, j: integer;
begin 
  sprite:= PictureABC.create(0, 0, 'images/Back.png');
  objBack:= sprite;
end;

procedure LoadingMenu(sprite: PictureABC; xp, yp: integer);
var i, j: integer;
begin 
  sprite:= PictureABC.create(xp, yp, 'images/LoadingMenu.png');
  objLoadingMenu:= sprite;
end;

procedure Logo1(sprite: PictureABC; xp, yp: integer);
var i, j: integer;
begin 
  sprite:= PictureABC.create(xp, yp, 'images/Logo1.png');
  objLogo1:= sprite;
  objLogo1.Scale(0.2);
end;

procedure Logo2(sprite: PictureABC; xp, yp: integer);
var i, j: integer;
begin 
  sprite:= PictureABC.create(xp, yp, 'images/Logo2.png');
  objLogo2:= sprite;
  objLogo2.Scale(0.2);
end;

procedure Logo3(sprite: PictureABC; xp, yp: integer);
var i, j: integer;
begin 
  sprite:= PictureABC.create(xp, yp, 'images/Logo3.png');
  objLogo3:= sprite;
  objLogo3.Scale(0.2);
end;

procedure Logo4(sprite: PictureABC; xp, yp: integer);
var i, j: integer;
begin 
  sprite:= PictureABC.create(xp, yp, 'images/Logo4.png');
  objLogo4:= sprite;
  objLogo4.Scale(0.2);
end;

procedure Player(sprite: PictureABC; speed, xp, yp : integer);
var i, j: integer;
begin 
  sprite:= PictureABC.create(xp, yp, 'images/player.png');
  objPlayer:= sprite;
  spPlayer:= speed;
end;

procedure chestWithItem(sprite: PictureABC; xp, yp: integer);
var i, j: integer;
begin 
  sprite:= PictureABC.create(xp, yp, 'images/chestWithItem.png');
  objchestWithItem:= sprite;
end;

procedure WellForResurrection(sprite: PictureABC; xp, yp: integer);
var i, j: integer;
begin 
  sprite:= PictureABC.create(xp, yp, 'images/WellForResurrection.png');
  objWellForResurrection:= sprite;
end;

procedure Enemy(sprite: PictureABC; nomer, xe1, ye1, speed, hp : integer);
var i, j: integer;
begin 
  sprite:= PictureABC.create(xe1, ye1, 'images/enemy.png');
  objEnemy[nomer]:= sprite;
  spEnemy:= speed;
  xe[nomer]:=xe1;
  ye[nomer]:=ye1;
end;

procedure NPC(sprite: PictureABC; nomer, xNPC, yNPC: integer);
begin
end;

procedure NPCTrader(sprite: PictureABC; nomer, xNPC, yNPC: integer);
begin
  sprite:= PictureABC.create(xNPC, yNPC, 'images/NPCTrader.png');
  objMasNPC[nomer]:= sprite;
end;

procedure NPCQuests(sprite: PictureABC; nomer, xNPC, yNPC: integer);
begin
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

procedure MapRoom(sprite: PictureABC; number, x1, y1: integer);
begin
  sprite:= PictureABC.create(x1, y1, 'images/MapRoom.png');
  objMapRoom[number]:= sprite;
end;

procedure loadObjMenu();
begin
  ObjMenu1(ObjMenu, 0, 0);
  ObjStart1(ObjStart, 100, 200);
  ObjSetting1(ObjSetting, 100, 270);
  ObjAuthors1(ObjAuthors, 100, 340);
  ObjExit1(ObjExit, 100, 410);
  AllPictureLoaded:= true; 
end;

procedure StartingGame(xm, ym, mb: integer);
begin
  if ObjStart.PtInside(xm, ym) = true then begin
    case mb of
      1: begin 
        AllPictureLoaded:= false; 
        ProcessNumber:=1;
        objMenu.Destroy;
        objStart.Destroy;
        objSetting.Destroy;
        objAuthors.Destroy;
        objExit.Destroy;
      end;
    end;
  end
end;

procedure SettingGame(xm, ym, mb: integer);
begin
  if objSetting.PtInside(xm, ym) = true then begin
    case mb of
      1: begin allowSetting:= true; ObjSettingMenu1(ObjSettingMenu, 220, 200); end;
    end;
  end
  else if (allowSetting = true) then begin objSettingMenu.Destroy; allowSetting:= false; end;
end;

procedure AuthorsGame(xm, ym, mb: integer);
begin
  if objAuthors.PtInside(xm, ym) = true then begin
    case mb of
      1: begin allowAuthors:= true; ObjAuthorsMenu1(ObjAuthorsMenu, 220, 200, 400); end;
    end;
  end
  else if (allowAuthors = true) then begin objAuthorsMenu.Destroy; allowAuthors:= false; end;
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
  SettingGame(xm, ym, mb);
  AuthorsGame(xm, ym, mb);
  ExitGame(xm, ym, mb);
  StartingGame(xm, ym, mb);
end;

procedure MenuOfGame();
begin
  if (AllPictureLoaded = false)and(ProcessNumber = 0) then loadObjMenu();
  OnMouseDown:= OpenMenu;
end;

//Работа с сохранением и чтением сохраненных файлов

var pictureAllow: boolean;
    objSaveProfileMenu, ButtonExitProfile, ButtonStartProfile, ButtonNextProfile, objProfileCreate, ButtonBackProfile: PictureABC;
    ButtonAllow:array[1..5]of boolean;
    StatusProfile: string;
    AmoungProfile: integer;

procedure SaveProfileMenu(sprite: PictureABC; x1, y1: integer);
begin
  sprite:= PictureABC.Create(x1, y1, 'images/SaveProfileMenu.png');
  objSaveProfileMenu:= sprite;
end;

procedure ProfileCreate(sprite: PictureABC; x1, y1: integer);
begin
  sprite:= PictureABC.Create(x1, y1, 'images/ProfileCreate.png');
  objProfileCreate:= sprite;
end;

procedure ButtonStartProfile1(sprite: PictureABC; x1, y1: integer);
begin
  sprite:= PictureABC.Create(x1, y1, 'images/ButtonStartProfile.png');
  ButtonStartProfile:= sprite;
end;

procedure ButtonNextProfile1(sprite: PictureABC; x1, y1: integer);
begin
  sprite:= PictureABC.Create(x1, y1, 'images/ButtonNextProfile.png');
  ButtonNextProfile:= sprite;
end;

procedure ButtonBackProfile1(sprite: PictureABC; x1, y1: integer);
begin
  sprite:= PictureABC.Create(x1, y1, 'images/ButtonBackProfile.png');
  ButtonBackProfile:= sprite;
end;

procedure ButtonExitProfile1(sprite: PictureABC; x1, y1: integer);
begin
  sprite:= PictureABC.Create(x1, y1, 'images/ButtonExitProfile.png');
  ButtonExitProfile:= sprite;
end;

procedure ReadSaveInfo();
var s1, s2: string;
    i, j: integer;
begin
  assign(t1, 'database/SaveInfo.txt');
  reset(t1);
  read(t1, s1);
  while s1 <> '' do begin
    AmoungProfile:= AmoungProfile + 1;
    SaveInfo[AmoungProfile]:=s1;
    readln(t1);
    read(t1, s1);
  end;
  close(t1);
end;

procedure WriteSaveInfo();
var i, j: integer;
begin
  assign(t1, 'database/SaveInfo.txt');
  rewrite(t1);
  for i:=1 to AmoungProfile do
    writeln(t1, SaveInfo[i]);
  close(t1);
end;

procedure CreateNewPlayer();
var i, j: integer;
begin
  AmoungProfile:= AmoungProfile + 1;
  assign(t1, 'createfolder.bat');
  rewrite(t1);
    write(t1, 'mkdir database\'+NamePlayer);
  close(t1);
  exec('createfolder.bat');
  sleep(150);
  
  assign(t1, 'createfiles.bat');
  rewrite(t1);
    write(t1, 'Echo >database\'+NamePlayer+'\database.txt');
    writeln(t1);
    write(t1, 'Echo >database\'+NamePlayer+'\playerinfo.txt');
    writeln(t1);
    write(t1, 'Echo >database\'+NamePlayer+'\inventar.txt');
  close(t1);
  exec('createfiles.bat');
  sleep(150);
  
  assign(t1, 'copyinventar.bat');
  rewrite(t1);
    write(t1, 'copy inventar.txt database\'+NamePlayer);
  close(t1);
  exec('copyinventar.bat');
  sleep(150);
  
  assign(t1, 'database\'+NamePlayer+'\playerinfo.txt');
  rewrite(t1);
  writeln(t1, NamePlayer);  // Имя персонажа 
  writeln(t1, '0');  // Количество exp
  writeln(t1, '20');  // Количество здоровья
  writeln(t1, '20');  // Максимальное здоровье
  writeln(t1, '30');  // Количество выносливости
  writeln(t1, '30');  // Максимальная выносливость 
  writeln(t1, '10');  // Уровень Силы S
  writeln(t1, '10');  // Уровень Ловкости L
  writeln(t1, '10');  // Уровень Интелекта I
  writeln(t1, '2');  // Урон
  writeln(t1, '3');  // Защита
  writeln(t1, '100');  // Скорость атаки в процентах
  writeln(t1, '-');  // Титул
  close(t1);
  
  assign(t1, 'database\'+NamePlayer+'\database.txt');
  rewrite(t1);
  write(t1, '');
  close(t1);
  
  SaveInfo[AmoungProfile]:= NamePlayer;
  
  WriteSaveInfo();
end;

procedure LoadPictureInProfile();
var i, j, x, y:integer;
begin
  SaveProfileMenu(objSaveProfileMenu, 0, 0);
  ButtonExitProfile1(ButtonExitProfile, 50,  600);
  ButtonAllow[1]:=true;
  ButtonStartProfile1(ButtonStartProfile, 550,  600);
  ButtonAllow[2]:=true;
  if (AmoungProfile <> 0) and (SaveNumber <> AmoungProfile) then begin ButtonNextProfile1(ButtonNextProfile, 550,  500); ButtonAllow[3]:=true; end;
  if (AmoungProfile <> 0) and (SaveNumber <> 1) then begin ButtonBackProfile1(ButtonBackProfile, 50,  500); ButtonAllow[4]:=true; end;
  ProfileCreate(objProfileCreate, 300, 500);
  ButtonAllow[5]:=true;
end;

procedure LoadingInfoOfPlayer();
var i, j: integer;
    str1: string;
begin
  NamePlayer:= SaveInfo[SaveNumber];
  assign(t1, 'database/'+NamePlayer+'/playerinfo.txt');
  reset(t1);
  for i:=1 to 13 do begin
    readln(t1, str1);
    playerInfo[i]:= str1;
  end;
  close(t1);
end;

procedure PanelInfoOfPlayer();
var i, j, x, y: integer;
begin
  x:= 100;
  y:= 80;
  InfoPanelPlayerMenuTxt[1]:= new TextABC(300, 10, 10, playerInfo[1], clBlack);
  for i:=2 to 13 do begin
    InfoPanelPlayerMenuTxt[i]:= new TextABC(x, y, 10, playerInfo[i], clBlack);
    y:= y + 30;
  end;
end;

procedure DeletePanelInfoForPlayer();
var i, j: integer;
begin
  for i:=1 to 13 do 
  InfoPanelPlayerMenuTxt[i].Destroy;
end;

procedure closeAllActionInProfile();
var i, j: integer;
begin
  ButtonExitProfile.Destroy;
  if ButtonAllow[3] = true then ButtonNextProfile.Destroy; 
  if ButtonAllow[4] = true then ButtonBackProfile.Destroy;
  ButtonStartProfile.Destroy; 
  objProfileCreate.Destroy;
  objSaveProfileMenu.Destroy;
  DeletePanelInfoForPlayer();
  ProcessNumber:=0;
  AmoungProfile:=0;
  pictureAllow := false;
end;

procedure ButtonPressing(xm, ym, mb: integer);
begin
  if ButtonExitProfile.PtInside(xm, ym) = true then begin
    closeAllActionInProfile();
  end;
  if ButtonStartProfile.PtInside(xm, ym) = true then begin
    closeAllActionInProfile();
    ProcessNumber:= 2;
  end;
  if ButtonAllow[3] = true then begin
    if ButtonNextProfile.PtInside(xm, ym) = true then begin
      SaveNumber:= SaveNumber + 1;
      
      if ButtonAllow[3] = true then ButtonNextProfile.Destroy; 
      if ButtonAllow[4] = true then ButtonBackProfile.Destroy;
      
      if (AmoungProfile <> 0) and (SaveNumber <> AmoungProfile) then begin ButtonNextProfile1(ButtonNextProfile, 550,  500); ButtonAllow[3]:=true; end;
      if (AmoungProfile <> 0) and (SaveNumber <> 1) then begin ButtonBackProfile1(ButtonBackProfile, 50,  500); ButtonAllow[4]:=true; end;
      
      DeletePanelInfoForPlayer();
      LoadingInfoOfPlayer();
      PanelInfoOfPlayer();
    end;
  end;
  if ButtonAllow[4] = true then begin
    if ButtonBackProfile.PtInside(xm, ym) = true then begin
      if SaveNumber = AmoungProfile then ButtonBackProfile.Destroy;
      SaveNumber:= SaveNumber - 1;
      
      if ButtonAllow[3] = true then ButtonNextProfile.Destroy; 
      if ButtonAllow[4] = true then ButtonBackProfile.Destroy;
      
      if (AmoungProfile <> 0) and (SaveNumber <> AmoungProfile) then begin ButtonNextProfile1(ButtonNextProfile, 550,  500); ButtonAllow[3]:=true; end;
      if (AmoungProfile <> 0) and (SaveNumber <> 1) then begin ButtonBackProfile1(ButtonBackProfile, 50,  500); ButtonAllow[4]:=true; end;
      
      DeletePanelInfoForPlayer();
      LoadingInfoOfPlayer();
      PanelInfoOfPlayer();
    end;
  end;
  if objProfileCreate.PtInside(xm, ym) = true then begin
    CreateNewPlayer;
    ButtonExitProfile.Destroy;
    if ButtonAllow[3] = true then ButtonNextProfile.Destroy; 
    if ButtonAllow[4] = true then ButtonBackProfile.Destroy;
    ButtonStartProfile.Destroy; 
    objProfileCreate.Destroy;
    objSaveProfileMenu.Destroy;
    pictureAllow:= false;
    AmoungProfile:=0;
  end;
end;

procedure ActionInProfile();
var i, j: integer;
begin
  if pictureAllow = false then begin
    ReadSaveInfo();
    LoadPictureInProfile();
    if amoungProfile <> 0 then begin 
      LoadingInfoOfPlayer();
      PanelInfoOfPlayer();
    end;
    pictureAllow := true;
  end;
  
  onMouseDown:=ButtonPressing;
  
  if key1 = vk_escape then closeAllActionInProfile();
  onkeydown:= readkey;
end;

procedure XYvar1up;
begin
  yvar1:=mas[0,nomer-1];
  xvar1:=mas[-1,nomer-1];
  mas[0,nomer]:= yvar1-1;
  mas[-1,nomer]:= xvar1;
end;

procedure XYvar1right;
begin
  xvar1:=mas[-1,nomer-1];
  yvar1:=mas[0,nomer-1];
  mas[-1,nomer]:= xvar1+1;
  mas[0,nomer]:= yvar1;
end;

procedure XYvar1down;
begin
  xvar1:=mas[-1,nomer-1];
  yvar1:=mas[0,nomer-1];
  mas[0,nomer]:= yvar1+1;
  mas[-1,nomer]:=mas[-1,nomer-1];
end;

procedure XYvar1left;
begin
  yvar1:=mas[0,nomer-1];
  xvar1:=mas[-1,nomer-1];
  mas[-1,nomer]:= xvar1-1;
  mas[0,nomer]:= yvar1;
end;

procedure checkroom;
var i, j: integer;
begin
  if (ld = 1) then begin 
    for i:=1 to nomer-1 do begin
      if (mas[-1,i] = mas[-1,nomer]+1)and(mas[0,i] = mas[0,nomer]) then begin
        if mas[7,i] > 0 then mas[5,nomer]:=mas[7,i] else mas[5,nomer]:=0; end
      else if (mas[-1,i] = mas[-1,nomer])and(mas[0,i] = mas[0,nomer]-1) then begin
        if mas[6,i] > 0 then mas[4,nomer]:=mas[6,i] else mas[4,nomer]:=0; end
      else if (mas[-1,i] = mas[-1,nomer]-1)and(mas[0,i] = mas[0,nomer]) then begin
        if mas[5,i] > 0 then mas[7,nomer]:=mas[5,i] else mas[7,nomer]:=0; end
                            end;  
  end
  else if (ld = 2)  then begin  
    for i:=1 to nomer-1 do begin
      if (mas[-1,i] = mas[-1,nomer])and(mas[0,i] = mas[0,nomer]+1) then begin
        if mas[4,i] > 0 then mas[6,nomer]:=mas[4,i] else mas[6,nomer]:=0; end
      else if (mas[-1,i] = mas[-1,nomer])and(mas[0,i] = mas[0,nomer]-1) then begin
        if mas[6,i] > 0 then mas[4,nomer]:=mas[6,i] else mas[5,nomer]:=0; end
      else if (mas[-1,i] = mas[-1,nomer]-1)and(mas[0,i] = mas[0,nomer]) then begin
        if mas[5,i] > 0 then mas[7,nomer]:=mas[5,i] else mas[7,nomer]:=0; end    
                            end; 
  end
  else if (ld = 3)  then begin  
    for i:=1 to nomer-1 do begin
      if (mas[-1,i] = mas[-1,nomer]+1)and(mas[0,i] = mas[0,nomer]) then begin
        if mas[7,i] > 0 then mas[5,nomer]:=mas[7,i] else mas[5,nomer]:=0; end
      else if (mas[-1,i] = mas[-1,nomer])and(mas[0,i] = mas[0,nomer]+1) then begin
        if mas[4,i] > 0 then mas[6,nomer]:=mas[4,i] else mas[6,nomer]:=0; end
      else if (mas[-1,i] = mas[-1,nomer]-1)and(mas[0,i] = mas[0,nomer]) then begin
        if mas[5,i] > 0 then mas[7,nomer]:=mas[5,i] else mas[7,nomer]:=0; end     
    end; 
  end
  else if (ld = 4)  then begin 
    for i:=1 to nomer-1 do begin
      if (mas[-1,i] = mas[-1,nomer]+1)and(mas[0,i] = mas[0,nomer]) then begin
        if mas[7,i] > 0 then mas[5,nomer]:=mas[7,i] else mas[5,nomer]:=0; end
      else if (mas[-1,i] = mas[-1,nomer])and(mas[0,i] = mas[0,nomer]-1) then begin
        if mas[6,i] > 0 then mas[4,nomer]:=mas[6,i] else mas[4,nomer]:=0; end
      else if (mas[-1,i] = mas[-1,nomer])and(mas[0,i] = mas[0,nomer]+1) then begin
        if mas[4,i] > 0 then mas[6,nomer]:=mas[4,i] else mas[6,nomer]:=0; end    
    end; 
  end
end;

procedure copyroom;
var i, j: integer;
begin
  for i:=1 to nomer-1 do begin
    if (mas[-1,nomer]=mas[-1,i]) and (mas[0,nomer]=mas[0,i]) then 
      for j:=-1 to 46 do mas[j,nomer]:=mas[j,i];
  end;
end;

procedure generateroom;
var i, j, RandomNumber: integer;
begin
  nomer:= nomer + 1;
  if nomer = 1 then begin
    mas[-1,nomer]:=0;  // X
    mas[0,nomer]:=0;  // Y
  end
  else if nomer > 1 then
    begin 
      if ld=1 then XYvar1up 
      else if ld=2 then XYvar1right 
      else if ld=3 then XYvar1down
      else if ld=4 then XYvar1left;
    end;
  if nomer = 1 then begin
    mas[1,nomer]:=7  // Размер комнаты
  end
  else begin 
    mas[1,nomer]:=7  
  end;
  RandomNumber:=random(100)+1;
  if RandomNumber<=70 then mas[2,nomer]:=0  // Тип  (Еще не готовы Города и НПС)
  else if (RandomNumber <85)and(RandomNumber >70) then mas[2,nomer]:=3;
  mas[3,nomer]:=random(1)+1;  // Биом
  if nomer = 1 then begin  // Система создания путей
  for i:=1 to 4 do begin    
    mas[4+i-1,nomer]:=random(mas[1,nomer]); // P1 - P4 (nomer = 1)
                    end;
                      end
  else begin
    for i:=1 to 4 do begin 
      if i<>ld then
      mas[3+i,nomer]:=random(mas[1,nomer]);
                      end; 
      if ld<3 then mas[3+ld+2,nomer]:=mas[3+ld,nomer-1]
      else mas[3+ld-2,nomer]:=mas[3+ld,nomer-1];
      checkroom;
       end;
  //  Колодец воскрешения 
  if mas[2, nomer] = 3 then begin
    mas[8, nomer]:=1;
    mas[9, nomer]:=7;
  end;
  //  Возможный сундук
  RandomNumber:=random(101)+1;
  if RandomNumber<80 then begin
    mas[10, nomer]:=random(mas[1, nomer])+1;
    mas[11, nomer]:=random(mas[1, nomer])+1;
  end;
  //  Враги
  if mas[2, nomer] = 0 then begin
    randomNumber:= random(6)+1;
    if RandomNumber <> 0 then begin
      for i:=1 to randomNumber do begin
        mas[12+2*(i-1), nomer]:=random(mas[1, nomer])+1;
        mas[13+2*(i-1), nomer]:=random(mas[1, nomer])+1;
      end;
    end else begin
      for i:=1 to 5 do begin
        mas[12+2*(i-1), nomer]:=0;
        mas[13+2*(i-1), nomer]:=0;
      end;
    end;
  end
  else for i:=1 to 5 do begin
    mas[12+2*(i-1), nomer]:=0;
    mas[13+2*(i-1), nomer]:=0;
  end;
  
  copyroom;  //  переход к уже созданным комнатам
end;

procedure nodoor;
begin
  if ld=1 then if mas[4,nomer] < 1 then enter:=-1 else enter:=1;
  if ld=2 then if mas[5,nomer] < 1 then enter:=-1 else enter:=1;
  if ld=3 then if mas[6,nomer] < 1 then enter:=-1 else enter:=1;
  if ld=4 then if mas[7,nomer] < 1 then enter:=-1 else enter:=1;
end;

{procedure loadbase;  // Загрузка данных из файла 
var i, j: integer;
begin
assign(t1,'database/database.txt');
reset(t1);
read(t1,str1);
write(str1);
a1:=length(str1);
while str1<>'' do begin
  while i <> 21 do begin
    
  end;
  read(t1,str1);
end;
close(t1);
end;}

procedure SaveGameInfo();
var i, j, k: integer;
begin
  assign(t1,'database/'+NamePlayer+'database.txt');
  append(t1);
  for k:=1 to nomer do begin
    for i:=-1 to 21 do 
      write(t1,mas[i,k],' ');
    for i:=1 to 5 do
      for j:=1 to 10 do begin
        write(t1, EnemysInfo[j, i],' ');
    end;
    writeln(t1);
  end;
  close(t1);
end;

//КНОПКИ И ПАНЕЛИ
 
var 
  objPanelMenu, objPanelLeftUp, objPanelHPandST, objPanelEnemy, objButtonInv, objButtonMenu, objPanelExperience, objMapButton, objSkillsButton, objActionButton, objQuestsButton: PictureABC;
  objEscapeMenu, ReturnToGameButton, SettingInGameButton, SaveInGameButton, ExitInGameButton: PictureABC;
  
procedure PanelMenu(sprite: PictureABC; x1, y1: integer);
begin
  sprite:= PictureABC.create(x1, y1, 'images/PanelMenu.png');
  objPanelMenu:= sprite;
end;

procedure EscapeMenu(sprite: PictureABC; x1, y1: integer);
begin
  sprite:= PictureABC.create(x1, y1, 'images/EscapeMenu.png');
  objEscapeMenu:= sprite;
end;

procedure ReturnToGameButton1(sprite: PictureABC; x1, y1: integer);
begin
  sprite:= PictureABC.create(x1, y1, 'images/ReturnToGameButton.png');
  ReturnToGameButton:= sprite;
end;

procedure SettingInGameButton1(sprite: PictureABC; x1, y1: integer);
begin
  sprite:= PictureABC.create(x1, y1, 'images/SettingInGameButton.png');
  SettingInGameButton:= sprite;
end;

procedure SaveInGameButton1(sprite: PictureABC; x1, y1: integer);
begin
  sprite:= PictureABC.create(x1, y1, 'images/SaveInGameButton.png');
  SaveInGameButton:= sprite;
end;

procedure ExitInGameButton1(sprite: PictureABC; x1, y1: integer);
begin
  sprite:= PictureABC.create(x1, y1, 'images/ExitInGameButton.png');
  ExitInGameButton:= sprite;
end;

procedure PanelHPandST(sprite: PictureABC; x1, y1: integer);
begin
  sprite:= PictureABC.create(x1, y1, 'images/PanelHPandST.png');
  objPanelHPandST:= sprite;
end;

procedure PanelExperience(sprite: PictureABC; x1, y1: integer);
begin
  sprite:= PictureABC.create(x1, y1, 'images/PanelExperience.png');
  objPanelExperience:= sprite;
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

procedure QuestsButton(sprite: PictureABC; x1, y1: integer);
begin
  sprite:= PictureABC.create(x1, y1, 'images/QuestsButton.png');
  objQuestsButton:= sprite;
end;

procedure MapButton(sprite: PictureABC; x1, y1: integer);
begin
  sprite:= PictureABC.create(x1, y1, 'images/MapButton.png');
  objMapButton:= sprite;
end;

procedure SkillsButton(sprite: PictureABC; x1, y1: integer);
begin
  sprite:= PictureABC.create(x1, y1, 'images/SkillsButton.png');
  objskillsButton:= sprite;
end;

procedure ActionButton(sprite: PictureABC; x1, y1: integer);
begin
  sprite:= PictureABC.create(x1, y1, 'images/ActionButton.png');
  objActionButton:= sprite;
end;

procedure pictload;
var i, j, iEnemy: integer;
begin
  xg:=0;
  yg:=440;
  for i := 1 to mas[1,nomer] do
    for j := 1 to mas[1,nomer] do begin
      masGraund(objGround[j+7*(i-1)],j+7*(i-1), xg, yg);
      for iEnemy:=1 to 5 do 
        if (mas[12+2*(iEnemy-1), nomer] <> 0)and(mas[13+2*(iEnemy-1), nomer] <> 0) then begin
          if (i=mas[12+2*(iEnemy-1), nomer])and(j=mas[13+2*(iEnemy-1), nomer])then begin
            Enemy(objEnemy[iEnemy], iEnemy, xg+20, yg-63, 1, 100);
            xe[iEnemy]:=xg+20;
            ye[iEnemy]:=yg-63;
          end;
        end;
      if (i = 1)and(j = mas[4,nomer])and(mas[4,nomer]>=1) then begin Door1(objDoor1[1],1,xg+22,yg-100); objDoor1[1].ToFront; end;  // p1
      if (j = mas[1,nomer])and(i = mas[5,nomer])and(mas[5,nomer]>=1) then begin Door2(objDoor2[1],1,xg+27,yg-75); objDoor2[1].ToFront; end;  // p2
      if (i = mas[1,nomer])and(j = mas[6,nomer])and(mas[6,nomer]>=1) then begin Door1(objDoor1[2],2,xg+22,yg-50); objDoor1[2].ToFront; end;  // p3
      if (j = 1)and(i = mas[7,nomer])and(mas[7,nomer]>=1) then begin Door2(objDoor2[2],2,xg-22,yg-50); objDoor2[2].ToFront; end;  // p4
      if (mas[10, nomer] <> 0)and(mas[11, nomer] <> 0) then 
        if (i = mas[10, nomer])and(j = mas[11, nomer]) then begin
          chestWithItem(objchestWithItem, xg+10, yg-35);
          objChestWithItem.Scale(0.8);
        end;
      if (mas[8, nomer]<>0)and(mas[9, nomer]<>0) then 
        if (i = mas[8, nomer])and(j = mas[9, nomer]) then begin
          WellForResurrection(objWellForResurrection, xg+10, yg-37);
          objWellForResurrection.Scale(0.8);
        end;
      xg := xg + 50;
      yg := yg - 25;
      if j = mas[1,nomer] then begin xg := 50 * i; yg := 440 + 25 * i; end;
    end;
end;

procedure AllMapPlayer();
var i, j, XNumber, YNumber: integer;
begin
  if (scene='Map')and(workMap=false) then begin
    workMap:=true;
    xr:=325;
    yr:=300;
    for i:=1 to nomer do begin
      {if mas[-1, nomer] + 1 = lastXr then begin lastXr:=mas[-1,i]; xr:=xr - 26; yr:=yr + 13; end;  // Переписывай код, проблема при переходе в другие комнаты
      if mas[0,i] + 1 = lastYr then begin lastYr:=mas[0,i]; xr:=xr - 26; yr:=yr - 13 ; end;
      if mas[-1, nomer] - 1 = lastXr then begin lastXr:=mas[-1,i]; xr:=xr + 26; yr:=yr - 13; end;
      if mas[0,i] - 1 = lastYr then begin lastYr:=mas[0,i]; xr:=xr + 26; yr:=yr + 13 ; end;}
      MapRoom(objMapRoom[i], i, xr, yr);
    end;
  end;
end;

procedure CloseMap();
var i, j: integer;
begin
  for i:=1 to nomer do begin objMapRoom[i].Destroy; end;
  workMap:=false;
  scene:='FightPlayer';
  key1:=0;
end;

procedure OpenDoor();
var i, j: integer;
begin
  nodoor; 
  if ld = 1 then begin
    objPlayer.Destroy;
    xp:=100;
    yp:=100;
    Player(objPlayer, 1, xp, yp);
  end;
  if mas[4,nomer]<>0 then ObjDoor1[1].Destroy;
  if mas[5,nomer]<>0 then ObjDoor2[1].Destroy;
  if mas[6,nomer]<>0 then ObjDoor1[2].Destroy;
  if mas[7,nomer]<>0 then ObjDoor2[2].Destroy;
  if enter=1 then begin 
    for i:=1 to 5 do 
      if (mas[12+2*(i-1), nomer]<>0)and(mas[13+2*(i-1), nomer]<>0)then begin
        objEnemy[i].Destroy;
      end;
    
    for i:=sqr(mas[1, nomer]) downto 1 do begin
      objGround[i].Destroy;
    end;
    
    generateroom; pictload;
    objPlayer.ToFront;
  end;
  enter:=-1;
end;

procedure GoDoor(xm, ym, mb: integer);
begin
  if mas[4, nomer]<>0 then if (objDoor1[1].PtInside(xm, ym)= true)and(objDoor1[1].Intersect(objPlayer)= true) then begin ld:=1; OpenDoor(); end;
  if mas[5, nomer]<>0 then if (objDoor2[1].PtInside(xm, ym)= true)and(objDoor2[1].Intersect(objPlayer)= true) then begin ld:=2; OpenDoor(); end;
  if mas[6, nomer]<>0 then if (objDoor1[2].PtInside(xm, ym)= true)and(objDoor1[2].Intersect(objPlayer)= true) then begin ld:=3; OpenDoor(); end;
  if mas[7, nomer]<>0 then if (objDoor2[2].PtInside(xm, ym)= true)and(objDoor2[2].Intersect(objPlayer)= true) then begin ld:=4; OpenDoor(); end;
end;

procedure testBorders(xp, yp: integer);
var i, j, xp1, xp2, yp1, yp2: integer;
begin 
  if xp <= 350 then begin
    yp1:=465 - xp div 2;
    yp2:=462 + xp div 2;
  end;
  if xp >= 350 then begin
    yp1:=465 - (700 - xp) div 2;
    yp2:=462 + (700 - xp) div 2;
  end;
  if (yp>yp1)and(yp<yp2) then borders := false 
  else borders := true;
end;

procedure movePlayer(time, xm, ym: integer);
var i, j:integer;
begin
  testBorders(xp+23, yp+80);
  if borders = false then begin
    lastXP:=xp;
    lastYP:=yp;
    if (xp+23<xm) then begin xp:= xp+spPlayer; accept:=false; end else begin accept:=true; end;
    if (xp+23>xm) then begin xp:= xp-spPlayer; accept:=false; end else begin accept:=true; end;
    if (yp+80<ym) then begin yp:= yp+spPlayer; accept:=false; end else begin accept:=true; end;
    if (yp+80>ym) then begin yp:= yp-spPlayer; accept:=false; end else begin accept:=true; end; 
    objPlayer.MoveTo(xp, yp);
  end else if borders = true then begin
    xp:= lastXP;
    yp:= LastYP;
    objPlayer.MoveTo(xp, yp);
    testBorders(xp+23, yp+80);
  end;
end;

procedure mouseDownGame(xm, ym, mb: integer);
begin
if (scene='FightPlayer') then 
  case mb of
    1:begin 
      mb1:= 1; xm1:= xm; ym1:= ym;
    end;
  end;
end;

// ИНВЕНТАРЬ 

var 
  coli, col, number, nomerObjX, nomerObjY, lastnumber, lastX, lastY, lastNameInfo, InfoName, obmenInfoInt, timeUp, TypeInv, lastTypeInv, objOn1, lastObjOn1: integer;
  xi, yi, xi1, yi1, xt, yt, xi2, yi2: integer;
  workObj, workObj1: boolean;
  objInventar, Obj1, obmenInfoPict: PictureABC;
  txt1: TextABC;
  lastInfo, obmenInfoStr: string;
  
  masInfo: array[0..20,1..66] of string;
  masObj: array[0..66] of PictureABC;
  masObjNumber: array[0..66] of integer;
  masPlayerInfo: array[0..20] of integer;
  masPInfo: array[0..20] of TextABC;
  masTxt: array[1..9] of TextABC;  

procedure readinfo();
var i, j, len: integer;
begin
  assign(t1,'database\'+NamePlayer+'\inventar.txt');
  reset(t1);
  i:=0;
  j:=1;
  coli:=0;
  read(t1,str1);
  while str1<>'' do begin
    coli:=coli+1;
    len:=length(str1);
    while (1=1)and(str1<>'') do begin
      i:=i+1;
      if len=1 then begin masInfo[j,coli]:=copy(str1,1,1); delete(str1,1,1); str(j,masInfo[0,coli]); i:=0; break; end;
      if (str1[i]=' ') then begin masInfo[j,coli]:=copy(str1,1,i-1); delete(str1,1,i); i:=0; j:=j+1; len:=length(str1); end; 
    end;
    j:=1;
    readln(t1);
    read(t1,str1);
  end;
  close(t1);
end;

procedure writeinfo();
var i, j: integer;
begin
  assign(t1,'database\'+NamePlayer+'\inventar.txt');
  rewrite(t1);
  for i:=1 to 66 do 
    for j:=1 to 13 do begin
      write(t1,masInfo[j,i],' ');
      if j = 13 then writeln(t1);
    end;
  close(t1);
end;

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

procedure ChestArmor(sprite: PictureABC; number, x1, y1: integer);  // Нагрудники
begin
  sprite:= PictureABC.create(x1, y1, 'images/chest armor.png');
  masObj[number]:= sprite;
  masObjNumber[number]:=number;
end;

procedure Pants(sprite: PictureABC; number, x1, y1: integer);  // Штаны
begin
  sprite:= PictureABC.create(x1, y1, 'images/pants.png');
  masObj[number]:= sprite;
  masObjNumber[number]:=number;
end;

procedure Ring(sprite: PictureABC; number, x1, y1: integer);  // Кольца
begin
  sprite:= PictureABC.create(x1, y1, 'images/Ring.png');
  masObj[number]:= sprite;
  masObjNumber[number]:=number;
end;

procedure Necklace(sprite: PictureABC; number, x1, y1: integer);  // Ожерелье
begin
  sprite:= PictureABC.create(x1, y1, 'images/Necklace.png');
  masObj[number]:= sprite;
  masObjNumber[number]:=number;
end;

procedure ShoulderStraps(sprite: PictureABC; number, x1, y1: integer);  // Наплечники
begin
  sprite:= PictureABC.create(x1, y1, 'images/Shoulder Straps.png');
  masObj[number]:= sprite;
  masObjNumber[number]:=number;
end;

procedure Boots(sprite: PictureABC; number, x1, y1: integer);  // Ботинки
begin
  sprite:= PictureABC.create(x1, y1, 'images/Boots.png');
  masObj[number]:= sprite;
  masObjNumber[number]:=number;
end;

procedure loadobject();
var i, j: integer;
begin
  Inventar(objInventar, 0, 0); 
  for i:=1 to 48 do begin
    if masInfo[1, i]<>'.' then begin
      val(masInfo[12,i],xi1,code);
      val(masInfo[13,i],yi1,code);
      xi:=13+51*xi1;
      yi:=64+51*yi1;
      if masInfo[1,i]='Sword' then begin Sword(masObj[i], i, xi, yi); end;
      if masInfo[1,i]='Helmet' then begin Helmet(masObj[i], i, xi, yi); end;
      if masInfo[1,i]='ChestArmor' then begin ChestArmor(masObj[i], i, xi, yi); end;
      if masInfo[1,i]='Pants' then begin Pants(masObj[i], i, xi, yi); end;
      if masInfo[1,i]='Ring' then begin Ring(masObj[i], i, xi, yi); end;
      if masInfo[1,i]='Necklace' then begin Necklace(masObj[i], i, xi, yi); end;
      if masInfo[1,i]='ShoulderStraps' then begin ShoulderStraps(masObj[i], i, xi, yi); end;
      if masInfo[1,i]='Boots' then begin Boots(masObj[i], i, xi, yi); end;
    end;
  end;
  for i:=49 to 66 do begin
    if masInfo[1, i]<>'.' then begin
      val(masInfo[12,i],xi1,code);
      val(masInfo[13,i],yi1,code);
      xi:=484+51*xi1;
      yi:=64+51*yi1;
      if masInfo[1,i]='Sword' then begin Sword(masObj[i], i, xi, yi); end;
      if masInfo[1,i]='Helmet' then begin Helmet(masObj[i], i, xi, yi); end;
      if masInfo[1,i]='ChestArmor' then begin ChestArmor(masObj[i], i, xi, yi); end;
      if masInfo[1,i]='Pants' then begin Pants(masObj[i], i, xi, yi); end;
      if masInfo[1,i]='Ring' then begin Ring(masObj[i], i, xi, yi); end;
      if masInfo[1,i]='Necklace' then begin Necklace(masObj[i], i, xi, yi); end;
      if masInfo[1,i]='ShoulderStraps' then begin ShoulderStraps(masObj[i], i, xi, yi); end;
      if masInfo[1,i]='Boots' then begin Boots(masObj[i], i, xi, yi); end;
    end;
  end;
end;

procedure closeinventar();
var i, j, NOX, NOY: integer;
begin
  for i:=1 to 48 do 
    if masInfo[1, i]<> '.' then begin
      val(masInfo[12, i], NOX, code);
      val(masInfo[13, i], NOY, code);
      masObj[masobjnumber[NOX+8*(NOY-1)]].Destroy;
    end;
  for i:=49 to 66 do 
    if masInfo[1, i]<> '.' then begin
      val(masInfo[12, i], NOX, code);
      val(masInfo[13, i], NOY, code);
      masObj[masobjnumber[48+NOX+2*(NOY-1)]].Destroy;
      {for j:=3 to 11 do
        if masInfo[j, i]<>'.' then masTxT[j-2].Destroy;}
    end; 
 { for i:=1 to 10 do 
    masPInfo[i].Destroy; }
  //txt1.Destroy;
  objInventar.Destroy;
  sum:=0;
  frame:=0; 
  writeinfo();
  scene:='FightPlayer';
  xm1:= xp+23; ym1:= yp+80;
  key1:=0;
end;

procedure mousedownInv(xm, ym, mb: integer);
begin
  case mb of
    1:begin xm1:= xm; ym1:= ym; if (xm1>=637)and(xm1<=647)and(ym1>=89)and(ym1<=99)then closeinventar(); end;
  end;
end;

procedure ObjInfo();
var i, j: integer;
begin
  if (lastnumber=0)and(masInfo[1,number]<>'.') then begin
    for i:= 3 to 11 do 
      if masInfo[i,number]<>'.' then 
        masTxt[i-2] := new TextABC(236, 449+13*(i-3), 10, masInfo[i, number], clBlack);
    txt1 := new TextABC(236, 436, 10, 'Text.txt', clBlack);
    lastnumber:=number;
  end
  else 
    if (lastnumber<>number)and(lastnumber<>0) then begin 
      for i:=1 to 9 do begin if masInfo[i+2,number]<>'.' then masTxT[i].Destroy; end;  // Проблема в удалении несуществующего текста, проверка на наличие!!!
      txt1.Destroy;
      txt1 := new TextABC(236, 436, 10, 'Text.txt', clBlack);
      for i:= 3 to 11 do 
        if masInfo[i,number]<>'.' then 
        masTxt[i-2] := new TextABC(236, 449+13*(i-3), 10, masInfo[i, number], clBlack);
      lastnumber:=number;
    end;
end;

procedure PlayerInfoInv();
var i, j: integer;
begin
if scene = 'inventar' then begin
  for i:=1 to 10 do begin
    masPlayerInfo[i]:= i;
  end;
  for i:=49 to 66 do begin
    if masInfo[1, i]='Sword' then begin
      str1:=masInfo[3, i];
      val(str1[2], obmenInfoInt, code);
      masPlayerInfo[7]:= masPlayerInfo[7] + obmenInfoInt;
    end;
    if (masInfo[1, i]='Helmet')or(masInfo[1, i]='ChestArmor')or(masInfo[1, i]='Pants')or(masInfo[1, i]='ShoulderStraps')or(masInfo[1,i]='Boots') then begin
      str1:=masInfo[3, i];
      val(str1[2], obmenInfoInt, code);
      masPlayerInfo[8]:= masPlayerInfo[8] + obmenInfoInt;
    end;
    if (masInfo[1, i]='Ring')or(masInfo[1, i]='Necklace') then begin
    end;
    if masInfo[1,i]<>'.' then inc(objOn1);
  end;
  
  if sum=0 then begin
    for i:=1 to 10 do begin
      str(masPlayerInfo[i], str1);
      maspInfo[i] := new TextABC(193, 433+15*(i-1), 9, str1, clBlack);
    end;
    sum:=1;
  end;  
  
  if (objOn1<>lastObjOn1){and(lastObjOn1<>0){or(objOn1<>0)} then begin // Стату чини, дублируется число, проблема в полной отчистке !
    for i:=1 to 10 do begin
      maspInfo[i].Destroy;
    end;
    {for i:=1 to 10 do begin
      str(masPlayerInfo[i], str1);
      maspInfo[i] := new TextABC(193, 433+15*(i-1), 9, str1, clBlack);
    end;}
    lastObjOn1:= objOn1;  
  end;  

end;  
end;

procedure NameObj();
begin
  if masInfo[1, number]='Sword' then infoName:=1;
  if masInfo[1, number]='Helmet' then infoName:=6;
  if masInfo[1, number]='ChestArmor' then infoName:=7;
  if masInfo[1, number]='Pants' then infoName:=9;
  if masInfo[1, number]='Ring' then infoName:=5;
  if masInfo[1, number]='Necklace' then infoName:=4;
  if masInfo[1, number]='ShoulderStraps' then infoName:=8;
  if masInfo[1, number]='Boots' then infoName:=10;
end;

procedure LastNameObj();
begin
  if 48+nomerObjX+2*(nomerObjY-1) = 49 then lastNameInfo:= 1; 
  if 48+nomerObjX+2*(nomerObjY-1) = 50 then lastNameInfo:= 6; 
  if 48+nomerObjX+2*(nomerObjY-1) = 51 then lastNameInfo:= 1; 
  if 48+nomerObjX+2*(nomerObjY-1) = 52 then lastNameInfo:= 7; 
  if 48+nomerObjX+2*(nomerObjY-1) = 53 then lastNameInfo:= 2; 
  if 48+nomerObjX+2*(nomerObjY-1) = 54 then lastNameInfo:= 8; 
  if 48+nomerObjX+2*(nomerObjY-1) = 66 then lastNameInfo:= 2; 
  if 48+nomerObjX+2*(nomerObjY-1) = 56 then lastNameInfo:= 9; 
  if 48+nomerObjX+2*(nomerObjY-1) = 57 then lastNameInfo:= 3; 
  if 48+nomerObjX+2*(nomerObjY-1) = 58 then lastNameInfo:= 10; 
  if 48+nomerObjX+2*(nomerObjY-1) = 59 then lastNameInfo:= 3; 
  if 48+nomerObjX+2*(nomerObjY-1) = 60 then lastNameInfo:= 11; 
  if 48+nomerObjX+2*(nomerObjY-1) = 61 then lastNameInfo:= 4; 
  if 48+nomerObjX+2*(nomerObjY-1) = 62 then lastNameInfo:= 4; 
  if 48+nomerObjX+2*(nomerObjY-1) = 63 then lastNameInfo:= 5; 
  if 48+nomerObjX+2*(nomerObjY-1) = 64 then lastNameInfo:= 5; 
  if 48+nomerObjX+2*(nomerObjY-1) = 65 then lastNameInfo:= 5; 
  if 48+nomerObjX+2*(nomerObjY-1) = 66 then lastNameInfo:= 5; 
end;

procedure cordObj1(xm, ym: integer);
var i, j: integer;
begin
  if(xm>=65)and(xm<=65+51*8)and(ym>=113)and(ym<=113+51*6) then begin
    TypeInv:=1;
    nomerObjX:= (xm-65) div 51+1;
    nomerObjY:= (ym-115) div 51+1;
    for i:=1 to coli do  begin
      val(masInfo[12,i],xi1,code);
      val(masInfo[13,i],yi1,code);
      if(nomerObjX=xi1)and(nomerObjY=yi1)and(masInfo[1,i]<>'.') then begin
        number:=xi1+8*(yi1-1); 
        workObj1 := True; break; 
        end
      else workObj1 := False;
    end;
  end
  else if(xm>=535)and(xm<=535+51*2)and(ym>=115)and(ym<=115+51*9) then begin
    TypeInv:=2;
    nomerObjX:= (xm-535) div 51+1;
    nomerObjY:= (ym-115) div 51+1;
    for i:=48 to coli do  begin
      val(masInfo[12,i],xi1,code);
      val(masInfo[13,i],yi1,code);
      if(nomerObjX=xi1)and(nomerObjY=yi1)and(masInfo[1,i]<>'.') then begin
        number:=48+nomerObjX+2*(nomerObjY-1); 
        workObj1 := True; break; end
      else workObj1 := False;
    end;
  end;  
end;

procedure ObjMove(xm, ym, mb: integer);
var i, j: integer;
begin
  if scene = 'inventar' then begin
    if workObj= true then begin 
      cordObj1(xm, ym);
      if workObj1 = True then objInfo;
    end;
    case mb of 
      1: if workObj1 = True then begin masObj[masobjnumber[number]].MoveTo(xm-30, ym-30); NameObj(); workObj:= False; end;
    end;
  end;
end;

procedure workObjOn(xm, ym, mb: integer);
var i, j: integer;
begin
  lastnumber:= number;
  lastX:= nomerobjX;
  lastY:= nomerobjY;
  lastTypeInv:= TypeInv;
  workObj:= True;
  cordObj1(xm, ym);
  LastNameObj;
  if lastTypeInv = 1 then begin 
    if typeInv = 1 then begin
      if masobjnumber[lastnumber]<>0 then begin
        masObj[masobjnumber[lastnumber]].moveTo(15+51*nomerobjX,64+51*nomerobjY);
        if (masInfo[1,nomerObjX+8*(nomerObjY-1)]<>'.') then masObj[masobjnumber[nomerObjX+8*(nomerObjY-1)]].moveTo(15+51*lastX,64+51*lastY);
          for j:=0 to 14 do begin
            if (j=12)or(j=13) then begin end else if (j<>12)or(j<>13)or(j<>14) then begin
              obmenInfoStr:=masInfo[j,nomerObjX+8*(nomerObjY-1)]; masInfo[j,nomerObjX+8*(nomerObjY-1)]:=masInfo[j,lastnumber]; masInfo[j,lastnumber]:=obmenInfoStr;
            end;
            obmenInfoInt:=masObjNumber[nomerObjX+8*(nomerObjY-1)]; masObjNumber[nomerObjX+8*(nomerObjY-1)]:= masObjNumber[lastnumber]; masObjNumber[lastnumber]:=obmenInfoInt;
            writeinfo();
          end;
        end;  
     end else if LastNameInfo = InfoName then begin
     if masobjnumber[lastnumber]<>0 then begin
       masObj[masobjnumber[lastnumber]].moveTo(484+51*nomerobjX,64+51*nomerobjY);
         if (masInfo[1,48+nomerObjX+2*(nomerObjY-1)]<>'.') then masObj[masobjnumber[48+nomerObjX+2*(nomerObjY-1)]].moveTo(15+51*lastX,64+51*lastY);
           for j:=0 to 14 do begin
             if (j=12)or(j=13) then begin end else if (j<>12)or(j<>13)or(j<>14) then begin
               obmenInfoStr:=masInfo[j,48+nomerObjX+2*(nomerObjY-1)]; masInfo[j,48+nomerObjX+2*(nomerObjY-1)]:=masInfo[j,lastnumber]; masInfo[j,lastnumber]:=obmenInfoStr;
             end;
             obmenInfoInt:=masObjNumber[48+nomerObjX+2*(nomerObjY-1)]; masObjNumber[48+nomerObjX+2*(nomerObjY-1)]:= masObjNumber[lastnumber]; masObjNumber[lastnumber]:=obmenInfoInt;
             writeinfo();
           end;
         end;
      end else begin masObj[masobjnumber[lastnumber]].MoveTo(15+51*lastX,64+51*lastY); end;
  end else begin
      if typeInv = 1 then begin
      if masobjnumber[lastnumber]<>0 then begin
        masObj[masobjnumber[lastnumber]].moveTo(15+51*nomerobjX,64+51*nomerobjY);
        if (masInfo[1,nomerObjX+8*(nomerObjY-1)]<>'.') then masObj[masobjnumber[nomerObjX+8*(nomerObjY-1)]].moveTo(484+51*lastX,64+51*lastY);
          for j:=0 to 14 do begin
            if (j=12)or(j=13) then begin end else if (j<>12)or(j<>13)or(j<>14) then begin
              obmenInfoStr:=masInfo[j,nomerObjX+8*(nomerObjY-1)]; masInfo[j,nomerObjX+8*(nomerObjY-1)]:=masInfo[j,lastnumber]; masInfo[j,lastnumber]:=obmenInfoStr;
            end;
            obmenInfoInt:=masObjNumber[nomerObjX+8*(nomerObjY-1)]; masObjNumber[nomerObjX+8*(nomerObjY-1)]:= masObjNumber[lastnumber]; masObjNumber[lastnumber]:=obmenInfoInt;
            writeinfo();
          end;
        end;
      end else if LastNameInfo = InfoName then begin
      if masobjnumber[lastnumber]<>0 then begin
        masObj[masobjnumber[lastnumber]].moveTo(484+51*nomerobjX,64+51*nomerobjY);
        if (masInfo[1,48+nomerObjX+2*(nomerObjY-1)]<>'.') then masObj[masobjnumber[48+nomerObjX+2*(nomerObjY-1)]].moveTo(484+51*lastX,64+51*lastY);
          for j:=0 to 14 do begin
            if (j=12)or(j=13) then begin end else if (j<>12)or(j<>13)or(j<>14) then begin
              obmenInfoStr:=masInfo[j,48+nomerObjX+2*(nomerObjY-1)]; masInfo[j,48+nomerObjX+2*(nomerObjY-1)]:=masInfo[j,lastnumber]; masInfo[j,lastnumber]:=obmenInfoStr;
            end;
            obmenInfoInt:=masObjNumber[48+nomerObjX+2*(nomerObjY-1)]; masObjNumber[48+nomerObjX+2*(nomerObjY-1)]:= masObjNumber[lastnumber]; masObjNumber[lastnumber]:=obmenInfoInt;
            writeinfo();
          end;
        end;
      end else if masobjnumber[lastnumber]<>0 then begin masObj[masobjnumber[lastnumber]].MoveTo(484+51*lastX,64+51*lastY); end;
  end; 
end;

procedure LoadInventar();
var i, j:integer;
begin
  readinfo();
  //writeinfo();
  loadobject();
end;

procedure ImportantPartProgramInv();
begin
  if scene='inventar' then begin
    workObj:= True;
  
    Loadinventar;
    //playerInfoInv;
  
    onmousedown:= mouseDownInv;
    onmouseMove:= objMove;
    onmouseup:= workObjOn;
  end;
end;

// Взаимодействие с монстром и генерация его инвентаря
var 
  speedAttackPlayer, LastHPPlayer, HPPlayer, MaxHPPlayer, DamagePlayer,  ProtectPlayer, LvlPlayer, LastLvlPlayer, ExperiencePlayer, Experience, LastExperience, lastExperiencePlayer, MoneyPlayer, lastMoneyPlayer: integer;
  LvlEnemy, ProtectEnemy, DamageEnemy, HPEnemy, speedAttackEnemy, ExperienceEnemy, MoneyEnemy: integer;
  timeToAttack, timeToFightEffect, SpawnMobTime: integer;
  xEX, yEX: integer;
  infoPanelPlayerAllowMoney, infoPanelPlayerAllowLvl, infoPanelPlayerAllowNickName: boolean;
  
procedure FightEffect(sprite: PictureABC; number, x1, y1: integer);
begin
  sprite:= PictureABC.create(x1, y1, 'images/FightEffect.png');
  objFightEffect[number]:= sprite;
end;

procedure createHPPlayer(sprite: PictureABC; number, x1, y1: integer);
begin
  sprite:= PictureABC.create(x1, y1, 'images/HP.png');
  objHPPlayer[number]:= sprite;
end;

procedure createEXPlayer(sprite: PictureABC; number, x1, y1: integer);
begin
  sprite:= PictureABC.create(x1, y1, 'images/Experience.png');
  objEXPlayer[number]:= sprite;
end;

procedure FindiEnemy(xm, ym: integer);
var i, j: integer;
begin
  for i:=1 to 5 do begin
    if (mas[12+2*(i-1), nomer]<>0)and(mas[13+2*(i-1), nomer]<>0) then 
      if objEnemy[i].PtInside(xm, ym)=true then begin
        iEnemy:=i;
        break;
      end;
  end;
end;

procedure readInfoPlayer();  // Чтение информации из файла
var i, j: integer;
begin 
  assign(t1,'database/'+NamePlayer+'/playerInfo.txt');
  reset(t1);
  read(t1,str1);
  while str1<>'' do begin
    i:=i+1;
    playerInfo[i]:=str1;
    readln(t1);
    read(t1,str1);
  end;
  close(t1);
end;

procedure writeInfoPlayer;  // Загрузка информации игрока в файл
var i, j: integer;
begin 
  assign(t1,'database/'+NamePlayer+'/playerinfo.txt');
  rewrite(t1);
  for i:= 1 to 13 do
    writeln(t1, PlayerInfo[i]);
  close(t1);
end;

procedure BeginHPPlayer();  //Создание полосы здоровья игрока
var i, j, NumberHP: integer;
begin
  x1:=107;
  y1:=645;
  val(PlayerInfo[4], MaxHPPlayer, code);
  val(PlayerInfo[3], HPPlayer, code);
  NumberHP:= HPPlayer * 810 div MaxHPPlayer;
  for i:=1 to NumberHP do begin
    y1:=y1+2;
    createHPPlayer(objHPPlayer[i], i, x1, y1);
    if i mod 18 = 0 then begin x1:=x1+2; y1:=645; end;
  end;
end;

procedure ReadLVLPlayer();  //Создание и обновление полосы опыта игрока
var i, i1, i2, j, Lvl: integer;
begin
  val(PlayerInfo[2], ExperiencePlayer, code);
  LvlPlayer:=0;
  lvl:=1;
  Experience:= 10;
  while LvlPlayer=0 do begin
    if (ExperiencePlayer <= Experience) then begin
      lvlPlayer:= lvl;
      if LastExperiencePlayer = 0 then begin
        //write('0');
        for i:=1 to ExperiencePlayer * 1044 div Experience do begin
          CreateEXPlayer(objEXPlayer[i], i, xEX, yEX);
          yEX:= yEX+2;
          if i mod 3 = 0 then begin xEX:=xEX+2; yEX:=692; end;
        end;
      end
      else begin 
        if lastExperience > ExperiencePlayer then begin
          //write('1');
          for i:=lastExperiencePlayer * 1044 div LastExperience to ExperiencePlayer * 1044 div lastExperience do begin
            CreateEXPlayer(objEXPlayer[i], i, xEX, yEX);
            yEX:= yEX+2;
            if i mod 3 = 0 then begin xEX:=xEX+2; yEX:=692; end;
          end;
        end
        else begin
          //write('2');
          for i:=lastExperiencePlayer * 1044 div LastExperience to 1044 do begin
            CreateEXPlayer(objEXPlayer[i], i, xEX, yEX);
            yEX:= yEX+2;
            if i mod 3 = 0 then begin xEX:=xEX+2; yEX:=692; end;
          end;
          xEX:= 2;
          yEX:= 692;
          for i:=1044 downto 1 do
            objExPlayer[i].Destroy;
          for i:=1 to (ExperiencePlayer-lastExperience) * 1044 div Experience do begin
            CreateEXPlayer(objEXPlayer[i], i, xEX, yEX);
            yEX:= yEX+2;
            if i mod 3 = 0 then begin xEX:=xEX+2; yEX:=692; end;
          end;
        end;
      end;
      break;
    end;
    Lvl:= lvl+1;
    Experience:= Experience + Experience * 5 div 3;
  end;
  //write(lvlPlayer,' ', ExperiencePlayer,'/', Experience);
end;

// Генерация инвентаря и статистики монстра

procedure RandomEnemy();
var iEnemy1, randomNumber: integer;
begin
  for iEnemy1:=1 to 5 do begin
    if (mas[12+2*(iEnemy1-1), nomer]<>0)or(mas[13+2*(iEnemy1-1), nomer]<>0) then begin
      randomNumber:= random(1)+1;
      if randomNumber = 1 then EnemysInfo[1,iEnemy1]:='zombie';
    end;
  end;
end;

// Информация об враге 
// 1 - Тип монстра
// 2 - Количество опыта
// 3 - Количество Здоровья
// 4 - Макс здоровье
// 5 - Количество Выносливости
// 6 - Макс выносливости 
// 7 - Урон
// 8 - Защита 
// 9 - Скорость атаки
// 10 - Титул монсра 

procedure GenerationEnemysByPlayer();  // Генерация статистики монстров относительно уровня игрока
var i, j: integer;
begin
  RandomEnemy();
  if lvlPlayer = 1 then begin LvlEnemy:= lvlPlayer; end
  else begin lvlEnemy:= random(lvlPlayer)+lvlPlayer div 2; end;
  ExperienceEnemy:=Experience div 10 + Random(Experience div 10)+1;
  for i:=1 to 5 do 
    if (mas[12+2*(i-1), nomer]<>0)and(mas[13+2*(i-1), nomer]<>0) then begin
      str(ExperienceEnemy, EnemysInfo[2,i]);
      if EnemysInfo[1,i] = 'zombie' then begin  // Варианты хп и типов
        HPenemy:= 15*LvlEnemy+random(5*lvlEnemy)+1; str(HPEnemy, EnemysInfo[3,i]);  // Здоровье 
        str(HPEnemy, EnemysInfo[4,i]);
        DamageEnemy:= 2*lvlEnemy+random(lvlEnemy div 2)+1; str(DamageEnemy, EnemysInfo[7,i]);  // Урон
        ProtectEnemy:= 3*LvlEnemy+random(lvlEnemy div 2)+1; str(ProtectEnemy, EnemysInfo[8,i]);  // Защита
        SpeedAttackEnemy:=100+random(10)-10; str(SpeedAttackEnemy, EnemysInfo[9,i]);   // Скорость атаки
        str1:='Обычный';
        str(str1, EnemysInfo[10,i]);
      end;
    end;
end;

procedure GenerationItemsEnemys();  // Генерация предметов у монстров 
var i, j, k, randomNumber, iEnemy1, RN: integer;
begin
  for iEnemy1:=1 to 5 do 
    if (mas[12+2*(iEnemy1-1), nomer]<>0)and(mas[13+2*(iEnemy1-1), nomer]<>0) then begin
  for i:= 1 to 12 do begin
    randomNumber:= random(21)-10;
    if (randomNumber>0)and(randomNumber<>2)and(randomNumber<>3)and(randomNumber<>4)and(randomNumber<>5)then begin 
      if randomNumber=1 then begin
        EnemysInventar[i, 1, iEnemy1]:= 'Sword';  // Типы предметов 
        
        DamageEnemy:= (DamageEnemy div 2) + random(DamageEnemy div 5)+1;
        str(DamageEnemy, str1);
        EnemysInventar[i, 3, iEnemy1]:= 'D'+ str1;
      end
      else if randomNumber = 6 then begin
        EnemysInventar[i, 1, iEnemy1]:= 'Helmet';
        
        ProtectEnemy:= (ProtectEnemy div 2) + random(ProtectEnemy div 5)+1;
        str(ProtectEnemy, str1);
        EnemysInventar[i, 3, iEnemy1]:= 'P'+ str1;
      end
      else if randomNumber = 7 then begin
        EnemysInventar[i, 1, iEnemy1]:= 'ChestArmor';
        
        ProtectEnemy:= (ProtectEnemy div 2) + random(ProtectEnemy div 5)+1;
        str(ProtectEnemy, str1);
        EnemysInventar[i, 3, iEnemy1]:= 'P'+ str1;
      end 
      else if randomNumber = 8 then begin
        EnemysInventar[i, 1, iEnemy1]:= 'ShoulderStraps';
        
        ProtectEnemy:= (ProtectEnemy div 2) + random(ProtectEnemy div 5)+1;
        str(ProtectEnemy, str1);
        EnemysInventar[i, 3, iEnemy1]:= 'P'+ str1;
      end 
      else if randomNumber = 9 then begin
        EnemysInventar[i, 1, iEnemy1]:= 'Pants';
        
        ProtectEnemy:= (ProtectEnemy div 2) + random(ProtectEnemy div 5)+1;
        str(ProtectEnemy, str1);
        EnemysInventar[i, 3, iEnemy1]:= 'P'+ str1;
      end 
      else if randomNumber = 10 then begin
        EnemysInventar[i, 1, iEnemy1]:= 'Boots';
        
        ProtectEnemy:= (ProtectEnemy div 2) + random(ProtectEnemy div 5)+1;
        str(ProtectEnemy, str1);
        EnemysInventar[i, 3, iEnemy1]:= 'P'+ str1;
      end
      else if randomNumber = 4 then begin
        EnemysInventar[i, 1, iEnemy1]:= 'Necklace';
        
        {ProtectEnemy:= (ProtectEnemy div 2) + random(ProtectEnemy div 5)+1;
        str(ProtectEnemy, str1);
        EnemysInventar[i, 3, iEnemy1]:= 'P'+ str1;}
      end
      else if randomNumber = 5 then begin
        EnemysInventar[i, 1, iEnemy1]:= 'Ring';
        
        {ProtectEnemy:= (ProtectEnemy div 2) + random(ProtectEnemy div 5)+1;
        str(ProtectEnemy, str1);
        EnemysInventar[i, 3, iEnemy1]:= 'P'+ str1;}
      end
      else if randomNumber = 2 then begin
        {EnemysInventar[i, 1, iEnemy1]:= 'Щит';
        
        ProtectEnemy:= (HPEnemy div 10) + random(HPEnemy div 10)+1;
        str(ProtectEnemy, str1);
        EnemysInventar[i, 3, iEnemy1]:= 'P'+ str1;}
      end
      else if randomNumber = 3 then begin
        {EnemysInventar[i, 1, iEnemy1]:= 'усиление';
        
        ProtectEnemy:= (HPEnemy div 10) + random(HPEnemy div 10)+1;
        str(ProtectEnemy, str1);
        EnemysInventar[i, 3, iEnemy1]:= 'P'+ str1;}
      end;
     
      str(randomnumber, EnemysInventar[i, 2, iEnemy1]);
      EnemysInventar[i, 4, iEnemy1]:= 'S' ;
      EnemysInventar[i, 5, iEnemy1]:= 'L' ;
      EnemysInventar[i, 6, iEnemy1]:= 'I' ;
      if EnemysInventar[i, 1, iEnemy1]= 'Sword' then begin 
        str(random(lvlEnemy div 5), str1);
        EnemysInventar[i, 7, iEnemy1]:= '+SP'+str1;
      end
        else EnemysInventar[i, 7, iEnemy1]:= '+SP0';
        
      for j:=1 to 5 do begin
        {RN:= random(100);
        if RN>50 then begin 
          if EnemysInventar[i, 1, iEnemy1]= 'Sword' then str2:='D' else 
          if (EnemysInventar[i, 1, iEnemy1]= 'Helmet')or(EnemysInventar[i, 1, iEnemy1]= 'Boots')or(EnemysInventar[i, 1, iEnemy1]= 'ChestArmor')or(EnemysInventar[i, 1, iEnemy1]= 'Pants')or(EnemysInventar[i, 1, iEnemy1]= 'ShoulderStraps') then str2:='P' else 
          EnemysInventar[i, j+7, iEnemy1]:= '+' + str2 + random(lvlEnemy);
        end
        else} EnemysInventar[i, j+7, iEnemy1]:= '.';
      end;   
    end    
    else begin 
      for j:=1 to 14 do EnemysInventar[i, j, iEnemy1]:= '.';
    end;
  end;
  end;
end;

procedure GenerationEnemysByPlayerN2();  // Продолжение процесса генерации статистики врага
var i, j, DamageEnemyN2, ProtectEnemyN2, iEnemy1: integer;
begin
  GenerationEnemysByPlayer();
  GenerationItemsEnemys();
  
  for iEnemy1:=1 to 5 do 
    if (mas[12+2*(iEnemy1-1), nomer]<>0)and(mas[13+2*(iEnemy1-1), nomer]<>0) then begin
  for i:= 1 to 12 do 
    if EnemysInventar[i, 1, iEnemy1]= 'Sword' then begin  // Подсчет статистики с одетыми вещами
      str1:=copy(EnemysInventar[i, 3, iEnemy1], 2, length(EnemysInventar[i, 3, iEnemy1])-1);
      val(str1, DamageEnemyN2, code);
      str(DamageEnemyN2+DamageEnemy, EnemysInfo[7, iEnemy1])
    end
    else 
    if (EnemysInventar[i, 1, iEnemy1]= 'Helmet')or(EnemysInventar[i, 1, iEnemy1]= 'ChestArmor')or(EnemysInventar[i, 1, iEnemy1]= 'ShoulderStraps')or(EnemysInventar[i, 1, iEnemy1]= 'Pants')or(EnemysInventar[i, 1, iEnemy1]= 'Boots') then begin
      str1:=copy(EnemysInventar[i, 3, iEnemy1], 2, length(EnemysInventar[i, 3, iEnemy1])-1);
      val(str1, ProtectEnemyN2, code);
      str(ProtectEnemyN2+ProtectEnemy, EnemysInfo[8,iEnemy1])
    end;
  end;
  {for iEnemy:=1 to 5 do 
    if (mas[8+2*(iEnemy-1), nomer]<>0)and(mas[9+2*(iEnemy-1), nomer]<>0) then begin
  for i:=1 to 12 do
    for j:=1 to 14 do begin
      write(EnemysInventar[i, j, iEnemy1]);
      if j=14 then writeln();
    end;
  end; }
end;

procedure PlayerInfoPanel();  // Информация на основном экране
var i, j: integer;
begin
  val(playerinfo[2], moneyPlayer, code);
  
  if infoPanelPlayerAllowNickName = true then begin
    str(PlayerInfo[1], str1);
    InfoPanelPlayerTXT[1]:= new TextABC(110, 3, 9, str1, clBlack);
    infoPanelPlayerAllowNickName:= false;
  end;
  
  If ((lastLvlPlayer=lvlPlayer)or(lastLvlPlayer = 0))and(InfoPanelPlayerAllowLvl = true) then begin
    str(lvlPlayer, str1);
    InfoPanelPlayerTXT[2]:= new TextABC(110, 18, 9, str1, clBlack);
    InfoPanelPlayerAllowLvl:= false;
    lastLvlPlayer:=lvlPlayer
  end
  else if (lastLvlPlayer<>lvlPlayer)and(InfoPanelPlayerAllowLvl = false) then begin
    InfoPanelPlayerTXT[2].Destroy;
    InfoPanelPlayerAllowLVl:= true;
  end;
end;

procedure EscapeMenuPicture();
begin
  EscapeMenu(objEscapeMenu, 0, 0);
  ReturnToGameButton1(ReturnToGameButton, 215, 220);
  SettingInGameButton1(SettingInGameButton, 215, 270);
  SaveInGameButton1(SaveInGameButton, 215, 320);
  ExitInGameButton1(ExitInGameButton, 215, 370);
end;

procedure ReturnFromEscapeMenu();
var i, j: integer;
begin
  ExitInGameButton.Destroy;
  SaveInGameButton.Destroy;
  SettingInGameButton.Destroy;
  ReturnToGameButton.Destroy;
  objEscapeMenu.Destroy;
  workEscape := false;
  key1:=0;
  Scene:='FightPlayer';
end;

procedure ExitFromGame();
var i, j: integer;
begin
  ExitInGameButton.Destroy;
  SaveInGameButton.Destroy;
  SettingInGameButton.Destroy;
  ReturnToGameButton.Destroy;
  objEscapeMenu.Destroy;
  ObjPanelHPandST.Destroy;
  objPanelExperience.Destroy;
  ObjPanelLeftUp.Destroy;
  ObjPanelMenu.Destroy;
  objButtonInv.Destroy;
  objButtonMenu.Destroy;
  objQuestsButton.Destroy;
  objMapButton.Destroy;
  objSkillsButton.Destroy;
  objActionButton.Destroy;
  objPlayer.Destroy;
  workEscape := false;
  AllPictureLoaded := false;
  ProcessNumber:=0;
end;

procedure EscapeButton(xm, ym, mb: integer);
var i, j: integer;
begin
  if ReturnToGameButton.PtInside(xm, ym) = true then begin
    ReturnFromEscapeMenu();
  end;
  if SaveInGameButton.PtInside(xm, ym) = true then begin
    SaveGameInfo();
    write('1');
    ReturnFromEscapeMenu();
  end;
  if SettingInGameButton.PtInside(xm, ym) = true then begin
    
  end;
  if ExitInGameButton.PtInside(xm, ym) = true then begin
    ExitFromGame();
  end;
end;

procedure MoveEscape(xm, ym, mb: integer);
begin
  scene := 'EscapeMenu';
end;

Procedure EscapeMenu();  // Escape Menu
var i, l: integer;
begin
  if scene = 'EscapeMenu' then begin
    if workEscape = false then begin
      EscapeMenuPicture();
      workEscape := true;
    end;
    
    //scene := 'EscapeMenu';
    
    onMouseDown:=EscapeButton;
    onMouseMove:=MoveEscape;
  end;
end;

// Обмен вещами у торговца

var objTradeMenu, objAttackItemButton, objProtectItemButton, objAddItemButton, objInvPlayerButton, objBuyButtonInTrade, objNoMoneyButtonInTrade, objSellButtonInTrade, objNoSpaceButtonInTrade, objCancelButtonInTrade, objShowItemFromTrade: PictureABC;
  workSceneTrade, workOfDestroyItem, readyToBuy, readyToSell: boolean;
  numberOfItem, lastNumberOfItem, NumberOfInvTrade, lastNumberOfInvTrade: integer;

  masTxtInfoTrade:array[1..11]of TextABC;
  masObjItemTrade:array[0..48]of PictureABC;
  
procedure SwordTrade(sprite: PictureABC; number, x1, y1: integer);  // Мечи
begin
  sprite:= PictureABC.create(x1, y1, 'images/sword.png');
  masObjItemTrade[number]:= sprite;
end;

procedure HelmetTrade(sprite: PictureABC; number, x1, y1: integer);  // Шлемы
begin
  sprite:= PictureABC.create(x1, y1, 'images/helmet.png');
  masObjItemTrade[number]:= sprite;
end;

procedure ChestArmorTrade(sprite: PictureABC; number, x1, y1: integer);  // Нагрудники
begin
  sprite:= PictureABC.create(x1, y1, 'images/chest armor.png');
  masObjItemTrade[number]:= sprite;
end;

procedure PantsTrade(sprite: PictureABC; number, x1, y1: integer);  // Штаны
begin
  sprite:= PictureABC.create(x1, y1, 'images/pants.png');
  masObjItemTrade[number]:= sprite;
end;

procedure RingTrade(sprite: PictureABC; number, x1, y1: integer);  // Кольца
begin
  sprite:= PictureABC.create(x1, y1, 'images/Ring.png');
  masObjItemTrade[number]:= sprite;
end;

procedure NecklaceTrade(sprite: PictureABC; number, x1, y1: integer);  // Ожерелье
begin
  sprite:= PictureABC.create(x1, y1, 'images/Necklace.png');
  masObjItemTrade[number]:= sprite;
end;

procedure ShoulderStrapsTrade(sprite: PictureABC; number, x1, y1: integer);  // Наплечники
begin
  sprite:= PictureABC.create(x1, y1, 'images/Shoulder Straps.png');
  masObjItemTrade[number]:= sprite;
end;

procedure BootsTrade(sprite: PictureABC; number, x1, y1: integer);  // Ботинки
begin
  sprite:= PictureABC.create(x1, y1, 'images/Boots.png');
  masObjItemTrade[number]:= sprite;
end;

procedure TradeMenu(sprite: PictureABC; xNPC, yNPC: integer);
begin
  sprite:= PictureABC.create(xNPC, yNPC, 'images/TradeNPC.png');
  objTradeMenu:= sprite;
end;

procedure AttackItemButton(sprite: PictureABC; xNPC, yNPC: integer);
begin
  sprite:= PictureABC.create(xNPC, yNPC, 'images/AttackItemButton.png');
  objAttackItemButton:= sprite;
end;

procedure ProtectItemButton(sprite: PictureABC; xNPC, yNPC: integer);
begin
  sprite:= PictureABC.create(xNPC, yNPC, 'images/ProtectItemButton.png');
  objProtectItemButton:= sprite;
end;

procedure AddItemButton(sprite: PictureABC; xNPC, yNPC: integer);
begin
  sprite:= PictureABC.create(xNPC, yNPC, 'images/AddItemButton.png');
  objAddItemButton:= sprite;
end;

procedure InvPlayerButton(sprite: PictureABC; xNPC, yNPC: integer);
begin
  sprite:= PictureABC.create(xNPC, yNPC, 'images/InvPlayerButton.png');
  objInvPlayerButton:= sprite;
end;

procedure BuyButtonInTrade(sprite: PictureABC; x1, y1: integer);
begin
  sprite:= PictureABC.create(x1, y1, 'images/BuyButtonInTrade.png');
  objBuyButtonInTrade:= sprite;
end;

procedure NoMoneyButtonInTrade(sprite: PictureABC; x1, y1: integer);
begin
  sprite:= PictureABC.create(x1, y1, 'images/NoMoneyButtonInTrade.png');
  objNoMoneyButtonInTrade:= sprite;
end;

procedure SellButtonInTrade(sprite: PictureABC; x1, y1: integer);
begin
  sprite:= PictureABC.create(x1, y1, 'images/SellButtonInTrade.png');
  objSellButtonInTrade:= sprite;
end;

procedure NoSpaceButtonInTrade(sprite: PictureABC; x1, y1: integer);
begin
  sprite:= PictureABC.create(x1, y1, 'images/NoSpaceButtonInTrade.png');
  objNoSpaceButtonInTrade:= sprite;
end;

procedure CancelButtonInTrade(sprite: PictureABC; x1, y1: integer);
begin
  sprite:= PictureABC.create(x1, y1, 'images/CancelButtonInTrade.png');
  objCancelButtonInTrade:= sprite;
end;

procedure LoadingInvTrade();
var i, j: integer;
begin
  TradeMenu(objTradeMenu, 0, 0);
  AttackItemButton(objAttackItemButton, 135, 105);
  ProtectItemButton(objProtectItemButton, 189, 105);
  AddItemButton(objAddItemButton, 243, 105);
  InvPlayerButton(objInvPlayerButton, 297, 105);
  WorkSceneTrade:=true;
end;

procedure CreateItemForInventarTrader();
var i, j, k, randomNumber1, randomNumber2, randomNumber3, Damage, Protect, AddPotion, ElseNumber1, ElseNumber2: integer;
begin
  randomNumber1:=random(18)+1;
  for k:=1 to 3 do
    for i:=1 to 48 do 
      if randomNumber1>=i then begin
        if k = 1 then masTradeInv[k, i, 1]:='Sword';
        if k = 2 then begin
          randomNumber2:=random(5)+1;
          if randomNumber2+5 = 6 then masTradeInv[k, i, 1]:='Helmet';
          if randomNumber2+5 = 7 then masTradeInv[k, i, 1]:='ChestArmor';
          if randomNumber2+5 = 8 then masTradeInv[k, i, 1]:='ShoulderStraps';
          if randomNumber2+5 = 9 then masTradeInv[k, i, 1]:='Pants';
          if randomNumber2+5 = 10 then masTradeInv[k, i, 1]:='Boots';
        end;
        if k = 3 then begin
          if i = 1 then masTradeInv[k, i, 1]:='HealingPotion';
          if i = 2 then masTradeInv[k, i, 1]:='EnergyPotion';
          if i>2 then randomNumber3:= random(5)+3;
          if randomNumber3 = 3 then masTradeInv[k, i, 1]:='Улучшение';
          if randomNumber3 = 4 then masTradeInv[k, i, 1]:='Necklace';
          if randomNumber3 = 5 then masTradeInv[k, i, 1]:='Ring';
        end;
        if masTradeInv[k, i, 1]='Sword' then begin 
          Damage:= 2*lvlPlayer + random(lvlPlayer)+1;
          str(Damage, str1);
          masTradeInv[k, i, 3]:='D'+str1;
          str(Damage*4*lvlPlayer, masTradeInv[k, i, 2]);
        end;
        if (masTradeInv[k, i, 1]='Helmet')or(masTradeInv[k, i, 1]='ShoulderStraps')or(masTradeInv[k, i, 1]='ChestArmor')or(masTradeInv[k, i, 1]='Pants')or(masTradeInv[k, i, 1]='Boots') then begin 
          Protect:= 3*lvlPlayer + random(lvlPlayer)+1;
          str(Protect, str1);
          masTradeInv[k, i, 3]:='P'+str1;
          str(Protect*3*lvlPlayer, masTradeInv[k, i, 2]);
        end;
        {if masTradeInv[k, i, 1]='HealingPotion' then begin 
          AddPotion:= ;
          str(AddPotion, str1);
          masTradeInv[k, i, 3]='+HP'+str1;
        end;}
        masTradeInv[k, i, 4]:= 'S' ;
        masTradeInv[k, i, 5]:= 'L' ;
        masTradeInv[k, i, 6]:= 'I' ;
        if masTradeInv[k, i, 1]= 'Sword' then begin 
          str(random(lvlPlayer div 5)+1, str1);
          masTradeInv[k, i, 7]:= '+SP'+str1;
        end else masTradeInv[k, i, 7]:= '+SP0';
        for ElseNumber1:=8 to 11 do
          masTradeInv[k, i, ElseNumber1]:='.';
      end else begin
        for ElseNumber2:=1 to 11 do
          masTradeInv[k, i, ElseNumber2]:='.';
        if i = 48 then begin str(randomNumber1, masTradeInv[k, 0, 1]); randomNumber1:=random(18)+1; end;
    end;
end;

procedure LoadItemTrade(NumberWindow: integer);
var i, j, xNPC, yNPC, Number1: integer;
begin
  xNPC:= 147;
  yNPC:= 146;
  val(masTradeInv[NumberWindow, 0, 1], Number1, code);
  for i:=1 to Number1 do begin
    if masTradeInv[NumberWindow, i, 1]='Sword' then begin
      SwordTrade(masObjItemTrade[i], i, xNPC, yNPC);
    end
    else if masTradeInv[NumberWindow, i, 1]='Helmet' then begin 
      HelmetTrade(masObjItemTrade[i], i, xNPC, yNPC); 
    end
    else if masTradeInv[NumberWindow, i, 1]='ChestArmor' then begin
      ChestArmorTrade(masObjItemTrade[i], i, xNPC, yNPC); 
    end
    else if masTradeInv[NumberWindow, i, 1]='Pants' then begin 
      PantsTrade(masObjItemTrade[i], i, xNPC, yNPC); 
    end
    else if masTradeInv[NumberWindow, i, 1]='Ring' then begin 
      RingTrade(masObjItemTrade[i], i, xNPC, yNPC); 
    end
    else if masTradeInv[NumberWindow, i, 1]='Necklace' then begin 
      NecklaceTrade(masObjItemTrade[i], i, xNPC, yNPC); 
    end
    else if masTradeInv[NumberWindow, i, 1]='ShoulderStraps' then begin 
      ShoulderStrapsTrade(masObjItemTrade[i], i, xNPC, yNPC); 
    end
    else if masTradeInv[NumberWindow, i, 1]='Boots' then begin 
      BootsTrade(masObjItemTrade[i], i, xNPC, yNPC); 
    end;
    xNPC:= xNPC+51;
    if i mod 8 = 0 then begin yNPC:=yNPC+50; xNPC:= 147; end;
  end;
  lastNumberOfInvTrade:=NumberOfInvTrade;
  workOfDestroyItem:= true;
end;

procedure LoadItemInvPlayerTrade(NumberWindow: integer);
var i, j, xNPC, yNPC, Number1: integer;
begin
  xNPC:= 147;
  yNPC:= 146;
  for i:=1 to 48 do begin
    if masInfo[1, i]='Sword' then begin
      SwordTrade(masObjItemTrade[i], i, xNPC, yNPC);
    end
    else if masInfo[1, i]='Helmet' then begin 
      HelmetTrade(masObjItemTrade[i], i, xNPC, yNPC); 
    end
    else if masInfo[1, i]='ChestArmor' then begin
      ChestArmorTrade(masObjItemTrade[i], i, xNPC, yNPC); 
    end
    else if masInfo[1, i]='Pants' then begin 
      PantsTrade(masObjItemTrade[i], i, xNPC, yNPC); 
    end
    else if masInfo[1, i]='Ring' then begin 
      RingTrade(masObjItemTrade[i], i, xNPC, yNPC); 
    end
    else if masInfo[1, i]='Necklace' then begin 
      NecklaceTrade(masObjItemTrade[i], i, xNPC, yNPC); 
    end
    else if masInfo[1, i]='ShoulderStraps' then begin 
      ShoulderStrapsTrade(masObjItemTrade[i], i, xNPC, yNPC); 
    end
    else if masInfo[1, i]='Boots' then begin 
      BootsTrade(masObjItemTrade[i], i, xNPC, yNPC); 
    end;
    xNPC:= xNPC+51;
    if i mod 8 = 0 then begin yNPC:=yNPC+50; xNPC:= 147; end;
  end;
  lastNumberOfInvTrade:=NumberOfInvTrade;
  workOfDestroyItem:= true;
end;

procedure ShowItemFromTrade();
var i, j: integer;
begin
  for i:=1 to 48 do begin
    if NumberOfInvTrade = 4 then begin
     if masInfo[1, numberOfItem] = 'Sword' then begin
        SwordTrade(masObjItemTrade[0], 0, xm + 105, ym);
      end;     
    end else 
    if NumberOfInvTrade <> 4 then begin
      if masTradeInv[NumberOfInvTrade, numberOfItem, 1] = 'Sword' then begin
        SwordTrade(masObjItemTrade[0], 0, xm + 105, ym);
      end;
    end;
  end;
end;

procedure DestroyItemTrade(NumberWindow: integer);
var i, j, Number1: integer;
begin
  if NumberWindow = 4 then begin
    for i:=1 to 48 do begin
      if masInfo[1, i]<>'.' then masObjItemTrade[i].Destroy;
    end;
  end else begin
    val(masTradeInv[NumberWindow, 0, 1], Number1, code);
    for i:=1 to Number1 do begin
      masObjItemTrade[i].Destroy;
    end;
  end;
  workOfDestroyItem:=false;
end;

procedure CloseSceneTrade();
var i, j: integer;
begin
  objTradeMenu.Destroy;
  objAttackItemButton.Destroy;
  objProtectItemButton.Destroy;
  objAddItemButton.Destroy;
  objInvPlayerButton.Destroy;
  if lastNumberOfItem<>0 then 
    for i:=1 to 11 do 
      masTxtInfoTrade[i].Destroy;
  DestroyItemTrade(NumberOfInvTrade);
  writeinfo();
  WorkSceneTrade:=false;
  scene:='FightPlayer';
  key1:=0;
end;

procedure BuyItemInTrade(xm, ym: integer);
var i, j, EmptySlots, EmptySlotsFirst, ExperiencePlayerN1, ExperienceItemN1: integer;
begin
  for i:=1 to 48 do 
    if masInfo[1, i]='.' then begin
      EmptySlots:= EmptySlots + 1;
      if EmptySlotsFirst = 0 then EmptySlotsFirst:=i;
    end;
  if readyToBuy = false then begin
    BuyButtonInTrade(objBuyButtonInTrade, xm, ym);
    CancelButtonInTrade(objCancelButtonInTrade, xm, ym+30);
    lastNumberOfItem:=numberOfItem;
    //ShowItemFromTrade();
    readyToBuy:=true;
  end else
  if(objCancelButtonInTrade.PtInside(xm, ym)=true)and(readyToBuy = true)then begin
    objBuyButtonInTrade.Destroy;
    objCancelButtonInTrade.Destroy;
    readyToBuy:=false;
  end else
  if (objBuyButtonInTrade.PtInside(xm, ym)=true)and(readyToBuy = true)and(EmptySlots<>0) then begin
    val(playerInfoGame[2], ExperiencePlayerN1, code);
    val(masTradeInv[NumberOfInvTrade, numberOfItem, 2], ExperienceItemN1, code);
    ExperiencePlayerN1:=ExperiencePlayerN1 - ExperienceItemN1;
    objBuyButtonInTrade.Destroy;
    objCancelButtonInTrade.Destroy;
    masObjItemTrade[numberOfItem].Destroy;
    readyToBuy:=false;
    for i:=1 to 11 do begin
      masInfo[i, EmptySlotsFirst] := masTradeInv[NumberOfInvTrade, numberOfItem, i]
    end;
    for i:=1 to 11 do begin
      masTradeInv[NumberOfInvTrade, numberOfItem, i] := '.';
    end;
    writeinfo();
  end
  else if EmptySlots = 0 then begin
    
  end;
end;

procedure SellItemInTrade(xm, ym: integer);
var i, j, ExperiencePlayerN1, ExperienceItemN1: integer;
begin
   if readyToSell = false then begin
    SellButtonInTrade(objSellButtonInTrade, xm, ym);
    CancelButtonInTrade(objCancelButtonInTrade, xm, ym+30);
    lastNumberOfItem:=numberOfItem;
    //ShowItemFromTrade();
    readyToSell:=true;
  end else 
  if(objCancelButtonInTrade.PtInside(xm, ym)=true)and(readyToSell = true)then begin
    objSellButtonInTrade.Destroy;
    objCancelButtonInTrade.Destroy;
    readyToSell:=false;
  end else 
  if (objSellButtonInTrade.PtInside(xm, ym)=true)and(readyToSell = true)then begin
    val(playerInfoGame[2], ExperiencePlayerN1, code);
    val(masInfo[2, numberOfItem], ExperienceItemN1, code);
    ExperiencePlayerN1:=ExperiencePlayerN1 + ExperienceItemN1;
    objSellButtonInTrade.Destroy;
    objCancelButtonInTrade.Destroy;
    masObjItemTrade[numberOfItem].Destroy;
    readyToSell:=false;
    for i:=1 to 11 do begin
      masInfo[i,numberOfItem] := '.';
    end;
    writeinfo();
  end;
end;

procedure FindNumberOfItemTrade(xm, ym: integer); 
var i, j, numberX, numberY: integer;
begin
  if (readyToBuy=false)and(readyToSell=false) then begin
    numberX:= (xm-147) div 51+1;
    numberY:= (ym-146) div 51+1;
    numberOfItem:= numberX + 8*(numberY-1);
  end;
end;

procedure MouseDownInvTrade(xm, ym, mb: integer);
var i, j, numberOfItem1: integer;
begin
  if (objAttackItemButton.PtInside(xm, ym)=true) then begin
    NumberOfInvTrade:=1;
    if workOfDestroyItem = true then DestroyItemTrade(lastNumberOfInvTrade);
    LoadItemTrade(NumberOfInvTrade);
  end
  else if (objProtectItemButton.PtInside(xm, ym)=true) then begin
    NumberOfInvTrade:=2;
    if workOfDestroyItem = true then DestroyItemTrade(lastNumberOfInvTrade);
    LoadItemTrade(NumberOfInvTrade);
  end
  else if (objAddItemButton.PtInside(xm, ym)=true) then begin
    NumberOfInvTrade:=3;
    if workOfDestroyItem = true then DestroyItemTrade(lastNumberOfInvTrade);
    LoadItemTrade(NumberOfInvTrade);
  end
  else if (objInvPlayerButton.PtInside(xm, ym)=true) then begin
    NumberOfInvTrade:=4;
    if workOfDestroyItem = true then DestroyItemTrade(lastNumberOfInvTrade);
    LoadItemInvPlayerTrade(NumberOfInvTrade);
  end
  else if (xm>553)and(xm<564)and(ym>91)and(ym<102) then begin 
    CloseSceneTrade();
  end;
  
  FindNumberOfItemTrade(xm, ym);
  if (NumberOfInvTrade <> 4)then if (readyToBuy = true)or((masTradeInv[NumberOfInvTrade, numberOfItem, 1]<>'.')and(masObjItemTrade[numberOfItem].PtInside(xm, ym)) = true) then begin
    BuyItemInTrade(xm, ym);
  end;
  if (NumberOfInvTrade = 4)then if (readyToSell = true)or((masInfo[1, numberOfItem]<>'.')and(masObjItemTrade[numberOfItem].PtInside(xm, ym) = true))then begin
    SellItemInTrade(xm, ym);
  end;
end;

procedure InfoItemForTrade(xm, ym: integer);
var i, j, xNPC, yNPC, numberX, numberY:integer;
begin
if ((xm>=147)and(xm<=552)and(ym>=146)and(ym<=449))and(NumberOfInvTrade<>0) then begin
  FindNumberOfItemTrade(xm, ym);
  if NumberOfInvTrade = 4 then begin
    if lastNumberOfItem=0 then begin
      for i:=1 to 11 do 
        masTxtInfoTrade[i]:= new TextABC(155, 466+10*(i-1), 8, masInfo[i, numberOfItem] , clWhite);
      lastNumberOfItem:=numberOfItem;
    end
    else if lastNumberOfItem<>numberOfItem then begin
      for i:=1 to 11 do 
        masTxtInfoTrade[i].Destroy;
      for i:=1 to 11 do 
        masTxtInfoTrade[i]:= new TextABC(155, 466+10*(i-1), 8, masInfo[i, numberOfItem] , clWhite);
      lastNumberOfItem:=numberOfItem;
    end;
  end else begin
    if lastNumberOfItem=0 then begin
      for i:=1 to 11 do 
        masTxtInfoTrade[i]:= new TextABC(155, 466+10*(i-1), 8, masTradeInv[NumberOfInvTrade, numberOfItem, i] , clWhite);
      lastNumberOfItem:=numberOfItem;
    end
    else if lastNumberOfItem<>numberOfItem then begin
      for i:=1 to 11 do 
        masTxtInfoTrade[i].Destroy;
      for i:=1 to 11 do 
        masTxtInfoTrade[i]:= new TextABC(155, 466+10*(i-1), 8, masTradeInv[NumberOfInvTrade, numberOfItem, i] , clWhite);
      lastNumberOfItem:=numberOfItem;
    end;
  end;
end;
end;

procedure MouseMoveInvTrade(xm, ym, mb:integer);
var i, j: integer;
begin
  InfoItemForTrade(xm, ym);
end;

procedure TradeWithNPC();
var i, j: integer;
begin
  if(scene = 'Trade')then begin
    if (WorkSceneTrade=false)then begin 
      LoadingInvTrade(); CreateItemForInventarTrader(); readinfo(); NumberOfInvTrade:= 4; LoadItemInvPlayerTrade(NumberOfInvTrade); 
    end;
    OnMouseDown:= MouseDownInvTrade;
    OnMouseMove:= MouseMoveInvTrade;
  end;
end;

procedure FightPlayerGame(iEnemy: integer);  // Процесс удара игрока
var j, ProtectPlayer2, ProtectEnemy2: integer;
begin
  val(PlayerInfo[3], HPPlayer, code);
  val(PlayerInfo[10], DamagePlayer, code);
  val(PlayerInfo[11], ProtectPlayer, code);
  
  val(EnemysInfo[8, iEnemy], ProtectEnemy, code);
  
  val(EnemysInfo[3, iEnemy], HPEnemy, code);
  HPEnemy:=HPenemy-(DamagePlayer div 2{+(random(DamagePlayer div 10)+1))-((ProtectEnemy div 2)+random(ProtectEnemy div 2)+1});
  
  if timeToFightEffect=0 then begin 
    FightEffect(objFightEffect[2], 2, xe[iEnemy], ye[iEnemy]);
    timeToFightEffect:=1;
    objEnemy[iEnemy].MoveTo(xe[iEnemy], ye[iEnemy]-5);
  end;
    
  if HPEnemy<=0 then spawnMobTime:=0;
  
  str(HPEnemy, EnemysInfo[3, iEnemy]);
  str(ProtectEnemy, EnemysInfo[8, iEnemy]);
 
  str(HPPlayer, PlayerInfo[3]);
  str(DamagePlayer, PlayerInfo[10]);
  str(ProtectPlayer, PlayerInfo[11]);
    
  writeInfoPlayer;
  
end;

procedure FightEnemyGame(iEnemy: integer);  // Процесс удара врага
var j, ProtectPlayer2: integer;
begin
  val(PlayerInfo[3], HPPlayer, code);
  val(PlayerInfo[10], DamagePlayer, code);
  val(PlayerInfo[11], ProtectPlayer, code);

  LastHPPlayer:= HPPlayer;
  val(EnemysInfo[7, iEnemy], DamageEnemy, code);
  HpPlayer:=hpPlayer-(DamageEnemy div 2+(random(DamageEnemy div 10)+1))-((ProtectPlayer div 2)+random(ProtectPlayer div 2)+1);
  
  if timeToFightEffect=0 then begin 
    FightEffect(objFightEffect[1], 1, xp, yp);
    timeToFightEffect:=1;
    objPlayer.MoveTo(xp, yp-5);
  end;

  str(DamageEnemy, EnemysInfo[7, iEnemy]);

  str(HPPlayer, PlayerInfo[3]);
  str(DamagePlayer, PlayerInfo[10]);
  str(ProtectPlayer, PlayerInfo[11]);
    
  writeInfoPlayer;
  
end;

procedure ItemFromEnemy(iEnemy: integer);
var i, j, randomNumber: integer;
    acceptN1: boolean;
begin
  acceptN1:=true;
  randomNumber:=5{random(12)+1};
  readInfo();
  for i:=1 to 48 do begin
    if (masInfo[1, i] = '.')and(acceptN1=true) then 
      for j:=1 to 11 do begin 
        masInfo[j, i]:=EnemysInventar[randomNumber, j, iEnemy];
        acceptN1:= false;
      end;
  end;
  writeInfo();
end;

procedure ItemFromChest();
begin
  objChestWithItem.Destroy;
  mas[10, nomer]:=0;
  mas[11, nomer]:=0;
end;

// Важная часть движения и взаимодействия

var LogoPict1, LogoPict2, LogoPict3, LogoPict4 :boolean;

procedure LoadingGame();  // Загрузка функций 
var i, j: integer;
begin
  LoadingMenu(objLoadingMenu, 0, 0);
  j:=1;
  while GameReadyToPlay <> true do begin 
    i:=i+1;
    sleep(1);
    if j = 1 then begin
      if logoPict1 = false then begin 
        Logo1(objLogo1, 540, 570);
        if LogoPict4 = true then begin objLogo4.Destroy; LogoPict4:= false; end;
      end;
      LogoPict1:=true;
      if i = 200  then begin
        i:=0;
        j:=2;
      end; 
    end else if j = 2 then begin
      if logoPict2 = false then begin 
        Logo2(objLogo2, 540, 570);
        if LogoPict1 = true then begin objLogo1.Destroy; LogoPict1:= false; end;
      end;
      LogoPict2:=true;
      if i = 200  then begin
        i:=0;
        j:=3;
      end;
    end else if j = 3 then begin
      if logoPict3 = false then begin 
        Logo3(objLogo3, 540, 570);
        if LogoPict2 = true then begin objLogo2.Destroy; LogoPict2:= false; end;
      end;
      LogoPict3:=true;
      if i = 200  then begin
        i:=0;
        j:=4;
      end;
    end else if j = 4 then begin
      if logoPict4 = false then begin 
        Logo4(objLogo4, 540, 570);
        if LogoPict3 = true then begin objLogo3.Destroy; LogoPict3:= false; end;
      end;
      LogoPict4:=true;
      if i = 200  then begin
        i:=0;
        j:=1;
      end;
    end;
  end;
end;

procedure EnemyInfo(xm, ym, mb: integer);  // Информация о враге 
var i, j: integer;
    HelpTxt: string;
begin
  if (iEnemy<>0)and(objEnemy[iEnemy].PtInside(xm, ym)=true)and(InfoEnemyButtom=0)then begin
    PanelEnemy(ObjPanelEnemy, 290, 100);
    InfoEnemyButtom:=1;
    InfoEnemyTxt[1]:= new TextABC(320, 100, 10, enemysInfo[1,iEnemy], clWhite);
    InfoEnemyTxt[2]:= new TextABC(375, 100, 10, enemysInfo[2,iEnemy], clWhite);
    HelpTxt:='HP:'+enemysInfo[4,iEnemy]+'/'+enemysInfo[3,iEnemy];
    InfoEnemyTxt[3]:= new TextABC(300, 115, 9, HelpTxt, clWhite);
    HelpTxt:='ST:'+enemysInfo[5,iEnemy];
    InfoEnemyTxt[4]:= new TextABC(300, 125, 9, HelpTxt, clWhite);
    HelpTxt:='AT:'+enemysInfo[7,iEnemy];
    InfoEnemyTxt[5]:= new TextABC(300, 135, 9, HelpTxt, clWhite);
    HelpTxt:='P:'+enemysInfo[8,iEnemy];
    InfoEnemyTxt[6]:= new TextABC(355, 115, 9, HelpTxt, clWhite);
    HelpTxt:='SP:'+enemysInfo[9,iEnemy];
    InfoEnemyTxt[7]:= new TextABC(355, 125, 9, HelpTxt, clWhite);
  end
    else if (InfoEnemyButtom=1)and(objEnemy[iEnemy].PtInside(xm, ym)=false)then begin 
      objPanelEnemy.Destroy; 
      InfoEnemyButtom:=0;
      for i:=1 to 7 do 
        InfoEnemyTxt[i].Destroy;
    end;
end;

procedure TestMouse(xm, ym, mb: integer);  // Значение сцены 
var i, j: integer;
begin
  if (ym>150)and(ym<650) then begin
    scene:= 'FightPlayer';
    EnemyInfo(xm, ym, mb);
    FindiEnemy(xm, ym);
    GoDoor(xm, ym, mb);  // Нужно шлифовать код!
  end
  else begin
    scene:='PanelAndButtoms';
  end;
end;

procedure BeginMove();  // Движение объекта и взаимодействие с врагом 
var i, j: integer;
begin
  if (scene='FightPlayer') then begin
    onmousedown:= mousedownGame;
  end;
 
  if (iEnemy<>0)and(objEnemy[iEnemy].Intersect(objPlayer)=true)and(objEnemy[iEnemy].PtInside(xm1, ym1)=true) then begin 
    val(PlayerInfo[12], speedAttackPlayer, code);
    val(EnemysInfo[9, iEnemy], speedAttackEnemy, code);

    if (timeToAttack mod round((200-speedAttackPlayer)div 2)=0)or(timeToAttack = 1) then begin
      FightPlayerGame(iEnemy);
      timeToAttack:= timeToAttack+1;
      sleep(1);
      val(EnemysInfo[3, iEnemy], HPEnemy, code);
      if HPEnemy<=0 then begin 
        objEnemy[iEnemy].Destroy;
        xe[iEnemy]:=0;
        ye[iEnemy]:=0;
        ItemFromEnemy(iEnemy);
        val(EnemysInfo[2, iEnemy], ExperienceEnemy, code);
        //if ExperiencePlayer = 0 then ExperiencePlayer:= 1;
        if (ExperiencePlayer + ExperienceEnemy>Experience)or(lastExperience=0) then begin 
          lastExperiencePlayer:= ExperiencePlayer;
          lastExperience:= Experience;
        end;
        ExperiencePlayer:= ExperiencePlayer + ExperienceEnemy;
        str(ExperiencePlayer, PlayerInfo[2]);
        ReadLVLPlayer;
      end;
      if (timeToFightEffect=1) then begin
        objFightEffect[2].Destroy;
        TimeToFightEffect:=0;
        objEnemy[iEnemy].MoveTo(xe[iEnemy], ye[iEnemy]);
      end;
    end;
    
    if (timeToAttack mod round((200-speedAttackEnemy)div 2)=0)or(timeToAttack = 1)  then begin
      FightEnemyGame(iEnemy);
      timeToAttack:= timeToAttack+1;
      sleep(1);
      for i:=(lastHPPlayer * 810 div MaxHPPlayer) downto (HPPlayer * 810 div MaxHPPlayer) do begin
        if HpPlayer>0 then objHPPlayer[i].Destroy;
      end;
      if (timeToFightEffect=1) then begin
        objFightEffect[1].Destroy;
        TimeToFightEffect:=0;
        objPlayer.MoveTo(xp, yp);
      end;
    end; 
    
    if ((timeToAttack mod round((200-speedAttackEnemy)div 2)<>0)and(timeToAttack mod round((200-speedAttackPlayer)div 2)<>0))or(timeToAttack = 1) then begin
      timeToAttack:=timeToAttack+1;
      sleep(1);
    end;
  end;
  
  if (key1=vk_e) then begin  // Сделай генерацию НПС и тогда вернешь!
    if (objMasNPC[1].Intersect(objPlayer)=true) then begin 
      scene:='Trade'; key1:= 0; TradeWithNPC(); 
    end
    else begin
      key1:= 0;
    end;
    //else if objChestWithItem.PtInside(xp+23, yp+80) then begin ItemFromChest(); end;
  end
  else if (key1=vk_i) then begin
    scene:= 'inventar'; key1:= 0; ImportantPartProgramInv();
  end
  else if (key1=vk_m) then begin
    scene:='Map'; key1:= 0; AllMapPlayer;
  end
  else if (key1=vk_escape) then begin
    scene:='EscapeMenu'; key1:= 0; EscapeMenu();
  end
  {else if (key1=vk_s) then begin
    scene:='Skills';
  end
  else if (key1=vk_q) then begin
    scene:='Quests';
  end}
  else if ((mb1 = 1)or(accept = false))and(scene = 'FightPlayer') then begin 
    timeToAttack:=0; movePlayer(0, xm1, ym1);
  end;
  sleep(time); 
end;

procedure loadObjPanelAndButtoms();
begin
  PanelHPandST(ObjPanelHPandST, 100, 640);
  PanelExperience(objPanelExperience, 0, 690);
  PanelLeftUp(ObjPanelLeftUp, 0, 0);
  PanelMenu(ObjPanelMenu, 330, 0);
  ButtonInv(objButtonInv, 595, 5);
  ButtonMenu(objButtonMenu, 645, 5);
  QuestsButton(objQuestsButton, 545, 5);
  MapButton(objMapButton, 495, 5);
  SkillsButton(objSkillsButton, 445, 5);
  ActionButton(objActionButton, 395, 5);
end;

procedure MouseDownPABN2(xm, ym: integer);
begin
  if (objButtonInv.PtInside(xm, ym)= true) then begin scene:= 'inventar'; key1:= 0; ImportantPartProgramInv(); end;
  if (objMasNPC[1].Intersect(objPlayer)=true)and(objActionButton.PtInside(xm, ym)= true) then begin scene:= 'Trade'; key1:= 0; TradeWithNPC();end;
  if (objMapButton.PtInside(xm, ym)= true) then begin scene:='Map'; key1:= 0; AllMapPlayer; end;
  if (objButtonMenu.PtInside(xm, ym)=true) then begin scene:='EscapeMenu'; key1:= 0; EscapeMenu(); end;
end;

procedure MouseDownPAB(xm, ym, mb: integer);
begin
  case mb of
    1: begin 
         MouseDownPABN2(xm, ym);
         lastXM:= xm;
         lastYM:= ym;
       end;
  end;
end;

procedure ReturnToBack();
begin
  if (scene = 'Map')and(key1 = vk_escape) then begin key1:= 0; closeMap; end;
  if (scene = 'inventar')and(key1 = vk_escape) then begin key1:= 0; closeinventar; end;
  if (scene = 'Trade')and(key1 = vk_escape) then begin key1:= 0; CloseSceneTrade(); end;
  if (scene = 'EscapeMenu')and(key1 = vk_escape) then begin key1:= 0; ReturnFromEscapeMenu(); end;
  
  onkeydown:= readkey;
end;

procedure GameProcess();
begin
  if scene = 'FightPlayer' then begin 
    BeginMove();
    PlayerInfoPanel();   
  end;
  if (scene = 'FightPlayer')or(scene = 'PanelAndButtoms')then begin onMouseMove:= TestMouse; end;
  if (scene='PanelAndButtoms') then begin 
    OnMouseDown:= MouseDownPAB;
  end;
  
  //write(scene);
  
  ReturnToBack();
end;

procedure AllProcesses();
begin
while 1=1 do begin
  while ProcessNumber=0 do begin
    MenuOfGame();
  end;
  while ProcessNumber=1 do begin
    ActionInProfile();
  end;
  while ProcessNumber=2 do begin
    if AllPictureLoaded = false then begin
      Back1(objBack);
      generateroom;
      pictload;
      objBack.ToBack;
      if (mas[10, nomer]<>0)and(mas[11, nomer]<>0) then objChestWithItem.ToFront;
      if mas[7, nomer]<>0 then objDoor2[2].ToFront;
      if mas[6, nomer]<>0 then objDoor1[2].ToFront;
      
      Player(objPlayer, 1, xp, yp);
      NPCTrader(objmasnpc[1], 1, 400, 400);
      
      loadObjPanelAndButtoms;  // Загрузка всех кнопок на экране 
      readInfoPlayer();  // Загрузка информации с файла
      BeginHPPlayer();  // Загрузка шкалы здоровья
      ReadLVLPlayer();  // Загрузка и подсчет количества опыта и уровня
      GenerationEnemysByPlayerN2();  // Полная генерация инвентаря и статистики монстра
      AllPictureLoaded:=true;
      
      scene:='FightPlayer';
    end;
    GameProcess();
  end;
end;
end;

begin 
  SetWindowTop(-5);
  SetWindowTitle('game_ver_0.0');
  setwindowsize(700,700);
  yg := 440;
  xg := 0;
  y1 := y;
  xp:=300;
  yp:=400;
  xm1:=xp+23;
  ym1:=yp+80;
  //schet:=1;
  time:=12;
  accept:=true;
  xEX:= 2;
  yEX:= 692;
  mb1:=1;
  InfoPanelPlayerAllowMoney:=true;
  InfoPanelPlayerAllowLvl:=true;
  infoPanelPlayerAllowNickName:=true;
  WorkSceneTrade:=false;
  readyToBuy:=false;
  borders:=false;
  AllPictureLoaded:=false;
  ProcessNumber:=0;
  SaveNumber:= 1;
  NamePlayer:='ZlajaMalekula';  // Важное место!
  
  //LoadingGame();
  
  //GameReadyToPlay:=true;
  
  AllProcesses();
end.