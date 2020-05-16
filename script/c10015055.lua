--Tusked Nautiloid
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TRENCH_HUNTER)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--draw
	aux.AddTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,aux.DrawTarget(PLAYER_SELF),aux.DrawOperation(PLAYER_SELF,1),nil,scard.con1)
end
--draw
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	return tc:IsControler(tp) and tc:IsHasEffect(EFFECT_BLOCKER)
end
