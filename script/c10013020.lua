--Photon Weaver
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SKY_WEAVER)
	--creature
	aux.EnableCreatureAttribute(c)
end
