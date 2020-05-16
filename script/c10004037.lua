--Drakon Warchief
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DRAKON)
	--creature
	aux.EnableCreatureAttribute(c)
	--powerful attack
	aux.EnablePowerfulAttack(c,2000,aux.MZoneExclusiveCondition(Card.IsCivilization,CIVILIZATION_FIRE))
	aux.AddEffectDescription(c,0,aux.MZoneExclusiveCondition(Card.IsCivilization,CIVILIZATION_FIRE))
	--fast attack
	aux.EnableEffectCustom(c,EFFECT_FAST_ATTACK,aux.MZoneExclusiveCondition(Card.IsCivilization,CIVILIZATION_FIRE))
	aux.AddEffectDescription(c,1,aux.MZoneExclusiveCondition(Card.IsCivilization,CIVILIZATION_FIRE))
end
