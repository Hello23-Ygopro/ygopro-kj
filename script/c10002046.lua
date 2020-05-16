--Chief Many-Tribes
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SPIRIT_TOTEM)
	--creature
	aux.EnableCreatureAttribute(c)
	--to mana zone
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1,nil,scard.con1)
end
--to mana zone
function scard.cfilter(c)
	return c:IsFaceup() and c:IsCivilization(CIVILIZATION_NATURE)
end
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(scard.cfilter,tp,LOCATION_BZONE,0,2,e:GetHandler())
end
scard.tg1=aux.DecktopSendtoMZoneTarget(PLAYER_SELF)
scard.op1=aux.DecktopSendtoMZoneOperation(PLAYER_SELF,1)
