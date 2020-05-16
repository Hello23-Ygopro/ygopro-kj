--Potato Gun Glu-urrgle
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_LORD)
	aux.AddNameCategory(c,NAMECAT_GLUURRGLE)
	--creature
	aux.EnableCreatureAttribute(c)
	--return
	aux.AddSingleTriggerEffect(c,0,EVENT_BATTLE_START,nil,nil,scard.op1,nil,scard.con1)
end
--return
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and e:GetHandler():GetBattleTarget()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetBattleTarget()
	Duel.SendtoHand(tc,PLAYER_OWNER,REASON_EFFECT)
end
