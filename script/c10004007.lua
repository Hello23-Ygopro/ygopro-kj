--Prism-Blade Enforcer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ENFORCER)
	--creature
	aux.EnableCreatureAttribute(c)
	--power up
	aux.EnableUpdatePower(c,2000,aux.MZoneExclusiveCondition(Card.IsCivilization,CIVILIZATION_LIGHT))
	aux.AddEffectDescription(c,0,aux.MZoneExclusiveCondition(Card.IsCivilization,CIVILIZATION_LIGHT))
	--blocker
	aux.EnableBlocker(c,aux.MZoneExclusiveCondition(Card.IsCivilization,CIVILIZATION_LIGHT))
	aux.AddEffectDescription(c,1,aux.MZoneExclusiveCondition(Card.IsCivilization,CIVILIZATION_LIGHT))
end
