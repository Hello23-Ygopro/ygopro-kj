--Ninja Pumpkin
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_WILD_VEGGIE)
	--creature
	aux.EnableCreatureAttribute(c)
	--must be attacked
	aux.EnableMustBeAttacked(c)
end
