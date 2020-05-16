--Lumbering Coliseum
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LIVING_CITY)
	--creature
	aux.EnableCreatureAttribute(c)
end
