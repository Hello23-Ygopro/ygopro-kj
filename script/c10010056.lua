--Sabotage Worm
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CORRUPTED,RACE_ROT_WORM)
	--creature
	aux.EnableCreatureAttribute(c)
	--discard
	aux.AddTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,nil,scard.op1,nil,scard.con1)
end
--discard
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	return tc:IsControler(tp) and tc:KJIsRace(RACE_CORRUPTED)
end
scard.op1=aux.DiscardOperation(PLAYER_OPPO,aux.TRUE,0,LOCATION_HAND,1)
