--King Coral
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LEVIATHAN)
	--creature
	aux.EnableCreatureAttribute(c)
	--return
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1)
	aux.AddTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1,nil,scard.con1)
end
--return
function scard.cfilter(c,tp)
	return c:IsFaceup() and c:KJIsRace(RACE_LEVIATHAN) and c:IsControler(tp)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(scard.cfilter,1,e:GetHandler(),tp)
end
function scard.retfilter(c)
	return c:IsFaceup() and c:IsManaCostBelow(4)
end
scard.op1=aux.SendtoHandOperation(nil,scard.retfilter,LOCATION_BZONE,LOCATION_BZONE)
