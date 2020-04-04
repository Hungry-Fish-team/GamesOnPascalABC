// Владелец: Владимир Балыш @Запрещено полное либо частичное копирование !!!
// Owner: Mr.Balysh @Forbidden total or partial copy !!!
unit Inv;

uses graphABC, ABCObjects;

var 
  i, j, coli, col, code, number, nomerObjX, nomerObjY, lastnumber, lastX, lastY, lastNameInfo, InfoName, obmenInfoInt, timeUp, TypeInv, lastTypeInv, objOn1, lastObjOn1: integer;
  x1, y1, xi, yi, xi1, yi1, xm1, ym1, xt, yt, xi2, yi2: integer;
  workObj, workObj1: boolean;
  objInventar, Obj1, obmenInfoPict: PictureABC;
  txt1, pInfo1, pInfo2, pInfo3, pInfo4, pInfo5, pInfo6, pInfo7, pInfo8, pInfo9, pInfo10: TextABC;
  str1, lastInfo, obmenInfoStr, scene2, scene: string;
  
  masInfo: array[0..20,1..66] of string;
  masObj: array[0..66] of PictureABC;
  masObjNumber: array[0..66] of integer;
  masPlayerInfo: array[0..20] of integer;
  masPInfo: array[0..20] of TextABC;
  masTxt: array[1..9] of TextABC;
  
  t1: text;
  
//Interface  // 
//Procedure ImportantPartProgram;   

procedure readinfo();
var i, j, len: integer;
begin
  assign(t1,'database/inventar.txt');
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

procedure writeinfo;
var i, j: integer;
begin
  assign(t1,'database/inventar.txt');
  rewrite(t1);
  val(masInfo[0,coli],col,code);
  for i:=1 to 48 do 
    for j:=1 to col do begin
      if j<>col then write(t1,masInfo[j,i],' ');
      if j=col then begin write(t1,masInfo[j,i]); val(masInfo[0,48],col,code); if i<>48 then  writeln(t1); end;
    end;
  writeln(t1);
  for i:=49 to 66 do 
    for j:=1 to col do begin
      if j<>col then write(t1,masInfo[j,i],' ');
      if j=col then begin write(t1,masInfo[j,i]); val(masInfo[0,66],col,code); if i<>66 then  writeln(t1); end;
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

procedure loadobject();
var i, j: integer;
begin
  xi:=13;
  yi:=115;
  Inventar(objInventar, 0, 0); 
  for i:=1 to 48 do begin
    if masInfo[1, i]<>'.' then begin
      val(masInfo[12,i],xi1,code);
      val(masInfo[13,i],yi1,code);
      xi:=13+51*xi1;
      yi:=64+51*yi1;
      if masInfo[1,i]='sword' then begin Sword(masObj[i], i, xi, yi); end;
      if masInfo[1,i]='helmet' then begin Helmet(masObj[i], i, xi, yi); end;
    end;
  end;
  for i:=49 to 66 do begin
    if masInfo[1, i]<>'.' then begin
      val(masInfo[12,i],xi1,code);
      val(masInfo[13,i],yi1,code);
      xi:=484+51*xi1;
      yi:=64+51*yi1;
      if masInfo[1,i]='sword' then begin Sword(masObj[i], i, xi, yi); end;
      if masInfo[1,i]='helmet' then begin Helmet(masObj[i], i, xi, yi); end;
    end;
  end;
end;

procedure closeinventar();
var i, j, NOX, NOY: integer;
begin
  if (xm1>=637)and(xm1<=647)and(ym1>=89)and(ym1<=99)then begin
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
        for j:=3 to 11 do
          if masInfo[j, i]<>'.' then masTxT[j-2].Destroy;
      end; 
    for i:=1 to 10 do 
      masPInfo[i].Destroy;    
    objInventar.Destroy;
    scene2:= 'PanelAndButtoms';
  end;
end;

procedure mousedownInv(xm, ym, mb: integer);
begin
  case mb of
    1:begin xm1:= xm; ym1:= ym; closeinventar(); end;
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

procedure PlayerInfo();
var i, j: integer;
begin
  for i:=1 to 10 do begin
    masPlayerInfo[i]:= i;
  end;
  for i:=49 to 66 do begin
    if masInfo[1, i]='sword' then begin
      str1:=masInfo[3, i];
      val(str1[2], obmenInfoInt, code);
      masPlayerInfo[7]:= masPlayerInfo[7] + obmenInfoInt;
    end;
    if masInfo[1, i]='helmet' then begin
      str1:=masInfo[3, i];
      val(str1[2], obmenInfoInt, code);
      masPlayerInfo[8]:= masPlayerInfo[8] + obmenInfoInt;
    end;
    if masInfo[1,i]<>'.' then inc(objOn1);
  end;
  if (objOn1<>lastObjOn1)and(lastObjOn1<>0){or(objOn1<>0)} then begin // Стату чини, дублируется число, проблема в полной отчистке !
    for i:=1 to 10 do begin
      maspInfo[i].Destroy;
    end;
    
  end;  
  for i:=1 to 10 do begin
    str(masPlayerInfo[i], str1);
    maspInfo[i] := new TextABC(193, 433+15*(i-1), 9, str1, clBlack);
  end;
  
  lastObjOn1:= objOn1;
  
end;

procedure NameObj();
begin
  if masInfo[1, number]='sword' then infoName:=1;
  if masInfo[1, number]='helmet' then infoName:=6;
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
    nomerObjX:= (xm-65) div 50+1;
    nomerObjY:= (ym-115) div 50+1;
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
    nomerObjX:= (xm-535) div 50+1;
    nomerObjY:= (ym-115) div 50+1;
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
  if workObj= true then begin 
    cordObj1(xm, ym);
    if workObj1 = True then objInfo;
  end;
  case mb of 
    1: if workObj1 = True then begin masObj[masobjnumber[number]].MoveTo(xm-30, ym-30); NameObj(); workObj:= False; end;
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
    
  playerInfo();
end;

procedure LoadInventar();
var i, j:integer;
begin
  readinfo;
  writeinfo();
  loadobject();
end;

procedure ImportantPartProgramInv(scene: string);
begin
  scene2:= scene;
  if scene2 = 'inventar' then begin
    workObj:= True;
  
    Loadinventar;
    if scene2 = 'inventar' then playerInfo;
  
    onmousedown:= mousedownInv;
    onmouseMove:= objMove;
    onmouseup:= workObjOn;
  end;
end;

begin 
end.
 