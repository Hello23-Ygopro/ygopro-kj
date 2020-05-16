--The Mystic of Water
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MYSTIC)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--guard
	aux.EnableGuard(c)
	--search (to hand)
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.SendtoHandOperation(PLAYER_SELF,scard.thfilter,LOCATION_DECK,0,0,1,true))
end
--search (to hand)
function scard.thfilter(c)
	return c:IsSpell() and c:IsCivilization(CIVILIZATION_WATER)
end
