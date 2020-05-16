--Grave Scrounger
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DREAD_MASK)
	--creature
	aux.EnableCreatureAttribute(c)
	--return
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,nil,aux.SendtoHandOperation(PLAYER_SELF,aux.KJDPileFilter(scard.retfilter),LOCATION_DPILE,0,1))
end
--return
function scard.retfilter(c)
	return c:IsCreature() and c:IsManaCostBelow(4)
end
