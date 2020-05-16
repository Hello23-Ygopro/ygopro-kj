--Lava Leaper
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DUNE_GECKO)
	--creature
	aux.EnableCreatureAttribute(c)
	--cannot be attacked
	aux.EnableCannotBeAttacked(c,aux.TargetBoolFunction(Card.IsPowerBelow,3000))
end
