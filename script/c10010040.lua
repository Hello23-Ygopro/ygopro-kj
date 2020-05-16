--Skyvolt Mech
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CORRUPTED,RACE_MECHA_THUNDER)
	--creature
	aux.EnableCreatureAttribute(c)
end
