--Seer Serpent
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_FRACTAL)
	--creature
	aux.EnableCreatureAttribute(c)
	--search (to hand)
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.SendtoHandOperation(PLAYER_SELF,scard.thfilter,LOCATION_DECK,0,0,1,true))
end
--search (to hand)
function scard.thfilter(c)
	return c:IsSpell() and c:IsCivilization(CIVILIZATION_LIGHT)
end
