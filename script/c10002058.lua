--Bat-Breath Scaradorable
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CHIMERA)
	aux.AddNameCategory(c,NAMECAT_SCARADORABLE)
	--creature
	aux.EnableCreatureAttribute(c)
	--cannot be attacked
	aux.EnableCannotBeAttacked(c,aux.TargetBoolFunction(Card.IsManaCostBelow,5))
	--cannot be blocked
	aux.EnableCannotBeBlocked(c,aux.CannotBeBlockedBoolFunction(Card.IsManaCostBelow,5))
end
