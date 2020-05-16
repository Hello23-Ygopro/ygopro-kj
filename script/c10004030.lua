--Scavenging Chimera
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CHIMERA)
	--creature
	aux.EnableCreatureAttribute(c)
	--power up
	aux.EnableUpdatePower(c,2000,scard.con1)
	aux.AddEffectDescription(c,1,scard.con1)
	--return
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,nil,scard.op1,nil,scard.con1)
end
--return
scard.con1=aux.MZoneExclusiveCondition(Card.IsCivilization,CIVILIZATION_DARKNESS)
scard.op1=aux.SendtoHandOperation(PLAYER_SELF,aux.KJDPileFilter(Card.IsCreature),LOCATION_DPILE,0,1)
