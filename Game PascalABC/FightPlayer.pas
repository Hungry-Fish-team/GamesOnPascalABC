// Владелец: Владимир Балыш @Запрещено полное либо частичное копирование !!!
// Owner: Mr.Balysh @Forbidden total or partial copy !!!
unit FightPlayer;

uses graphABC, ABCObjects;

var 
  a1, a2, i, j, key1, scena, nomer, code, ld, varXY, enter, schet: integer;
  timeToAttack, speedAttackPlayer, speedAttackEnemy, HPPlayer, HPEnemy, DamagePlayer, DamageEnemy, ProtectPlayer, ProtectEnemy, LvlPlayer, LvlEnemy : integer;
  ground, wall, back, room: picture;
  x, y, x1, y1, xvar1, yvar1, xr, yr, spPlayer, xp, yp, xm, ym, xm1, ym1, spEnemy, xe, ye, xe1, ye1, mb1, time: integer;
  accept: boolean;
  str1, str2, scene: string;
  objPlayer, objEnemy: pictureABC;
  t1: text;
  
  playerInfo:array[1..7]of string;
  
  EnemysInventar:array[1..12,1..20,1..5]of string;
  EnemysInfo:array[1..8,1..5]of string;
  
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

procedure writeInfoPlayer;
var i, j: integer;
begin 
  for i:= 1 to 7 do
  write(PlayerInfo[i],' ');
end;

procedure RandomEnemy();
var randomNumber: integer;
begin
  randomNumber:= random(1)+1;
  
  if randomNumber = 1 then EnemysInfo[1,1]:='zombie';
  
end;

procedure GenerationEnemysByPlayer();  // Генерация статистики монстров относительно уровня игрока
var i, j: integer;
begin
  RandomEnemy();

  val(PlayerInfo[1], LvlPlayer, code);
  if lvlPlayer = 1 then begin LvlEnemy:= lvlPlayer; str(lvlEnemy, EnemysInfo[2,1]); end
  else begin lvlEnemy:= lvlPlayer + random(2)-1; str(lvlEnemy, EnemysInfo[2,1]); end;
  
  if EnemysInfo[1,1] = 'zombie' then begin HPenemy:= 40*LvlEnemy+random(5*lvlEnemy)+1; str(HPEnemy, EnemysInfo[3,1]); end;  // Варианты хп и типов
end;

procedure GenerationItemsEnemys();  // Генерация предметов у монстров 
var i, j, k, randomNumber, RN: integer;
begin
  for i:= 1 to 12 do begin
    randomNumber:= random(24)-11;
    if randomNumber>0 then begin 
      if randomNumber=1 then begin
        EnemysInventar[i, 1, 1]:= 'sword';  // Типы предметов 
        
        str(LvlEnemy, EnemysInventar[i, 2, 1]);
        
        DamageEnemy:= (HPEnemy div 10) + random(HPEnemy div 10)+1;
        str(DamageEnemy, str1);
        EnemysInventar[i, 2, 1]:= 'D'+ str1;
      end
      else if randomNumber = 6 then begin
        EnemysInventar[i, 1, 1]:= 'helmet';
        
        str(LvlEnemy, EnemysInventar[i, 2, 1]);
        
        ProtectEnemy:= (HPEnemy div 10) + random(HPEnemy div 10)+1;
        str(ProtectEnemy, str1);
        EnemysInventar[i, 2, 1]:= 'P'+ str1;
      end;  
      
      EnemysInventar[i, 3, 1]:= 'S' ;
      EnemysInventar[i, 4, 1]:= 'L' ;
      EnemysInventar[i, 5, 1]:= 'I' ;
        
      for j:=1 to 5 do begin
        RN:= random(20)-10;
        if RN>0 then begin 
          if EnemysInventar[i, 1, 1]= 'sword' then str2:='D' else 
          if (EnemysInventar[i, 1, 1]= 'helmet')or(EnemysInventar[i, 1, 1]= 'Boots')or(EnemysInventar[i, 1, 1]= 'ChestArmor')or(EnemysInventar[i, 1, 1]= 'Pants')or(EnemysInventar[i, 1, 1]= 'ShoulderStraps') then str2:='P' else 
          EnemysInventar[i, j+5, 1]:= '+' + str2 + RN;
        end
        else EnemysInventar[i, j+5, 1]:= '.';
      end;   
    end    
    else begin 
      for j:=1 to 14 do EnemysInventar[i, j, 1]:= '.';
    end;
  end;
end;

procedure GenerationEnemysByPlayerN2();  // Продолжение процесса генерации статистики врага
var i, j, DamageEnemyN2, ProtectEnemyN2: integer;
begin
  GenerationEnemysByPlayer();
  GenerationItemsEnemys();
  
  for i:= 1 to 12 do 
    if EnemysInventar[i, 1, 1]= 'sword' then begin  // Подсчет статистики с одетой броней
      str1:=copy(EnemysInventar[i, 3, 1], 2, length(EnemysInventar[i, 3, 1])-1);
      val(str2, DamageEnemyN2, code);
      str(DamageEnemyN2+DamageEnemy, EnemysInfo[5,1])
    end
    else 
    if EnemysInventar[i, 1, 1]= 'helmet' then begin
      str1:=copy(EnemysInventar[i, 3, 1], 2, length(EnemysInventar[i, 3, 1])-1);
      val(str2, ProtectEnemyN2, code);
      str(ProtectEnemyN2+ProtectEnemy, EnemysInfo[6,1])
    end;
  
  {for i:=1 to 12 do
    for j:=1 to 14 do begin
      write(EnemysInventar[i, j, 1],' ');
    end;}
    
  {for i:=1 to 8 do 
    write(EnemysInfo[i, 1],' ');}
end;

procedure FightPlayerGame();
var i, j: integer;
begin
  i:=0;
  val(PlayerInfo[6], speedAttackPlayer, code);
  if i>=(20*speedAttackPlayer) then begin
    write('0');
    val(PlayerInfo[1], LvlPlayer, code);
    val(PlayerInfo[2], HPPlayer, code);
    //val(PlayerInfo[3], DamagePlayer, code);
    val(PlayerInfo[4], DamagePlayer, code);
    val(PlayerInfo[5], ProtectPlayer, code);
    
    i:=0;
    HPEnemy:=HPenemy-(DamagePlayer+(random(DamagePlayer)-(lvlPlayer+3)));
    
    hpPlayer:=hpPlayer-(DamageEnemy+(random(DamageEnemy)-(lvlPlayer+3)));
    
    //if HPEnemy<=0 then objEnemy.Destroy;
  
    str(LvlPlayer, PlayerInfo[1]);
    str(HPPlayer, PlayerInfo[2]);
    //str(LvlPlayer, PlayerInfo[3]);
    str(DamagePlayer, PlayerInfo[4]);
    str(ProtectPlayer, PlayerInfo[5]);
  end
  else begin
    write('1');
    i:=i+1;
    sleep(1);
  end;
end;

begin

  readInfoPlayer;
  GenerationEnemysByPlayerN2();
  //writeInfoPlayer;

end.  