--Sentinel Orb
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BATTLE_SPHERE)
	--creature
	aux.EnableCreatureAttribute(c)
end
