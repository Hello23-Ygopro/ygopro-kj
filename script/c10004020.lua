--Reef Gladiator
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_AQUAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--guard
	aux.EnableGuard(c)
	--power up
	aux.EnableUpdatePower(c,3000,aux.MZoneExclusiveCondition(Card.IsCivilization,CIVILIZATION_WATER))
	aux.AddEffectDescription(c,1,aux.MZoneExclusiveCondition(Card.IsCivilization,CIVILIZATION_WATER))
	--draw
	aux.AddSingleTriggerEffect(c,0,EVENT_CUSTOM+EVENT_BLOCK,true,scard.tg1,scard.op1,nil,scard.con1)
end
--draw
scard.con1=aux.MZoneExclusiveCondition(Card.IsCivilization,CIVILIZATION_WATER)
scard.tg1=aux.DrawTarget(PLAYER_SELF)
scard.op1=aux.DrawOperation(PLAYER_SELF,1)
