--Silver Axe
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BEAST_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
end
