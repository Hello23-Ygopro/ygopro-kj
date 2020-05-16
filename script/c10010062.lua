--Bad Apple
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CORRUPTED,RACE_WILD_VEGGIE)
	--creature
	aux.EnableCreatureAttribute(c)
	--add race
	aux.EnableAddRace(c,RACE_CORRUPTED,LOCATION_BZONE,0,aux.TargetBoolFunction(Card.KJIsRace,RACE_WILD_VEGGIE))
	--to mana zone
	aux.AddTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,scard.tg1,scard.op1,nil,scard.con1)
end
--to mana zone
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	return tc:IsControler(tp) and tc:KJIsRace(RACE_CORRUPTED)
end
scard.tg1=aux.DecktopSendtoMZoneTarget(PLAYER_SELF)
scard.op1=aux.DecktopSendtoMZoneOperation(PLAYER_SELF,1)
