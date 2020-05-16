--Flame-Vent Diver
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TRENCH_HUNTER,RACE_DRAKON)
	--creature
	aux.EnableCreatureAttribute(c)
end
