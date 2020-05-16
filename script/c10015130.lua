--Field Marshal Cornucopia
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_WILD_VEGGIE)
	--creature
	aux.EnableCreatureAttribute(c)
	--power up
	aux.EnableUpdatePower(c,2000,nil,LOCATION_BZONE,0,aux.TargetBoolFunctionExceptSelf(Card.KJIsRace,RACE_WILD_VEGGIE))
	--to battle zone
	aux.AddTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,true,scard.tg1,scard.op1,nil,scard.con1)
end
--to battle zone
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	return tc:IsControler(tp) and tc:KJIsRace(RACE_WILD_VEGGIE)
end
function scard.tbfilter(c)
	return not c:IsEvolution() and c:KJIsRace(RACE_WILD_VEGGIE) and c:IsManaCostBelow(5)
end
scard.tg1=aux.SendtoBZoneTarget(aux.ManaZoneFilter(scard.tbfilter),LOCATION_MZONE,0)
scard.op1=aux.SendtoBZoneOperation(PLAYER_SELF,aux.ManaZoneFilter(scard.tbfilter),LOCATION_MZONE,0,1)
