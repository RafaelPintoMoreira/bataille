program bataille;

uses crt;

type jeuxtbl=array[1..10,1..10] of char;



//afficher present jeux
procedure affiche_preJeux;
begin
    gotoxy(5,5); write(' ________           ___     _____________     ___          _____________    _          _         _________  ');
    gotoxy(5,6); write('|  ____  |         / _ \   |_____   _____|   / _ \        |_____   _____|  | |        | |       |         | ');
    gotoxy(5,7); write('| |    | |        / / \ \        | |        / / \ \             | |        | |        | |       |  _______| ');
    gotoxy(5,8); write('| |____| |       / /   \ \       | |       / /   \ \            | |        | |        | |       | |         ');
    gotoxy(5,9); write('| _______|      / /_____\ \      | |      / /_____\ \           | |        | |        | |       | |______   ');
    gotoxy(5,10);write('|  ____  |     / _________ \     | |     / _________ \          | |        | |        | |       |  ______|  ');
    gotoxy(5,11);write('| |    | |    / /         \ \    | |    / /         \ \         | |        | |        | |       | |         ');
    gotoxy(5,12);write('| |    | |   / /           \ \   | |   / /           \ \        | |        | |        | |       | |________ ');
    gotoxy(5,13);write('| |____| |  / /             \ \  | |  / /             \ \   ____| |____    | |______  | |______ |          |');
    gotoxy(5,14);write('|________| /_/               \_\ |_| /_/               \_\ |____________|  |________| |________||__________|');
    readln;
    clrscr;

    gotoxy(5,5);write('Bonjour etes vous pret a en decoudre!!');readln;clrscr;
    gotoxy(5,5);write('Alor ne tricher pas et respecter le tour de chaque joueur!!');readln;clrscr;
    gotoxy(5,5);write('Bonne chance et amuser vous ;) !!!');readln;clrscr;
    gotoxy(5,5);write('START Push ENTER!');
end;
//recup nom joueur
function nomjoueur(nbrj:integer):string;
var nom :string;
begin
    IF nbrj=1 then
    begin
        gotoxy(42,2);
        write('Entrer le nom du joueur N.1: ');
        read(nom);
        gotoxy(48,2);
        write('Enchanter ',nom,' bonne chance!');
        readln;
        clrscr;
    end;
    IF nbrj=2 then
    begin
        gotoxy(42,2);
        write('Entrer le nom du joueur N.2: ');
        read(nom);
        gotoxy(48,2);
        write('Enchanter ',nom,' bonne chance!');
        readln;
        clrscr;
    end;
    nomjoueur:=nom;
end;


//init des char du tableau
function int_char(i:integer):char;
begin
    case i of
        1 : int_char := ' ';
        2 : int_char := '1';
        3 : int_char := '2';
        4 : int_char := '3';
        5 : int_char := '4';
        6 : int_char := '5';
        7 : int_char := '6';
        8 : int_char := '7';
        9 : int_char := '8';
        10 : int_char :='9';
    end;
end;
//afficher map
procedure affiche (var jeux:jeuxtbl);
var i,j:integer;
begin

    for i:= 1 to 10 do
    begin
        jeux[i,1]:= int_char(i);
        gotoxy(i*2,1);
        //write(jeux[i,1]);

        jeux[1,i]:= int_char(i);
        gotoxy(1,i+1);
        //writeln(jeux[1,i]);

    end;
    for i:= 1 to 10 do
        for j:= 1 to 10 do
        begin
            gotoxy(i*2,j);
            //jeux[i,j]:= '-' ;

            if jeux[i,j]='-' then
                textcolor(blue)
            else
                if jeux[i,j] = 'X' then
                    textcolor(green)
                else
                    if jeux[i,j] = 'O' then
                        textcolor(red)
                    else textcolor(6);//orange

            write (jeux[i,j]);

        end;
end;
//map vide
function vide(var map:jeuxtbl;car:char):jeuxtbl;
var i,j:integer;
begin
    for i:= 1 to 10 do
        for j:= 1 to 10 do
            map[i,j]:=car;

    vide:=map;
end;

function remplace_map(entrer1,sorti1,entrer2,sorti2:integer;map:jeuxtbl;sensPoseBat:char):jeuxtbl;
var maptemp:jeuxtbl;
var i,j:integer;
begin
    maptemp:=map;
    if sensPoseBat='V' then
    begin
        for i:=entrer2 to sorti2 do
        begin
            for j:=entrer1 to sorti1 do
            begin
                maptemp[i,j]:='X';
                entrer1:=entrer1+1;
            end;
        end;
        affiche(maptemp);
    end
    else
        if sensPoseBat='H' then
        begin
            for i:=entrer1 to sorti1 do
            begin
                //maque?
                for j:= entrer2 to sorti2 do
                begin
                    maptemp[j,i]:='X';
                    entrer2:=entrer2+1;
                end;
            end;
            affiche(maptemp);
        end
        else
            if sensPoseBat=' ' then
            begin
                maptemp[entrer2,entrer1]:='*';
            end;
        remplace_map:=maptemp;
end;

function saisir_emplacement(var map:jeuxtbl;sensPoseBat:char;casesBateau:integer):jeuxtbl;
var entrer1,sorti1,entrer2,sorti2,delta_place:integer;
begin
    repeat
        entrer1:=0;
        sorti1:=0;
        entrer2:=0;
        sorti2:=0;

        while ((entrer1<1)or(entrer1>10)or
                (entrer2<1)or(entrer2>10)or
                (sorti1<1)or(sorti1>10)or
                (sorti2<1)or(sorti2>10)) do
        begin
            gotoxy(2,15);
            write('veuiller rentrer les 2 chiffre de la premier cases!Le 1chiffre V le 2chiffre H!');
            gotoxy(2,16);
            readln(entrer1);
            entrer1:=entrer1+1;

            gotoxy(2,17);
            readln(entrer2);
            entrer2:=entrer2+1;

            gotoxy(2,18);
            write('veuiller rentrer les 2 de la deuxieme cases!Le 1chiffre V le 2chiffre H!');
            gotoxy(2,19);
            readln(sorti1);
            sorti1:=sorti1+1;

            gotoxy(2,20);
            readln(sorti2);
            sorti2:=sorti2+1;
        end;

        if sensPoseBat='V' then
        begin
            delta_place:=(sorti1-entrer1)+1;
        end;
        if sensPoseBat='H' then
        begin
            delta_place:=(sorti2-entrer2)+1;
        end;
        // cordoner pas accepter
        if ((map[entrer2,entrer1]='O')or
            (map[sorti2,sorti1]='O')or
            (map[entrer2,entrer1]='X')or
            (map[sorti2,sorti1]='X')or
            (delta_place>casesBateau)or
            (delta_place<casesBateau)) then
        begin
            writeln('L''emplacement designe manque de place ou n''existe pas.');
            writeln('Veuillez appuyer sur entrer');
        end;
        readln;
    until ((map[entrer2,entrer1]='-')and(map[sorti2,sorti1]='-')and(delta_place=casesBateau));
    saisir_emplacement:=remplace_map(entrer1,sorti1,entrer2,sorti2,map,sensPoseBat);
end;

function place_libre(var map:jeuxtbl;carVide:char;bateauNom:string;casesBateau:integer):jeuxtbl;
var i,j,nbrcase,casesLibr,jTemp:integer;
    carLibr,sensPoseBat:char;
    maptemp:jeuxtbl;
begin
    casesLibr:=0;
    nbrcase:=1;
    jTemp:=2;
    carLibr:=' ';
    maptemp:=map;

    affiche(map);
    gotoxy(2,12);
    writeln('Le ',bateauNom,' comprend ',casesBateau, ' cases.');
    repeat
        gotoxy(2,13);
        write('Voulez-vous le placer H ou V?');
        gotoxy(2,14);
        readln(sensPoseBat);
    until((sensPoseBat='V')or(sensPoseBat='H'));

    if ((sensPoseBat='H')or(sensPoseBat='V')) then
    begin
        for i:=1 to 10 do
        begin
            for j:=1 to 10 do
            begin
                if maptemp[i,j]=carVide then
                    casesLibr:=casesLibr+1
                else
                    casesLibr:=0;

                if casesLibr=casesBateau then
                begin
                    maptemp[i,j]:='-';
                    jTemp:=j+1;
                    for nbrcase:=1 to casesBateau do
                    begin
                        jTemp:=jTemp-1;
                        maptemp[i,jTemp]:='-';
                    end;
                    casesLibr:=0;
                end;

            end;
            casesLibr:=0;
        end;
    end;

    affiche(maptemp);
    place_libre:=saisir_emplacement(maptemp,sensPoseBat,casesBateau);

end;

function initiation_map(var map:jeuxtbl;car_vide:char;bateauNom:string;casesBateau:integer):jeuxtbl;

begin
    map:=place_libre(map,car_vide,bateauNom,casesBateau);
    readln;
    clrscr;
    initiation_map:=map;
end;

function verifPos(entrer1,entrer2:integer;var map:jeuxtbl):jeuxtbl;
var maptemp:jeuxtbl;
begin
    maptemp:=map;

    if map[entrer2,entrer1]='X' then
    begin

        if((entrer1>1)or(entrer1<10)) then
        begin
            if ((entrer2>1)or(entrer2<10)) then
            begin
                if ((map[entrer2-1,entrer1]='X')or
                    (map[entrer2,entrer1]='X')or
                    (map[entrer2,entrer1-1]='X')or
                    (map[entrer2,entrer1+1]='X')) then

                        writeln('toucher')
                else
                    writeln('toucher & couler !!');
            end
            else
                if entrer2=1 then
                begin
                    if ((map[entrer2+1,entrer1]='X')or
                        (map[entrer2,entrer1-1]='X')or
                        (map[entrer2,entrer1+1]='X')) then

                            writeln('toucher')
                    else
                        writeln('toucher & couler !!');
                end
                else
                    if entrer2=10 then
                    begin
                        if ((map[entrer2-1,entrer1]='X')or
                            (map[entrer2,entrer1-1]='X')or
                            (map[entrer2,entrer1+1]='X')) then

                                 writeln('toucher')
                        else
                            writeln('toucher & couler !!');
                    end;
        end
        else
            if entrer1=1 then
            begin
                if ((entrer2>1)or(entrer2<10)) then
                begin
                    if ((map[entrer2-1,entrer1]='X')or
                        (map[entrer2+1,entrer1]='X')or
                        (map[entrer2,entrer1+1]='X')) then

                            writeln('toucher')
                    else
                        writeln('toucher & couler !!');
                end
                else
                    if entrer2=1 then
                    begin
                        if ((map[entrer2+1,entrer1]='X')or
                            (map[entrer2,entrer1+1]='X')) then

                                writeln('toucher')
                        else
                            writeln('toucher & couler !!');
                    end
                    else
                        if entrer2=10 then
                        begin
                            if ((map[entrer2-1,entrer1]='X')or
                                (map[entrer2,entrer1+1]='X')) then

                                    writeln('toucher')
                            else
                                writeln('toucher & couler !!');
                        end;
            end
            else
                if entrer1=10 then
                begin
                    if ((entrer2>1)or(entrer2<10)) then
                    begin
                        if ((map[entrer2-1,entrer1]='X')or
                            (map[entrer2+1,entrer1]='X')or
                            (map[entrer2,entrer1-1]='X')) then

                                writeln('toucher')
                        else
                            writeln('toucher & couler !!');
                    end
                    else
                        if entrer2=1 then
                        begin
                            if ((map[entrer2+1,entrer1]='X')or
                                (map[entrer2,entrer1-1]='X')) then

                                    writeln('toucher')
                            else
                                writeln('toucher & couler !!');
                        end
                        else
                            if entrer2=10 then
                            begin
                                if ((map[entrer2-1,entrer1]='X')or
                                    (map[entrer2,entrer1-1]='X')) then

                                        writeln('toucher')
                                else
                                    writeln('toucher & couler !!');
                            end;
                end;
                maptemp:=remplace_map(entrer1,0,entrer2,0,map,' ');
    end
    else
        writeln('RATER');

    verifPos:=maptemp;

end;

function tirer(var map:jeuxtbl):jeuxtbl;
var entrer1,entrer2:integer;
var maptemp:jeuxtbl;
begin
    maptemp:=map;
    entrer1:=0;
    entrer2:=0;

    while ((entrer1<1)or(entrer1>10)or
            (entrer2<1)or(entrer2>10)) do
    begin
        gotoxy(2,15);
        write('veulliez entrer les 2 nbr correspondant a la position d''attaque en commencant par le nbr V puis H!');
        gotoxy(2,16);
        readln(entrer1);
        entrer1:=entrer1+1;

        gotoxy(2,17);
        readln(entrer2);
        entrer2:=entrer2+1;
    end;

    maptemp:=verifPos(entrer1,entrer2,map);
    tirer:=maptemp;
end;

function suivre_tire(var map:jeuxtbl; suivi_map:jeuxtbl):jeuxtbl;
var i,j:integer;
begin
    for i:=1 to 10 do
        for j:=1 to 10 do
            if map[i,j]='*' then
                suivi_map[i,j]:='/';

    suivre_tire:=suivi_map;
end;

function Vict(map:jeuxtbl;nb_a_abattre:integer):boolean;
var i,j,n_case_Lbr:integer;
begin
    n_case_Lbr:=0;
    for i:=1 to 10 do
    begin
        for j:=1 to 10 do
        begin
            if (map[i,j]='*') then
                n_case_Lbr:=n_case_Lbr+1;
        end;
    end;

    if (n_case_Lbr=nb_a_abattre) then
    begin
        Vict:=true;
    end
    else
    begin
        Vict:=false;
    end;

end;

var
    i,j,porte_avion,sous_marin,mini_croiseur,nbr_case_nav,nJ1,nJ2:integer;
    n_porte_avion,n_sous_marin,n_mini_croiseur,nom1,nom2:string;
    car_vide,exitKay:char;
    map1, map2, s_map1, s_map2:jeuxtbl;
    vict1, vict2:boolean;
//debut du programme principal
begin
    vict1:=false;
    vict2:=false;
    clrscr;
    repeat
        car_vide:='O';// caracter de la map vide
        //taille des bateau
        porte_avion:=4;
        sous_marin:= 3;
        mini_croiseur:=2;
        nbr_case_nav:=9; //nbr de case occuper par tout les navir
        nJ1:=1;
        nJ2:=2;
        //initialiser les nom
        nom1:=' ';
        nom2:=' ';
        n_porte_avion:='Porte avion';
        n_sous_marin:='Sous marin';
        n_mini_croiseur:='Mini-croiseur';
        //initialiser map vide
        map1:=vide(map1,car_vide);
        map2:=vide(map2,car_vide);
        s_map1:=vide(s_map1,car_vide);//suivi 1
        s_map2:=vide(s_map2,car_vide);//suivi 2


        //prensenter le jeu
        clrscr;
        affiche_preJeux;
        readln;
        clrscr;
        nom1:=nomjoueur(nJ1);
        nom2:=nomjoueur(nJ2);

        //initialiser map 1er joueur
        affiche(map1);
        gotoxy(50,5);
        write('votre map ',nom1);
        gotoxy(2,20);
        write('veuillez appuyer sur entrer pour commencer !');
        readln;
        clrscr;
        // mise en place 1
        map1:=initiation_map(map1,car_vide,n_sous_marin,sous_marin);
        map1:=initiation_map(map1,car_vide,n_porte_avion,porte_avion);
        map1:=initiation_map(map1,car_vide,n_mini_croiseur,mini_croiseur);
        readln;
        clrscr;

        //initialiser map 2iem joueur
        affiche(map2);
        gotoxy(50,5);
        write('votre map ',nom2);
        gotoxy(2,20);
        write('veuillez appuyer sur entrer pour commencer !');
        readln;
        clrscr;
        // mise en place 2
        map2:=initiation_map(map2,car_vide,n_sous_marin,sous_marin);
        map2:=initiation_map(map2,car_vide,n_porte_avion,porte_avion);
        map2:=initiation_map(map2,car_vide,n_mini_croiseur,mini_croiseur);
        readln;
        clrscr;

        gotoxy(2,30);
        writeln('Le placement est terminer. Le jeu peut commencer!');
        clrscr;

        while ((vict2=false)and(vict1=false)) do
        begin
            // tour J1
                affiche(s_map2);
                gotoxy(2,14);
                write('Choisi la position d''attaque! ',nom1);
                map2:=tirer(map2);
                s_map2:=suivre_tire(map2,s_map2);
                affiche(s_map2);
                vict1:=Vict(map2,nbr_case_nav);
                readln;
                clrscr;
                if(vict1=false) then
                begin
                   
                    // regarder chez victoir ??? il n'affiche pa le gangant!!
                    // tour J2
                    affiche(s_map1);
                    gotoxy(2,14);
                    write('Choisi la position d''attaque! ',nom2);
                    map1:=tirer(map1);
                    s_map1:=suivre_tire(map1,s_map1);
                    affiche(s_map1);
                    vict2:=Vict(map1,nbr_case_nav);
                    readln;
                    clrscr;
                end;
        end;

        textcolor(white);
        gotoxy(10,10);
        writeln('Fin de la partie, nous avons un vainqueur');

        if (vict1=true) then
        begin
            gotoxy(10,13);
           
            textcolor(green);
            writeln('Felicitation ',nom1,', vous gagnez!');  
        end
        else
        begin
             if (vict2=true) then
            begin
                gotoxy(10,13);
                
                textcolor(green);
                writeln('Felicitation ',nom2,', vous  gagnez!');
            end;
        end;
           

        readln;
        clrscr;
        gotoxy(10,10);
        write('pour sortir entrer s pour rejouer r');
        readln(exitKay);
    until((exitKay='S')or(exitKay='s'));
    affiche(map1);
    readln;
    affiche(map2);
    readln();
end.
