// Владелец: Владимир Балыш @Запрещено полное либо частичное копирование !!!
// Owner: Mr.Balysh @Forbidden total or partial copy !!!
program game;

uses graphABC, ABCObjects;

var
  a1, a2, i, j, key1, scena, nomer, code, ld, varXY, enter, schet: integer;
  ground, wall, back, room: picture;
  x, y, x1, y1, xvar1, yvar1, xr, yr, spPlayer, xp, yp, xm, ym, xm1, ym1, spEnemy, xe, ye, xe1, ye1, mb1, time: integer;
  accept: boolean;
  str1, str2, scene: string;
  objPlayer, objEnemy, Objback: pictureABC;
  t1: text;
 
  ObjDoor1, objDoor2: array[1..2] of PictureABC;
  objGround: array[1..100] of PictureABC;
  mas:array[-1..46,1..1000] of integer;
  playerInfo:array[1..7]of string;

//Работа с машью
{procedure MouseMove(x,y,mousebutton:integer);
begin
  if mousebutton = 2 then
  else write(x);
  // работа с мышью
  //while 1=1 do begin
  //  OnMouseMove := MouseMove;
  //end;
end;}

//Загрузка всех картинок
procedure pictureload;
begin
  back:=Picture.Create('images/back.png');
  room:=Picture.Create('images/room.png');
end;

//Работа с кнопками
procedure readkey(key:integer);   
  begin
    key1:=key;
  end;

{procedure XYvar2up;
begin 
  if varXY=1 then begin mas[0,nomer]:= mas[0,nomer]-1;varXY:=3;end;
  if varXY=2 then begin mas[-1,nomer]:= mas[-1,nomer]-1;varXY:=4;end;
  if varXY=3 then mas[0,nomer]:= mas[0,nomer]+1;
  if varXY=4 then begin mas[-1,nomer]:= mas[-1,nomer]+1;varXY:=2;end;
end;

procedure XYvar2right;
begin 
  if varXY=1 then begin mas[-1,nomer]:= mas[-1,nomer]+1;varXY:=2;end;
  if varXY=2 then begin mas[0,nomer]:= mas[0,nomer]-1;varXY:=3;end;
  if varXY=3 then begin mas[-1,nomer]:= mas[-1,nomer]-1;varXY:=4;end;
  if varXY=4 then begin mas[0,nomer]:= mas[0,nomer]+1;varXY:=1;end;
end;

procedure XYvar2down;
begin 
  if varXY=1 then begin mas[0,nomer]:= mas[0,nomer]+1;end;
  if varXY=2 then begin mas[-1,nomer]:= mas[-1,nomer]+1;end;
  if varXY=3 then begin mas[0,nomer]:= mas[0,nomer]-1;end;
  if varXY=4 then begin mas[-1,nomer]:= mas[-1,nomer]-1;end;
end;

procedure XYvar2left;
begin 
  if varXY=1 then begin mas[-1,nomer]:= mas[-1,nomer]-1;varXY:=4;end;
  if varXY=2 then begin mas[0,nomer]:= mas[0,nomer]+1;varXY:=1;end;
  if varXY=3 then begin mas[-1,nomer]:= mas[-1,nomer]+1;varXY:=2;end;
  if varXY=4 then begin mas[0,nomer]:= mas[0,nomer]-1;varXY:=3;end;
end;}

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
var i, j: integer;
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
  mas[2,nomer]:=random(3);  // Тип
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
  // Монстры (макс 5шт)
  a1:=random(4);
  if a1 <> 0 then 
    for i:=0 to 4 do begin
        if i <= a1 then begin
          mas[8+i*6+1,nomer]:=random(mas[1,nomer])+1; // Xm 
          mas[8+i*6+2,nomer]:=random(mas[1,nomer])+1; // Ym 
          mas[8+i*6+3,nomer]:=random(10)+1; // LVLm 
          mas[8+i*6+4,nomer]:=random(100)+1; // HPm 
          mas[8+i*6+5,nomer]:=random(100)+1; // Dm 
          mas[8+i*6+6,nomer]:=random(3); // Rm 
        end
        else begin
          mas[8+i*6+1,nomer]:=-1; // Xm 
          mas[8+i*6+2,nomer]:=-1; // Ym 
          mas[8+i*6+3,nomer]:=0; // LVLm 
          mas[8+i*6+4,nomer]:=0; // HPm 
          mas[8+i*6+5,nomer]:=0; // Dm 
          mas[8+i*6+6,nomer]:=0; // Rm 
        end;
    end
  else begin
    for i:=0 to 4 do begin
      mas[8+i*6+1,nomer]:=-1; // Xm 
      mas[8+i*6+2,nomer]:=-1; // Ym 
      mas[8+i*6+3,nomer]:=0; // LVLm 
      mas[8+i*6+4,nomer]:=0; // HPm 
      mas[8+i*6+5,nomer]:=0; // Dm 
      mas[8+i*6+6,nomer]:=0; // Rm 
    end;
  end;
  // Предметы (макс 3шт)
  a1:=random(2);
  if a1 <> 0 then 
    for i:= 0 to 2 do begin
      if i <= a1 then begin
        mas[38+i*2+1,nomer]:= random(mas[1,nomer])+1; // Xp
        mas[38+i*2+2,nomer]:= random(mas[1,nomer])+1; // Yp
      end
      else begin
        mas[38+i*2+1,nomer]:=-1; // Xp
        mas[38+i*2+2,nomer]:=-1; // Yp
      end
    end
    else  
      for i:=0 to 2 do begin
        mas[38+i*2+1,nomer]:=-1; // Xp
        mas[38+i*2+2,nomer]:=-1; // Yp
      end;
  // Фонтан
  a1:=random(100);
  if a1>=85 then begin
    mas[45,nomer]:=random(mas[1,nomer]+1); // Xф
    mas[46,nomer]:=random(mas[1,nomer]+1); // Yф
  end else begin
    mas[45,nomer]:=-1; // Xф
    mas[46,nomer]:=-1; // Yф
  end;
  copyroom;  //переход к уже созданным комнатам
end;

procedure nodoor;
begin
  if ld=1 then if mas[4,nomer] < 1 then enter:=-1 else enter:=1;
  if ld=2 then if mas[5,nomer] < 1 then enter:=-1 else enter:=1;
  if ld=3 then if mas[6,nomer] < 1 then enter:=-1 else enter:=1;
  if ld=4 then if mas[7,nomer] < 1 then enter:=-1 else enter:=1;
end;

procedure loadbase;
var i, j: integer;
begin
assign(t1,'database/database.txt');
reset(t1);
read(t1,str1);
write(str1);
a1:=length(str1);
while str1<>'' do begin
  nomer:= nomer + 1;
  while i <> a1 do begin
    i := i + 1;
    if str1[i]=' ' then begin i := 1; a2 := a2 + 1; 
    if a1 >= i-1 then begin str2:=copy(str1,1,a1); delete(str1,1,a1); val(str2,mas[a2,nomer],code);break;end
                 else begin str2:=copy(str1,1,i-1); delete(str1,1,i); a1:=length(str1); val(str2,mas[a2,nomer],code); end;
    end;
  end;
  read(t1,str1);
end;
close(t1);
end;

procedure masvivod;
var i: integer;
begin
  assign(t1,'database/database.txt');
  append(t1);
  for i:=-1 to 46 do
    write(t1,mas[i,nomer],' ');
    writeln(t1);
  close(t1);
end;

procedure Back1(sprite: PictureABC);
var i, j: integer;
begin 
  sprite:= PictureABC.create(xp, yp, 'images/Back.png');
  objBack:= sprite;
end;

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

procedure pictload;
var i, j: integer;
begin
  for i := 1 to mas[1,nomer] do
    for j := 1 to mas[1,nomer] do begin
      masGraund(objGround[i],i, x, y);
      objGround[i].ToBack;
      if (i = 1)and(j = mas[4,nomer])and(mas[4,nomer]>=1) then begin Door1(objDoor1[1],1,50*(mas[4,nomer]-2)+23,340-25*(mas[4,nomer]-2)); objDoor1[1].ToFront; end;  // p1
      if (j = mas[1,nomer])and(i = mas[5,nomer])and(mas[5,nomer]>=1) then begin Door2(objDoor2[1],1,x+27,y-75); objDoor2[1].ToFront; end;  // p2
      if (i = mas[1,nomer])and(j = mas[6,nomer])and(mas[6,nomer]>=1) then begin Door1(objDoor1[2],2,x+22,y-50); objDoor1[2].ToFront; end;  // p3
      if (j = 1)and(i = mas[7,nomer])and(mas[7,nomer]>=1) then begin Door2(objDoor2[2],2,x-23,y-50); objDoor2[2].ToFront; end;  // p4
      x := x + 50;
      y := y - 25;
      if j = mas[1,nomer] then begin x := 0 + 50 * i-1; y := y1 + 25 * i-1; end;
    end;
    x:=0;
    y:=440;
    write(mas[-1,nomer],' ',mas[0,nomer]);
end;

procedure map;
var i, j: integer;
begin
  xr:=340;
  yr:=340;
  back.Draw(0,0,700,700);
  for i:=1 to nomer do begin
    xr:=xr + 21*mas[-1,i];
    yr:=yr + 21*mas[0,i];
    room.Draw(xr,yr,20,20);
    xr:=340;
    yr:=340;
  end;
end;

procedure spawnmob();
var i, j: integer;
begin
  xe:= 100;
  ye:= 100;
end;

procedure readInfoPlayer();
var i, j: integer;
begin 
  assign(t1, 'database/playerInfo.txt');
  reset(t1);
  read(t1,str1);
  while str1<>'' do begin
    i:=i+1;
    playerInfo[i]:=str1;
    readln(t1);
    read(t1,str1);
  end;
end;

procedure moveEnemy(time, xe, ye: integer);
begin
  if objPlayer.Left > objEnemy.Left then objEnemy.Left:= objEnemy.Left + spEnemy;
  if objPlayer.Left < objEnemy.Left then objEnemy.left:= objEnemy.Left - spEnemy;
  if objPlayer.Top > objEnemy.Top then objEnemy.Top:= objEnemy.Top + spEnemy;
  if objPlayer.Top < objEnemy.Top then objEnemy.Top:= objEnemy.Top - spEnemy; 
  objEnemy.Move;
end;

procedure OpenDoor();
begin
  nodoor; 
  if enter=1 then begin 
    if mas[4,nomer]<>0 then ObjDoor1[1].Destroy;
    if mas[5,nomer]<>0 then ObjDoor2[1].Destroy;
    if mas[6,nomer]<>0 then ObjDoor1[2].Destroy;
    if mas[7,nomer]<>0 then ObjDoor2[2].Destroy;
    generateroom; pictload; masvivod;
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

procedure movePlayer(time, xm, ym: integer);
begin
  if (xp+23<xm) then begin xp:= xp+spPlayer; accept:=false; end else accept:=true;
  if (xp+23>xm) then begin xp:= xp-spPlayer; accept:=false; end else accept:=true;
  if (yp+100<ym) then begin yp:= yp+spPlayer; accept:=false; end else accept:=true;
  if (yp+100>ym) then begin yp:= yp-spPlayer; accept:=false; end else accept:=true; 
  objPlayer.MoveTo(xp, yp);
end;

procedure mouseDownGame(xm, ym, mb: integer);
begin
  case mb of
    1:begin 
      //GenerationEnemysByPlayerN2();
      mb1:= 1; xm1:= xm; ym1:= ym; 
    end;
  end;
end;

procedure BeginMove(scene: string);
begin
  while (scene = 'FightPlayer') do begin
    if scene = 'FightPlayer' then onmousedown:= mousedownGame;
    //ImportantPartProgramPanelAndButtoms(scene);
    if (mb1 = 1)or(accept = false)and(scene = 'FightPlayer') then begin movePlayer(0, xm1, ym1); end; 
    sleep(time);
  end;  
end;

procedure testMouse(xm, ym, mb: integer);
var i, j: integer;
begin
  if (ym<=150)or(ym>=650) then
    scene:= 'PanelAndButtoms'
  else 
    scene:= 'FightPlayer';
end;

begin 
  SetWindowTop(0);
  SetWindowTitle('game_ver_0.0');
  setwindowsize(700,700);
  pictureload;
  Back1(objBack);
  y := 440;
  y1 := y;
  xp:=300;
  yp:=300;
  xm1:=xp + 23;
  ym1:=yp + 100;
  schet:=1;
  time:=17;
  accept:=true;
  
  generateroom;
  pictload;
  objBack.ToBack;
  
  spawnmob;
  
  Player(objPlayer, 1, 100);
  onMouseMove:= TestMouse;
end.