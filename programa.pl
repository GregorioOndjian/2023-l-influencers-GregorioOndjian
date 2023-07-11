% Aquí va el código.
canal(ana,yt,3000000).
canal(ana,ig,2700000).
canal(ana,twich,2).
canal(ana,tiktok,1000000).
canal(beto,twich,120000).
canal(beto,yt,6000000).
canal(beto,ig,1100000).
canal(cami,tiktok,2000).
canal(dani,yt,1000000).
canal(evelyn,ig,1).


persona(Persona):-
    canal(Persona,_,_).


%2
seguidoresTotales(Persona,CantSeguidores):-
    persona(Persona),
    findall(Seguidores,canal(Persona,_,Seguidores),ListaSeguidores),
    sum_list(ListaSeguidores, CantSeguidores).
    

influencer(Persona):-
    persona(Persona),
    seguidoresTotales(Persona,CantSeguidores),
    CantSeguidores > 10000.

redActiva(RedSocial):-canal(_,RedSocial,_).

omnipresente(Persona):-
    persona(Persona),
    forall(redActiva(RedSocial),canal(Persona,RedSocial,_)).

exclusivo(Persona):-
    persona(Persona),
    findall(Cuenta,canal(Persona,Cuenta,_),ListaCuentas),
    length(ListaCuentas, CantCuentas),
    CantCuentas == 1.
    
%3

%a 
contenido(ana,tiktok,video([beto,evelyn],1)).
contenido(ana,tiktok,video([ana],1)).
contenido(ana,ig,foto([ana])).

contenido(beto,ig,foto([])).

contenido(cami,twich,stream(lol)).
contenido(cami,yt,video([cami],5)).

contenido(evelyn,ig,foto([evelyn,cami,a,a,a])).

%b
tematicaJuegos(lol).
tematicaJuegos(minecraft).
tematicaJuegos(aoe).

%4

adictiva(Red):-
    redActiva(Red),
    forall(contenido(_,Red,Contenido),contenidoAdictivo(Contenido)).

contenidoAdictivo(foto(ListaParticipantes)):-
    length(ListaParticipantes,CantParticipantes),
    CantParticipantes < 4.

contenidoAdictivo(video(_,Duracion)):-
    Duracion < 3.

contenidoAdictivo(stream(Tematica)):-
    tematicaJuegos(Tematica).


%5
participantes(_,video(Participantes,_),Participantes).

participantes(_,foto(Participantes),Participantes).

participantes(Usuario,stream(_),[Usuario]).


colaboran(Usuario1,Usuario2):-
    participaEn(Usuario1,Usuario2).

colaboran(Usuario1,Usuario2):-
    participaEn(Usuario2,Usuario1).


participaEn(Usuario1,Usuario2):-
    contenido(Usuario1,_,Contenido),
    participantes(Usuario1,Contenido,ParticipantesContenido),
    member(Usuario2,ParticipantesContenido).
    
    
%6




caminoALaFama(Usuario):-
    colaboran(Famoso, Usuario),
    Famoso \= Usuario,
    not(influencer(Usuario)),
    tieneFama(Famoso).

tieneFama(Usuario):-
    influencer(Usuario).
tieneFama(Usuario):-
    caminoALaFama(Usuario).

    


