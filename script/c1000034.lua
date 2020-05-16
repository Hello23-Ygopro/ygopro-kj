--Enslaved Flametropus
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CORRUPTED,RACE_ROCK_BRUTE)
	--creature
	aux.EnableCreatureAttribute(c)
	--powerful attack
	aux.EnablePowerfulAttack(c,4000,aux.BZoneExclusiveCondition(Card.KJIsRace,RACE_CORRUPTED))
	aux.AddEffectDescription(c,0,aux.BZoneExclusiveCondition(Card.KJIsRace,RACE_CORRUPTED))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER,aux.BZoneExclusiveCondition(Card.KJIsRace,RACE_CORRUPTED))
	aux.AddEffectDescription(c,1,aux.BZoneExclusiveCondition(Card.KJIsRace,RACE_CORRUPTED))
end
