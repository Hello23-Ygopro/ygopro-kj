--Supreme Dragon Bolshack
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--fast attack
	aux.EnableEffectCustom(c,EFFECT_FAST_ATTACK)
	--triple breaker
	aux.EnableBreaker(c,EFFECT_TRIPLE_BREAKER)
	--search (to battle)
	aux.AddTriggerEffectBecomeTarget(c,0,nil,nil,aux.SendtoBZoneOperation(PLAYER_SELF,scard.tbfilter,LOCATION_DECK,0,0,1))
end
--search (to battle)
function scard.tbfilter(c)
	return not c:IsEvolution() and c:KJIsRace(RACE_ARMORED_DRAGON) and c:IsManaCostBelow(7)
end
