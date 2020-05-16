--Taunting Totem
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SPIRIT_TOTEM)
	--creature
	aux.EnableCreatureAttribute(c)
	--must be attacked
	aux.EnableMustBeAttacked(c)
end
