--Ballistic Skyterror
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CORRUPTED,RACE_ATTACK_RAPTOR)
	--creature
	aux.EnableCreatureAttribute(c)
end
